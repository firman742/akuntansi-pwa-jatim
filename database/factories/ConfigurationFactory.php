<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Models\Configuration;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\Configuration>
 */
final class ConfigurationFactory extends Factory
{
    /**
    * The name of the factory's corresponding model.
    *
    * @var string
    */
    protected $model = Configuration::class;

    /**
    * Define the model's default state.
    *
    * @return array
    */
    public function definition(): array
    {
        return [
            'key' => fake()->word,
            'value' => fake()->optional()->text,
            'type' => fake()->randomElement(['string', 'integer', 'boolean', 'array', 'json', 'image']),
            'description' => fake()->optional()->text,
            'is_active' => fake()->randomNumber(1),
        ];
    }
}
