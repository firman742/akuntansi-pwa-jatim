<?php

namespace Database\Seeders;

use App\Enums\NormalBalanceEnum;
use App\Models\ChartOfAccount;
use App\Models\CoaBalance;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\User;
use Illuminate\Database\Seeder;

class OpeningBalanceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $creator = User::query()
            ->where('email', 'bendahara@example.com')
            ->first();

        if (!$creator) {
            return;
        }

        $periods = Period::query()
            ->whereIn('name', ['2025', '2026'])
            ->with('subPeriods')
            ->get();

        $assetTypeId = ChartOfAccountSeeder::ACCOUNT_TYPE['ASET'];

        $debitAccounts = ChartOfAccount::query()
            ->where('account_type_id', $assetTypeId)
            ->where('normal_balance', NormalBalanceEnum::DEBIT->value)
            ->whereDoesntHave('children')
            ->get();

        foreach ($periods as $period) {

            foreach ($period->subPeriods as $subPeriod) {

                foreach ($debitAccounts as $coa) {

                    $amount = fake()->numberBetween(
                        500_000,
                        50_000_000
                    );

                    $openingBalance = OpeningBalance::firstOrCreate(
                        [
                            'chart_of_account_id' => $coa->id,
                            'period_id'           => $period->id,
                            'sub_period_id'       => $subPeriod->id,
                        ],
                        [
                            'created_by'       => $creator->id,
                            'balance_type'     => $coa->normal_balance,
                            'amount'           => $amount,
                            'is_correction'    => false,
                            'correction_reason'=> null,
                        ]
                    );

                    CoaBalance::updateOrCreate(
                        [
                            'chart_of_account_id' => $coa->id,
                            'period_id'           => $period->id,
                            'sub_period_id'       => $subPeriod->id,
                        ],
                        [
                            'opening_balance'    => $openingBalance->amount,
                            'debit_total'        => 0,
                            'credit_total'       => 0,
                            'current_balance'    => $openingBalance->amount,
                            'last_transaction_at'=> null,
                        ]
                    );
                }
            }
        }
    }
}