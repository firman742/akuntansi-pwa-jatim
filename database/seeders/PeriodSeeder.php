<?php

namespace Database\Seeders;

use App\Models\Period;
use Illuminate\Database\Seeder;

class PeriodSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $period_with_sub_periods = [
            [
                "name" => "2026",
                "description" => "Fiscal year 2026",
                "start_date" => "2026-01-01",
                "end_date" => "2026-12-31",
                "sub_periods" => [
                    // [
                    //     "name" => "April 2026",
                    //     "description" => "Bulan April 2026",
                    //     "start_date" => "2026-04-01",
                    //     "end_date" => "2026-04-30",
                    //     "is_closed" => false,
                    //     "closed_at" => null,
                    //     "closed_by" => null,
                    // ],
                    // [
                    //     "name" => "Mei 2026",
                    //     "description" => "Bulan Mei 2026",
                    //     "start_date" => "2026-05-01",
                    //     "end_date" => "2026-05-31",
                    //     "is_closed" => false,
                    //     "closed_at" => null,
                    //     "closed_by" => null,
                    // ],
                    // [
                    //     "name" => "Juni 2026",
                    //     "description" => "Bulan Juni 2026",
                    //     "start_date" => "2026-06-01",
                    //     "end_date" => "2026-06-30",
                    //     "is_closed" => false,
                    //     "closed_at" => null,
                    //     "closed_by" => null,
                    // ],
                    [
                        "name" => "Juli 2026",
                        "description" => "Bulan Juli 2026",
                        "start_date" => "2026-07-01",
                        "end_date" => "2026-07-31",
                        "is_closed" => false,
                        "closed_at" => null,
                        "closed_by" => null,
                    ],
                ],
            ],
        ];

        foreach ($period_with_sub_periods as $period_data) {
            $sub_periods = $period_data["sub_periods"];
            unset($period_data["sub_periods"]);

            $period = Period::create($period_data);
            foreach ($sub_periods as $sub_period_data) {
                $period->subPeriods()->create($sub_period_data);
            }
        }
    }
}
