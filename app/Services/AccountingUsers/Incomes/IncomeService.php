<?php

namespace App\Services\AccountingUsers\Incomes;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Models\Transaction;
use App\Services\TransactionBaseService;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class IncomeService extends TransactionBaseService
{
    public function handle(array $data): Transaction
    {
        return DB::transaction(function () use ($data) {
            $amount = (float) $data['amount'];
            $data['status'] = TransactionStatus::POSTED->value;

            /*
            |--------------------------------------------------------------------------
            | Journal Lines
            |--------------------------------------------------------------------------
            */
            $lines = [];

            // Debit Kas Penerima (Dipilih dari $data['coa_id'])
            $lines[] = $this->line(
                $data['coa_id'],
                $amount,
                NormalBalanceEnum::DEBIT->value,
                MetaTypeTransactionEnum::MAIN,
                'Mutasi Kas Masuk'
            );

            // Credit Akun Sumber Penerimaan
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
            | Handle File Upload
            |--------------------------------------------------------------------------
            */
            if (isset($data['receipt_file']) && $data['receipt_file'] instanceof \Illuminate\Http\UploadedFile) {
                $file = $data['receipt_file'];
                $extension = $file->getClientOriginalExtension();
                $transaction->load(['period', 'subPeriod']);

                $jenis         = strtoupper($transaction->transaction_type->value);
                $periodName    = str_replace(['/', '\\', ' '], '_', $transaction->period?->name ?? 'Tanpa_Periode');
                $subPeriodName = str_replace(['/', '\\', ' '], '_', $transaction->subPeriod?->name ?? 'Tanpa_Sub_Periode');
                $tanggal       = $transaction->transaction_date->format('Y-m-d');
                $trxNumber     = str_replace(['/', '\\', ' '], '_', $transaction->transaction_number);

                $directory = sprintf('%s/%s/%s', $jenis, $periodName, $subPeriodName);
                $fileName  = $tanggal . '_' . $trxNumber . '.' . $extension;

                Storage::disk('google_receipt_transaction')->putFileAs($directory, $file, $fileName);
                $receiptPath = trim($directory, '/') . '/' . $fileName;

                $transaction->update(['receipt_path' => $receiptPath]);
            }

            /*
            |--------------------------------------------------------------------------
            | Create Journal Entries & Update CoaBalance (General Ledger)
            |--------------------------------------------------------------------------
            | Catatan: Method generateJournal() di TransactionBaseService Anda
            | bertugas meng-update tabel coa_balances secara otomatis.
            */
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
            | Audit Logs Transaction Only
            |--------------------------------------------------------------------------
            */
            $this->logger->log(
                action: 'CREATE',
                module: 'TRANSACTION_INCOME',
                subject: $transaction,
                description: 'Membuat transaksi penerimaan.',
                old: [],
                new: [
                    'transaction_id'     => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'total_amount'       => $amount,
                    'status'             => $transaction->status,
                ]
            );

            return $transaction;
        });
    }
}
