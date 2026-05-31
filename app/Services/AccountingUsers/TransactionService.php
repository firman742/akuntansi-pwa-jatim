<?php

namespace App\Services\AccountingUsers;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionType;
use App\Helpers\TransactionHelper;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\Transaction;
use App\Models\TransactionLine;
use App\Models\UserAccountBalance;
use App\Services\BaseService;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class TransactionService extends BaseService
{
    /**
     * Handle expense transaction
     *
     * @param array $data
     * @return Transaction
     * @throws ValidationException
     * @throws \Exception
     */
    public function handleExpense(array $data): Transaction
    {
        return DB::transaction(function () use ($data) {

            $userBalance = UserAccountBalance::query()
                ->with('userAccount')
                ->lockForUpdate()
                ->findOrFail(
                    $data['user_account_balance_id']
                );

            $oldBalance = [
                'used_balance' => $userBalance->used_balance,
                'remaining_balance' => $userBalance->remaining_balance,
            ];

            $totalExpense = collect($data['expense_lines'])->sum('amount');

            // Validasi saldo
            if ($userBalance->remaining_balance < $totalExpense) {
                throw new Exception('Periode tidak valid atau sudah ditutup.');
            }

            $lines = [];

            // Debit akun tujuan
            foreach ($data['expense_lines'] as $expense) {

                $lines[] = $this->line(
                    $expense['coa_id'],
                    $expense['amount'],
                    NormalBalanceEnum::DEBIT->value,
                    MetaTypeTransactionEnum::MAIN,
                    $expense['description'] ?? 'Pengeluaran'
                );
            }

            // Credit kas user
            $lines[] = $this->line(
                $userBalance->userAccount->coa_id,
                $totalExpense,
                NormalBalanceEnum::CREDIT->value,
                MetaTypeTransactionEnum::MAIN,
                'Kas Keluar'
            );

            $transaction = $this->storeTransaction(
                $data,
                $lines,
                $totalExpense
            );

            // Update distribusi saldo user
            $userBalance->increment('used_balance', $totalExpense);
            $userBalance->decrement('remaining_balance', $totalExpense);

            /**
             * =====================================================
             * AUDIT LOG - TRANSACTION CREATED
             * =====================================================
             */
            $this->logger->log(
                action: 'CREATE',
                module: 'TRANSACTION_EXPENSE',
                subject: $transaction,
                description: 'Membuat transaksi pengeluaran.',
                old: [],
                new: [
                    'transaction_id' => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'transaction_date' => $transaction->transaction_date,
                    'total_amount' => $totalExpense,
                    'status' => $transaction->status,
                    'lines' => collect($lines)->map(function ($line) {
                        return [
                            'coa_id' => $line['coa_id'],
                            'position' => $line['position'],
                            'amount' => $line['amount'],
                            'description' => $line['description'],
                        ];
                    })->toArray(),
                ],
                additionalData: [
                    'transaction_type' => TransactionType::EXPENSE->value,
                    'period_id' => $transaction->period_id,
                    'sub_period_id' => $transaction->sub_period_id,
                ]
            );

            /**
             * =====================================================
             * AUDIT LOG - USER BALANCE UPDATED
             * =====================================================
             */
            $this->logger->log(
                action: 'UPDATE',
                module: 'USER_ACCOUNT_BALANCE',
                subject: $userBalance,
                description: 'Saldo pengguna berkurang karena transaksi pengeluaran.',
                old: $oldBalance,
                new: [
                    'used_balance' => $userBalance->used_balance,
                    'remaining_balance' => $userBalance->remaining_balance,
                ],
                additionalData: [
                    'transaction_id' => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'expense_amount' => $totalExpense,
                ]
            );


            return $transaction;
        });
    }

    /**
     * Store transaction, journal, and their details in a single transaction.
     *
     * @param array $data
     * @param array $lines
     * @param float $totalAmount
     * @return Transaction
     * @throws Exception
     */
    private function storeTransaction(array $data, array $lines, float $totalAmount): Transaction
    {
        $totalDebit = collect($lines)->sum('debit');
        $totalCredit = collect($lines)->sum('credit');

        if ($totalDebit != $totalCredit) {
            throw new Exception("Journal not balanced.");
        }

        $transaction = Transaction::create([
            'transaction_number' => 'TRX-EXP-' . now()->format('YmdHis'),
            'transaction_date' => $data['transaction_date'],
            'transaction_type' => TransactionType::EXPENSE->value,
            'description' => $data['description'] ?? '-',
            'gross_amount' => $totalAmount,
            'net_amount' => $totalAmount,
            'status' => 'POSTED',
            'period_id' => $data['period_id'],
            'sub_period_id' => $data['sub_period_id'],
            'created_by' => Auth::id(),
        ]);

        foreach ($lines as $line) {
            TransactionLine::create([
                'transaction_id' => $transaction->id,
                'chart_of_account_id' => $line['coa_id'],
                'position' => $line['position'],
                'amount' => $line['amount'],
                'meta_type' => $line['meta_type'],
                'description' => $line['description'],
            ]);
        }

        $journal = Journal::create([
            'journal_number' => 'JR-EXP-' . now()->format('YmdHis'),
            'journal_date' => $data['transaction_date'],
            'description' => $data['description'] ?? '-',
            'total_debit' => $totalDebit,
            'total_credit' => $totalCredit,
            'period_id' => $data['period_id'],
            'sub_period_id' => $data['sub_period_id'],
            'transaction_id' => $transaction->id,
            'posted_by' => Auth::id(),
            'posted_at' => Carbon::now(),
        ]);

        foreach ($lines as $line) {

            JournalDetail::create([
                'journal_id' => $journal->id,
                'chart_of_account_id' => $line['coa_id'],
                'debit' => $line['debit'],
                'credit' => $line['credit'],
                'description' => $line['description'],
            ]);
        }

        return $transaction;
    }

    /**
     * Generate a transaction line array for journal entry.
     *
     * @param string $coaId
     * @param float $amount
     * @param string $position
     * @param MetaTypeTransactionEnum $meta
     * @param string|null $reference
     * @return array
     */
    private function line(string $coaId, float $amount, string $position, MetaTypeTransactionEnum $meta, ?string $reference = null): array
    {
        return [
            'coa_id' => $coaId,
            'amount' => $amount,
            'position' => $position,
            'debit' => $position === NormalBalanceEnum::DEBIT->value ? $amount : 0,
            'credit' =>  $position === NormalBalanceEnum::CREDIT->value ? $amount : 0,
            'meta_type' => $meta->value,
            'description' => TransactionHelper::generateLineDescription($coaId, $position, $meta, $reference ?? 'Transaksi'),
        ];
    }
}
