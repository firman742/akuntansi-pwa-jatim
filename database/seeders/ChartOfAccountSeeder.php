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
            ['11000', 'Aset Lancar', null, 1, 1, 'ASET', "DEBIT"],
            ['11100', 'Kas', '11000', 2, 1, 'ASET', "DEBIT"],
            ['11110', 'Kas Ditangan', '11100', 3, 1, 'ASET', "DEBIT"],
            ['11120', 'Kas di Bank Jatim Sidoarjo', '11100', 3, 2, 'ASET', "DEBIT"],
            ['11130', 'Kas di Bank Jatim Dr. Soetomo', '11100', 3, 3, 'ASET', "DEBIT"],
            ['11140', 'Kas di Bank Bukopin Syariah', '11100', 3, 4, 'ASET', "DEBIT"],
            ['11200', 'Kas Bon', '11000', 2, 2, 'ASET', "DEBIT"],
            ['11300', 'Piutang Karyawan', '11000', 2, 3, 'ASET', "DEBIT"],
            ['11400', 'Piutang Lainnya', '11000', 2, 4, 'ASET', "DEBIT"],
            ['11500', 'Penyertaan Modal Bueka Assakinah', '11000', 2, 5, 'ASET', "DEBIT"],
            ['11600', 'Tabungan Bueka Assakinah', '11000', 2, 6, 'ASET', "DEBIT"],
            ['11700', 'Kos Wonorejo', '11000', 2, 7, 'ASET', "DEBIT"],
            ['11800', 'Pajak Dibayar Dimuka', '11000', 2, 8, 'ASET', "DEBIT"],

            ['12000', 'Aset Tidak Lancar', null, 1, 2, 'ASET', "DEBIT"],
            ['12100', 'Tanah', '12000', 2, 1, 'ASET', "DEBIT"],
            ['12200', 'Gedung', '12000', 2, 2, 'ASET', "DEBIT"],
            ['12210', 'Akumulasi Depresiasi Gedung', '12200', 3, 1, 'ASET', "CREDIT"],
            ['12300', 'Kendaraan', '12000', 2, 3, 'ASET', "DEBIT"],
            ['12310', 'Akumulasi Depresiasi Kendaraan', '12300', 3, 1, 'ASET', "CREDIT"],
            ['12400', 'Meubel', '12000', 2, 4, 'ASET', "DEBIT"],
            ['12410', 'Akumulasi Depresiasi Meubel', '12400', 3, 1, 'ASET', "CREDIT"],
            ['12500', 'Peralatan Kantor', '12000', 2, 5, 'ASET', "DEBIT"],
            ['12510', 'Akumulasi Depresiasi Peralatan Kantor', '12500', 3, 1, 'ASET', "CREDIT"],
            ['12600', 'Investasi Jangka Panjang', '12000', 2, 6, 'ASET', "DEBIT"],

            /* ================= KEWAJIBAN ================= */
            ['21000', 'Hutang Pihak Lain', null, 1, 3, 'KEWAJIBAN', "CREDIT"],

            /* ================= EKUITAS ================= */
            ['31000', 'Aset Bersih', null, 1, 4, 'EKUITAS', "CREDIT"],
            ['31100', 'Modal Tetap', '31000', 2, 1, 'EKUITAS', "CREDIT"],
            ['31200', 'Modal Lancar', '31000', 2, 2, 'EKUITAS', "CREDIT"],
            ['31300', 'Selisih Lebih/Kurang', '31000', 2, 3, 'EKUITAS', "CREDIT"],

            /* ================= PENDAPATAN ================= */
            ['40000', 'Pendapatan', null, 1, 5, 'PENDAPATAN', "CREDIT"],

            ['41000', 'Pendapatan Organisasi', '40000', 2, 1, 'PENDAPATAN', "CREDIT"],
            ['41100', 'Iuran Anggota', '41000', 3, 1, 'PENDAPATAN', "CREDIT"],
            ['41200', 'Dana Wajib Organisasi', '41000', 3, 2, 'PENDAPATAN', "CREDIT"],
            ['41300', 'Zakat Infaq Shadaqoh', '41000', 3, 3, 'PENDAPATAN', "CREDIT"],
            ['41400', 'Muhammadiyah', '41000', 3, 4, 'PENDAPATAN', "CREDIT"],
            ['41500', 'Dana Bantuan Organisasi Lainnya', '41000', 3, 5, 'PENDAPATAN', "CREDIT"],
            ['41600', 'Simpanan Wajib Peserta', '41000', 3, 6, 'PENDAPATAN', "CREDIT"],

            ['42000', 'Kontribusi Amal Usaha', '40000', 2, 2, 'PENDAPATAN', "CREDIT"],
            ['42100', 'Kontribusi Bidang Pendidikan', '42000', 3, 1, 'PENDAPATAN', "CREDIT"],
            ['42200', 'Kontribusi Bidang Kesehatan', '42000', 3, 2, 'PENDAPATAN', "CREDIT"],
            ['42300', 'Kontribusi Bidang Ekonomi', '42000', 3, 3, 'PENDAPATAN', "CREDIT"],
            ['42400', 'Kontribusi Media', '42000', 3, 4, 'PENDAPATAN', "CREDIT"],
            ['42500', 'Kontribusi Lainnya', '42000', 3, 5, 'PENDAPATAN', "CREDIT"],

            ['43000', 'Pendapatan Jasa Bank (Neto)', '40000', 2, 3, 'PENDAPATAN', "CREDIT"],

            ['44000', 'Pendapatan Kerjasama', '40000', 2, 4, 'PENDAPATAN', "CREDIT"],
            ['44001', 'Kerjasama Internal', '44000', 3, 1, 'PENDAPATAN', "CREDIT"],
            ['44002', 'Kerjasama Eksternal', '44000', 3, 2, 'PENDAPATAN', "CREDIT"],
            ['44003', 'Pendapatan Sewa ATC', '44000', 3, 3, 'PENDAPATAN', "CREDIT"],
            ['44004', 'Pendapatan Pembangunan ATC', '44000', 3, 4, 'PENDAPATAN', "CREDIT"],
            ['44005', 'Pendapatan Inklusi', '44000', 3, 5, 'PENDAPATAN', "CREDIT"],

            /* ================= BEBAN ================= */
            ['51000', 'Biaya Personalia', null, 1, 6, 'BEBAN', "DEBIT"],
            ['51001', 'Biaya Gaji Karyawan & Staf', '51000', 2, 1, 'BEBAN', "DEBIT"],
            ['51002', 'Honorarium/Kontrak', '51000', 2, 2, 'BEBAN', "DEBIT"],
            ['51003', 'Insentif Lembur', '51000', 2, 3, 'BEBAN', "DEBIT"],
            ['51004', 'Uang Makan', '51000', 2, 4, 'BEBAN', "DEBIT"],
            ['51005', 'Tunjangan', '51000', 2, 5, 'BEBAN', "DEBIT"],

            ['52000', 'Biaya Administrasi Kantor', null, 1, 7, 'BEBAN', "DEBIT"],
            ['52100', 'Biaya Kertas & ATK', '52000', 2, 1, 'BEBAN', "DEBIT"],
            ['52200', 'Biaya Listrik & Internet', '52000', 2, 2, 'BEBAN', "DEBIT"],
            ['52300', 'Biaya Media', '52000', 2, 3, 'BEBAN', "DEBIT"],
            ['52400', 'Biaya Cetak', '52000', 2, 4, 'BEBAN', "DEBIT"],
            ['52500', 'Biaya Pengiriman', '52000', 2, 5, 'BEBAN', "DEBIT"],
            ['52600', 'Biaya Pemeliharaan Gedung', '52000', 2, 6, 'BEBAN', "DEBIT"],
            ['52700', 'Biaya Pemeliharaan Kendaraan', '52000', 2, 7, 'BEBAN', "DEBIT"],
            ['52800', 'Biaya Asuransi', '52000', 2, 8, 'BEBAN', "DEBIT"],
            ['52900', 'Biaya Pemeliharaan Meubel', '52000', 2, 9, 'BEBAN', "DEBIT"],
            ['52010', 'Biaya Pemeliharaan Peralatan', '52000', 2, 10, 'BEBAN', "DEBIT"],
            ['52011', 'Biaya Rumah Tangga', '52000', 2, 11, 'BEBAN', "DEBIT"],
            ['52012', 'Biaya BBM', '52000', 2, 12, 'BEBAN', "DEBIT"],
            ['52013', 'Biaya Parkir', '52000', 2, 13, 'BEBAN', "DEBIT"],
            ['52014', 'Biaya Komunikasi', '52000', 2, 14, 'BEBAN', "DEBIT"],
            ['52015', 'Biaya Administrasi Lainnya', '52000', 2, 15, 'BEBAN', "DEBIT"],

            ['53000', 'Biaya Depresiasi', null, 1, 8, 'BEBAN', "DEBIT"],
            ['53100', 'Depresiasi Gedung', '53000', 2, 1, 'BEBAN', "DEBIT"],
            ['53200', 'Depresiasi Kendaraan', '53000', 2, 2, 'BEBAN', "DEBIT"],
            ['53300', 'Depresiasi Meubel', '53000', 2, 3, 'BEBAN', "DEBIT"],
            ['53400', 'Depresiasi Peralatan', '53000', 2, 4, 'BEBAN', "DEBIT"],

            ['54000', 'Biaya Persidangan', null, 1, 9, 'BEBAN', "DEBIT"],
            ['54100', 'Sidang Rutin', '54000', 2, 1, 'BEBAN', "DEBIT"],
            ['54200', 'Sidang Muswil', '54000', 2, 2, 'BEBAN', "DEBIT"],
            ['54300', 'Sidang Tanwir', '54000', 2, 3, 'BEBAN', "DEBIT"],
            ['54400', 'Sidang Muktamar', '54000', 2, 4, 'BEBAN', "DEBIT"],

            ['55000', 'Biaya Perjalanan Dinas', null, 1, 10, 'BEBAN', "DEBIT"],
            ['55100', 'Tiket', '55000', 2, 1, 'BEBAN', "DEBIT"],
            ['55200', 'Transport Lokal', '55000', 2, 2, 'BEBAN', "DEBIT"],
            ['55300', 'Akomodasi', '55000', 2, 3, 'BEBAN', "DEBIT"],
            ['55400', 'Perdiem', '55000', 2, 4, 'BEBAN', "DEBIT"],

            ['56000', 'Biaya Pengembangan SDM', null, 1, 11, 'BEBAN', "DEBIT"],

            ['57000', 'Biaya Program', null, 1, 12, 'BEBAN', "DEBIT"],
            ['57100', 'Pelaksanaan Program', '57000', 2, 1, 'BEBAN', "DEBIT"],
            ['57200', 'Program Majelis', '57000', 2, 2, 'BEBAN', "DEBIT"],
            ['57201', 'Program Tabligh', '57200', 3, 1, 'BEBAN', "DEBIT"],
            ['57202', 'Program Pendidikan', '57200', 3, 2, 'BEBAN', "DEBIT"],
            ['57203', 'Program Kesehatan', '57200', 3, 3, 'BEBAN', "DEBIT"],
            ['57204', 'Program Ekonomi', '57200', 3, 4, 'BEBAN', "DEBIT"],
            ['57205', 'Program Kader', '57200', 3, 5, 'BEBAN', "DEBIT"],
            ['57206', 'Program Sosial', '57200', 3, 6, 'BEBAN', "DEBIT"],
            ['57207', 'Program Hukum', '57200', 3, 7, 'BEBAN', "DEBIT"],
            ['57208', 'Program Budaya', '57200', 3, 8, 'BEBAN', "DEBIT"],
            ['57209', 'Program Litbang', '57200', 3, 9, 'BEBAN', "DEBIT"],
            ['57210', 'Program Lingkungan', '57200', 3, 10, 'BEBAN', "DEBIT"],

            ['58000', 'Biaya Kesejahteraan', null, 1, 13, 'BEBAN', "DEBIT"],
            ['58100', 'THR', '58000', 2, 1, 'BEBAN', "DEBIT"],
            ['58200', 'Dana Sehat', '58000', 2, 2, 'BEBAN', "DEBIT"],
            ['58300', 'Hadiah', '58000', 2, 3, 'BEBAN', "DEBIT"],

            ['59000', 'Biaya Administrasi Bank', null, 1, 14, 'BEBAN', "DEBIT"], // untuk biaya administrasi bank, biaya transfer, dll
            ['59999', 'Biaya Sosial & Lainnya', null, 1, 15, 'BEBAN', "DEBIT"],

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
