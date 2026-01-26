<?php

namespace Database\Factories;

use App\Models\ChartOfAccount;
use App\Models\TransactionLine;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\TransactionLines>
 */
class TransactionLineFactory extends Factory
{
    protected $model = TransactionLine::class;

    public function definition(): array
    {
        return [
            'chart_of_account_id' => ChartOfAccount::query()->inRandomOrder()->first()?->id,
            'description'         => $this->faker->sentence(3),
            'debit_amount'        => 0,
            'credit_amount'       => 0,
            'line_type'           => 'NORMAL',
        ];
    }
}
