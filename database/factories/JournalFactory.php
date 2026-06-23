<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\Journal;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\Journal>
 */
final class JournalFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = Journal::class;

    /**
    * Define the model's default state.
    *
    * @return array
    */
    public function definition(): array
    {
        return [
            'journal_number' => fake()->word,
            'journal_date' => fake()->date(),
            'description' => fake()->optional()->text,
            'total_debit' => fake()->randomFloat(2, 0, 9999999999999),
            'total_credit' => fake()->randomFloat(2, 0, 9999999999999),
            'posted_by' => \App\Models\User::factory(),
            'posted_at' => fake()->optional()->dateTime(),
            'period_id' => \App\Models\Period::factory(),
            'sub_period_id' => \App\Models\SubPeriod::factory(),
            'transaction_id' => \App\Models\Transaction::factory(),
        ];
    }
}
