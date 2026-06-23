<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\ActivityLog;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\ActivityLog>
 */
final class ActivityLogFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = ActivityLog::class;

    /**
    * Define the model's default state.
    *
    * @return array
    */
    public function definition(): array
    {
        return [
            'user_id' => \App\Models\User::factory(),
            'action' => fake()->word,
            'module' => fake()->word,
            'description' => fake()->optional()->text,
            'subject_type' => fake()->optional()->word,
            'subject_id' => fake()->optional()->word,
            'old_values' => fake()->optional()->word,
            'new_values' => fake()->optional()->word,
            'ip_address' => fake()->optional()->word,
            'user_agent' => fake()->optional()->userAgent,
            'additional_data' => fake()->optional()->word,
        ];
    }
}
