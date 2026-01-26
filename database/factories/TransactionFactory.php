<?php

namespace Database\Factories;

use App\Models\User;
use App\Models\Period;
use App\Models\Transaction;
use App\Enums\TransactionType;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Transaction>
 */
class TransactionFactory extends Factory
{
    protected $model = Transaction::class;

    public function definition(): array
    {
        return [
            'transaction_number' => 'TRX-' . now()->format('Ymd') . '-' . strtoupper($this->faker->bothify('###??')),
            'transaction_date'   => $this->faker->dateTimeBetween('-1 month', 'now'),
            'description'        => $this->faker->sentence(4),
            'transaction_type'   => $this->faker->randomElement(TransactionType::cases()),
            'status'             => 'POSTED',
            'total_amount'       => 0, // diisi setelah detail dibuat
            'period_id'          => Period::query()->inRandomOrder()->first()?->id,
            'created_by'         => User::query()->inRandomOrder()->first()?->id,
        ];
    }
}
