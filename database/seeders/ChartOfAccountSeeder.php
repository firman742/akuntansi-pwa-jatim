<?php

namespace Database\Seeders;

use App\Models\ChartOfAccount;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class ChartOfAccountSeeder extends Seeder
{
    private const ACCOUNT_TYPE = [
        'ASET'       => 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
        'KEWAJIBAN'  => 'a1b2c3d4-e5f6-7890-abcd-ef1234567891',
        'EKUITAS'    => 'a1b2c3d4-e5f6-7890-abcd-ef1234567892',
        'PENDAPATAN' => 'a1b2c3d4-e5f6-7890-abcd-ef1234567893',
        'BEBAN'      => 'a1b2c3d4-e5f6-7890-abcd-ef1234567894',
    ];

    public function run(): void
    {
        $accounts = [
            /* ================= ASET ================= */
            ['11000', 'Aset Lancar', null, 1, 1, 'ASET', 'debit'],
                ['11100', 'Kas', '11000', 2, 1, 'ASET', 'debit'],
                    ['11110', 'Kas Ditangan', '11100', 3, 1, 'ASET', 'debit'],
                    ['11120', 'Kas di Bank Jatim Sidoarjo', '11100', 3, 2, 'ASET', 'debit'],
                    ['11130', 'Kas di Bank Jatim Dr. Soetomo', '11100', 3, 3, 'ASET', 'debit'],
                    ['11140', 'Kas di Bank Bukopin Syariah', '11100', 3, 4, 'ASET', 'debit'],
                ['11200', 'Kas Bon', '11000', 2, 2, 'ASET', 'debit'],
                ['11300', 'Piutang Karyawan', '11000', 2, 3, 'ASET', 'debit'],
                ['11400', 'Piutang Lainnya', '11000', 2, 4, 'ASET', 'debit'],
                ['11500', 'Penyertaan Modal Bueka Assakinah', '11000', 2, 5, 'ASET', 'debit'],
                ['11600', 'Tabungan Bueka Assakinah', '11000', 2, 6, 'ASET', 'debit'],
                ['11700', 'Kos Wonorejo', '11000', 2, 7, 'ASET', 'debit'],
        
            ['12000', 'Aset Tidak Lancar', null, 1, 2, 'ASET', 'debit'],
                ['12100', 'Tanah', '12000', 2, 1, 'ASET', 'debit'],
                ['12200', 'Gedung', '12000', 2, 2, 'ASET', 'debit'],
                    ['12210', 'Akumulasi Depresiasi Gedung', '12200', 3, 1, 'ASET', 'credit'],
                ['12300', 'Kendaraan', '12000', 2, 3, 'ASET', 'debit'],
                    ['12310', 'Akumulasi Depresiasi Kendaraan', '12300', 3, 1, 'ASET', 'credit'],
                ['12400', 'Meubel', '12000', 2, 4, 'ASET', 'debit'],
                    ['12410', 'Akumulasi Depresiasi Meubel', '12400', 3, 1, 'ASET', 'credit'],
                ['12500', 'Peralatan Kantor', '12000', 2, 5, 'ASET', 'debit'],
                    ['12510', 'Akumulasi Depresiasi Peralatan Kantor', '12500', 3, 1, 'ASET', 'credit'],
                ['12600', 'Investasi Jangka Panjang', '12000', 2, 6, 'ASET', 'debit'],
        
            /* ================= KEWAJIBAN ================= */
            ['21000', 'Hutang Pihak Lain', null, 1, 3, 'KEWAJIBAN', 'credit'],
        
            /* ================= EKUITAS ================= */
            ['31000', 'Aset Bersih', null, 1, 4, 'EKUITAS', 'credit'],
                ['31100', 'Modal Tetap', '31000', 2, 1, 'EKUITAS', 'credit'],
                ['31200', 'Modal Lancar', '31000', 2, 2, 'EKUITAS', 'credit'],
                ['31300', 'Selisih Lebih/Kurang', '31000', 2, 3, 'EKUITAS', 'credit'],
        
            /* ================= PENDAPATAN ================= */
            ['40000', 'Pendapatan', null, 1, 5, 'PENDAPATAN', 'credit'],
                ['41000', 'Pendapatan Organisasi', '40000', 2, 1, 'PENDAPATAN', 'credit'],
                    ['41100', 'Iuran Anggota', '41000', 3, 1, 'PENDAPATAN', 'credit'],
                    ['41200', 'Dana Wajib Organisasi', '41000', 3, 2, 'PENDAPATAN', 'credit'],
                    ['41300', 'Zakat Infaq Shadaqoh Organisasi', '41000', 3, 3, 'PENDAPATAN', 'credit'],
                    ['41400', 'Muhammadiyah', '41000', 3, 4, 'PENDAPATAN', 'credit'],
                    ['41500', 'Dana Bantuan Organisasi Lainnya', '41000', 3, 5, 'PENDAPATAN', 'credit'],
                    ['41600', 'Simpanan Wajib Peserta', '41000', 3, 6, 'PENDAPATAN', 'credit'],
        
            /* ================= BEBAN ================= */
            ['51000', 'Biaya Personalia', null, 1, 6, 'BEBAN', 'debit'],
                ['51001', 'Biaya Gaji Karyawan & Staf', '51000', 2, 1, 'BEBAN', 'debit'],
                ['51002', 'Honorarium/Kontrak', '51000', 2, 2, 'BEBAN', 'debit'],
                ['51003', 'Insentif Lembur', '51000', 2, 3, 'BEBAN', 'debit'],
                ['51004', 'Uang Makan Karyawan & Staf', '51000', 2, 4, 'BEBAN', 'debit'],
                ['51005', 'Tunjangan', '51000', 2, 5, 'BEBAN', 'debit'],
                // lanjutkan sesuai urutan lain jika ada
        ];
        

        $coaMap = [];

        foreach ($accounts as [$code, $name, $parentCode, $level, $order, $typeKey, $normal]) {
            $coa = ChartOfAccount::firstOrCreate(
                ['code' => $code],
                [
                    'id' => Str::uuid(),
                    'name' => $name,
                    'parent_id' => $parentCode ? ($coaMap[$parentCode] ?? null) : null,
                    'level' => $level,
                    'order' => $order,
                    'account_type_id' => self::ACCOUNT_TYPE[$typeKey],
                    'normal_balance' => $normal,
                    'is_active' => true,
                ]
            );

            $coaMap[$code] = $coa->id;
        }
    }
}
