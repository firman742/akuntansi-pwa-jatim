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
            /** GROUP 1 : Master data coa & user account */
            AccountTypeSeeder::class,
            ChartOfAccountSeeder::class,
            UserAccountSeeder::class,

            // /** Group 2 : Opening Balance & Coa Balance */
            // OpeningBalanceSeeder::class,

            // /** Group 3 : Budget Allocation & Journal */
            // BudgetAllocationSeeder::class,

            // /** Group 4 : User Account Balance & Journal */
            // UserAccountBalanceSeeder::class,

            // /** Group 5 : Transaction */
            // TransactionExpenseSeeder::class,

            // /** Group 6 : Request */
            // CoaRequestSeeder::class,
            // BalanceRequestSeeder::class,

            // /** Group 7 : Account Topup */
            // AccountTopupSeeder::class,
            
        ]);
    }
}
