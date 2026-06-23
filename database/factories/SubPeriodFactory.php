<?php

namespace Database\Factories;

use App\Models\Period;
use App\Models\SubPeriod;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\SubPeriod>
 */
class SubPeriodFactory extends Factory
{
    protected $model = SubPeriod::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'period_id' => Period::factory(),
            'name' => $this->faker->monthName(),
            'description' => $this->faker->sentence(),
            'start_date' => $this->faker->date(),
            'end_date' => $this->faker->date(),
            'is_active' => true,
        ];
    }
}
