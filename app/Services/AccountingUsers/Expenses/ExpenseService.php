<?php

namespace App\Services\AccountingUsers\Expenses;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Helpers\TransactionHelper;
use App\Models\Transaction;
use App\Models\TransactionLine;
use App\Services\TransactionBaseService;
use Exception;
use Illuminate\Support\Facades\DB;

class ExpenseService extends TransactionBaseService
{
    /**
     * Handle expense transaction.
     *
     * Journal:
     * Debit  : Akun Pengeluaran (Beberapa line)
     * Credit : Kas User / Sumber COA
     *
     * @throws Exception
     */
    public function handle(array $data): Transaction
    {
        return DB::transaction(function () use ($data) {
            $status = $data['status'] ?? TransactionStatus::DRAFT->value;
            $cashCoaId = $data['cash_coa_id'] ?? $data['coa_id'] ?? null;

            if (! $cashCoaId) {
                throw new Exception('Akun Kas Sumber wajib dipilih.');
            }

            $totalExpense = collect($data['expense_lines'])->sum('amount');

            $parentDescription = !empty($data['description'])
                ? $data['description']
                : collect($data['expense_lines'])->pluck('description')->filter()->implode(' dan ');

            if (empty($parentDescription)) {
                $parentDescription = 'Transaksi Pengeluaran';
            }

            $data['description'] = $parentDescription;

            $lines = [];

            // Debit akun tujuan (Pengeluaran)
            foreach ($data['expense_lines'] as $expense) {
                $lineDesc = !empty($expense['description'])
                    ? $expense['description']
                    : TransactionHelper::generateLineDescription(
                        $expense['coa_id'],
                        $expense['description'] ?? null
                    );

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

            if (! in_array($status, [TransactionStatus::DRAFT->value, TransactionStatus::POSTED->value])) {
                throw new Exception('Status transaksi tidak valid.');
            }

            $transaction = $this->storeTransaction(
                $data,
                $lines,
                $totalExpense,
                TransactionType::EXPENSE
            );

            if ($status === TransactionStatus::POSTED->value) {
                // Create Journal Entry & Update General Ledger / CoaBalance
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
                    'EXP',
                    $transaction
                );
            }

            // Audit Log Transaction Created
            $this->logger->log(
                action: 'CREATE',
                module: 'TRANSACTION_EXPENSE',
                subject: $transaction,
                description: 'Membuat transaksi pengeluaran.',
                old: [],
                new: [
                    'transaction_id'     => $transaction->id,
                    'transaction_number' => $transaction->transaction_number,
                    'transaction_date'   => $transaction->transaction_date,
                    'total_amount'       => $totalExpense,
                    'status'             => $transaction->status,
                ],
                additionalData: [
                    'transaction_type' => TransactionType::EXPENSE->value,
                    'period_id'        => $transaction->period_id,
                    'sub_period_id'    => $transaction->sub_period_id,
                ]
            );

            return $transaction;
        });
    }

    /**
     * Post a draft transaction.
     *
     * @throws Exception
     */
    public function postTransaction(string $id): Transaction
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

    /**
     * Handle update expense transaction.
     *
     * @throws Exception
     */
    public function update(string $id, array $data): Transaction
    {
        return DB::transaction(function () use ($id, $data) {
            $transaction = Transaction::with(['transactionLines.chartOfAccount', 'period', 'subPeriod', 'journal.details'])
                ->lockForUpdate()
                ->findOrFail($id);

            if ($transaction->subPeriod && $transaction->subPeriod->is_closed) {
                throw new Exception('Sub periode transaksi ini sudah ditutup, data tidak dapat diubah.');
            }

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

            // 1. REVERT JURNAL & COA BALANCE LAMA (Jika sebelumnya POSTED)
            if ($oldStatus === TransactionStatus::POSTED->value) {
                if ($transaction->journal) {
                    self::revertJournal($transaction->journal);
                    $transaction->journal->details()->delete();
                    $transaction->journal->delete();
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

            // 2. SIAPKAN LINES BARU
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

            // 3. UPDATE TRANSACTION HEADER & TRANSACTION LINES
            $transaction->transactionLines()->delete();

            $transaction->update([
                'transaction_date' => $data['transaction_date'],
                'description'      => $data['description'],
                'gross_amount'      => $totalExpense,
                'net_amount'        => $totalExpense,
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

            // 4. TERAPKAN JURNAL BARU JIKA STATUS BARU = POSTED
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

            // Handle file upload
            if (isset($data['proof_file'])) {
                $transaction->clearMediaCollection('receipts');
                $transaction->addMediaFromRequest('proof_file')->toMediaCollection('receipts');
            }

            // 5. AUDIT LOG TRANSACTION UPDATED
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
     * Handle delete expense transaction.
     *
     * @throws Exception
     */
    public function delete(string $id): bool
    {
        return DB::transaction(function () use ($id) {
            $transaction = Transaction::with(['transactionLines.chartOfAccount', 'period', 'subPeriod', 'journal.details'])
                ->lockForUpdate()
                ->findOrFail($id);

            if ($transaction->subPeriod && $transaction->subPeriod->is_closed) {
                throw new Exception('Sub periode transaksi ini sudah ditutup, data tidak dapat dihapus.');
            }

            $oldStatus = $transaction->status->value;
            $oldGrossAmount = (float) $transaction->gross_amount;

            $oldTransactionSnapshot = [
                'transaction_id'     => $transaction->id,
                'transaction_number' => $transaction->transaction_number,
                'transaction_date'   => $transaction->transaction_date->format('Y-m-d'),
                'total_amount'       => $oldGrossAmount,
                'status'             => $oldStatus,
                'description'        => $transaction->description,
            ];

            // 1. REVERT JURNAL & COA BALANCE LAMA (Jika POSTED)
            if ($oldStatus === TransactionStatus::POSTED->value) {
                if ($transaction->journal) {
                    self::revertJournal($transaction->journal);
                    $transaction->journal->details()->delete();
                    $transaction->journal->delete();
                }
            }

            // 2. HAPUS RELASI DATA TERKAIT
            $transaction->transactionLines()->delete();
            $transaction->clearMediaCollection('receipts');

            // 3. AUDIT LOG TRANSACTION DELETED
            $this->logger->log(
                action: 'DELETE',
                module: 'TRANSACTION_EXPENSE',
                subject: $transaction,
                description: 'Menghapus transaksi pengeluaran.',
                old: $oldTransactionSnapshot,
                new: [],
                additionalData: [
                    'transaction_type' => TransactionType::EXPENSE->value,
                    'period_id'        => $transaction->period_id,
                    'sub_period_id'    => $transaction->sub_period_id,
                ]
            );

            // 4. HAPUS TRANSAKSI UTAMA
            return $transaction->delete();
        });
    }
}
