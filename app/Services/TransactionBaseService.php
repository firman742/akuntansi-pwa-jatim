<?php

namespace App\Services;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Helpers\TransactionHelper;
use App\Models\ChartOfAccount;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\Transaction;
use App\Models\TransactionLine;
use App\Services\BaseService;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Auth;

class TransactionBaseService extends BaseService
{
    /**
     * Store transaction, journal, and their details in a single transaction.
     *
     * @param array $data
     * @param array $lines
     * @param float $totalAmount
     * @param TransactionType $type
     * @return Transaction
     * @throws Exception
     */
    protected static function storeTransaction(array $data, array $lines, float $totalAmount, TransactionType $type): Transaction
    {
        $totalDebit = collect($lines)->sum('debit');
        $totalCredit = collect($lines)->sum('credit');
        $status = $data['status'] ?? TransactionStatus::DRAFT->value;

        if ($totalDebit != $totalCredit) {
            throw new Exception("Journal not balanced.");
        }

        $prefix = $type === TransactionType::INCOME ? 'INC' : 'EXP';

        $transaction = Transaction::create([
            'transaction_number' => 'TRX-' . $prefix . '-' . now()->format('YmdHis'),
            'transaction_date' => $data['transaction_date'],
            'transaction_type' => $type,
            'description' => $data['description'] ?? '-',
            'gross_amount' => $totalAmount,
            'net_amount' => $totalAmount,
            'status' => $status,
            'period_id' => $data['period_id'],
            'sub_period_id' => $data['sub_period_id'],
            'created_by' => Auth::id(),
        ]);

        foreach ($lines as $line) {
            TransactionLine::create([
                'transaction_id' => $transaction->id,
                'chart_of_account_id' => $line['coa_id'],
                'position' => $line['position'],
                'amount' => $line['amount'],
                'meta_type' => $line['meta_type'],
                'description' => $line['description'],
            ]);
        }

        return $transaction;
    }

    /**
     * Generate a journal entry for a transaction.
     *
     * @param array $data
     * @param array $lines
     * @param int $totalDebit
     * @param int $totalCredit
     * @param string $prefix
     * @param Transaction $transaction
     * @return Journal
     */
    protected static function generateJournal(array $data, array $lines, int $totalDebit, int $totalCredit, string $prefix, Transaction $transaction): Journal
    {
        $journal = Journal::create([
            'journal_number' => 'JR-' . $prefix . '-' . now()->format('YmdHis'),
            'journal_date' => $data['transaction_date'],
            'description' => $data['description'] ?? '-',
            'total_debit' => $totalDebit,
            'total_credit' => $totalCredit,
            'period_id' => $data['period_id'],
            'sub_period_id' => $data['sub_period_id'],
            'transaction_id' => $transaction->id,
            'posted_by' => Auth::id(),
            'posted_at' => Carbon::now(),
        ]);

        foreach ($lines as $line) {
            $position = $line['position']->value ?? $line['position'];

            $amountDebit = $position === NormalBalanceEnum::DEBIT->value
                ? (float) $line['amount']
                : 0;

            $amountCredit = $position === NormalBalanceEnum::CREDIT->value
                ? (float) $line['amount']
                : 0;

            JournalDetail::create([
                'journal_id' => $journal->id,
                'chart_of_account_id' => $line['coa_id'],
                'debit' => $amountDebit,
                'credit' => $amountCredit,
                'description' => $line['description'],
            ]);

            // Update CoaBalance for the specific chart of account, period, and sub-period
            self::updateCoaBalance(
                $line['coa_id'],
                $data['period_id'],
                $data['sub_period_id'],
                $amountDebit,
                $amountCredit
            );
        }

        return $journal;
    }
    /**
     * Generate a transaction line array for journal entry.
     *
     * @param string $coaId
     * @param float $amount
     * @param string $position
     * @param MetaTypeTransactionEnum $meta
     * @param string|null $reference
     * @return array
     */
    protected static function line(string $coaId, float $amount, string $position, MetaTypeTransactionEnum $meta, ?string $reference = null): array
    {
        return [
            'coa_id' => $coaId,
            'amount' => $amount,
            'position' => $position,
            'debit' => $position === NormalBalanceEnum::DEBIT->value ? $amount : 0,
            'credit' =>  $position === NormalBalanceEnum::CREDIT->value ? $amount : 0,
            'meta_type' => $meta->value,
            'description' => TransactionHelper::generateLineDescription($coaId, $reference),
        ];
    }

