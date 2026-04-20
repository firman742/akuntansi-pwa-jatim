<?php

namespace Database\Seeders;

use App\Models\ChartOfAccount;
use App\Models\Tax;
use Illuminate\Database\Seeder;

class TaxSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Ambil akun dari COA
        $payable = ChartOfAccount::where('code', '21000')->first();
        $expense = ChartOfAccount::where('code', '59999')->first();
        $prepaid = ChartOfAccount::where('code', '11800')->first(); // pastikan ada

        $taxes = [
            [
                'name' => 'PPN 11%',
                'rate' => 11,
                'type' => 'PERCENTAGE',
            ],
            [
                'name' => 'PPH 21',
                'rate' => 5,
                'type' => 'PERCENTAGE',
            ],
            [
                'name' => 'PPH 23',
                'rate' => 2,
                'type' => 'PERCENTAGE',
            ],
        ];

        foreach ($taxes as $tax) {
            Tax::updateOrCreate(
                ['name' => $tax['name']],
                [
                    'rate' => $tax['rate'],
                    'type' => $tax['type'],
                    'account_payable_id' => $payable?->id,
                    'account_expense_id' => $expense?->id,
                    'account_prepaid_id' => $prepaid?->id,
                ]
            );
        }
    }
}
