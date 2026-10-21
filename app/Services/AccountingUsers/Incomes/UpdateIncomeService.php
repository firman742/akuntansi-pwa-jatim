<?php

namespace App\Services\AccountingUsers\Incomes;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\Transaction;
use App\Models\TransactionLine;
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
            $oldAmount = (float) $transaction->gross_amount;

            // 1. ROLLBACK JURNAL & COA BALANCE LAMA
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

            // Hapus detail line transaksi lama
            $transaction->transactionLines()->delete();

            // 2. PROSES DATA BARU
            $newAmount = (float) $data['amount'];

            $lines = [];
            // Debit Kas Penerima
            $lines[] = $this->line(
                $data['coa_id'],
                $newAmount,
                NormalBalanceEnum::DEBIT->value,
                MetaTypeTransactionEnum::MAIN,
                'Mutasi Kas Masuk (Updated)'
            );

            // Credit Akun Sumber Penerimaan
            $lines[] = $this->line(
                $data['income_coa_id'],
                $newAmount,
                NormalBalanceEnum::CREDIT->value,
                MetaTypeTransactionEnum::MAIN,
                $data['description'] ?? 'Penerimaan (Updated)'
            );

            // Update Transaction Header
            $transaction->update([
                'transaction_date' => $data['transaction_date'],
                'description'      => $data['description'],
                'gross_amount'     => $newAmount,
                'net_amount'       => $newAmount,
                'period_id'        => $data['period_id'],
                'sub_period_id'    => $data['sub_period_id'],
            ]);

            // Create Transaction Lines Baru
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

            // Post Jurnal Baru & Update CoaBalance
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

            // 3. HANDLE FILE UPLOAD (Google Drive)
            if (isset($data['receipt_file']) && $data['receipt_file'] instanceof \Illuminate\Http\UploadedFile) {
                try {
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

                    $transaction->update(['receipt_path' => $receiptPath]);
                } catch (\Exception $e) {
                    throw new Exception('Gagal mengunggah bukti transaksi ke Google Drive: ' . $e->getMessage());
                }
            }

            // 4. AUDIT LOG
            $this->logger->log(
                action: 'UPDATE',
                module: 'TRANSACTION_INCOME',
                subject: $transaction,
                description: 'Perbarui transaksi penerimaan.',
                old: ['gross_amount' => $oldAmount],
                new: [
                    'transaction_id'     => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'total_amount'       => $newAmount,
                    'status'             => $transaction->status,
                ]
            );

            return $transaction;
        });
    }

    /**
     * Rollback CoaBalance untuk akun, periode, dan sub-periode tertentu.
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
