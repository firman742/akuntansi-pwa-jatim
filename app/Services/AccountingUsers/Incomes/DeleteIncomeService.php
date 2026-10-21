<?php

namespace App\Services\AccountingUsers\Incomes;

use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\Transaction;
use App\Services\TransactionBaseService;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class DeleteIncomeService extends TransactionBaseService
{
    /**
     * Handle deleting an existing income transaction.
     *
     * @param Transaction $transaction
     * @return bool
     * @throws Exception
     */
    public function handle(Transaction $transaction): bool
    {
        return DB::transaction(function () use ($transaction) {
            $amount = (float) $transaction->gross_amount;

            $oldTransactionSnapshot = [
                'transaction_id'     => $transaction->id,
                'transaction_number' => $transaction->transaction_number,
                'transaction_date'   => $transaction->transaction_date->format('Y-m-d'),
                'total_amount'       => $amount,
                'description'        => $transaction->description,
                'status'             => $transaction->status,
            ];

            // 1. ROLLBACK JOURNAL & COA BALANCE (Buku Besar)
            $oldJournal = Journal::where('transaction_id', $transaction->id)
                ->with('details')
                ->first();

            if ($oldJournal) {
                foreach ($oldJournal->details as $detail) {
                    self::rollbackCoaBalance(
                        $detail->chart_of_account_id,
                        $transaction->period_id,
                        $transaction->sub_period_id,
                        (float) $detail->debit,
                        (float) $detail->credit
                    );
                }
                $oldJournal->details()->delete();
                Journal::whereKey($oldJournal->getKey())->delete();
            }

            // 2. HAPUS TRANSACTION LINES & FILE BUKTI TRANSAKSI
            $transaction->transactionLines()->delete();

            if ($transaction->receipt_path && Storage::disk('google_receipt_transaction')->exists($transaction->receipt_path)) {
                Storage::disk('google_receipt_transaction')->delete($transaction->receipt_path);
            }

            $transaction->clearMediaCollection('receipts');

            // 3. AUDIT LOG
            $this->logger->log(
                action: 'DELETE',
                module: 'TRANSACTION_INCOME',
                subject: $transaction,
                description: 'Menghapus transaksi penerimaan dan berkas lampirannya.',
                old: $oldTransactionSnapshot,
                new: [],
                additionalData: [
                    'transaction_type' => $transaction->transaction_type,
                    'period_id'        => $transaction->period_id,
                    'sub_period_id'    => $transaction->sub_period_id,
                ]
            );

            // 4. HAPUS HEADER TRANSAKSI
            return (bool) Transaction::query()
                ->whereKey($transaction->getKey())
                ->delete();
        });
    }

    /**
     * Rollback CoaBalance untuk akun, periode, dan sub-periode tertentu.
     */
    protected static function rollbackCoaBalance(string $coaId, string $periodId, string $subPeriodId, float $debit, float $credit): void
    {
        $coaBalance = CoaBalance::query()
            ->where('chart_of_account_id', $coaId)
            ->where('period_id', $periodId)
            ->where('sub_period_id', $subPeriodId)
            ->first();

        if ($coaBalance) {
            $coaBalance->decrement('debit_total', $debit);
            $coaBalance->decrement('credit_total', $credit);
            $coaBalance->refresh();

            $coa = \App\Models\ChartOfAccount::whereKey($coaId)->first();
            $normalBalanceStr = strtoupper(is_object($coa->normal_balance) ? $coa->normal_balance->value : (string) $coa->normal_balance);

            if ($normalBalanceStr === 'DEBIT') {
                $newBalance = $coaBalance->opening_balance + ($coaBalance->debit_total - $coaBalance->credit_total);
            } else {
                $newBalance = $coaBalance->opening_balance + ($coaBalance->credit_total - $coaBalance->debit_total);
            }

            $coaBalance->update(['current_balance' => $newBalance]);
        }
    }
}
