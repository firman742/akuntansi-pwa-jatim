<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\AccountTopup;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\AccountTopup>
 */
final class AccountTopupFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = AccountTopup::class;

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
            'amount' => fake()->word,
            'reason' => fake()->optional()->word,
        ];
    }
}
