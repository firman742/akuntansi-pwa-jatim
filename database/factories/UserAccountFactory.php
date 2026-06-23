<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\UserAccount;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\UserAccount>
 */
final class UserAccountFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = UserAccount::class;

    /**
    * Define the model's default state.
    *
    * @return array
    */
    public function definition(): array
    {
        return [
            'user_id' => \App\Models\User::factory(),
            'coa_id' => \App\Models\ChartOfAccount::factory(),
        ];
    }
}
