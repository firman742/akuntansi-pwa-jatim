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
     * Handle income transaction.
     *
     * Journal:
     * Debit  : Kas User
     * Credit : Akun Penerimaan
     *
     * @param array $data
     * @return Transaction
     * @throws Exception
     */
    public function handleIncome(array $data): Transaction
    {
        return DB::transaction(function () use ($data) {

            $userBalance = UserAccountBalance::query()
                ->with('userAccount')
                ->lockForUpdate()
                ->findOrFail(
                    $data['user_account_balance_id']
                );

            $oldBalance = [
                'allocated_balance' => $userBalance->allocated_balance,
                'used_balance' => $userBalance->used_balance,
                'remaining_balance' => $userBalance->remaining_balance,
            ];

            $amount = (float) $data['amount'];

            /*
            |--------------------------------------------------------------------------
            | Journal Lines
            |--------------------------------------------------------------------------
            */

            $lines = [];

            /**
             * Debit Kas User
             */
            $lines[] = $this->line(
                $userBalance->userAccount->coa_id,
                $amount,
                NormalBalanceEnum::DEBIT->value,
                MetaTypeTransactionEnum::MAIN,
                'Kas Masuk'
            );

            /**
             * Credit Akun Penerimaan
             */
            $lines[] = $this->line(
                $data['income_coa_id'],
                $amount,
                NormalBalanceEnum::CREDIT->value,
                MetaTypeTransactionEnum::MAIN,
                $data['description'] ?? 'Penerimaan'
            );

            /*
            |--------------------------------------------------------------------------
            | Store Transaction
            |--------------------------------------------------------------------------
            */

            $transaction = $this->storeTransaction(
                data: $data,
                lines: $lines,
                totalAmount: $amount,
                type: TransactionType::INCOME
            );

            /*
            |--------------------------------------------------------------------------
            | Update Saldo User
            |--------------------------------------------------------------------------
            */

            $userBalance->increment(
                'allocated_balance',
                $amount
            );

            $userBalance->increment(
                'remaining_balance',
                $amount
            );

            /*
            |--------------------------------------------------------------------------
            | Audit Log
            |--------------------------------------------------------------------------
            */

            $this->logger->log(
                action: 'CREATE',
                module: 'TRANSACTION_INCOME',
                subject: $transaction,
                description: 'Membuat transaksi penerimaan.',
                old: [],
                new: [
                    'transaction_id' => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'transaction_date' => $transaction->transaction_date,
                    'total_amount' => $amount,
                    'status' => $transaction->status,
                    'lines' => collect($lines)
                        ->map(function ($line) {

                            return [

                                'coa_id' => $line['coa_id'],
                                'position' => $line['position'],
                                'amount' => $line['amount'],
                                'description' => $line['description'],

                            ];
                        })
                        ->toArray(),
                ],
                additionalData: [
                    'transaction_type' => TransactionType::INCOME->value,
                    'period_id' => $transaction->period_id,
                    'sub_period_id' => $transaction->sub_period_id,

                ]
            );

            $this->logger->log(
                action: 'UPDATE',
                module: 'USER_ACCOUNT_BALANCE',
                subject: $userBalance,
                description: 'Saldo pengguna bertambah karena transaksi penerimaan.',
                old: $oldBalance,
                new: [
                    'allocated_balance' => $userBalance->allocated_balance,
                    'used_balance' => $userBalance->used_balance,
                    'remaining_balance' => $userBalance->remaining_balance,
                ],
                additionalData: [
                    'transaction_id' => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'income_amount' => $amount,
                ]
            );

            return $transaction;
        });
    }

    /**
     * Handle expense transaction
     * 
     * Journal:
     * Debit  : Akun Pengeluaran
     * Credit : Kas User
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
                $totalExpense,
                TransactionType::EXPENSE
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
     * @param TransactionType $type
     * @return Transaction
     * @throws Exception
     */
    private function storeTransaction(array $data, array $lines, float $totalAmount, TransactionType $type): Transaction
    {
        $totalDebit = collect($lines)->sum('debit');
        $totalCredit = collect($lines)->sum('credit');

        if ($totalDebit != $totalCredit) {
            throw new Exception("Journal not balanced.");
        }

        $prefix = $type === TransactionType::INCOME ? 'INC' : 'EXP';

        $transaction = Transaction::create([
            'transaction_number' => 'TRX-' . $prefix . '-' . now()->format('YmdHis'),
            'transaction_date' => $data['transaction_date'],
            'transaction_type' => $type,
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
            'journal_number' => 'JR-' . $prefix . '-' . now()->format('YmdHis'),
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
