<?php

namespace App\Config;

use App\Enums\PermissionEnum;
use App\Enums\RoleEnum;

class Menu
{
    public static function byRole(RoleEnum $role): array
    {
        return match ($role) {
            RoleEnum::SUPER_ADMIN => self::superAdmin(),
            RoleEnum::BENDAHARA => self::bendahara(),
            RoleEnum::USER => self::accountingUser(),
        };
    }

    /* ================= SUPER ADMIN ================= */

    private static function superAdmin(): array
    {
        return [
            self::section('Utama', [
                self::item(
                    'Beranda',
                    'dashboard',
                    '/superadmin/dashboard'
                ),
            ]),
            self::section('Master Data', [
                self::item(
                    'Peran & Izin',
                    'roles',
                    '/superadmin/roles',
                    ['superadmin/roles*']
                ),
                self::item(
                    'Pengguna',
                    'user-profile',
                    '/superadmin/users',
                    ['superadmin/users*']
                ),
            ]),
            self::section('Pengaturan', [
                self::item(
                    'Log Aktifitas',
                    'logs',
                    '/superadmin/activity-logs',
                    ['superadmin/activity-logs*']
                ),
                self::item(
                    'Pengaturan Sistem',
                    'system-config',
                    '/superadmin/configurations/edit',
                    ['superadmin/configurations/edit*']
                ),
            ]),
        ];
    }

    /* ================= BENDAHARA ================= */

    private static function bendahara(): array
    {
        return [
            self::section('Utama', [
                self::item(
                    'Beranda',
                    'dashboard',
                    '/bendahara/dashboard',
                    ['bendahara/dashboard*']
                ),
            ]),
            self::section('Manajemen Akuntansi', [
                // 1. PERIODE AKUNTANSI
                [
                    'name' => 'Periode Akuntansi',
                    'icon' => 'calendar',
                    'active_on' => [
                        'bendahara/periods*',
                        'bendahara/sub-periods*',
                    ],
                    'subItems' => [
                        self::item(
                            'Periode Utama (Tahun)',
                            null,
                            '/bendahara/periods',
                            ['bendahara/periods*']
                        ),
                        self::item(
                            'Sub-Periode (Bulan)',
                            null,
                            '/bendahara/sub-periods',
                            ['bendahara/sub-periods*']
                        ),
                    ],
                ],

                // 2. MASTER DATA AKUNTANSI (BAGAN AKUN)
                [
                    'name' => 'Bagan Akun (COA)',
                    'icon' => 'book',
                    'active_on' => [
                        'bendahara/master*',
                    ],
                    'subItems' => [
                        self::item(
                            'Klasifikasi Tipe Akun',
                            null,
                            '/bendahara/master/account-types',
                            ['bendahara/master/account-types*']
                        ),
                        self::item(
                            'Daftar Kode Akun (COA)',
                            null,
                            '/bendahara/master/coas',
                            ['bendahara/master/coas*'],
                            PermissionEnum::COA_VIEW
                        ),
                        self::item(
                            'Penanggung Jawab Akun',
                            null,
                            '/bendahara/master/account-users',
                            ['bendahara/master/account-users*'],
                            PermissionEnum::COA_ASSIGN_USER
                        ),
                        self::item(
                            'Persetujuan Pengajuan COA',
                            null,
                            '/bendahara/master/requests/coas',
                            ['bendahara/master/requests/coas*']
                        ),
                    ],
                ],

                // 3. PENGELOLAAN KAS & SALDO (Penggabungan Anggaran & Saldo)
                [
                    'name' => 'Pengelolaan Kas & Saldo',
                    'icon' => 'money',
                    'active_on' => [
                        'bendahara/opening-balances*',
                        'bendahara/coa-balances*',
                        'bendahara/budget-allocations*',
                        'bendahara/user-account-balances*',
                        'bendahara/requests/balances*',
                    ],
                    'subItems' => [
                        self::item(
                            'Penetapan Saldo Awal',
                            null,
                            '/bendahara/opening-balances',
                            ['bendahara/opening-balances*']
                        ),
                        /* -------------------------------------------------------------
                         * HIDE SEMENTARA: Alokasi Anggaran
                         * -------------------------------------------------------------
                        self::item(
                            'Alokasi Anggaran',
                            null,
                            '/bendahara/budget-allocations',
                            ['bendahara/budget-allocations*']
                        ),
                        ------------------------------------------------------------- */
                        self::item(
                            'Alokasi Kas Operasional',
                            null,
                            '/bendahara/user-account-balances',
                            ['bendahara/user-account-balances*']
                        ),

                        self::item(
                            'Mutasi dan Posisi Saldo Akun',
                            null,
                            '/bendahara/coa-balances',
                            ['bendahara/coa-balances*']
                        ),
                        self::item(
                            'Otorisasi Pencairan Dana',
                            null,
                            '/bendahara/requests/balances',
                            ['bendahara/requests/balances*']
                        ),
                    ],
                ],
            ]),
            self::section('Laporan Keuangan', [
                self::item(
                    'Jurnal Umum',
                    'database',
                    '/bendahara/reports/journal',
                    ['bendahara/reports/journal*']
                ),
                self::item(
                    'Buku Besar Utama',
                    'ledger',
                    '/bendahara/reports/ledger',
                    ['bendahara/reports/ledger*']
                ),
                self::item(
                    'Laporan Aktivitas',
                    'report',
                    '/bendahara/reports/activity',
                    ['bendahara/reports/activity*']
                ),
                self::item(
                    'Neraca Saldo',
                    'balance',
                    '/bendahara/reports/trial-balance',
                    ['bendahara/reports/trial-balance*']
                ),
                self::item(
                    'Rincian Transaksi',
                    'report',
                    '/bendahara/reports/transactions',
                    ['bendahara/reports/transactions*']
                ),
            ]),
        ];
    }

