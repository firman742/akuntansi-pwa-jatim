<?php

namespace Database\Seeders;

use App\Models\ChartOfAccount;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class ChartOfAccountSeeder extends Seeder
{
    public const ACCOUNT_TYPE = [
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
            ['11120', 'Kas di Bank Jatim', '11100', 3, 2, 'ASET', "DEBIT"],
            ['11130', 'Kas di Bank Jatim Dr. Soetomo', '11100', 3, 3, 'ASET', "DEBIT"],
            ['11140', 'Kas di Bank Bukopin Syariah', '11100', 3, 4, 'ASET', "DEBIT"],
            ['11200', 'Kas Bon', '11000', 2, 2, 'ASET', "DEBIT"],
            ['11300', 'Piutang Karyawan', '11000', 2, 3, 'ASET', "DEBIT"],
            ['11400', 'Piutang Lainnya', '11000', 2, 4, 'ASET', "DEBIT"],
            ['11500', 'Penyertaan Modal Bueka Assakinah', '11000', 2, 5, 'ASET', "DEBIT"],
            ['11600', 'Tabungan Bueka Assakinah', '11000', 2, 6, 'ASET', "DEBIT"],
            ['11700', 'Kos Wonorejo', '11000', 2, 7, 'ASET', "DEBIT"],
            // Tambahan untuk akun pajak dibayar dimuka
            ['11800', 'Pajak Dibayar Dimuka', '11000', 2, 8, 'ASET', "DEBIT"],
            ['11810', 'PPN Masukan', '11800', 3, 1, 'ASET', "DEBIT"],
            ['11820', 'PPh Dibayar Dimuka', '11800', 3, 2, 'ASET', "DEBIT"],

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
            // Tambahan untuk akun hutang pajak
            ['22000', 'Hutang Pajak', null, 1, 4, 'KEWAJIBAN', "CREDIT"],
            ['22100', 'Hutang PPN', '22000', 2, 1, 'KEWAJIBAN', "CREDIT"],
            ['22200', 'Hutang PPh 21', '22000', 2, 2, 'KEWAJIBAN', "CREDIT"],
            ['22300', 'Hutang PPh 23', '22000', 2, 3, 'KEWAJIBAN', "CREDIT"],
            ['22400', 'Hutang PPh Final', '22000', 2, 4, 'KEWAJIBAN', "CREDIT"],

            /* ================= EKUITAS ================= */
            ['31000', 'Aset Bersih', null, 1, 4, 'EKUITAS', "CREDIT"],
            ['31100', 'Modal Tetap', '31000', 2, 1, 'EKUITAS', "CREDIT"],
            ['31200', 'Modal Lancar', '31000', 2, 2, 'EKUITAS', "CREDIT"],
            ['31300', 'Selisih Lebih/Kurang', '31000', 2, 3, 'EKUITAS', "CREDIT"],

            /* ================= PENDAPATAN ================= */
            ['40000', 'Pendapatan', null, 1, 5, 'PENDAPATAN', "DEBIT"],

            ['41000', 'Pendapatan Organisasi', '40000', 2, 1, 'PENDAPATAN', "DEBIT"],
            ['41100', 'Iuran Anggota', '41000', 3, 1, 'PENDAPATAN', "DEBIT"],
            ['41200', 'Dana Wajib Organisasi', '41000', 3, 2, 'PENDAPATAN', "DEBIT"],
            ['41300', 'Zakat Infaq Shadaqoh Organisasi', '41000', 3, 3, 'PENDAPATAN', "DEBIT"],
            ['41400', 'Muhammadiyah', '41000', 3, 4, 'PENDAPATAN', "DEBIT"],
            ['41500', 'Dana Bantuan Organisasi Lainnya', '41000', 3, 5, 'PENDAPATAN', "DEBIT"],
            ['41600', 'Simpanan Wajib Peserta', '41000', 3, 6, 'PENDAPATAN', "DEBIT"],

            ['42000', 'Kontribusi Amal Usaha', '40000', 2, 2, 'PENDAPATAN', "DEBIT"],
            ['42100', 'Kontribusi Bidang Pendidikan', '42000', 3, 1, 'PENDAPATAN', "DEBIT"],
            ['42200', 'Kontribusi Bidang Kesehatan', '42000', 3, 2, 'PENDAPATAN', "DEBIT"],
            ['42300', 'Kontribusi Bidang Ekonomi', '42000', 3, 3, 'PENDAPATAN', "DEBIT"],
            ['42400', 'Kontribusi Media', '42000', 3, 4, 'PENDAPATAN', "DEBIT"],
            ['42500', 'Kontribusi Lainnya', '42000', 3, 5, 'PENDAPATAN', "DEBIT"],

            ['43000', 'Pendapatan Jasa Bank (Neto)', '40000', 2, 3, 'PENDAPATAN', "DEBIT"],
            // Tambahan untuk akun pendapatan jasa bank
            ['43100', 'Pendapatan Bunga Bank', '43000', 3, 1, 'PENDAPATAN', "DEBIT"],
            ['43200', 'Pendapatan Deposito', '43000', 3, 2, 'PENDAPATAN', "DEBIT"],

            ['44000', 'Pendapatan Kerjasama', '40000', 2, 4, 'PENDAPATAN', "DEBIT"],
            ['44001', 'Kerjasama Internal', '44000', 3, 1, 'PENDAPATAN', "DEBIT"],
            ['44002', 'Kerjasama Eksternal', '44000', 3, 2, 'PENDAPATAN', "DEBIT"],
            ['44003', 'Pendapatan Sewa ATC', '44000', 3, 3, 'PENDAPATAN', "DEBIT"],
            ['44004', 'Pendapatan Pembangunan ATC', '44000', 3, 4, 'PENDAPATAN', "DEBIT"],
            ['44005', 'Pendapatan Inklusi', '44000', 3, 5, 'PENDAPATAN', "DEBIT"],

            /* ================= BEBAN ================= */
            ['50000', 'Beban Operasional', null, 1, 5, 'BEBAN', "CREDIT"], // ini tambahan agar bisa menampung semua beban operasional, karena sebelumnya tidak ada akun induk untuk beban operasional
            ['51000', 'Biaya Personalia', '50000', 2, 1, 'BEBAN', "CREDIT"],
            ['51001', 'Biaya Gaji Karyawan & Staf', '51000', 3, 1, 'BEBAN', "CREDIT"],
            ['51002', 'Honorarium/Kontrak', '51000', 3, 2, 'BEBAN', "CREDIT"],
            ['51003', 'Insentif Lembur Karyawan & Staf', '51000', 3, 3, 'BEBAN', "CREDIT"],
            ['51004', 'Uang Makan Karyawan & Staf', '51000', 3, 4, 'BEBAN', "CREDIT"],
            ['51005', 'Tunjangan', '51000', 3, 5, 'BEBAN', "CREDIT"],

            ['52000', 'Biaya Tata Usaha Administrasi Kantor', '50000', 2, 2, 'BEBAN', "CREDIT"],
            ['52100', 'Biaya Kertas & ATK', '52000', 3, 1, 'BEBAN', "CREDIT"],
            ['52200', 'Biaya Listrik, Telepon, Air, & Internet', '52000', 3, 2, 'BEBAN', "CREDIT"],
            ['52300', 'Biaya surat kabar & langganan Media', '52000', 3, 3, 'BEBAN', "CREDIT"],
            ['52400', 'Biaya Cetak-Cetak', '52000', 3, 4, 'BEBAN', "CREDIT"],
            ['52500', 'Biaya Pengiriman', '52000', 3, 5, 'BEBAN', "CREDIT"],
            ['52600', 'Biaya Pemeliharaan Gedung', '52000', 3, 6, 'BEBAN', "CREDIT"],
            ['52700', 'Biaya Pemeliharaan Kendaraan', '52000', 3, 7, 'BEBAN', "CREDIT"],
            ['52800', 'Biaya Asuransi kendaraan', '52000', 3, 8, 'BEBAN', "CREDIT"],
            ['52900', 'Biaya Pemeliharaan Meubel', '52000', 3, 9, 'BEBAN', "CREDIT"],
            ['52010', 'Biaya Pemeliharaan Peralatan Kantor', '52000', 3, 10, 'BEBAN', "CREDIT"],
            ['52011', 'Biaya Kerumahtanggaan', '52000', 3, 11, 'BEBAN', "CREDIT"],
            ['52012', 'Biaya BBM', '52000', 3, 12, 'BEBAN', "CREDIT"],
            ['52013', 'Biaya Parkir', '52000', 3, 13, 'BEBAN', "CREDIT"],
            ['52014', 'Biaya Komunikasi', '52000', 3, 14, 'BEBAN', "CREDIT"],
            ['52015', 'Biaya Administrasi Kantor Lainnya', '52000', 3, 15, 'BEBAN', "CREDIT"],

            ['53000', 'Biaya Depresiasi Aset Tetap', '50000', 2, 3, 'BEBAN', "CREDIT"],
            ['53100', 'Depresiasi Gedung', '53000', 3, 1, 'BEBAN', "CREDIT"],
            ['53200', 'Depresiasi Kendaraan', '53000', 3, 2, 'BEBAN', "CREDIT"],
            ['53300', 'Depresiasi Meubel', '53000', 3, 3, 'BEBAN', "CREDIT"],
            ['53400', 'Depresiasi Peralatan Kantor', '53000', 3, 4, 'BEBAN', "CREDIT"],

            ['54000', 'Biaya Persidangan', '50000', 2, 4, 'BEBAN', "CREDIT"],
            ['54100', 'Biaya Sidang Rutin, Pleno dll', '54000', 3, 1, 'BEBAN', "CREDIT"],
            ['54200', 'Biaya Sidang Muswil/Muspimwil/Konsolidasi & Pembinaan AMM', '54000', 3, 2, 'BEBAN', "CREDIT"],
            ['54300', 'Biaya Sidang Tanwir', '54000', 3, 3, 'BEBAN', "CREDIT"],
            ['54400', 'Biaya Sidang Muktamar', '54000', 3, 4, 'BEBAN', "CREDIT"],

            ['55000', 'Biaya Perjalanan Dinas', '50000', 2, 5, 'BEBAN', "CREDIT"],
            ['55100', 'Biaya Tiket', '55000', 3, 1, 'BEBAN', "CREDIT"],
            ['55200', 'Biaya Transport Lokal', '55000', 3, 2, 'BEBAN', "CREDIT"],
            ['55300', 'Biaya Akomodasi', '55000', 3, 3, 'BEBAN', "CREDIT"],
            ['55400', 'Perdiem Pengiriman Utusan', '55000', 3, 4, 'BEBAN', "CREDIT"],

            ['56000', 'Biaya Pengembangan SDM', '50000', 2, 6, 'BEBAN', "CREDIT"],

            ['57000', 'Biaya Program Organisasi', '50000', 2, 7, 'BEBAN', "CREDIT"],
            ['57100', 'Biaya Pelaksanaan Program', '57000', 3, 1, 'BEBAN', "CREDIT"],
            ['57200', 'Biaya Pelaksanaan Program Majelis & Lembaga', '57000', 3, 2, 'BEBAN', "CREDIT"],
            ['57201', 'Biaya Program Majelis Tablig dan Ketarjihan', '57200', 4, 1, 'BEBAN', "CREDIT"],
            ['57202', 'Biaya Program Pendidikan Anak Usia Dini, Dasar dan Menengah', '57200', 4, 2, 'BEBAN', "CREDIT"],
            ['57203', 'Biaya Program Majelis Kesehatan', '57200', 4, 3, 'BEBAN', "CREDIT"],
            ['57204', 'Biaya Program Ekonomi dan Ketenagakerjaan', '57200', 4, 4, 'BEBAN', "CREDIT"],
            ['57205', 'Biaya Program Pimbinaan Kader', '57200', 4, 5, 'BEBAN', "CREDIT"],
            ['57206', 'Biaya Program Kesejahteraan Sosial', '57200', 4, 6, 'BEBAN', "CREDIT"],
            ['57207', 'Biaya Program Majelis Hukum dan HAM', '57200', 4, 7, 'BEBAN', "CREDIT"],
            ['57208', 'Biaya Program Lembaga Budaya Seni dan Olah Raga', '57200', 4, 8, 'BEBAN', "CREDIT"],
            ['57209', 'Biaya Program Penelitian dan Pengembangan Aisyiyah', '57200', 4, 9, 'BEBAN', "CREDIT"],
            ['57210', 'Biaya Program Lingkungan Hidup dan Penanggulangan Bencana', '57200', 4, 10, 'BEBAN', "CREDIT"],
            ['57300', 'Biaya kehumasan', '57000', 3, 3, 'BEBAN', "CREDIT"],
            ['57400', 'Biaya Diskusi dan Kajian', '57000', 3, 4, 'BEBAN', "CREDIT"],
            ['57500', 'Biaya Pelaksanaan Program Kerjasama', '57000', 3, 5, 'BEBAN', "CREDIT"],
            ['57600', 'Biaya operasional ATC', '57000', 3, 6, 'BEBAN', "CREDIT"],
            ['57700', 'Biaya Pembangunan ATC', '57000', 3, 7, 'BEBAN', "CREDIT"],
            ['57800', 'Biaya Operasional Inklusi', '57000', 3, 8, 'BEBAN', "CREDIT"],

            ['58000', 'Biaya Kesejahteraan', '50000', 2, 8, 'BEBAN', "CREDIT"],
            ['58100', 'Tunjangan Hari Raya', '58000', 3, 1, 'BEBAN', "CREDIT"],
            ['58200', 'Dana Sehat Muhammadiyah', '58000', 3, 2, 'BEBAN', "CREDIT"],
            ['58300', 'Hadiah', '58000', 3, 3, 'BEBAN', "CREDIT"],

            ['59000', 'Biaya Administrasi Bank', '50000', 2, 9, 'BEBAN', "CREDIT"], 
            // untuk biaya administrasi bank, biaya transfer, dll
            ['59100', 'Biaya Pajak Bank', '59000', 3, 1, 'BEBAN', "CREDIT"],
            ['59200', 'Biaya Bunga Bank', '59000', 3, 2, 'BEBAN', "CREDIT"],
            ['59300', 'Biaya Materai', '59000', 3, 3, 'BEBAN', "CREDIT"],
            
            ['59999', 'Biaya Sosial & Lainnya', '50000', 2, 10, 'BEBAN', "CREDIT"],

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
