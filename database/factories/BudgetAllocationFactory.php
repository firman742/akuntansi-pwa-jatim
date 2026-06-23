<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\BudgetAllocation;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\BudgetAllocation>
 */
final class BudgetAllocationFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = BudgetAllocation::class;

    /**
    * Define the model's default state.
    *
    * @return array
    */
    public function definition(): array
    {
        return [
            'from_chart_of_account_id' => \App\Models\ChartOfAccount::factory(),
            'to_chart_of_account_id' => \App\Models\ChartOfAccount::factory(),
            'period_id' => \App\Models\Period::factory(),
            'sub_period_id' => \App\Models\SubPeriod::factory(),
            'created_by' => \App\Models\User::factory(),
            'amount' => fake()->randomFloat(2, 0, 9999999999999),
            'allocation_type' => fake()->randomElement(['manual', 'auto']),
            'description' => fake()->optional()->text,
        ];
    }
}
