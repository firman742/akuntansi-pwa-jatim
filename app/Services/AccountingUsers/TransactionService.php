<?php

namespace App\Services\AccountingUsers;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionType;
use App\Helpers\TransactionHelper;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\Transaction;
use App\Models\TransactionLine;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class TransactionService
{
    /**
     * Handle the creation of a transaction with its lines and journal entries.
     *
     * @param array $data
     * @return array
     * @throws \Exception
     */
    public function handle(array $data): array
    {
        return DB::transaction(function () use ($data) {

            $transactions = [];
            $type = $data['type'];

            // =========================
            // INCOME FLOW
            // =========================
            if ($type === TransactionType::INCOME->value) {

                // 1. MAIN INCOME
                $transactions[] = $this->createIncomeTransaction($data);

                // 2. TAX (per line)
                if (!empty($data['tax_lines'])) {
                    $transactions = array_merge(
                        $transactions,
                        $this->createTaxTransactions($data)
                    );
                }

                // 3. INTEREST (per line)
                if (!empty($data['interest_lines'])) {
                    $transactions = array_merge(
                        $transactions,
                        $this->createInterestTransactions($data)
                    );
                }
            }

            // =========================
            // EXPENSE FLOW
            // =========================
            if ($type === TransactionType::EXPENSE->value) {
                $transactions[] = $this->createExpenseTransaction($data);
            }

            // =========================
            // TRANSFER FLOW
            // =========================
            if ($type === TransactionType::TRANSFER->value) {
                $this->validateTransferBalance($data);
                $transactions[] = $this->createTransferTransaction($data);
            }

            return $transactions;
        });
    }

    /**
     * =====================================================
     * 🔹 INCOME
     * =====================================================
     * Flow utama untuk transaksi INCOME, yang akan membuat 1 transaksi utama untuk pendapatan,
     * dan jika ada pajak atau bunga, akan membuat transaksi terpisah untuk masing-masing, agar lebih mudah pelacakan dan pelaporan.
     * 
     * @param array $data
     * @return Transaction
     * @throws \Exception
     */
    private function createIncomeTransaction(array $data): Transaction
    {
        $incomeAmount = collect($data['income_lines'])->sum('amount');
        $taxAmount    = collect($data['tax_lines'] ?? [])->sum('amount');

        $cashReceived = $incomeAmount - $taxAmount;

        $lines = [];

        // Kas Masuk
        $lines[] = $this->line(
            $data['cash_coa_id'],
            $cashReceived,
            NormalBalanceEnum::DEBIT->value,
            MetaTypeTransactionEnum::MAIN,
            'Kas Masuk'
        );

        // Pajak Dibayar Dimuka
        foreach ($data['tax_lines'] ?? [] as $tax) {
            if ($tax['amount'] <= 0) continue;

            $lines[] = $this->line(
                $tax['coa_id'],
                $tax['amount'],
                NormalBalanceEnum::DEBIT->value,
                MetaTypeTransactionEnum::TAX,
                'Pajak Dibayar Dimuka'
            );
        }

        // Pendapatan
        foreach ($data['income_lines'] as $inc) {
            $lines[] = $this->line(
                $inc['coa_id'],
                $inc['amount'],
                NormalBalanceEnum::CREDIT->value,
                MetaTypeTransactionEnum::MAIN,
                $inc['description'] ?? 'Pendapatan'
            );
        }

        return $this->storeTransaction($data, $lines, 'PENERIMAAN');
    }

    /**
     * =====================================================
     * 🔹 TAX (PER LINE)
     * =====================================================
     * Karena pajak bisa berbeda-beda untuk setiap jenis pendapatan, maka dibuat transaksi terpisah per line pajak,
     * agar lebih mudah pelacakan dan pelaporan, serta memudahkan jika ada perubahan atau koreksi di kemudian hari.
     * 
     * @param array $data
     * @return array
     * @throws \Exception
     */
    private function createTaxTransactions(array $data): array
    {
        $transactions = [];

        foreach ($data['tax_lines'] as $tax) {

            if ($tax['amount'] <= 0) continue;

            $lines = [];

            // Pajak (Debit)
            $lines[] = $this->line(
                $tax['coa_id'],
                $tax['amount'],
                NormalBalanceEnum::DEBIT->value,
                MetaTypeTransactionEnum::TAX,
                'Pembayaran Pajak'
            );

            // Kas (Credit)
            $lines[] = $this->line(
                $data['cash_coa_id'],
                $tax['amount'],
                NormalBalanceEnum::CREDIT->value,
                MetaTypeTransactionEnum::TAX,
                'Kas Keluar Pajak'
            );

            $transactions[] = $this->storeTransaction($data, $lines, 'PAJAK');
        }

        return $transactions;
    }

    /**
     * =====================================================
     * 🔹 INTEREST (PER LINE)
     * =====================================================
     * Karena bunga bisa berbeda-beda untuk setiap jenis pendapatan, maka dibuat transaksi terpisah per line bunga,
     * agar lebih mudah pelacakan dan pelaporan, serta memudahkan jika ada perubahan atau koreksi di kemudian hari.
     * 
     * @param array $data
     * @return array
     * @throws \Exception
     */
    private function createInterestTransactions(array $data): array
    {
        $transactions = [];

        foreach ($data['interest_lines'] as $int) {

            if ($int['amount'] <= 0) continue;

            $lines = [];

            // Kas Masuk
            $lines[] = $this->line(
                $data['cash_coa_id'],
                $int['amount'],
                NormalBalanceEnum::DEBIT->value,
                MetaTypeTransactionEnum::INTEREST,
                'Kas dari Bunga'
            );

            // Pendapatan Bunga
            $lines[] = $this->line(
                $int['coa_id'],
                $int['amount'],
                NormalBalanceEnum::CREDIT->value,
                MetaTypeTransactionEnum::INTEREST,
                'Pendapatan Bunga'
            );

            $transactions[] = $this->storeTransaction($data, $lines, 'BUNGA');
        }

        return $transactions;
    }

    /**
     * =====================================================
     * 🔹 EXPENSE
     * =====================================================
     * Flow utama untuk transaksi EXPENSE, yang akan membuat 1 transaksi utama untuk beban,
     * dan jika ada pajak, akan membuat transaksi terpisah untuk pajak, agar lebih mudah pelacakan dan pelaporan.
     * 
     * @param array $data
     * @return Transaction
     * @throws \Exception
     */
    private function createExpenseTransaction(array $data): Transaction
    {
        $lines = [];
        $totalExpense = 0;

        foreach ($data['expense_lines'] as $exp) {
            $lines[] = $this->line(
                $exp['coa_id'],
                $exp['amount'],
                NormalBalanceEnum::DEBIT->value,
                MetaTypeTransactionEnum::MAIN,
                $exp['description'] ?? 'Beban'
            );

            $totalExpense += $exp['amount'];
        }

        foreach ($data['tax_lines'] ?? [] as $tax) {
            $lines[] = $this->line(
                $tax['coa_id'],
                $tax['amount'],
                NormalBalanceEnum::DEBIT->value,
                MetaTypeTransactionEnum::TAX,
                'Pajak'
            );

            $totalExpense += $tax['amount'];
        }

        // Kas keluar
        $lines[] = $this->line(
            $data['cash_coa_id'],
            $totalExpense,
            NormalBalanceEnum::CREDIT->value,
            MetaTypeTransactionEnum::MAIN,
            'Kas Keluar'
        );

        return $this->storeTransaction($data, $lines, 'PENGELUARAN');
    }

    /**
     * =====================================================
     * 🔹 TRANSFER
     * =====================================================
     * Flow untuk transaksi TRANSFER, yang akan membuat 1 transaksi utama untuk transfer antar akun,
     * dengan debit di akun tujuan dan credit di akun sumber, agar lebih mudah pelacakan dan pelaporan.
     * 
     * @param array $data
     * @return Transaction
     * @throws \Exception
     */
    private function createTransferTransaction(array $data): Transaction
    {
        $lines = [
            $this->line(
                $data['to_coa_id'], 
                $data['amount'], 
                NormalBalanceEnum::DEBIT->value, 
                MetaTypeTransactionEnum::MAIN, 
                'Kas Masuk'
            ),
            $this->line(
                $data['from_coa_id'], 
                $data['amount'], 
                NormalBalanceEnum::CREDIT->value, 
                MetaTypeTransactionEnum::MAIN, 
                'Kas Keluar'
            ),
        ];

        return $this->storeTransaction($data, $lines, 'TRANSFER');
    }

    /**
     * =====================================================
     * 🔹 STORE TRANSACTION & JOURNAL
     * =====================================================
     * Method untuk menyimpan transaksi, detail transaksi, jurnal, dan detail jurnal ke database,
     * dengan validasi bahwa total debit harus sama dengan total credit, agar jurnal tetap seimbang.
     * 
     * @param array $data
     * @param array $lines
     * @param string $label
     * @return Transaction
     * @throws \Exception
     */
    private function storeTransaction(array $data, array $lines, string $label): Transaction
    {
        $totalDebit  = collect($lines)->sum('DEBIT');
        $totalCredit = collect($lines)->sum('CREDIT');
        // dd($lines, $totalDebit, $totalCredit);

        if ($totalDebit !== $totalCredit) {
            throw new \Exception("Journal not balanced: {$totalDebit} ≠ {$totalCredit}");
        }

        $transaction = Transaction::create([
            'transaction_number' => 'TRX-' . $label . '-' . now()->format('YmdHis'),
            'transaction_date'   => $data['transaction_date'],
            'transaction_type'   => $data['type'],
            'description'        => ($data['description'] ?? '-') . " ({$label})",
            'gross_amount'       => $totalDebit,
            'net_amount'         => $totalDebit,
            'total_amount'       => $totalDebit,
            'status'             => 'POSTED',
            'period_id'          => $data['period_id'],
            'sub_period_id'      => $data['sub_period_id'],
            'created_by'         => Auth::id(),
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

        $journal = Journal::create([
            'journal_number' => 'JR-' . $label . '-' . now()->format('YmdHis'),
            'journal_date'   => $data['transaction_date'],
            'description'    => ($data['description'] ?? '-') . " ({$label})",
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
    }

    /**
     * Helper method untuk membuat struktur line transaksi/jurnal, agar lebih konsisten dan mudah digunakan di berbagai flow.
     * 
     * @param string $coaId
     * @param float $amount
     * @param string $type
     * @param MetaTypeTransactionEnum $meta
     * @param string|null $desc
     * @return array
     */
    private function line($coaId, $amount, $type, $meta, $reference = null): array
    {
        $desc = TransactionHelper::generateLineDescription(
            $coaId,
            $type,
            $meta,
            $reference ?? 'Transaksi'
        );

        return [
            'coa_id'    => $coaId,
            'amount'    => $amount,
            'position'  => $type,
            'debit'     => $type === NormalBalanceEnum::DEBIT->value ? $amount : 0,
            'credit'    => $type === NormalBalanceEnum::CREDIT->value ? $amount : 0,
            'meta_type' => $meta->value,
            'description' => $desc,
        ];
    }

    /**
     * Validasi khusus untuk transaksi TRANSFER, untuk memastikan bahwa akun sumber memiliki saldo yang cukup sebelum melakukan transfer,
     * agar tidak terjadi overdraft atau saldo negatif di akun sumber, yang bisa menyebabkan masalah dalam pencatatan dan pelaporan keuangan.
     * 
     * @param array $data
     * @throws ValidationException
     */
    private function validateTransferBalance(array $data): void
    {
        $balance = $this->getAccountBalance(
            $data['from_coa_id'],
            $data['period_id'],
            $data['sub_period_id']
        );

        if ($balance < $data['amount']) {
            throw ValidationException::withMessages([
                'amount' => 'Saldo tidak mencukupi'
            ]);
        }
    }

    /**
     * Method untuk menghitung saldo akun berdasarkan jurnal yang sudah ada di periode dan sub-periode tertentu,
     * dengan menjumlahkan total debit dan kredit, agar bisa digunakan untuk validasi sebelum melakukan transaksi, terutama untuk transfer.
     * 
     * @param string $coaId
     * @param string $periodId
     * @param string|null $subPeriodId
     * @return float
     */
    private function getAccountBalance(string $coaId, string $periodId, ?string $subPeriodId): float
    {
        $query = DB::table('journal_details as jd')
            ->join('journals as j', 'jd.journal_id', '=', 'j.id')
            ->where('jd.coa_id', $coaId)
            ->where('j.period_id', $periodId);

        if ($subPeriodId) {
            $query->where('j.sub_period_id', $subPeriodId);
        }

        $debit  = $query->clone()->sum('jd.debit');
        $credit = $query->clone()->sum('jd.credit');

        return $debit - $credit;
    }
}
