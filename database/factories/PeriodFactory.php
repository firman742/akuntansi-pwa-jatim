<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Carbon;

class PeriodFactory extends Factory
{
    public function definition(): array
    {
        // 70% ACTIVE, 30% CLOSED
        $isClosed = $this->faker->boolean(30);

        if ($isClosed) {
            // PERIODE LAMA (CLOSED)
            $start = $this->faker->dateTimeBetween('-2 years', '-6 months');
            $end   = (clone $start)->modify('+3 months');
        } else {
            // PERIODE AKTIF (NOW di dalam range)
            $start = Carbon::now()->subMonths(1);
            $end   = Carbon::now()->addMonths(2);
        }

        return [
            'id'          => $this->faker->uuid,
            'name'        => 'Periode ' . $start->format('F Y'),
            'description' => $this->faker->sentence,
            'start_date'  => $start->format('Y-m-d'),
            'end_date'    => $end->format('Y-m-d'),
            'is_closed'   => $isClosed,

            'closed_at' => $isClosed
                ? Carbon::instance($end)->addDays(rand(1, 10))
                : null,

            'closed_by' => $isClosed
                ? User::factory()
                : null,
        ];
    }
}
