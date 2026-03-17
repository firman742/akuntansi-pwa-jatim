<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Period;
use App\Models\ChartOfAccount;
use App\Models\OpeningBalance;
use App\Models\SubPeriod;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class OpeningBalanceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::transaction(function () {

            $period = Period::active()->first();
            $subPeriod = SubPeriod::where('period_id', $period->id)->inRandomOrder()->first();
            $user   = User::query()->inRandomOrder()->first();

            $coas = ChartOfAccount::where('is_active', true)->get();

            foreach ($coas as $coa) {

                $amount = match ($coa->normal_balance) {
                    'debit'  => fake()->numberBetween(1_000_000, 20_000_000),
                    'credit' => fake()->numberBetween(1_000_000, 20_000_000),
                };

                OpeningBalance::create([
                    'chart_of_account_id' => $coa->id,
                    'period_id'           => $period->id,
                    'sub_period_id'       => $subPeriod->id,
                    'created_by'          => $user->id,
                    'balance_type'        => $coa->normal_balance,
                    'amount'              => $amount,
                ]);
            }
        });
    }
}
