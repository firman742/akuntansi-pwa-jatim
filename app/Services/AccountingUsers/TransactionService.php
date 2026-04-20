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

class TransactionService
{
    /**
     * TransactionService is a general service to handle all types of transactions (income, expense, transfer) in a unified way. It will build the necessary lines based on the transaction type, calculate totals, and create both Transaction and Journal entries in a single atomic operation.
     *
     * @param array $data
     * @return Transaction
     */
    public function handle(array $data): Transaction
    {
        return DB::transaction(function () use ($data) {

            $type = $data['type'];

            // ── 1. Build Lines (UNIVERSAL) ─────────────────────
            $lines = match ($type) {
                TransactionType::INCOME->value   => $this->buildIncomeLines($data),
                TransactionType::EXPENSE->value  => $this->buildExpenseLines($data),
                TransactionType::TRANSFER->value => $this->buildTransferLines($data),
                default => throw new \Exception("Invalid transaction type"),
            };

            // ── 2. Calculate Totals ────────────────────────────
            $totalDebit  = collect($lines)->sum('debit');
            $totalCredit = collect($lines)->sum('credit');

            if ($totalDebit !== $totalCredit) {
                throw new \Exception("Journal not balanced: Debit {$totalDebit} ≠ Credit {$totalCredit}");
            }

            // ── 3. Create Transaction ──────────────────────────
            $transaction = Transaction::create([
                'transaction_number' => 'TRX-' . now()->format('YmdHis'),
                'transaction_date'   => $data['transaction_date'],
                'transaction_type'   => $type,
                'description'        => $data['description'] ?? null,
                'gross_amount'       => $totalDebit,
                'net_amount'         => $totalDebit,
                'total_amount'       => $totalDebit,
                'status'             => 'POSTED',
                'period_id'          => $data['period_id'],
                'sub_period_id'      => $data['sub_period_id'],
                'created_by'         => Auth::id(),
            ]);

            // ── 4. Save Lines ──────────────────────────────────
            foreach ($lines as $line) {
                TransactionLine::create([
                    'transaction_id'      => $transaction->id,
                    'chart_of_account_id' => $line['coa_id'],
                    'position'            => $line['position'],
                    'amount'              => $line['amount'],
                    'meta_type'           => $line['meta_type'],
                    'description'         => $line['description'] ?? null,
                ]);
            }

            // ── 5. Create Journal ──────────────────────────────
            $journal = Journal::create([
                'journal_number' => 'JR-' . now()->format('YmdHis'),
                'journal_date'   => $data['transaction_date'],
                'description'    => $data['description'],
                'total_debit'    => $totalDebit,
                'total_credit'   => $totalCredit,
                'period_id'      => $data['period_id'],
                'sub_period_id'  => $data['sub_period_id'],
                'transaction_id' => $transaction->id,
                'posted_by'      => Auth::id(),
                'posted_at'      => now(),
            ]);

            foreach ($lines as $line) {
                JournalDetail::create([
                    'journal_id'  => $journal->id,
                    'coa_id'      => $line['coa_id'],
                    'debit'       => $line['debit'],
                    'credit'      => $line['credit'],
                    'description' => $line['description'],
                ]);
            }

            return $transaction;
        });
    }

