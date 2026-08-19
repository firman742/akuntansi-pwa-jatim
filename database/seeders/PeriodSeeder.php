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
                "name" => "2022",
                "description" => "Fiscal year 2022",
                "start_date" => "2022-01-01",
                "end_date" => "2022-12-31",
                "sub_periods" => [
                    [
                        "name" => "Juli 2022",
                        "description" => "Bulan Desember 2022",
                        "start_date" => "2022-12-01",
                        "end_date" => "2022-12-31",
                        "is_closed" => false,
                        "closed_at" => null,
                        "closed_by" => null,
                    ],
                ],
            ],
            [
                "name" => "2023",
                "description" => "Fiscal year 2023",
                "start_date" => "2023-01-01",
                "end_date" => "2023-12-31",
                "sub_periods" => [
                    [
                        "name" => "Januari 2023",
                        "description" => "Bulan Januari 2023",
                        "start_date" => "2023-01-01",
                        "end_date" => "2023-01-31",
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
