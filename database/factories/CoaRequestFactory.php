<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\CoaRequest;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\CoaRequest>
 */
final class CoaRequestFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = CoaRequest::class;

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
            'parent_coa_id' => \App\Models\ChartOfAccount::factory(),
            'account_type_id' => \App\Models\AccountType::factory(),
            'sub_period_id' => \App\Models\SubPeriod::factory(),
            'proposed_name' => fake()->word,
            'proposed_code' => fake()->word,
            'normal_balance' => fake()->randomElement(['DEBIT', 'CREDIT']),
            'status' => fake()->randomElement(['pending', 'approved', 'rejected', 'canceled']),
            'description' => fake()->optional()->text,
            'approved_at' => fake()->optional()->datetime(),
            'approval_notes' => fake()->optional()->text,
            'rejected_at' => fake()->optional()->datetime(),
            'rejection_reason' => fake()->optional()->text,
        ];
    }
}
