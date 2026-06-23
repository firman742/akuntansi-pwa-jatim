<?php

namespace Database\Seeders;

use App\Models\BudgetAllocation;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class BudgetAllocationSeeder extends Seeder
{
    public function run(): void
    {
        $creator = User::query()
            ->where('email', 'bendahara@example.com')
            ->first();

        if (!$creator) {
            return;
        }

        $balances = CoaBalance::query()
            ->with([
                'chartOfAccount',
                'period',
                'subPeriod',
            ])
            ->where('current_balance', '>', 1000000)
            ->get();

        foreach ($balances as $fromBalance) {

            DB::transaction(function () use ($fromBalance, $creator) {

                /**
                 * Ambil akun tujuan berbeda
                 */
                $targetBalances = CoaBalance::query()
                    ->where('period_id', $fromBalance->period_id)
                    ->where('sub_period_id', $fromBalance->sub_period_id)
                    ->where('chart_of_account_id', '!=', $fromBalance->chart_of_account_id)
                    ->inRandomOrder()
                    ->take(rand(1, 3))
                    ->get();

                foreach ($targetBalances as $toBalance) {

                    /**
                     * Maksimal 20% saldo akun sumber
                     */
                    $maxAllocation =
                        floor($fromBalance->current_balance * 0.20);

                    if ($maxAllocation < 100000) {
                        continue;
                    }

                    $amount = fake()->numberBetween(
                        100000,
                        $maxAllocation
                    );

                    /**
                     * Budget Allocation
                     */
                    $allocation = BudgetAllocation::create([
                        'from_chart_of_account_id' => $fromBalance->chart_of_account_id,
                        'to_chart_of_account_id' => $toBalance->chart_of_account_id,
                        'period_id' => $fromBalance->period_id,
                        'sub_period_id' => $fromBalance->sub_period_id,
                        'created_by'  => $creator->id,
                        'amount'  => $amount,
                        'allocation_type' => "auto",
                        'description'  => 'Seeder budget allocation',
                    ]);

                    /**
                     * UPDATE FROM BALANCE
                     */
                    $fromBalance->increment(
                        'credit_total',
                        $amount
                    );

                    $fromBalance->decrement(
                        'current_balance',
                        $amount
                    );

                    /**
                     * UPDATE TO BALANCE
                     */
                    $toBalance->increment(
                        'debit_total',
                        $amount
                    );

                    $toBalance->increment(
                        'current_balance',
                        $amount
                    );

                    /**
                     * JOURNAL
                     */
                    $journal = Journal::create([
                        'journal_number' => 'JRNL-'
                            . now()->format('YmdHis')
                            . '-'
                            . strtoupper(Str::random(5)),

                        'journal_date' => now(),

                        'description' => 'Alokasi dana dari '
                            . $fromBalance->chartOfAccount->name
                            . ' ke '
                            . $toBalance->chartOfAccount->name,

                        'total_debit' => $amount,

                        'total_credit' => $amount,

                        'posted_by' => $creator->id,

                        'posted_at' => now(),

                        'period_id' => $fromBalance->period_id,

                        'sub_period_id' => $fromBalance->sub_period_id,
                    ]);

                    /**
                     * DEBIT
                     */
                    JournalDetail::create([
                        'journal_id'
                        => $journal->id,

                        'chart_of_account_id'
                        => $toBalance->chart_of_account_id,

                        'debit'
                        => $amount,

                        'credit'
                        => 0,

                        'description'
                        => 'Debit alokasi dana',
                    ]);

                    /**
                     * CREDIT
                     */
                    JournalDetail::create([
                        'journal_id'
                        => $journal->id,

                        'chart_of_account_id'
                        => $fromBalance->chart_of_account_id,

                        'debit'
                        => 0,

                        'credit'
                        => $amount,

                        'description'
                        => 'Credit alokasi dana',
                    ]);
                }
            });
        }
    }
}
