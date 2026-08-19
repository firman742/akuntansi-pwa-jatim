<?php

namespace App\Config;


use App\Enums\RoleEnum;
use App\Enums\PermissionEnum;

class menu
{
    public static function byRole(RoleEnum $role): array
    {
        return [
            [
                'title' => 'Menu',
                'items' => match ($role) {
                    RoleEnum::SUPER_ADMIN   => self::superAdmin(),
                    RoleEnum::BENDAHARA     => self::bendahara(),
                    RoleEnum::USER          => self::accountingUser(),
                },
            ],
        ];
    }

    /* ================= SUPER ADMIN ================= */

    private static function superAdmin(): array
    {
        return [
            self::item(
                'Beranda',
                'dashboard',
                '/superadmin/dashboard'
            ),
            self::item(
                'Peran & Izin',
                'roles',
                '/superadmin/roles',
                ['superadmin/roles*'],
            ),
            self::item(
                'Pengguna',
                'user-profile',
                '/superadmin/users',
                ['superadmin/users*'],
            ),
            self::item(
                'Log Aktifitas',
                'logs',
                '/superadmin/activity-logs',
                ['superadmin/activity-logs*'],
            ),
            self::item(
                'Pengaturan Sistem',
                'system-config',
                '/superadmin/configurations/edit',
                ['superadmin/configurations/edit*'],
            )
        ];
    }

    /* ================= BENDAHARA ================= */

    /* ================= BENDAHARA ================= */

    private static function bendahara(): array
    {
        return [
            self::item(
                'Beranda',
                'dashboard',
                '/bendahara/dashboard',
                ['bendahara/dashboard*']
            ),

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
                        'Tahun / Periode Utama',
                        null,
                        '/bendahara/periods',
                        ['bendahara/periods*']
                    ),
                    self::item(
                        'Sub Periode (Bulan)',
                        null,
                        '/bendahara/sub-periods',
                        ['bendahara/sub-periods*']
                    ),
                ]
            ],

            // 2. MASTER DATA AKUNTANSI
            [
                'name' => 'Master Data',
                'icon' => 'book',
                'active_on' => [
                    'bendahara/master*'
                ],
                'subItems' => [
                    self::item(
                        'Tipe Akun',
                        null,
                        '/bendahara/master/account-types',
                        ['bendahara/master/account-types*']
                    ),
                    self::item(
                        'Daftar COA', // Diperbaiki dari "Akun COA"
                        null,
                        '/bendahara/master/coas',
                        ['bendahara/master/coas*'],
                        PermissionEnum::COA_VIEW
                    ),
                    self::item(
                        'Penanggung Jawab COA',
                        null,
                        '/bendahara/master/account-users',
                        ['bendahara/master/account-users*'],
                        PermissionEnum::COA_ASSIGN_USER
                    ),
                    self::item(
                        'Pengajuan COA Baru',
                        null,
                        '/bendahara/master/requests/coas',
                        ['bendahara/master/requests/coas*']
                    ),
                ],
            ],

            // 3. SALDO & BUKU BESAR (GENERAL LEDGER)
            [
                'name' => 'Saldo & Buku Besar',
                'icon' => 'money',
                'active_on' => [
                    'bendahara/opening-balances*',
                    'bendahara/coa-balances*',
                ],
                'subItems' => [
                    self::item(
                        'Saldo Awal Periode',
                        null,
                        '/bendahara/opening-balances',
                        ['bendahara/opening-balances*']
                    ),
                    self::item(
                        'Monitoring Saldo COA',
                        null,
                        '/bendahara/coa-balances',
                        ['bendahara/coa-balances*']
                    ),
                ]
            ],

            // 4. ANGGARAN & KAS (TREASURY OPERATIONS)
            [
                'name' => 'Anggaran & Kas',
                'icon' => 'transaction',
                'active_on' => [
                    'bendahara/budget-allocations*',
                    'bendahara/user-account-balances*',
                    'bendahara/requests/balances*',
                ],
                'subItems' => [
                    self::item(
                        'Alokasi Anggaran',
                        null,
                        '/bendahara/budget-allocations',
                        ['bendahara/budget-allocations*']
                    ),
                    self::item(
                        'Kas Operasional User',
                        null,
                        '/bendahara/user-account-balances',
                        ['bendahara/user-account-balances*']
                    ),
                    self::item(
                        'Persetujuan Pencairan Dana',
                        null,
                        '/bendahara/requests/balances',
                        ['bendahara/requests/balances*']
                    ),
                ]
            ],
            self::item(
                'Jurnal Umum',
                'database',
                '/bendahara/reports/journal',
                ['bendahara/reports/journal*']
            ),
            self::item(
                'Buku Besar',
                'ledger',
                '/bendahara/reports/ledger',
                ['bendahara/reports/ledger*']
            ),

            self::item(
                'Laporan Aktivitas', // Diperbaiki ejaan dari "Aktifitas"
                'report',
                '/bendahara/reports/activity',
                ['bendahara/reports/activity*']
            ),
            self::item(
                'Neraca Saldo', // Diperbaiki dari "Laporan Neraca" jika isinya Trial Balance
                'balance',
                '/bendahara/reports/trial-balance',
                ['bendahara/reports/trial-balance*']
            ),
            self::item(
                'Laporan Rincian Transaksi',
                'report',
                '/bendahara/reports/transactions',
                ['bendahara/reports/transactions*']
            ),
        ];
    }

    /* ================= ACCOUNTING USER ================= */

    private static function accountingUser(): array
    {
        return [
            self::item(
                'Beranda',
                'dashboard',
                '/user/dashboard',
                ['user/dashboard*']
            ),
            [
                'name' => 'Dana & Saldo',
                'icon' => 'money',
                'active_on' => [
                    'user/coas*',
                    'user/user-account-balances*',
                ],
                'subItems' => [
                    self::item(
                        'Daftar COA',
                        null,
                        '/user/coas',
                        ['user/coas*']
                    ),
                    self::item(
                        'Saldo Saya',
                        null,
                        '/user/user-account-balances',
                        ['user/user-account-balances*']
                    ),
                ]
            ],
            [
                'name' => 'Transaksi',
                'icon' => 'transaction',
                'active_on' => [
                    'user/transactions/incomes*',
                    'user/transactions/expenses*'
                ],
                'subItems' => [
                    self::item(
                        'Transaksi Penerimaan',
                        null,
                        '/user/transactions/incomes',
                        ['user/transactions/incomes*']
                    ),
                    self::item(
                        'Transaksi Pengeluaran',
                        null,
                        '/user/transactions/expenses',
                        ['user/transactions/expenses*']
                    ),
                ]
            ],
            [
                'name' => 'Pengajuan',
                'icon' => 'request',
                'active_on' => [
                    'user/requests/coas*',
                    'user/requests/balances*',
                ],
                'subItems' => [
                    self::item(
                        'Pengajuan COA Baru',
                        null,
                        '/user/requests/coas',
                        ['user/requests/coas*']
                    ),
                    self::item(
                        'Pengajuan Penambahan Dana',
                        null,
                        '/user/requests/balances',
                        ['user/requests/balances*']
                    ),
                ]
            ],
            self::item(
                'Riwayat Transaksi',
                'report',
                '/user/transactions/histories',
                ['user/transactions/histories*']
            ),

        ];
    }

    /* ================= HELPER ================= */

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