    /* ================= ACCOUNTING USER ================= */

    private static function accountingUser(): array
    {
        return [
            self::section('Utama', [
                self::item(
                    'Beranda',
                    'dashboard',
                    '/user/dashboard',
                    ['user/dashboard*']
                ),
            ]),
            self::section('Dana & Saldo', [
                self::item(
                    'Daftar COA',
                    'book',
                    '/user/coas',
                    ['user/coas*']
                ),
                self::item(
                    'Saldo Saya',
                    'money',
                    '/user/user-account-balances',
                    ['user/user-account-balances*']
                ),
            ]),
            self::section('Transaksi', [
                self::item(
                    'Transaksi Penerimaan',
                    'income',
                    '/user/transactions/incomes',
                    ['user/transactions/incomes*']
                ),
                self::item(
                    'Transaksi Pengeluaran',
                    'expense',
                    '/user/transactions/expenses',
                    ['user/transactions/expenses*']
                ),
                self::item(
                    'Riwayat Transaksi',
                    'report',
                    '/user/transactions/histories',
                    ['user/transactions/histories*']
                ),
            ]),
            self::section('Pengajuan', [
                self::item(
                    'Pengajuan COA Baru',
                    'request',
                    '/user/requests/coas',
                    ['user/requests/coas*']
                ),
                self::item(
                    'Pengajuan Penambahan Dana',
                    'request',
                    '/user/requests/balances',
                    ['user/requests/balances*']
                ),
            ]),
            self::section('Laporan', [
                self::item(
                    'Laporan Transaksi',
                    'report',
                    '/user/reports/transactions',
                    ['user/reports/transactions*']
                ),
            ]),
        ];
    }

    /* ================= HELPER ================= */

    private static function section(string $title, array $items): array
    {
        return [
            'title' => $title,
            'items' => $items,
        ];
    }

    private static function item(
        string $name,
        ?string $icon,
        string $path,
        array $activeOn = [],
        ?PermissionEnum $permission = null
    ): array {
        return [
            'name' => $name,
            'icon' => $icon,
            'path' => $path,
            'active_on' => $activeOn ?: [ltrim($path, '/') . '*'],
            'permission' => $permission,
        ];
    }
}
