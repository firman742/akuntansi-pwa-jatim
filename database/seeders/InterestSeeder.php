<?php

namespace Database\Seeders;

use App\Models\ChartOfAccount;
use App\Models\Interest;
use Illuminate\Database\Seeder;

class InterestSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $interestAccount = ChartOfAccount::where('code', '43000')->first(); // pendapatan bunga
        $expenseAccount = ChartOfAccount::where('code', '59000')->first();  // biaya bank

        $interests = [
            [
                'name' => 'Bunga Tabungan',
                'rate' => 2.5,
                'type' => 'PERCENTAGE',
            ],
            [
                'name' => 'Bunga Deposito',
                'rate' => 5,
                'type' => 'PERCENTAGE',
            ],
            [
                'name' => 'Biaya Administrasi Bank',
                'rate' => 1,
                'type' => 'PERCENTAGE',
            ],
        ];

        foreach ($interests as $interest) {
            Interest::updateOrCreate(
                ['name' => $interest['name']],
                [
                    'rate' => $interest['rate'],
                    'type' => $interest['type'],
                    'account_interest_id' => $interestAccount?->id,
                    'account_expense_id' => $expenseAccount?->id,
                ]
            );
        }
    }
}
