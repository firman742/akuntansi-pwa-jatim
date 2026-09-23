<?php

namespace App\Services\AccountingUsers\Incomes;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionType;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\Transaction;
use App\Models\TransactionLine;
use App\Models\UserAccountBalance;
use App\Services\TransactionBaseService;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class UpdateIncomeService extends TransactionBaseService
{
    /**
     * Handle updating an existing income transaction.
     *
     * @param Transaction $transaction
     * @param array $data
     * @return Transaction
     * @throws Exception
     */
    public function handle(Transaction $transaction, array $data): Transaction
    {
        return DB::transaction(function () use ($transaction, $data) {
            $userId = $transaction->created_by;
            $oldAmount = (float) $transaction->gross_amount;

            // ... (kode rollback saldo & jurnal lama tetap sama) ...
            $oldDebitLine = $transaction->transactionLines()->where('position', NormalBalanceEnum::DEBIT)->first();
            $oldCreditLine = $transaction->transactionLines()->where('position', NormalBalanceEnum::CREDIT)->first();

            $oldUserBalance = null;
            $oldSourceBalance = null;
            $oldUserBalanceSnapshot = [];
            $oldSourceBalanceSnapshot = [];

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

                    $oldUserBalance->decrement('income_balance', $oldAmount);
                    $oldUserBalance->decrement('remaining_balance', $oldAmount);
                    $oldUserBalance->refresh();
                }
            }

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

                    $oldSourceBalance->decrement('used_balance', $oldAmount);
                    $oldSourceBalance->increment('remaining_balance', $oldAmount);
                    $oldSourceBalance->refresh();
                }
            }

            $oldJournal = Journal::where('transaction_id', $transaction->id)->with('details')->first();
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
                $oldJournal->delete();
            }

            $transaction->transactionLines()->delete();

            // 2. TERAPKAN DATA BARU
            $newAmount = (float) $data['amount'];

            $newUserBalance = UserAccountBalance::query()
                ->with('userAccount')
                ->lockForUpdate()
                ->findOrFail($data['user_account_balance_id']);

            $newUserBalanceBeforeSnapshot = [
                'allocated_balance' => $newUserBalance->allocated_balance,
                'income_balance'    => $newUserBalance->income_balance,
                'used_balance'      => $newUserBalance->used_balance,
                'remaining_balance' => $newUserBalance->remaining_balance,
            ];

            $newSourceBalance = UserAccountBalance::query()
                ->whereHas('userAccount', fn($q) => $q->where('coa_id', $data['income_coa_id']))
                ->where('period_id', $data['period_id'])
                ->where('sub_period_id', $data['sub_period_id'])
                ->lockForUpdate()
                ->first();

            $newSourceBalanceBeforeSnapshot = [];
            if ($newSourceBalance) {
                $newSourceBalanceBeforeSnapshot = [
                    'allocated_balance' => $newSourceBalance->allocated_balance,
                    'income_balance'    => $newSourceBalance->income_balance,
                    'used_balance'      => $newSourceBalance->used_balance,
                    'remaining_balance' => $newSourceBalance->remaining_balance,
                ];
            }

            $lines = [];
            $lines[] = $this->line(
                $newUserBalance->userAccount->coa_id,
                $newAmount,
                NormalBalanceEnum::DEBIT->value,
                MetaTypeTransactionEnum::MAIN,
                'Mutasi Kas Masuk (Updated)'
            );

            $lines[] = $this->line(
                $data['income_coa_id'],
                $newAmount,
                NormalBalanceEnum::CREDIT->value,
                MetaTypeTransactionEnum::MAIN,
                $data['description'] ?? 'Penerimaan (Updated)'
            );

            $transaction->update([
                'transaction_date' => $data['transaction_date'],
                'description'      => $data['description'],
                'gross_amount'     => $newAmount,
                'net_amount'       => $newAmount,
                'period_id'        => $data['period_id'],
                'sub_period_id'    => $data['sub_period_id'],
            ]);

            foreach ($lines as $line) {
                TransactionLine::create([
                    'transaction_id'      => $transaction->id,
                    'chart_of_account_id' => $line['coa_id'],
                    'position'            => $line['position'],
                    'amount'              => $line['amount'],
                    'meta_type'           => $line['meta_type'],
                    'description'         => $line['description'],
                ]);
            }

            $newUserBalance->increment('income_balance', $newAmount);
            $newUserBalance->increment('remaining_balance', $newAmount);
            $newUserBalance->refresh();

            if ($newSourceBalance) {
                $newSourceBalance->increment('used_balance', $newAmount);
                $newSourceBalance->decrement('remaining_balance', $newAmount);
                $newSourceBalance->refresh();
            }

            $this->generateJournal(
                [
                    'transaction_date' => $transaction->transaction_date,
                    'description'      => $transaction->description,
                    'period_id'        => $transaction->period_id,
                    'sub_period_id'    => $transaction->sub_period_id,
                ],
                $lines,
                collect($lines)->sum('debit'),
                collect($lines)->sum('credit'),
                'INC',
                $transaction
            );

            /*
            |--------------------------------------------------------------------------
            | Handle File Upload to Google Drive (Update)
            |--------------------------------------------------------------------------
            */
            if (isset($data['receipt_file']) && $data['receipt_file'] instanceof \Illuminate\Http\UploadedFile) {
                try {
                    // Hapus file lama di Google Drive jika ada
                    if ($transaction->receipt_path && Storage::disk('google_receipt_transaction')->exists($transaction->receipt_path)) {
                        Storage::disk('google_receipt_transaction')->delete($transaction->receipt_path);
                    }

                    $file = $data['receipt_file'];
                    $extension = $file->getClientOriginalExtension();

                    $transaction->load(['period', 'subPeriod']);

                    $jenis         = strtoupper($transaction->transaction_type->value);
                    $periodName    = str_replace(['/', '\\', ' '], '_', $transaction->period?->name ?? 'Tanpa_Periode');
                    $subPeriodName = str_replace(['/', '\\', ' '], '_', $transaction->subPeriod?->name ?? 'Tanpa_Sub_Periode');
                    $trxNumber     = str_replace(['/', '\\', ' '], '_', $transaction->transaction_number);

                    $directory = sprintf('%s/%s/%s', $jenis, $periodName, $subPeriodName);
                    $fileName  = $trxNumber . '.' . $extension;

                    Storage::disk('google_receipt_transaction')->putFileAs($directory, $file, $fileName);

                    $receiptPath = trim($directory, '/') . '/' . $fileName;

                    $transaction->update([
                        'receipt_path' => $receiptPath
                    ]);
                } catch (\Exception $e) {
                    throw new Exception('Gagal mengunggah bukti transaksi ke Google Drive: ' . $e->getMessage());
                }
            }

            // ... (Log audit dan return tetap sama) ...
            return $transaction;
        });
    }

    /**
     * Rollback CoaBalance for a specific chart of account, period, and sub-period.
     *
     * @param string $coaId
     * @param string $periodId
     * @param string $subPeriodId
     * @param float $debit
     * @param float $credit
     * @return void
     */
    protected static function rollbackCoaBalance(string $coaId, string $periodId, string $subPeriodId, float $debit, float $credit): void
    {
        $coaBalance = CoaBalance::where([
            'chart_of_account_id' => $coaId,
            'period_id'           => $periodId,
            'sub_period_id'       => $subPeriodId,
        ])->first();

        if ($coaBalance) {
            $coaBalance->decrement('debit_total', $debit);
            $coaBalance->decrement('credit_total', $credit);
            $coaBalance->refresh();

            $coa = \App\Models\ChartOfAccount::find($coaId);
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
