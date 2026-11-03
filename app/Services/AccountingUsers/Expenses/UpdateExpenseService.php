<?php

namespace App\Services\AccountingUsers\Expenses;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Helpers\TransactionHelper;
use App\Models\ChartOfAccount;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\Transaction;
use App\Models\TransactionLine;
use App\Services\TransactionBaseService;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class UpdateExpenseService extends TransactionBaseService
{
    /**
     * Handle update expense transaction.
     *
     * @throws Exception
     */
    public function handle(string $id, array $data): Transaction
    {
        return DB::transaction(function () use ($id, $data) {
            $transaction = Transaction::with(['transactionLines.chartOfAccount', 'period', 'subPeriod', 'journal.details'])
                ->lockForUpdate()
                ->findOrFail($id);

            $oldStatus = $transaction->status->value;
            $newStatus = $data['status'] ?? TransactionStatus::DRAFT->value;
            $oldGrossAmount = (float) $transaction->gross_amount;
            $cashCoaId = $data['cash_coa_id'] ?? $data['coa_id'] ?? null;

            if (! $cashCoaId) {
                throw new Exception('Akun Kas Sumber wajib dipilih.');
            }

            $oldTransactionSnapshot = [
                'transaction_id'     => $transaction->id,
                'transaction_number' => $transaction->transaction_number,
                'transaction_date'   => $transaction->transaction_date->format('Y-m-d'),
                'total_amount'       => $oldGrossAmount,
                'status'             => $oldStatus,
                'description'        => $transaction->description,
            ];

            /*
            |--------------------------------------------------------------------------
            | 1. ROLLBACK JURNAL & COA BALANCE LAMA (Jika sebelumnya POSTED)
            |--------------------------------------------------------------------------
            */
            if ($oldStatus === TransactionStatus::POSTED->value) {
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
            }

            $totalExpense = collect($data['expense_lines'])->sum('amount');

            $parentDescription = !empty($data['description'])
                ? $data['description']
                : collect($data['expense_lines'])->pluck('description')->filter()->implode(' dan ');

            if (empty($parentDescription)) {
                $parentDescription = 'Transaksi Pengeluaran';
            }
            $data['description'] = $parentDescription;

            /*
            |--------------------------------------------------------------------------
            | 2. SIAPKAN LINES BARU
            |--------------------------------------------------------------------------
            */
            $lines = [];
            foreach ($data['expense_lines'] as $expense) {
                $lineDesc = !empty($expense['description'])
                    ? $expense['description']
                    : TransactionHelper::generateLineDescription($expense['coa_id'], null);

                $lines[] = $this->line(
                    $expense['coa_id'],
                    $expense['amount'],
                    NormalBalanceEnum::DEBIT->value,
                    MetaTypeTransactionEnum::MAIN,
                    $lineDesc
                );
            }

            // Credit kas user (Sumber COA)
            $lines[] = $this->line(
                $cashCoaId,
                $totalExpense,
                NormalBalanceEnum::CREDIT->value,
                MetaTypeTransactionEnum::MAIN,
                "Mutasi Kas Keluar"
            );

            // Validasi Balance Debit == Credit
            $totalDebit = collect($lines)->sum('debit');
            $totalCredit = collect($lines)->sum('credit');
            if ($totalDebit != $totalCredit) {
                throw new Exception("Journal not balanced.");
            }

            /*
            |--------------------------------------------------------------------------
            | 3. UPDATE TRANSACTION HEADER & TRANSACTION LINES
            |--------------------------------------------------------------------------
            */
            $transaction->transactionLines()->delete();

            $transaction->update([
                'transaction_date' => $data['transaction_date'],
                'description'      => $data['description'],
                'gross_amount'     => $totalExpense,
                'net_amount'       => $totalExpense,
                'status'           => $newStatus,
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

            /*
            |--------------------------------------------------------------------------
            | 4. TERAPKAN JURNAL BARU JIKA STATUS BARU = POSTED
            |--------------------------------------------------------------------------
            */
            if ($newStatus === TransactionStatus::POSTED->value) {
                $this->generateJournal(
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
            }

            /*
            |--------------------------------------------------------------------------
            | 5. HANDLE FILE UPLOAD (Google Drive)
            |--------------------------------------------------------------------------
            */
            if (isset($data['receipt_file']) && $data['receipt_file'] instanceof \Illuminate\Http\UploadedFile) {
                try {
                    // Hapus berkas lama jika ada di Google Drive
                    if ($transaction->receipt_path && Storage::disk('google_receipt_transaction')->exists($transaction->receipt_path)) {
                        Storage::disk('google_receipt_transaction')->delete($transaction->receipt_path);
                    }

                    $file = $data['receipt_file'];
                    $extension = $file->getClientOriginalExtension();
                    $transaction->load(['period', 'subPeriod']);

                    $jenis         = strtoupper($transaction->transaction_type->value); // EXPENSE
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

            /*
            |--------------------------------------------------------------------------
            | 6. AUDIT LOG TRANSACTION UPDATED
            |--------------------------------------------------------------------------
            */
            $this->logger->log(
                action: 'UPDATE',
                module: 'TRANSACTION_EXPENSE',
                subject: $transaction,
                description: 'Memperbarui transaksi pengeluaran.',
                old: $oldTransactionSnapshot,
                new: [
                    'transaction_id'     => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'transaction_date'   => $transaction->transaction_date->format('Y-m-d'),
                    'total_amount'       => $totalExpense,
                    'status'             => $newStatus,
                    'description'        => $transaction->description,
                ],
                additionalData: [
                    'transaction_type' => TransactionType::EXPENSE->value,
                    'period_id'        => $transaction->period_id,
                    'sub_period_id'    => $transaction->sub_period_id,
                ]
            );

            return $transaction->fresh(['transactionLines', 'journal']);
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

            $coa = ChartOfAccount::find($coaId);
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
