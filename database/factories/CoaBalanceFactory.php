<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\CoaBalance;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\CoaBalance>
 */
final class CoaBalanceFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = CoaBalance::class;

    /**
    * Define the model's default state.
    *
    * @return array
    */
    public function definition(): array
    {
        return [
            'chart_of_account_id' => \App\Models\ChartOfAccount::factory(),
            'period_id' => \App\Models\Period::factory(),
            'sub_period_id' => \App\Models\SubPeriod::factory(),
            'opening_balance' => fake()->randomFloat(2, 0, 999999999999999999),
            'debit_total' => fake()->randomFloat(2, 0, 999999999999999999),
            'credit_total' => fake()->randomFloat(2, 0, 999999999999999999),
            'current_balance' => fake()->randomFloat(2, 0, 999999999999999999),
            'last_transaction_at' => fake()->datetime(),
        ];
    }
}
