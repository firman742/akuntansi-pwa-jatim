<?php

namespace App\Services\AccountingUsers\Expenses;

use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionStatus;
use App\Models\Transaction;
use App\Services\TransactionBaseService;
use Exception;
use Illuminate\Support\Facades\DB;

class PostTransactionExpenseService extends TransactionBaseService
{
    /**
     * Post a draft transaction.
     *
     * @throws Exception
     */
    public function handle(string $id): Transaction
    {
        return DB::transaction(function () use ($id) {
            $transaction = Transaction::query()
                ->with(['transactionLines'])
                ->lockForUpdate()
                ->findOrFail($id);

            if ($transaction->status !== TransactionStatus::DRAFT->value) {
                throw new Exception('Hanya transaksi DRAFT yang dapat diposting.');
            }

            // Build journal lines
            $lines = $transaction->transactionLines->map(function ($line) {
                return [
                    'coa_id'      => $line->chart_of_account_id,
                    'amount'      => $line->amount,
                    'position'    => $line->position,
                    'debit'       => $line->position == NormalBalanceEnum::DEBIT->value ? $line->amount : 0,
                    'credit'      => $line->position == NormalBalanceEnum::CREDIT->value ? $line->amount : 0,
                    'meta_type'   => $line->meta_type,
                    'description' => $line->description,
                ];
            })->values()->toArray();

            $transaction->update([
                'status' => TransactionStatus::POSTED->value,
            ]);

            // Generate Journal Entry & Update CoaBalance
            $totalDebit = $transaction->transactionLines
                ->where('position', NormalBalanceEnum::DEBIT->value)
                ->sum('amount');

            $totalCredit = $transaction->transactionLines
                ->where('position', NormalBalanceEnum::CREDIT->value)
                ->sum('amount');

            self::generateJournal(
                [
                    'transaction_date' => $transaction->transaction_date,
                    'description'      => $transaction->description,
                    'period_id'        => $transaction->period_id,
                    'sub_period_id'    => $transaction->sub_period_id,
                ],
                $lines,
                $totalDebit,
                $totalCredit,
                'EXP',
                $transaction
            );

            return $transaction->fresh(['transactionLines']);
        });
    }
}