    /** =========================================================
     * 🔹 INCOME
     * =========================================================
     *
     * Build the necessary lines for an income transaction, including:
     * - Kas (DEBIT)
     * - Pajak Dibayar Dimuka (DEBIT) untuk setiap tax line
     * - Pendapatan (CREDIT) untuk setiap income line
     * - Bunga (CREDIT) untuk setiap interest line
     *
     * @param array $data
     * @return array
     */
    private function buildIncomeLines(array $data): array
    {
        $lines = [];

        $incomeAmount   = collect($data['income_lines'])->sum('amount');
        $interestAmount = collect($data['interest_lines'] ?? [])->sum('amount');
        $taxAmount      = collect($data['tax_lines'] ?? [])->sum('amount');

        $cashReceived = ($incomeAmount + $interestAmount) - $taxAmount;

        // Kas (DEBIT)
        $lines[] = $this->line($data['cash_coa_id'], $cashReceived, 'debit', MetaTypeTransactionEnum::MAIN, 'Kas Masuk');

        // Pajak (DEBIT - prepaid)
        foreach ($data['tax_lines'] ?? [] as $tax) {
            if ($tax['amount'] <= 0) continue;

            $lines[] = $this->line(
                $tax['coa_id'],
                $tax['amount'],
                'debit',
                MetaTypeTransactionEnum::TAX,
                'Pajak Dibayar Dimuka'
            );
        }

        // Pendapatan (CREDIT)
        foreach ($data['income_lines'] as $inc) {
            $lines[] = $this->line(
                $inc['coa_id'],
                $inc['amount'],
                'credit',
                MetaTypeTransactionEnum::MAIN,
                $inc['description'] ?? null
            );
        }

        // Bunga (CREDIT)
        foreach ($data['interest_lines'] ?? [] as $int) {
            if ($int['amount'] <= 0) continue;

            $lines[] = $this->line(
                $int['coa_id'],
                $int['amount'],
                'credit',
                MetaTypeTransactionEnum::INTEREST,
                'Pendapatan Bunga'
            );
        }

        return $lines;
    }

    /** =========================================================
     * 🔹 EXPENSE
     * =========================================================
     *
     * Build the necessary lines for an expense transaction, including:
     * - Expense (DEBIT) untuk setiap expense line
     * - Pajak (DEBIT) untuk setiap tax line
     * - Kas (CREDIT) untuk total pengeluaran (expense + tax)
     *
     * @param array $data
     * @return array
     */
    private function buildExpenseLines(array $data): array
    {
        $lines = [];

        $totalExpense = collect($data['expense_lines'])->sum('amount');

        // Expense (DEBIT)
        foreach ($data['expense_lines'] as $exp) {
            $lines[] = $this->line(
                $exp['coa_id'],
                $exp['amount'],
                'debit',
                MetaTypeTransactionEnum::MAIN,
                $exp['description'] ?? null
            );
        }

        // Pajak (misal PPN)
        foreach ($data['tax_lines'] ?? [] as $tax) {
            $lines[] = $this->line(
                $tax['coa_id'],
                $tax['amount'],
                'debit',
                MetaTypeTransactionEnum::TAX,
                'Pajak'
            );
            $totalExpense += $tax['amount'];
        }

        // Kas (CREDIT)
        $lines[] = $this->line(
            $data['cash_coa_id'],
            $totalExpense,
            'credit',
            MetaTypeTransactionEnum::MAIN,
            'Kas Keluar'
        );

        return $lines;
    }

    /**
     * Transfer
     *
     * @param array $data
     * @return array
     */
    private function buildTransferLines(array $data): array
    {
        return [
            $this->line($data['to_coa_id'], $data['amount'], 'debit', MetaTypeTransactionEnum::MAIN, 'Kas Masuk'),
            $this->line($data['from_coa_id'], $data['amount'], 'credit', MetaTypeTransactionEnum::MAIN, 'Kas Keluar'),
        ];
    }

    /**
     * Helper untuk membuat line dengan format yang konsisten
     *
     * @param string $coaId
     * @param float $amount
     * @param string $type 'debit' atau 'credit'
     * @param MetaTypeTransactionEnum $meta
     * @param string|null $desc
     * @return array
     */
    private function line($coaId, $amount, $type, $meta, $desc = null): array
    {
        return [
            'coa_id'    => $coaId,
            'amount'    => $amount,
            'position'  => $type === 'debit'
                ? NormalBalanceEnum::DEBIT->value
                : NormalBalanceEnum::CREDIT->value,
            'debit'     => $type === 'debit' ? $amount : 0,
            'credit'    => $type === 'credit' ? $amount : 0,
            'meta_type' => $meta->value,
            'description' => $desc,
        ];
    }
}