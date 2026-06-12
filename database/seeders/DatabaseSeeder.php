<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            ConfigurationSeeder::class,
            RolePermissionSeeder::class,
            UserSeeder::class,
            PeriodSeeder::class,
            AccountTypeSeeder::class,
            ChartOfAccountSeeder::class,
            TaxSeeder::class,
            InterestSeeder::class,
            // OpeningBalanceSeeder::class,
            // TransactionSeeder::class,
        ]);
    }
}
