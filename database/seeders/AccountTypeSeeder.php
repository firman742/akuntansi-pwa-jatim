<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AccountTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $account_types = [
            [
                'id' => 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
                'name' => 'ASET',
                'description' => 'Sumber daya ekonomi yang dimiliki perusahaan (kas, piutang, persediaan, tanah, gedung).',
                'is_active' => true,
            ],
            [
                'id' => 'a1b2c3d4-e5f6-7890-abcd-ef1234567891',
                'name' => 'KEWAJIBAN',
                'description' => 'Kewajiban atau hutang perusahaan kepada pihak lain (utang usaha, utang bank, obligasi).',
                'is_active' => true,
            ],
            [
                'id' => 'a1b2c3d4-e5f6-7890-abcd-ef1234567892',
                'name' => 'EKUITAS',
                'description' => 'Kepemilikan pemilik dalam perusahaan setelah dikurangi kewajiban (modal saham, laba ditahan).',
                'is_active' => true,
            ],
            [
                'id' => 'a1b2c3d4-e5f6-7890-abcd-ef1234567893',
                'name' => 'PENDAPATAN',
                'description' => 'account type representing the inflow of economic benefits from business activities.',
                'is_active' => true,
            ],
            [
                'id' => 'a1b2c3d4-e5f6-7890-abcd-ef1234567894',
                'name' => 'BEBAN',
                'description' => 'account type representing the outflow of economic benefits incurred in the process of generating revenue.',
                'is_active' => true,
            ],
        ];

        foreach ($account_types as $type) {
            \App\Models\AccountType::create($type);
        }
    }
}
