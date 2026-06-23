<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\OpeningBalance;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\OpeningBalance>
 */
final class OpeningBalanceFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = OpeningBalance::class;

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
            'created_by' => \App\Models\User::factory(),
            'balance_type' => fake()->randomElement(['DEBIT', 'CREDIT']),
            'amount' => fake()->randomFloat(2, 0, 9999999999999),
            'is_correction' => fake()->randomNumber(1),
            'correction_reason' => fake()->optional()->word,
        ];
    }
}
