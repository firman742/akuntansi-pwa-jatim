<?php

namespace Database\Factories;

use App\Models\Period;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Period>
 */
class PeriodFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Period::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $startDate = $this->faker->dateTimeBetween('-1 year', 'now');
        $endDate = (clone $startDate)->modify('+1 year');

        return [
            'name' => $startDate->format('Y'),
            'description' => $this->faker->sentence(),
            'start_date' => $startDate->format('Y-m-d'),
            'end_date' => $endDate->format('Y-m-d'),
            'is_closed' => false,
            'closed_at' => null,
            'closed_by' => null,
        ];
    }

    /**
     * Indicate that the period is closed.
     */
    public function closed(): static
    {
        return $this->state(fn (array $attributes) => [
            'is_closed' => true,
            'closed_at' => now(),
            'closed_by' => User::factory(),
        ]);
    }
}
