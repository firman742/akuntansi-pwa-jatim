<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\JournalDetail;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\JournalDetail>
 */
final class JournalDetailFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = JournalDetail::class;

    /**
    * Define the model's default state.
    *
    * @return array
    */
    public function definition(): array
    {
        return [
            'journal_id' => \App\Models\Journal::factory(),
            'chart_of_account_id' => \App\Models\ChartOfAccount::factory(),
            'debit' => fake()->randomFloat(2, 0, 9999999999999),
            'credit' => fake()->randomFloat(2, 0, 9999999999999),
            'description' => fake()->optional()->text,
        ];
    }
}
