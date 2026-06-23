<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\UserAccountBalance;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\UserAccountBalance>
 */
final class UserAccountBalanceFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = UserAccountBalance::class;

    /**
    * Define the model's default state.
    *
    * @return array
    */
    public function definition(): array
    {
        return [
            'user_account_id' => \App\Models\UserAccount::factory(),
            'coa_balance_id' => \App\Models\CoaBalance::factory(),
            'period_id' => \App\Models\Period::factory(),
            'sub_period_id' => \App\Models\SubPeriod::factory(),
            'allocated_by' => \App\Models\User::factory(),
            'allocated_balance' => fake()->randomFloat(2, 0, 9999999999999),
            'used_balance' => fake()->randomFloat(2, 0, 9999999999999),
            'remaining_balance' => fake()->randomFloat(2, 0, 9999999999999),
            'allocated_at' => fake()->optional()->datetime(),
        ];
    }
}
