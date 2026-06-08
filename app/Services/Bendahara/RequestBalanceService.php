<?php

namespace App\Services\Bendahara;

use App\Enums\RequestStatus;
use App\Models\BalanceRequest;
use App\Models\BudgetAllocation;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\UserAccountBalance;
use App\Services\BaseService;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class RequestBalanceService extends BaseService
{
    /**
     * Approve a balance request.
     *
     * @param BalanceRequest $balanceRequest
     * @param array $data
     * @return BalanceRequest
     * @throws Exception
     */
    public function approve(BalanceRequest $balanceRequest, array $data): BalanceRequest
    {
        return DB::transaction(function () use ($balanceRequest, $data) {

            // Validasi status permintaan
            if ($balanceRequest->status !== RequestStatus::PENDING->value) {
                throw new Exception(
                    'Permintaan saldo tidak dapat diproses karena statusnya bukan menunggu persetujuan.'
                );
            }

            $sourceCoa = CoaBalance::query()
                ->lockForUpdate()
                ->findOrFail($data['source_coa_id']);

            // Validasi saldo COA sumber
            if ($sourceCoa->current_balance < $balanceRequest->amount) {
                throw new Exception('Saldo sumber tidak mencukupi.');
            }

            // COA tujuan diambil dari akun pengguna yang melakukan request
            $destinationCoaId = $balanceRequest->userAccount->coa_id;

            // Simpan alokasi anggaran untuk permintaan yang disetujui
            $this->storeBudgetAllocation($balanceRequest, $sourceCoa, $destinationCoaId);

            // Kurangi saldo COA sumber
            $this->reduceSourceCoaBalance($sourceCoa, $balanceRequest);

            // Tambahkan atau perbarui saldo akun pengguna untuk COA tujuan
            $this->updateUserAccountBalance($balanceRequest, $sourceCoa);


            // Buat jurnal untuk distribusi saldo
            $this->generateJournal($balanceRequest, $sourceCoa, $destinationCoaId);

            // Perbarui status permintaan menjadi disetujui
            $balanceRequest = $this->updateBalanceRequest($balanceRequest, $sourceCoa, $data);

            return $balanceRequest->fresh();
        });
    }


    /**
     * Reject a balance request.
     *
     * @param BalanceRequest $balanceRequest
     * @param array $data
     * @return BalanceRequest
     * @throws Exception
     */
    public function reject(BalanceRequest $balanceRequest, array $data): BalanceRequest
    {
        return DB::transaction(function () use ($balanceRequest, $data) {

            if ($balanceRequest->status !== RequestStatus::PENDING->value) {
                throw new Exception('Tidak bisa menolak permintaan dikarenakan tidak berstatus menunggu.');
            }

            $balanceRequest->update([
                'rejection_notes' => $data['rejection_notes'] ?? null,
                'status' => RequestStatus::REJECTED->value,
                'approver_id' => Auth::id(),
            ]);

            /**
             * =====================================================
             * AUDIT LOG - USER BALANCE REJECTED
             * =====================================================
             */
            $this->logger->log(
                action: 'REJECT',
                module: 'BALANCE_REQUEST',
                subject: $balanceRequest,
                description: "Request balance dengan jumlah '" . $balanceRequest->amount . "' untuk periode '" . $balanceRequest->subPeriod->name . "' telah ditolak oleh user " . Auth::user()->name . ".",
                old: [
                    'status' => RequestStatus::PENDING->value,
                    'approver_id' => null,
                ],
                new: [
                    'status' => RequestStatus::REJECTED->value,
                    'approver_id' => Auth::id(),
                ],
                additionalData: [
                    'requester_id' => $balanceRequest->requester_id,
                    'user_account_id' => $balanceRequest->user_account_id,
                    'period_id' => $balanceRequest->period_id,
                    'sub_period_id' => $balanceRequest->sub_period_id,
                    'amount' => $balanceRequest->amount,
                    'purpose' => $balanceRequest->purpose,
                    'note' => $balanceRequest->note,
                ]
            );

            return $balanceRequest->fresh();
        });
    }

    /**
     * Generate a unique journal number in the format JRNL-YYYYMMDD-XXXX.
     *
     * @return string
     */
    private function generateJournalNumber(): string
    {
        $latestJournal = Journal::query()
            ->orderBy('created_at', 'desc')
            ->lockForUpdate()
            ->latest()
            ->first();

        $lastNumber = $latestJournal ? (int) substr($latestJournal->journal_number, -4) : 0;
        $newNumber = str_pad($lastNumber + 1, 4, '0', STR_PAD_LEFT);

        return 'JRNL-' . date('Ymd') . '-' . $newNumber;
    }


    /**
     * Store budget allocation record for the approved balance request.
     *
     * @param BalanceRequest $balanceRequest
     * @param CoaBalance $sourceCoa
     * @param string $destinationCoaId
     * @return BudgetAllocation
     * @throws Exception
     */
    private function storeBudgetAllocation(BalanceRequest $balanceRequest, CoaBalance $sourceCoa, string $destinationCoaId): BudgetAllocation
    {
        try {
            $budgetAllocation = BudgetAllocation::create([
                'from_chart_of_account_id' => $sourceCoa->chart_of_account_id,
                'to_chart_of_account_id' => $destinationCoaId,
                'period_id' => $balanceRequest->period_id,
                'sub_period_id' => $balanceRequest->sub_period_id,
                'created_by' => Auth::id(),
                'amount' => $balanceRequest->amount,
                'allocation_type' => 'auto',
                'description' => $balanceRequest->purpose,
            ]);

            $this->logger->log(
                action: 'CREATE',
                module: 'BUDGET_ALLOCATION',
                subject: $budgetAllocation,
                description: "Alokasi anggaran otomatis sebesar '{$balanceRequest->amount}' dari COA '{$sourceCoa->chartOfAccount->code} - {$sourceCoa->chartOfAccount->name}' ke COA '{$balanceRequest->userAccount->coa->code} - {$balanceRequest->userAccount->coa->name}' untuk periode '{$balanceRequest->subPeriod->name}'.",
                old: [],
                new: $budgetAllocation->toArray(),
                additionalData: [
                    'balance_request_id' => $balanceRequest->id,
                    'from_chart_of_account_id' => $budgetAllocation->from_chart_of_account_id,
                    'to_chart_of_account_id' => $budgetAllocation->to_chart_of_account_id,
                    'period_id' => $budgetAllocation->period_id,
                    'sub_period_id' => $budgetAllocation->sub_period_id,
                    'amount' => $budgetAllocation->amount,
                    'allocation_type' => $budgetAllocation->allocation_type,
                ]
            );

            return $budgetAllocation;
        } catch (Exception $e) {
            $this->logger->log(
                action: 'ERROR',
                module: 'BUDGET_ALLOCATION',
                subject: null,
                description: "Gagal membuat alokasi anggaran otomatis untuk request balance #{$balanceRequest->id}. Error: " . $e->getMessage(),
                old: [],
                new: [],
                additionalData: [
                    'balance_request_id' => $balanceRequest->id,
                    'from_chart_of_account_id' => $sourceCoa->chart_of_account_id,
                    'to_chart_of_account_id' => $destinationCoaId,
                    'period_id' => $balanceRequest->period_id,
                    'sub_period_id' => $balanceRequest->sub_period_id,
                    'amount' => $balanceRequest->amount,
                    'allocation_type' => 'auto',
                ]
            );

            throw new Exception('Gagal membuat alokasi anggaran otomatis. Silakan coba lagi.');
        }
    }

    /**
     * Reduce the balance of the source COA after approving the balance request.
     *
     * @param CoaBalance $sourceCoa
     * @param BalanceRequest $balanceRequest
     * @return void
     * @throws Exception
     */
    private function reduceSourceCoaBalance(CoaBalance $sourceCoa, BalanceRequest $balanceRequest): void
    {
        try {
            $oldBalance = $sourceCoa->current_balance;

            $sourceCoa->decrement(
                'current_balance',
                $balanceRequest->amount
            );

            $sourceCoa->decrement(
                'available_balance',
                $balanceRequest->amount
            );

            $sourceCoa->refresh();

            $this->logger->log(
                action: 'UPDATE',
                module: 'COA_BALANCE',
                subject: $sourceCoa,
                description: "Saldo COA '{$sourceCoa->chartOfAccount->code} - {$sourceCoa->chartOfAccount->name}' berkurang sebesar '{$balanceRequest->amount}' karena distribusi saldo untuk request balance #{$balanceRequest->id}.",
                old: [
                    'current_balance' => $oldBalance,
                ],
                new: [
                    'current_balance' => $sourceCoa->current_balance,
                ],
                additionalData: [
                    'balance_request_id' => $balanceRequest->id,
                    'coa_balance_id' => $sourceCoa->id,
                    'chart_of_account_id' => $sourceCoa->chart_of_account_id,
                    'period_id' => $sourceCoa->period_id,
                    'sub_period_id' => $sourceCoa->sub_period_id,
                ]
            );
        } catch (Exception $e) {
            $this->logger->log(
                action: 'ERROR',
                module: 'COA_BALANCE',
                subject: $sourceCoa,
                description: "Gagal mengurangi saldo COA '{$sourceCoa->chartOfAccount->code} - {$sourceCoa->chartOfAccount->name}' untuk request balance #{$balanceRequest->id}. Error: " . $e->getMessage(),
                old: [
                    'current_balance' => $sourceCoa->current_balance,
                ],
                new: [],
                additionalData: [
                    'balance_request_id' => $balanceRequest->id,
                    'coa_balance_id' => $sourceCoa->id,
                    'chart_of_account_id' => $sourceCoa->chart_of_account_id,
                    'period_id' => $sourceCoa->period_id,
                    'sub_period_id' => $sourceCoa->sub_period_id,
                    'amount_to_reduce' => $balanceRequest->amount,
                ]
            );

            throw new Exception('Gagal mengurangi saldo COA sumber. Silakan coba lagi.');
        }
    }

    /**
     * Update or create user account balance for the approved balance request.
     *
     * @param BalanceRequest $balanceRequest
     * @param CoaBalance $sourceCoa
     * @return UserAccountBalance
     * @throws Exception
     * 
     */
    private function updateUserAccountBalance(BalanceRequest $balanceRequest, CoaBalance $sourceCoa): UserAccountBalance
    {
        try {
            $userAccountBalance = UserAccountBalance::query()
                ->where('user_account_id', $balanceRequest->user_account_id)
                ->where('coa_balance_id', $sourceCoa->id)
                ->where('sub_period_id', $balanceRequest->sub_period_id)
                ->lockForUpdate()
                ->first();

            $oldAllocatedBalance = $userAccountBalance ? $userAccountBalance->allocated_balance : 0;
            $oldRemainingBalance = $userAccountBalance ? $userAccountBalance->remaining_balance : 0;

            if ($userAccountBalance) {
                $userAccountBalance->increment(
                    'allocated_balance',
                    $balanceRequest->amount
                );

                $userAccountBalance->increment(
                    'remaining_balance',
                    $balanceRequest->amount
                );
            } else {
                $userAccountBalance = UserAccountBalance::create([
                    'user_account_id' => $balanceRequest->user_account_id,
                    'coa_balance_id' => $sourceCoa->id,
                    'period_id' => $balanceRequest->period_id,
                    'sub_period_id' => $balanceRequest->sub_period_id,
                    'allocated_by' => Auth::id(),
                    'allocated_balance' => $balanceRequest->amount,
                    'used_balance' => 0,
                    'remaining_balance' => $balanceRequest->amount,
                    'allocated_at' => now(),
                ]);
            }

            $userAccountBalance->refresh();

            $this->logger->log(
                action: 'UPDATE',
                module: 'USER_ACCOUNT_BALANCE',
                subject: $userAccountBalance,
                description: "Saldo akun pengguna untuk COA '{$sourceCoa->chartOfAccount->code} - {$sourceCoa->chartOfAccount->name}' bertambah sebesar '{$balanceRequest->amount}' karena distribusi saldo untuk request balance #{$balanceRequest->id}.",
                old: [
                    'allocated_balance' => $oldAllocatedBalance,
                    'remaining_balance' => $oldRemainingBalance,
                ],
                new: [
                    'allocated_balance' => $userAccountBalance->allocated_balance,
                    'remaining_balance' => $userAccountBalance->remaining_balance,
                ],
                additionalData: [
                    'balance_request_id' => $balanceRequest->id,
                    'user_account_balance_id' => $userAccountBalance->id,
                    'user_account_id' => $userAccountBalance->user_account_id,
                    'coa_balance_id' => $userAccountBalance->coa_balance_id,
                    'period_id' => $userAccountBalance->period_id,
                    'sub_period_id' => $userAccountBalance->sub_period_id,
                ]
            );


            return $userAccountBalance;
        } catch (Exception $e) {
            $this->logger->log(
                action: 'ERROR',
                module: 'USER_ACCOUNT_BALANCE',
                subject: null,
                description: "Gagal memperbarui saldo akun pengguna untuk request balance #{$balanceRequest->id}. Error: " . $e->getMessage(),
                old: [],
                new: [],
                additionalData: [
                    'balance_request_id' => $balanceRequest->id,
                    'user_account_id' => $balanceRequest->user_account_id,
                    'coa_balance_id' => $sourceCoa->id,
                    'period_id' => $balanceRequest->period_id,
                    'sub_period_id' => $balanceRequest->sub_period_id,
                    'amount_to_allocate' => $balanceRequest->amount,
                ]
            );

            throw new Exception('Gagal memperbarui saldo akun pengguna. Silakan coba lagi.');
        }
    }


    /**
     * Generate journal entries for the approved balance request.
     *
     * @param BalanceRequest $balanceRequest
     * @param CoaBalance $sourceCoa
     * @param string $destinationCoaId
     * @return void
     * @throws Exception
     * 
     */
    private function generateJournal(BalanceRequest $balanceRequest, CoaBalance $sourceCoa, string $destinationCoaId): void
    {
        try {
            $journal = Journal::create([
                'journal_number' => $this->generateJournalNumber(),
                'journal_date' => now(),
                'description' => 'Distribusi saldo request #' . $balanceRequest->id,
                'total_debit' => $balanceRequest->amount,
                'total_credit' => $balanceRequest->amount,
                'posted_by' => Auth::id(),
                'posted_at' => now(),
                'period_id' => $balanceRequest->period_id,
                'sub_period_id' => $balanceRequest->sub_period_id,
            ]);

            $this->logger->log(
                action: 'CREATE',
                module: 'JOURNAL',
                subject: $journal,
                description: "Membuat jurnal distribusi saldo untuk request balance #{$balanceRequest->id} dengan nomor jurnal '{$journal->journal_number}'.",
                old: [],
                new: $journal->toArray(),
                additionalData: [
                    'balance_request_id' => $balanceRequest->id,
                    'journal_id' => $journal->id,
                    'journal_number' => $journal->journal_number,
                    'journal_date' => $journal->journal_date,
                    'description' => $journal->description,
                    'total_debit' => $journal->total_debit,
                    'total_credit' => $journal->total_credit,
                    'posted_by' => $journal->posted_by,
                    'posted_at' => $journal->posted_at,
                    'period_id' => $journal->period_id,
                    'sub_period_id' => $journal->sub_period_id,
                ]
            );

            /*
            |--------------------------------------------------------------------------
            | DEBIT COA TUJUAN
            |--------------------------------------------------------------------------
            */
            $journalDetailDebit = JournalDetail::create([
                'journal_id' => $journal->id,
                'chart_of_account_id' => $destinationCoaId,
                'debit' => $balanceRequest->amount,
                'credit' => 0,
                'description' => 'Penerimaan alokasi saldo',
            ]);

            $this->logger->log(
                action: 'CREATE',
                module: 'JOURNAL_DETAIL',
                subject: $journalDetailDebit,
                description: "Membuat detail jurnal untuk COA tujuan dengan posisi debit sebesar '{$balanceRequest->amount}' pada jurnal distribusi saldo untuk request balance #{$balanceRequest->id}.",
                old: [],
                new: $journalDetailDebit->toArray(),
                additionalData: [
                    'balance_request_id' => $balanceRequest->id,
                    'journal_id' => $journal->id,
                    'chart_of_account_id' => $destinationCoaId,
                    'debit' => $journalDetailDebit->debit,
                    'credit' => $journalDetailDebit->credit,
                    'description' => $journalDetailDebit->description,
                ]
            );

            /*
            |--------------------------------------------------------------------------
            | CREDIT COA SUMBER
            |--------------------------------------------------------------------------
            */

            $journalDetailCredit = JournalDetail::create([
                'journal_id' => $journal->id,
                'chart_of_account_id' => $sourceCoa->chart_of_account_id,
                'debit' => 0,
                'credit' => $balanceRequest->amount,
                'description' => 'Distribusi saldo',
            ]);

            $this->logger->log(
                action: 'CREATE',
                module: 'JOURNAL_DETAIL',
                subject: $journalDetailCredit,
                description: "Membuat detail jurnal untuk COA sumber dengan posisi kredit sebesar '{$balanceRequest->amount}' pada jurnal distribusi saldo untuk request balance #{$balanceRequest->id}.",
                old: [],
                new: $journalDetailCredit->toArray(),
                additionalData: [
                    'balance_request_id' => $balanceRequest->id,
                    'journal_id' => $journal->id,
                    'chart_of_account_id' => $sourceCoa->chart_of_account_id,
                    'debit' => $journalDetailCredit->debit,
                    'credit' => $journalDetailCredit->credit,
                    'description' => $journalDetailCredit->description,
                ]
            );
        } catch (Exception $e) {
            $this->logger->log(
                action: 'ERROR',
                module: 'JOURNAL',
                subject: null,
                description: "Gagal membuat jurnal distribusi saldo untuk request balance #{$balanceRequest->id}. Error: " . $e->getMessage(),
                old: [],
                new: [],
                additionalData: [
                    'balance_request_id' => $balanceRequest->id,
                    'source_coa_id' => $sourceCoa->id,
                    'destination_coa_id' => $destinationCoaId,
                    'amount' => $balanceRequest->amount,
                    'period_id' => $balanceRequest->period_id,
                    'sub_period_id' => $balanceRequest->sub_period_id,
                ]
            );

            throw new Exception('Gagal membuat jurnal distribusi saldo. Silakan coba lagi.');
        }
    }

    /**
     * Update the balance request status to approved and log the approval action.
     *
     * @param BalanceRequest $balanceRequest
     * @param CoaBalance $sourceCoa
     * @param array $data
     * @return BalanceRequest
     */
    private function updateBalanceRequest(BalanceRequest $balanceRequest, CoaBalance $sourceCoa, array $data): BalanceRequest
    {
        try {
            $balanceRequest->update([
                'source_coa_id' => $sourceCoa->id,
                'approval_notes' => $data['approval_notes'] ?? null,
                'status' => RequestStatus::APPROVED->value,
                'approver_id' => Auth::id(),
                'approved_at' => now(),
            ]);

            /*
                |--------------------------------------------------------------------------
                | AUDIT LOG
                |--------------------------------------------------------------------------
                */

            $this->logger->log(
                action: 'APPROVE',
                module: 'BALANCE_REQUEST',
                subject: $balanceRequest,
                description: "Request balance '{$balanceRequest->amount}' disetujui oleh " . Auth::user()->name,
                old: [
                    'status' => RequestStatus::PENDING->value,
                ],
                new: [
                    'status' => RequestStatus::APPROVED->value,
                ],
                additionalData: [
                    "balance_request" => $balanceRequest,
                ]
            );

            return $balanceRequest->fresh();
        } catch (Exception $e) {
            $this->logger->log(
                action: 'ERROR',
                module: 'BALANCE_REQUEST',
                subject: $balanceRequest,
                description: "Gagal memperbarui status request balance #{$balanceRequest->id} menjadi disetujui. Error: " . $e->getMessage(),
                old: [
                    'status' => RequestStatus::PENDING->value,
                ],
                new: [],
                additionalData: [
                    "balance_request" => $balanceRequest,
                ]
            );

            throw new Exception('Gagal memperbarui status request balance. Silakan coba lagi.');
        }
    }
}
