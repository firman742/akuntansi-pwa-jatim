<?php

namespace Database\Seeders;

use App\Enums\NormalBalanceEnum;
use App\Models\AccountTopup;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\User;
use Illuminate\Database\Seeder;

class AccountTopupSeeder extends Seeder
{
    public function run(): void
    {
        $creator = User::query()
            ->where('email', 'bendahara@example.com')
            ->first();

        if (!$creator) {
            return;
        }

        $coaBalances = CoaBalance::query()
            ->with('chartOfAccount')
            ->inRandomOrder()
            ->limit(50)
            ->get();

        $journalCounter = 1;

        foreach ($coaBalances as $coaBalance) {

            $coa = $coaBalance->chartOfAccount;

            if (!$coa) {
                continue;
            }

            $amount = fake()->numberBetween(
                500_000,
                10_000_000
            );

            /**
             * =====================================================
             * CREATE TOPUP
             * =====================================================
             */
            $topup = AccountTopup::create([
                'chart_of_account_id' => $coa->id,
                'period_id' => $coaBalance->period_id,
                'sub_period_id' => $coaBalance->sub_period_id,
                'created_by' => $creator->id,
                'amount' => $amount,
                'reason' => fake()->randomElement([
                    'Tambahan dana operasional',
                    'Tambahan saldo program',
                    'Tambahan dana kegiatan',
                    'Penyesuaian saldo',
                    'Topup kas',
                ]),
            ]);

            /**
             * =====================================================
             * UPDATE COA BALANCE
             * =====================================================
             */
            if ($coa->normal_balance === NormalBalanceEnum::DEBIT->value) {

                $coaBalance->increment('debit_total', $amount);
            } else {

                $coaBalance->increment('credit_total', $amount);
            }

            $coaBalance->increment('current_balance', $amount);

            $coaBalance->update([
                'last_transaction_at' => now(),
            ]);

            /**
             * =====================================================
             * JOURNAL
             * =====================================================
             */
            $journal = Journal::create([
                'journal_number' => sprintf(
                    'JR-TOPUP-%s-%04d',
                    now()->format('Ymd'),
                    $journalCounter++
                ),

                'journal_date' => now(),

                'description' => 'Topup saldo akun ' . $coa->name,

                'total_debit' => $amount,
                'total_credit' => $amount,

                'posted_by' => $creator->id,
                'posted_at' => now(),

                'period_id' => $coaBalance->period_id,
                'sub_period_id' => $coaBalance->sub_period_id,

                'transaction_id' => null,
            ]);

            /**
             * =====================================================
             * JOURNAL DETAIL
             * =====================================================
             *
             * DR : Akun tujuan (akun yang ditopup)
             * CR : Akun modal/dana sementara
             *
             * Karena tidak ada akun sumber pada tabel topup,
             * gunakan akun ekuitas/modal sebagai balancing.
             */

            JournalDetail::create([
                'journal_id' => $journal->id,
                'chart_of_account_id' => $coa->id,
                'debit' => $amount,
                'credit' => 0,
                'description' => 'Topup saldo akun',
            ]);

            $equityCoa = \App\Models\ChartOfAccount::query()
                ->where('code', '31200') // Modal Lancar
                ->first();

            if ($equityCoa) {

                JournalDetail::create([
                    'journal_id' => $journal->id,
                    'chart_of_account_id' => $equityCoa->id,
                    'debit' => 0,
                    'credit' => $amount,
                    'description' => 'Sumber dana topup',
                ]);
            }
        }
    }
}
