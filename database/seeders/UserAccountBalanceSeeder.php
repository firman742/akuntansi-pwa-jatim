<?php

namespace Database\Seeders;

use App\Enums\NormalBalanceEnum;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\User;
use App\Models\UserAccount;
use App\Models\UserAccountBalance;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class UserAccountBalanceSeeder extends Seeder
{
    public function run(): void
    {
        $bendahara = User::query()
            ->where('email', 'bendahara@example.com')
            ->first();

        if (!$bendahara) {
            return;
        }

        $userAccounts = UserAccount::query()
            ->with([
                'user',
                'coa',
            ])
            ->get();

        foreach ($userAccounts as $userAccount) {

            DB::transaction(function () use ($userAccount, $bendahara) {
                /**
                 * Ambil balance yang sama COA nya
                 */
                $coaBalances = CoaBalance::query()
                    ->with('chartOfAccount')
                    ->where(
                        'chart_of_account_id',
                        $userAccount->coa_id
                    )
                    ->where('current_balance', '>', 500000)
                    ->get();

                foreach ($coaBalances as $coaBalance) {

                    /**
                     * 5% - 20% saldo tersedia
                     */
                    $maxAllocation = floor(
                        $coaBalance->current_balance * 0.20
                    );

                    if ($maxAllocation < 100000) {
                        continue;
                    }

                    $allocatedAmount = fake()->numberBetween(
                        100000,
                        $maxAllocation
                    );

                    /**
                     * CREATE USER BALANCE
                     */
                    $userBalance = UserAccountBalance::create([
                        'user_account_id'   => $userAccount->id,
                        'coa_balance_id'    => $coaBalance->id,
                        'period_id'         => $coaBalance->period_id,
                        'sub_period_id'     => $coaBalance->sub_period_id,
                        'allocated_by'      => $bendahara->id,

                        'allocated_balance' => $allocatedAmount,
                        'used_balance'      => 0,
                        'remaining_balance' => $allocatedAmount,
                        'allocated_at'      => now(),
                    ]);

                    /**
                     * UPDATE COA BALANCE
                     */
                    $coaBalance->credit_total += $allocatedAmount;

                    if ($coaBalance->chartOfAccount->normal_balance === NormalBalanceEnum::DEBIT->value) {
                        $coaBalance->current_balance -= $allocatedAmount;
                    } else {
                        $coaBalance->current_balance += $allocatedAmount;
                    }

                    $coaBalance->last_transaction_at = now();
                    $coaBalance->save();

                    /**
                     * JOURNAL
                     */
                    $journal = Journal::create([
                        'journal_number' => 'JRN-' . now()->format('YmdHis') . '-' . strtoupper(Str::random(5)),
                        'journal_date' => now(),
                        'description' => 'Distribusi saldo ke user ' . $userAccount->user->name,
                        'total_debit' => $allocatedAmount,
                        'total_credit' => $allocatedAmount,
                        'posted_by' => $bendahara->id,
                        'posted_at' => now(),
                        'period_id' => $coaBalance->period_id,
                        'sub_period_id' => $coaBalance->sub_period_id,
                    ]);

                    /**
                     * DEBIT
                     */
                    JournalDetail::create([
                        'journal_id' => $journal->id,
                        'chart_of_account_id' => $userAccount->coa_id,
                        'debit' => $allocatedAmount,
                        'credit' => 0,
                        'description' => 'Saldo operasional user',
                    ]);

                    /**
                     * CREDIT
                     */
                    JournalDetail::create([
                        'journal_id' => $journal->id,
                        'chart_of_account_id' => $coaBalance->chart_of_account_id,
                        'debit' => 0,
                        'credit' => $allocatedAmount,
                        'description' => 'Distribusi saldo dari akun pusat',
                    ]);
                }
            });
        }
    }
}
