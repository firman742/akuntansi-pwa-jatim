<?php

namespace App\Services\AccountingUsers\Expenses;

use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Models\ChartOfAccount;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\Transaction;
use App\Services\TransactionBaseService;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class DestroyExpenseService extends TransactionBaseService
{
    /**
     * Handle delete expense transaction.
     *
     * @param Transaction $transaction
     * @return bool
     * @throws Exception
     */
    public function handle(Transaction $transaction): bool
    {
        return DB::transaction(function () use ($transaction) {
            // Lock transaksi untuk menghindari race condition
            $transaction = Transaction::whereKey($transaction->getKey())
                ->lockForUpdate()
                ->firstOrFail();

            if ($transaction->subPeriod && $transaction->subPeriod->is_closed) {
                throw new Exception('Sub periode transaksi ini sudah ditutup, data tidak dapat dihapus.');
            }

            $amount = (float) $transaction->gross_amount;
            $oldStatus = is_object($transaction->status) ? $transaction->status->value : (string) $transaction->status;

            $oldTransactionSnapshot = [
                'transaction_id'     => $transaction->id,
                'transaction_number' => $transaction->transaction_number,
                'transaction_date'   => $transaction->transaction_date->format('Y-m-d'),
                'total_amount'       => $amount,
                'description'        => $transaction->description,
                'status'             => $oldStatus,
            ];

            /*
            |--------------------------------------------------------------------------
            | 1. ROLLBACK JURNAL & COA BALANCE (Jika Status POSTED)
            |--------------------------------------------------------------------------
            */
            if ($oldStatus === TransactionStatus::POSTED->value) {
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
            }

            /*
            |--------------------------------------------------------------------------
            | 2. HAPUS TRANSACTION LINES & FILE BUKTI TRANSAKSI (Google Drive)
            |--------------------------------------------------------------------------
            */
            $transaction->transactionLines()->delete();

            if ($transaction->receipt_path && Storage::disk('google_receipt_transaction')->exists($transaction->receipt_path)) {
                Storage::disk('google_receipt_transaction')->delete($transaction->receipt_path);
            }

            /*
            |--------------------------------------------------------------------------
            | 3. AUDIT LOG
            |--------------------------------------------------------------------------
            */
            $this->logger->log(
                action: 'DELETE',
                module: 'TRANSACTION_EXPENSE',
                subject: $transaction,
                description: 'Menghapus transaksi pengeluaran dan berkas lampirannya.',
                old: $oldTransactionSnapshot,
                new: [],
                additionalData: [
                    'transaction_type' => TransactionType::EXPENSE->value,
                    'period_id'        => $transaction->period_id,
                    'sub_period_id'    => $transaction->sub_period_id,
                ]
            );

            /*
            |--------------------------------------------------------------------------
            | 4. HAPUS HEADER TRANSAKSI UTAMA
            |--------------------------------------------------------------------------
            */
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

            $coa = ChartOfAccount::whereKey($coaId)->first();
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
