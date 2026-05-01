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
                "is_closed" => false,
                "closed_at" => null,
                "sub_periods" => [
                    // [
                    //     "name" => "Januari 2023",
                    //     "description" => "Bulan Januari 2023",
                    //     "start_date" => "2023-01-01",
                    //     "end_date" => "2023-01-31",
                    //     "is_active" => true,
                    // ],
                    // [
                    //     "name" => "Februari 2023",
                    //     "description" => "Bulan Februari 2023",
                    //     "start_date" => "2023-02-01",
                    //     "end_date" => "2023-02-28",
                    //     "is_active" => false,
                    // ],
                    // [
                    //     "name" => "Maret 2023",
                    //     "description" => "Bulan Maret 2023",
                    //     "start_date" => "2023-03-01",
                    //     "end_date" => "2023-03-31",
                    //     "is_active" => false,
                    // ],
                    // [
                    //     "name" => "April 2023",
                    //     "description" => "Bulan April 2023",
                    //     "start_date" => "2023-04-01",
                    //     "end_date" => "2023-04-30",
                    //     "is_active" => false,
                    // ],
                    // [
                    //     "name" => "Mei 2023",
                    //     "description" => "Bulan Mei 2023",
                    //     "start_date" => "2023-05-01",
                    //     "end_date" => "2023-05-31",
                    //     "is_active" => false,
                    // ],
                    // [
                    //     "name" => "Juni 2023",
                    //     "description" => "Bulan Juni 2023",
                    //     "start_date" => "2023-06-01",
                    //     "end_date" => "2023-06-30",
                    //     "is_active" => false,
                    // ],
                ],
            ],
            // [
            //     "name" => "2024",
            //     "description" => "Fiscal year 2024",
            //     "start_date" => "2024-01-01",
            //     "end_date" => "2024-12-31",
            //     "is_closed" => false,
            //     "closed_at" => null,
            //     "sub_periods" => [
            //         [
            //             "name" => "Januari 2024",
            //             "description" => "Bulan Januari 2024",
            //             "start_date" => "2024-01-01",
            //             "end_date" => "2024-01-31",
            //             "is_active" => true,
            //         ],
            //         [
            //             "name" => "Februari 2024",
            //             "description" => "Bulan Februari 2024",
            //             "start_date" => "2024-02-01",
            //             "end_date" => "2024-02-29",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "Maret 2024",
            //             "description" => "Bulan Maret 2024",
            //             "start_date" => "2024-03-01",
            //             "end_date" => "2024-03-31",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "April 2024",
            //             "description" => "Bulan April 2024",
            //             "start_date" => "2024-04-01",
            //             "end_date" => "2024-04-30",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "Mei 2024",
            //             "description" => "Bulan Mei 2024",
            //             "start_date" => "2024-05-01",
            //             "end_date" => "2024-05-31",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "Juni 2024",
            //             "description" => "Bulan Juni 2024",
            //             "start_date" => "2024-06-01",
            //             "end_date" => "2024-06-30",
            //             "is_active" => false,
            //         ],
            //     ],
            // ],
            // [
            //     "name" => "2025",
            //     "description" => "Fiscal year 2025",
            //     "start_date" => "2025-01-01",
            //     "end_date" => "2025-12-31",
            //     "is_closed" => false,
            //     "closed_at" => null,
            //     "sub_periods" => [
            //         [
            //             "name" => "Januari 2025",
            //             "description" => "Bulan Januari 2025",
            //             "start_date" => "2025-01-01",
            //             "end_date" => "2025-01-31",
            //             "is_active" => true,
            //         ],
            //         [
            //             "name" => "Februari 2025",
            //             "description" => "Bulan Februari 2025",
            //             "start_date" => "2025-02-01",
            //             "end_date" => "2025-02-28",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "Maret 2025",
            //             "description" => "Bulan Maret 2025",
            //             "start_date" => "2025-03-01",
            //             "end_date" => "2025-03-31",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "April 2025",
            //             "description" => "Bulan April 2025",
            //             "start_date" => "2025-04-01",
            //             "end_date" => "2025-04-30",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "Mei 2025",
            //             "description" => "Bulan Mei 2025",
            //             "start_date" => "2025-05-01",
            //             "end_date" => "2025-05-31",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "Juni 2025",
            //             "description" => "Bulan Juni 2025",
            //             "start_date" => "2025-06-01",
            //             "end_date" => "2025-06-30",
            //             "is_active" => false,
            //         ],
            //     ],
            // ],
            // [
            //     "name" => "2026",
            //     "description" => "Fiscal year 2026",
            //     "start_date" => "2026-01-01",
            //     "end_date" => "2026-12-31",
            //     "is_closed" => false,
            //     "closed_at" => null,
            //     "sub_periods" => [
            //         [
            //             "name" => "Januari 2026",
            //             "description" => "Bulan Januari 2026",
            //             "start_date" => "2026-01-01",
            //             "end_date" => "2026-01-31",
            //             "is_active" => true,
            //         ],
            //         [
            //             "name" => "Februari 2026",
            //             "description" => "Bulan Februari 2026",
            //             "start_date" => "2026-02-01",
            //             "end_date" => "2026-02-28",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "Maret 2026",
            //             "description" => "Bulan Maret 2026",
            //             "start_date" => "2026-03-01",
            //             "end_date" => "2026-03-31",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "April 2026",
            //             "description" => "Bulan April 2026",
            //             "start_date" => "2026-04-01",
            //             "end_date" => "2026-04-30",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "Mei 2026",
            //             "description" => "Bulan Mei 2026",
            //             "start_date" => "2026-05-01",
            //             "end_date" => "2026-05-31",
            //             "is_active" => false,
            //         ],
            //         [
            //             "name" => "Juni 2026",
            //             "description" => "Bulan Juni 2026",
            //             "start_date" => "2026-06-01",
            //             "end_date" => "2026-06-30",
            //             "is_active" => false,
            //         ],
            //     ],
            // ],
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
