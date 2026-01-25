<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Carbon;

class PeriodFactory extends Factory
{
    public function definition(): array
    {
        $start = $this->faker->dateTimeBetween('-2 years', '-3 months');
        $end   = (clone $start)->modify('+3 months');

        $isClosed = $this->faker->boolean(30);

        return [
            'id' => $this->faker->uuid,
            'name' => 'Periode ' . $this->faker->monthName . ' ' . $this->faker->year,
            'description' => $this->faker->sentence,
            'start_date' => $start->format('Y-m-d'),
            'end_date' => $end->format('Y-m-d'),
            'is_closed' => $isClosed,

            'closed_at' => $isClosed
                ? Carbon::instance($end)->addDays(rand(1, 10))
                : null,

            'closed_by' => $isClosed ? User::factory() : null,
        ];
    }
}
