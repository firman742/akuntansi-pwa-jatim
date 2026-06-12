<?php

namespace Database\Seeders;

use App\Enums\ConfigurationTypeEnum;
use App\Models\Configuration;
use Illuminate\Database\Seeder;

class ConfigurationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $configurations = [
            // APP_NAME
            [
                'key' => 'APP_NAME',
                'value' => 'My Laravel App',
                'description' => 'Nama aplikasi yang akan ditampilkan di berbagai tempat seperti judul halaman.',
                'is_active' => true,
                'type' => ConfigurationTypeEnum::STRING->value,
            ],
            // APP_DESCRIPTION
            [
                'key' => 'APP_DESCRIPTION',
                'value' => 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.',
                'description' => 'Deskripsi singkat tentang aplikasi yang dapat digunakan untuk SEO atau ditampilkan di halaman utama.',
                'is_active' => true,
                'type' => ConfigurationTypeEnum::STRING->value,
            ],
            // APP_TAGLINE
            [
                'key' => 'APP_TAGLINE',
                'value' => 'Sistem Informasi Akuntansi untuk pengelolaan keuangan, jurnal, dan laporan secara terintegrasi.',
                'description' => 'Tagline atau slogan yang menggambarkan nilai utama aplikasi.',
                'is_active' => true,
                'type' => ConfigurationTypeEnum::STRING->value,
            ],
            // APP_LOGO
            [
                'key' => 'APP_LOGO',
                'value' => null, // Bisa diisi dengan URL atau path ke logo aplikasi
                'description' => 'Logo aplikasi yang akan ditampilkan di header atau halaman login.',
                'is_active' => true,
                'type' => ConfigurationTypeEnum::IMAGE->value,
            ],
            // APP_BACKGROUND_LOGIN
            [
                'key' => 'APP_BACKGROUND_LOGIN',
                'value' => null, // Bisa diisi dengan URL atau path ke gambar latar belakang login
                'description' => 'Gambar latar belakang untuk halaman login aplikasi.',
                'is_active' => true,
                'type' => ConfigurationTypeEnum::IMAGE->value,
            ],
        ];

        foreach ($configurations as $config) {
            Configuration::updateOrCreate(
                ['key' => $config['key']],
                $config
            );
        }
    }
}
