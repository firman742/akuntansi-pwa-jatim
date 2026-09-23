<?php

namespace App\Services\AccountingUsers\Incomes;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Models\Transaction;
use App\Models\UserAccountBalance;
use App\Services\TransactionBaseService;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class IncomeService extends TransactionBaseService
{
    /**
     * Handle income transaction.
     *
     * Journal:
     * Debit  : Kas User (Penerima)
     * Credit : Akun Penerimaan (Sumber)
     *
     * @throws Exception
     */
    public function handle(array $data): Transaction
    {
        return DB::transaction(function () use ($data) {
            // 1. Lock & ambil UserAccountBalance Kas Penerima
            $userBalance = UserAccountBalance::query()
                ->with('userAccount')
                ->lockForUpdate()
                ->findOrFail($data['user_account_balance_id']);

            $oldBalance = [
                'allocated_balance' => $userBalance->allocated_balance,
                'income_balance'    => $userBalance->income_balance,
                'used_balance'      => $userBalance->used_balance,
                'remaining_balance' => $userBalance->remaining_balance,
            ];

            // 2. Lock & amankan UserAccountBalance Akun Sumber (jika income_coa_id terdaftar di UserAccount)
            $sourceUserBalance = UserAccountBalance::query()
                ->whereHas('userAccount', function ($q) use ($data) {
                    $q->where('coa_id', $data['income_coa_id']);
                })
                ->where('period_id', $data['period_id'])
                ->where('sub_period_id', $data['sub_period_id'])
                ->lockForUpdate()
                ->first();

            $amount = (float) $data['amount'];
            $data['status'] = TransactionStatus::POSTED->value;

            /*
            |--------------------------------------------------------------------------
            | Journal Lines
            |--------------------------------------------------------------------------
            */
            $lines = [];

            // Debit Kas User Penerima
            $lines[] = $this->line(
                $userBalance->userAccount->coa_id,
                $amount,
                NormalBalanceEnum::DEBIT->value,
                MetaTypeTransactionEnum::MAIN,
                'Mutasi Kas Masuk'
            );

            // Credit Akun Penerimaan (Sumber)
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
            | Handle File Upload to Google Drive
            |--------------------------------------------------------------------------
            */
            $receiptPath = null;
            if (isset($data['receipt_file']) && $data['receipt_file'] instanceof \Illuminate\Http\UploadedFile) {
                try {
                    $file = $data['receipt_file'];
                    $extension = $file->getClientOriginalExtension();

                    // Muat relasi period dan subPeriod jika belum ada
                    $transaction->load(['period', 'subPeriod']);

                    // Sanitasi string agar aman digunakan sebagai nama folder/file
                    $jenis         = strtoupper($transaction->transaction_type->value);
                    $periodName    = str_replace(['/', '\\', ' '], '_', $transaction->period?->name ?? 'Tanpa_Periode');
                    $subPeriodName = str_replace(['/', '\\', ' '], '_', $transaction->subPeriod?->name ?? 'Tanpa_Sub_Periode');
                    $tanggal     = $transaction->transaction_date->format('Y-m-d');
                    $trxNumber   = str_replace(['/', '\\', ' '], '_', $transaction->transaction_number);

                    // Menentukan direktori bersarang (nested folders) berdasarkan format
                    $directory = sprintf('%s/%s/%s', $jenis, $periodName, $subPeriodName);
                    $fileName  = $tanggal . '_' . $trxNumber . '.' . $extension;
                    
                    // Upload file ke Google Drive
                    Storage::disk('google_receipt_transaction')->putFileAs($directory, $file, $fileName);

                    // Simpan path lengkap ke database
                    $receiptPath = trim($directory, '/') . '/' . $fileName;

                    $transaction->update([
                        'receipt_path' => $receiptPath
                    ]);
                } catch (\Exception $e) {
                    // Lempar exception khusus jika upload gagal/gagal koneksi API
                    throw new Exception('Gagal mengunggah bukti transaksi ke Google Drive: ' . $e->getMessage());
                }
            }

            /*
            |--------------------------------------------------------------------------
            | Update Saldo User Penerima:
            | Total Penerimaan (income_balance) & Saldo Tersisa Bertambah
            |--------------------------------------------------------------------------
            */
            $userBalance->increment('income_balance', $amount);
            $userBalance->increment('remaining_balance', $amount);

            /*
            |--------------------------------------------------------------------------
            | Update Saldo User Sumber (Jika Ada):
            | Total Penggunaan (used_balance) Bertambah & Saldo Tersisa Berkurang
            |--------------------------------------------------------------------------
            */
            $oldSourceBalance = [];
            if ($sourceUserBalance) {
                $oldSourceBalance = [
                    'allocated_balance' => $sourceUserBalance->allocated_balance,
                    'income_balance'    => $sourceUserBalance->income_balance,
                    'used_balance'      => $sourceUserBalance->used_balance,
                    'remaining_balance' => $sourceUserBalance->remaining_balance,
                ];

                $sourceUserBalance->increment('used_balance', $amount);
                $sourceUserBalance->decrement('remaining_balance', $amount);
            }

            /**
             * Create Journal Entries & Update CoaBalance General Ledger
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
            | Audit Logs
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
                    'transaction_date'   => $transaction->transaction_date,
                    'total_amount'       => $amount,
                    'status'             => $transaction->status,
                    'lines'              => collect($lines)
                        ->map(fn($line) => [
                            'coa_id'      => $line['coa_id'],
                            'position'    => $line['position'],
                            'amount'      => $line['amount'],
                            'description' => $line['description'],
                        ])
                        ->toArray(),
                ],
                additionalData: [
                    'transaction_type' => TransactionType::INCOME->value,
                    'period_id'        => $transaction->period_id,
                    'sub_period_id'    => $transaction->sub_period_id,
                ]
            );

            // Audit log akun penerima
            $this->logger->log(
                action: 'UPDATE',
                module: 'USER_ACCOUNT_BALANCE',
                subject: $userBalance,
                description: 'Saldo pengguna bertambah karena transaksi penerimaan.',
                old: $oldBalance,
                new: [
                    'allocated_balance' => $userBalance->allocated_balance,
                    'income_balance'    => $userBalance->income_balance,
                    'used_balance'      => $userBalance->used_balance,
                    'remaining_balance' => $userBalance->remaining_balance,
                ],
                additionalData: [
                    'transaction_id'     => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'income_amount'      => $amount,
                ]
            );

            // Audit log akun sumber (jika merupakan UserAccountBalance)
            if ($sourceUserBalance) {
                $this->logger->log(
                    action: 'UPDATE',
                    module: 'USER_ACCOUNT_BALANCE',
                    subject: $sourceUserBalance,
                    description: 'Saldo akun sumber berkurang karena transaksi penerimaan.',
                    old: $oldSourceBalance,
                    new: [
                        'allocated_balance' => $sourceUserBalance->allocated_balance,
                        'income_balance'    => $sourceUserBalance->income_balance,
                        'used_balance'      => $sourceUserBalance->used_balance,
                        'remaining_balance' => $sourceUserBalance->remaining_balance,
                    ],
                    additionalData: [
                        'transaction_id'     => $transaction->id,
                        'transaction_number' => $transaction->transaction_number,
                        'deducted_amount'    => $amount,
                    ]
                );
            }

            return $transaction;
        });
    }
}
