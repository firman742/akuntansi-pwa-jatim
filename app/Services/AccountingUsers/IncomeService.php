<?php

namespace App\Services\AccountingUsers;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionType;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\Transaction;
use App\Models\TransactionLine;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

/**
 * Service class to handle all business logic related to income transactions, including creation of transactions, lines, and journal entries.
 */
class IncomeService
{
    /**
     * Handle the creation of a new income transaction, including all related lines and journal entries.
     * TODO: Masih salah alur, harusnya setiap kali transaksi penerimaan dengan bunga, maka akan ada 2 transaksi: 1 untuk pokok (income) dan 1 untuk bunga (interest). Karena kalau digabung, jadi susah buat laporan terpisah antara pendapatan pokok dan pendapatan bunga.
     *
     * @param array $data
     * @param \Illuminate\Http\UploadedFile|null $receiptFile
     * @return Transaction
     */
    public function handleStore(array $data): Transaction
    {
        // ── 1. Kalkulasi Nominal ─────────────────────────────────
        $incomeAmount   = collect($data['income_lines'])->sum('amount');
        $interestAmount = collect($data['interest_lines'] ?? [])->sum('amount');
        $totalTaxAmount = collect($data['tax_lines'] ?? [])->sum('amount');
        $receiptFile    = $data['receipt'] ?? null;

        $grossAmount = $incomeAmount + $interestAmount;
        $netAmount   = ($incomeAmount + $interestAmount) - $totalTaxAmount;

        return DB::transaction(function () use ($data, $receiptFile, $grossAmount, $netAmount, $incomeAmount, $interestAmount) {

            // ── 2. Create Transaction Header ─────────────────────
            $transaction = Transaction::create([
                'transaction_number' => 'TRX-IN-' . now()->format('YmdHis'),
                'transaction_date'   => $data['transaction_date'],
                'transaction_type'   => TransactionType::INCOME,
                'description'        => $data['description'],
                'gross_amount'       => $grossAmount,
                'net_amount'         => $netAmount,
                'total_amount'       => $grossAmount, // Backward compat
                'status'             => 'POSTED',
                'period_id'          => $data['period_id'],
                'sub_period_id'      => $data['sub_period_id'],
                'created_by'         => Auth::id(),
            ]);

            // ── 3. Handle Receipt Upload ─────────────────────────
            // if ($receiptFile) {
            //     $fileName = $transaction->transaction_number . '.' . $receiptFile->getClientOriginalExtension();
            //     $media = $transaction->addMedia($receiptFile)
            //         ->usingFileName($fileName)
            //         ->toMediaCollection('receipts');
            //     $transaction->update(['receipt_path' => $media->getPathRelativeToRoot()]);
            // }

            // ── 4. Create Transaction Lines ──────────────────────

            // 4a. KAS (DEBIT) - Pokok
            TransactionLine::create([
                'transaction_id'      => $transaction->id,
                'chart_of_account_id' => $data['cash_coa_id'],
                'position'            => NormalBalanceEnum::DEBIT->value,
                'amount'              => $incomeAmount,
                'meta_type'           => MetaTypeTransactionEnum::MAIN->value,
                'description'         => 'Penerimaan Pokok: ' . $data['description'],
            ]);

            // 4b. KAS (DEBIT) - Bunga
            if ($interestAmount > 0) {
                TransactionLine::create([
                    'transaction_id'      => $transaction->id,
                    'chart_of_account_id' => $data['cash_coa_id'],
                    'position'            => NormalBalanceEnum::DEBIT->value,
                    'amount'              => $interestAmount,
                    'meta_type'           => MetaTypeTransactionEnum::MAIN->value,
                    'description'         => 'Penerimaan Jasa Giro/Bunga',
                ]);
            }

            // 4c. PENDAPATAN (CREDIT)
            foreach ($data['income_lines'] as $line) {
                TransactionLine::create([
                    'transaction_id'      => $transaction->id,
                    'chart_of_account_id' => $line['coa_id'],
                    'position'            => NormalBalanceEnum::CREDIT->value,
                    'amount'              => $line['amount'],
                    'meta_type'           => MetaTypeTransactionEnum::MAIN->value,
                    'description'         => $line['description'] ?? null,
                ]);
            }

            // 4d. PAJAK DIBAYAR DIMUKA (DEBIT)
            foreach ($data['tax_lines'] ?? [] as $taxLine) {
                if ($taxLine['amount'] <= 0) continue;
                TransactionLine::create([
                    'transaction_id'      => $transaction->id,
                    'chart_of_account_id' => $taxLine['coa_id'],
                    'position'            => NormalBalanceEnum::DEBIT->value,
                    'amount'              => $taxLine['amount'],
                    'meta_type'           => MetaTypeTransactionEnum::TAX->value,
                    'description'         => 'Potongan Pajak Penerimaan',
                ]);
            }

            // 4e. PENDAPATAN BUNGA (CREDIT)
            foreach ($data['interest_lines'] ?? [] as $intLine) {
                if ($intLine['amount'] <= 0) continue;
                TransactionLine::create([
                    'transaction_id'      => $transaction->id,
                    'chart_of_account_id' => $intLine['coa_id'],
                    'position'            => NormalBalanceEnum::CREDIT->value,
                    'amount'              => $intLine['amount'],
                    'meta_type'           => MetaTypeTransactionEnum::INTEREST->value,
                    'description'         => 'Pendapatan Bunga Bank',
                ]);
            }

            // ── 5. Create Journal & Details ──────────────────────
            $journal = Journal::create([
                'journal_number' => 'JR-' . now()->format('YmdHis'),
                'journal_date'   => $transaction->transaction_date,
                'description'    => $transaction->description,
                'total_debit'    => $grossAmount,
                'total_credit'   => $grossAmount,
                'period_id'      => $transaction->period_id,
                'sub_period_id'  => $transaction->sub_period_id,
                'transaction_id' => $transaction->id,
                'posted_by'      => Auth::id(),
                'posted_at'      => now(),
            ]);

            foreach ($transaction->transactionLines as $line) {
                JournalDetail::create([
                    'journal_id'  => $journal->id,
                    'coa_id'      => $line->chart_of_account_id,
                    'debit'       => $line->position === NormalBalanceEnum::DEBIT->value ? $line->amount : 0,
                    'credit'      => $line->position === NormalBalanceEnum::CREDIT->value ? $line->amount : 0,
                    'description' => $line->description ?? $transaction->description,
                ]);
            }

            return $transaction;
        });
    }
}
