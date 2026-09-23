<?php

namespace App\Services\AccountingUsers\Incomes;

use App\Enums\NormalBalanceEnum;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\Transaction;
use App\Models\UserAccountBalance;
use App\Services\TransactionBaseService;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage; // ⬅️ PASTIKAN IMPORT STORAGE INI ADA

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

            // Simpan snapshot untuk audit log
            $oldTransactionSnapshot = [
                'transaction_id'     => $transaction->id,
                'transaction_number' => $transaction->transaction_number,
                'transaction_date'   => $transaction->transaction_date->format('Y-m-d'),
                'total_amount'       => $amount,
                'description'        => $transaction->description,
                'status'             => $transaction->status,
            ];

            // 1. Ambil line debit (kas penerima) & credit (akun sumber) lama
            $oldDebitLine = $transaction->transactionLines()->where('position', NormalBalanceEnum::DEBIT)->first();
            $oldCreditLine = $transaction->transactionLines()->where('position', NormalBalanceEnum::CREDIT)->first();

            $oldUserBalanceSnapshot = [];
            $oldSourceBalanceSnapshot = [];

            // 2. Rollback Saldo User Penerima Kas
            if ($oldDebitLine) {
                $oldUserBalance = UserAccountBalance::query()
                    ->whereHas('userAccount', fn($q) => $q->where('coa_id', $oldDebitLine->chart_of_account_id))
                    ->where('period_id', $transaction->period_id)
                    ->where('sub_period_id', $transaction->sub_period_id)
                    ->lockForUpdate()
                    ->first();

                if ($oldUserBalance) {
                    $oldUserBalanceSnapshot = [
                        'allocated_balance' => $oldUserBalance->allocated_balance,
                        'income_balance'    => $oldUserBalance->income_balance,
                        'used_balance'      => $oldUserBalance->used_balance,
                        'remaining_balance' => $oldUserBalance->remaining_balance,
                    ];

                    $oldUserBalance->decrement('income_balance', $amount);
                    $oldUserBalance->decrement('remaining_balance', $amount);
                    $oldUserBalance->refresh();
                }
            }

            // 3. Rollback Saldo User Akun Sumber (Jika ada)
            $oldSourceBalance = null;
            if ($oldCreditLine) {
                $oldSourceBalance = UserAccountBalance::query()
                    ->whereHas('userAccount', fn($q) => $q->where('coa_id', $oldCreditLine->chart_of_account_id))
                    ->where('period_id', $transaction->period_id)
                    ->where('sub_period_id', $transaction->sub_period_id)
                    ->lockForUpdate()
                    ->first();

                if ($oldSourceBalance) {
                    $oldSourceBalanceSnapshot = [
                        'allocated_balance' => $oldSourceBalance->allocated_balance,
                        'income_balance'    => $oldSourceBalance->income_balance,
                        'used_balance'      => $oldSourceBalance->used_balance,
                        'remaining_balance' => $oldSourceBalance->remaining_balance,
                    ];

                    $oldSourceBalance->decrement('used_balance', $amount);
                    $oldSourceBalance->increment('remaining_balance', $amount);
                    $oldSourceBalance->refresh();
                }
            }

            // 4. Rollback Journal & CoaBalance (Buku Besar)
            $oldJournal = Journal::where('transaction_id', '=', $transaction->id, 'and')
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

            // 5. Hapus Transaction Lines, File di Google Drive, & Spatie Media
            $transaction->transactionLines()->delete();

            // ⬅️ TAMBAHKAN KODE INI UNTUK HAPUS FILE FISIK DI GOOGLE DRIVE
            if ($transaction->receipt_path) {
                Storage::disk('google_receipt_transaction')->delete($transaction->receipt_path);
            }

            $transaction->clearMediaCollection('receipts');

            // 6. ACTIVITY LOGS (AUDIT TRAIL)
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

            if (isset($oldUserBalance) && $oldUserBalance) {
                $this->logger->log(
                    action: 'UPDATE',
                    module: 'USER_ACCOUNT_BALANCE',
                    subject: $oldUserBalance,
                    description: 'Saldo pengguna dikembalikan karena penghapusan transaksi penerimaan.',
                    old: $oldUserBalanceSnapshot,
                    new: [
                        'allocated_balance' => $oldUserBalance->allocated_balance,
                        'income_balance'    => $oldUserBalance->income_balance,
                        'used_balance'      => $oldUserBalance->used_balance,
                        'remaining_balance' => $oldUserBalance->remaining_balance,
                    ],
                    additionalData: [
                        'transaction_id'     => $transaction->id,
                        'transaction_number' => $transaction->transaction_number,
                    ]
                );
            }

            if (isset($oldSourceBalance) && $oldSourceBalance) {
                $this->logger->log(
                    action: 'UPDATE',
                    module: 'USER_ACCOUNT_BALANCE',
                    subject: $oldSourceBalance,
                    description: 'Saldo akun sumber dikembalikan karena penghapusan transaksi penerimaan.',
                    old: $oldSourceBalanceSnapshot,
                    new: [
                        'allocated_balance' => $oldSourceBalance->allocated_balance,
                        'income_balance'    => $oldSourceBalance->income_balance,
                        'used_balance'      => $oldSourceBalance->used_balance,
                        'remaining_balance' => $oldSourceBalance->remaining_balance,
                    ],
                    additionalData: [
                        'transaction_id'     => $transaction->id,
                        'transaction_number' => $transaction->transaction_number,
                    ]
                );
            }

            // 7. Hapus Header Transaksi
            return (bool) Transaction::query()
                ->whereKey($transaction->getKey())
                ->delete();
        });
    }

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
