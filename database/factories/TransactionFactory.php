<?php

namespace Database\Factories;

use App\Models\User;
use App\Models\Period;
use App\Models\Transaction;
use App\Enums\TransactionType;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

class TransactionFactory extends Factory
{
    protected $model = Transaction::class;

    public function definition(): array
    {
        $period = Period::query()->inRandomOrder()->first();

        return [
            // ❗ Diisi di Seeder (agar unik & terkontrol)
            'transaction_number' => null,

            'transaction_date' => $this->faker->dateTimeBetween(
                $period->start_date,
                $period->end_date
            ),

            'description'      => $this->faker->sentence(4),
            'transaction_type' => TransactionType::INCOME,
            'status'           => 'POSTED',
            'total_amount'     => 0,
            'period_id'        => $period->id,
            'created_by'       => User::query()->inRandomOrder()->value('id'),
        ];
    }
}
