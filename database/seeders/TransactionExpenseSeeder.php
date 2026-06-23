<?php

namespace Database\Seeders;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionType;
use App\Models\ChartOfAccount;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\Transaction;
use App\Models\TransactionLine;
use App\Models\UserAccountBalance;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class TransactionExpenseSeeder extends Seeder
{
    public function run(): void
    {
        $userBalances = UserAccountBalance::query()
            ->with([
                'userAccount.user',
                'userAccount.coa',
                'coaBalance',
                'period',
                'subPeriod',
            ])
            ->where('remaining_balance', '>', 500000)
            ->get();

        /**
         * akun beban level detail
         */
        $expenseAccounts = ChartOfAccount::query()
            ->where('account_type_id', ChartOfAccountSeeder::ACCOUNT_TYPE['BEBAN'])
            ->whereDoesntHave('children')
            ->get();

        foreach ($userBalances as $userBalance) {

            DB::transaction(function () use (
                $userBalance,
                $expenseAccounts
            ) {

                $maxExpense = floor(
                    $userBalance->remaining_balance * 0.30
                );

                if ($maxExpense < 100000) {
                    return;
                }

                $lineCount = rand(1, 4);

                $selectedExpenseAccounts = $expenseAccounts
                    ->shuffle()
                    ->take($lineCount);

                $remainingBudget = fake()->numberBetween(
                    100000,
                    $maxExpense
                );

                $expenseLines = [];

                foreach ($selectedExpenseAccounts as $index => $coa) {

                    if ($index === $selectedExpenseAccounts->count() - 1) {
                        $amount = $remainingBudget;
                    } else {

                        $amount = fake()->numberBetween(
                            50000,
                            floor($remainingBudget / 2)
                        );

                        $remainingBudget -= $amount;
                    }

                    $expenseLines[] = [
                        'coa' => $coa,
                        'amount' => $amount,
                    ];
                }

                $totalExpense = collect($expenseLines)
                    ->sum('amount');

                /**
                 * TRANSACTION
                 */


                $transaction = Transaction::create([
                    'transaction_number' => 'TRX-EXP-' . now()->format('YmdHis') . '-' . Str::upper(Str::random(6)),
                    'transaction_date' => now(),
                    'transaction_type' => TransactionType::EXPENSE,
                    'description' => 'Seeder transaksi pengeluaran',
                    'gross_amount' => $totalExpense,
                    'net_amount' => $totalExpense,
                    'status' => 'POSTED',
                    'period_id' => $userBalance->period_id,
                    'sub_period_id' => $userBalance->sub_period_id,
                    'created_by' => $userBalance->userAccount->user_id,
                ]);

                /**
                 * UPDATE USER BALANCE
                 */
                $userBalance->increment(
                    'used_balance',
                    $totalExpense
                );

                $userBalance->decrement(
                    'remaining_balance',
                    $totalExpense
                );

                /**
                 * JOURNAL
                 */
                $journal = Journal::create([
                    'journal_number' => 'JR-EXP-' . now()->format('YmdHis') . '-' . Str::upper(Str::random(6)),
                    'journal_date' => now(),
                    'description' => 'Seeder transaksi expense',
                    'total_debit' => $totalExpense,
                    'total_credit' => $totalExpense,
                    'period_id' => $userBalance->period_id,
                    'sub_period_id' => $userBalance->sub_period_id,
                    'transaction_id' => $transaction->id,
                    'posted_by' => $userBalance->userAccount->user_id,
                    'posted_at' => now(),
                ]);

                /**
                 * DEBIT BEBAN
                 */
                foreach ($expenseLines as $line) {

                    TransactionLine::create([
                        'transaction_id' => $transaction->id,
                        'chart_of_account_id' => $line['coa']->id,
                        'position' => NormalBalanceEnum::DEBIT,
                        'amount' => $line['amount'],
                        'meta_type' => MetaTypeTransactionEnum::MAIN,
                        'description' => 'Beban operasional',
                    ]);

                    JournalDetail::create([
                        'journal_id' => $journal->id,
                        'chart_of_account_id' => $line['coa']->id,
                        'debit' => $line['amount'],
                        'credit' => 0,
                        'description' => 'Beban operasional',
                    ]);

                    /**
                     * UPDATE COA BALANCE BEBAN
                     */
                    $expenseBalance = CoaBalance::firstOrCreate(
                        [
                            'chart_of_account_id' => $line['coa']->id,
                            'period_id' => $userBalance->period_id,
                            'sub_period_id' => $userBalance->sub_period_id,
                        ],
                        [
                            'opening_balance' => 0,
                            'debit_total' => 0,
                            'credit_total' => 0,
                            'current_balance' => 0,
                        ]
                    );

                    $expenseBalance->debit_total += $line['amount'];
                    $expenseBalance->current_balance += $line['amount'];
                    $expenseBalance->save();
                }

                /**
                 * CREDIT KAS USER
                 */
                TransactionLine::create([
                    'transaction_id' => $transaction->id,
                    'chart_of_account_id' => $userBalance->userAccount->coa_id,
                    'position' => NormalBalanceEnum::CREDIT,
                    'amount' => $totalExpense,
                    'meta_type' => MetaTypeTransactionEnum::MAIN,
                    'description' => 'Kas keluar',
                ]);

                JournalDetail::create([
                    'journal_id' => $journal->id,
                    'chart_of_account_id' => $userBalance->userAccount->coa_id,
                    'debit' => 0,
                    'credit' => $totalExpense,
                    'description' => 'Kas keluar',
                ]);

                /**
                 * UPDATE COA BALANCE SUMBER
                 */
                $sourceBalance = $userBalance->coaBalance;

                $sourceBalance->credit_total += $totalExpense;

                if (
                    $sourceBalance->chartOfAccount->normal_balance
                    === NormalBalanceEnum::DEBIT->value
                ) {
                    $sourceBalance->current_balance -= $totalExpense;
                } else {
                    $sourceBalance->current_balance += $totalExpense;
                }

                $sourceBalance->last_transaction_at = now();
                $sourceBalance->save();
            });
        }
    }
}
