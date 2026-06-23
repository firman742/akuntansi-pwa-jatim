<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\ClosingBalance;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\ClosingBalance>
 */
final class ClosingBalanceFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = ClosingBalance::class;

    /**
    * Define the model's default state.
    *
    * @return array
    */
    public function definition(): array
    {
        return [
            'period_id' => \App\Models\Period::factory(),
            'chart_of_account_id' => \App\Models\ChartOfAccount::factory(),
            'created_by' => \App\Models\User::factory(),
            'balance_type' => fake()->randomElement(['DEBIT', 'CREDIT']),
            'amount' => fake()->randomFloat(2, 0, 9999999999999),
        ];
    }
}
