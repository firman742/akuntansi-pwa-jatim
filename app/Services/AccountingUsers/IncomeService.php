<?php

namespace App\Services\AccountingUsers;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Models\Transaction;
use App\Models\UserAccountBalance;
use App\Services\TransactionBaseService;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\DB;

class IncomeService extends TransactionBaseService
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
    public function handle(array $data): Transaction
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
            $data['status'] = TransactionStatus::POSTED->value;

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
                type: TransactionType::INCOME,
            );

            /*
            |--------------------------------------------------------------------------
            | Update Saldo User:
            | Penerimaan -> Saldo Dialokasikan Bertambah & Saldo Tersisa Bertambah
            |--------------------------------------------------------------------------
            */
            $userBalance->increment('allocated_balance', $amount);
            $userBalance->increment('remaining_balance', $amount);

            /**
             * Create Journal Entries
             */
            $this->generateJournal(
                [
                    'transaction_date' => $transaction->transaction_date,
                    'description' => $transaction->description,
                    'period_id' => $transaction->period_id,
                    'sub_period_id' => $transaction->sub_period_id,
                ],
                $lines,
                collect($lines)->sum('debit'),
                collect($lines)->sum('credit'),
                "INC",
                $transaction
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
}
