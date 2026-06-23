<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\BalanceRequest;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\BalanceRequest>
 */
final class BalanceRequestFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = BalanceRequest::class;

    /**
    * Define the model's default state.
    *
    * @return array
    */
    public function definition(): array
    {
        return [
            'requester_id' => \App\Models\User::factory(),
            'approver_id' => \App\Models\User::factory(),
            'user_account_id' => \App\Models\UserAccount::factory(),
            'source_coa_id' => \App\Models\CoaBalance::factory(),
            'period_id' => \App\Models\Period::factory(),
            'sub_period_id' => \App\Models\SubPeriod::factory(),
            'amount' => fake()->randomFloat(2, 0, 9999999999999),
            'status' => fake()->randomElement(['pending', 'approved', 'rejected', 'canceled']),
            'purpose' => fake()->optional()->word,
            'note' => fake()->optional()->sentence,
            'approved_at' => fake()->optional()->datetime(),
            'approval_notes' => fake()->optional()->text,
            'rejected_at' => fake()->optional()->datetime(),
            'rejection_reason' => fake()->optional()->text,
        ];
    }
}