    /**
     * Update the CoaBalance for a specific chart of account, period, and sub-period.
     *
     * @param string $coaId
     * @param string $periodId
     * @param string $subPeriodId
     * @param float $debit
     * @param float $credit
     * @return void
     */
    protected static function updateCoaBalance(
        string $coaId,
        string $periodId,
        string $subPeriodId,
        float $debit,
        float $credit
    ): void {
        $coa = ChartOfAccount::findOrFail($coaId);

        // Normalisasi string normal_balance ke Uppercase untuk menghindari Mismatch
        $normalBalanceStr = strtoupper(
            is_object($coa->normal_balance) ? $coa->normal_balance->value : (string) $coa->normal_balance
        );

        // 1. Ambil atau buat record CoaBalance
        $coaBalance = CoaBalance::firstOrCreate(
            [
                'chart_of_account_id' => $coaId,
                'period_id'          => $periodId,
                'sub_period_id'      => $subPeriodId,
            ],
            [
                'opening_balance'     => 0,
                'debit_total'         => 0,
                'credit_total'        => 0,
                'current_balance'     => 0,
            ]
        );

        // 2. Tambahkan akumulasi mutasi ke database
        $coaBalance->increment('debit_total', $debit);
        $coaBalance->increment('credit_total', $credit);

        // 3. Refresh model untuk mendapatkan nilai debit_total & credit_total paling mutakhir
        $coaBalance->refresh();

        // 4. Hitung Ulang Current Balance secara utuh (Termasuk Saldo Awal)
        if ($normalBalanceStr === 'DEBIT') {
            $newBalance = $coaBalance->opening_balance + ($coaBalance->debit_total - $coaBalance->credit_total);
        } else {
            $newBalance = $coaBalance->opening_balance + ($coaBalance->credit_total - $coaBalance->debit_total);
        }

        // 5. Simpan saldo akhir baru
        $coaBalance->update([
            'current_balance'     => $newBalance,
            'last_transaction_at' => now(),
        ]);
    }

    /**
     * Revert / batalkan efek jurnal lama pada CoaBalance sebelum dihapus.
     * 
     * @param Journal $journal
     * @return void
     * @throws Exception
     */
    protected static function revertJournal(Journal $journal): void
    {
        foreach ($journal->details as $detail) {
            $coa = ChartOfAccount::findOrFail($detail->chart_of_account_id);
            $normalBalanceStr = strtoupper(
                is_object($coa->normal_balance) ? $coa->normal_balance->value : (string) $coa->normal_balance
            );

            $coaBalance = CoaBalance::where([
                'chart_of_account_id' => $detail->chart_of_account_id,
                'period_id' => $journal->period_id,
                'sub_period_id' => $journal->sub_period_id,
            ])->first();

            if ($coaBalance) {
                // Kurangi akumulasi debit dan kredit total
                $coaBalance->decrement('debit_total', $detail->debit);
                $coaBalance->decrement('credit_total', $detail->credit);

                $coaBalance->refresh();

                // Hitung ulang current balance secara utuh
                if ($normalBalanceStr === 'DEBIT') {
                    $newBalance = $coaBalance->opening_balance + ($coaBalance->debit_total - $coaBalance->credit_total);
                } else {
                    $newBalance = $coaBalance->opening_balance + ($coaBalance->credit_total - $coaBalance->debit_total);
                }

                $coaBalance->update([
                    'current_balance' => $newBalance,
                    'last_transaction_at' => now(),
                ]);
            }
        }
    }
}
