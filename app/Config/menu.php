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
                    RoleEnum::SUPER_ADMIN        => self::superAdmin(),
                    RoleEnum::BENDAHARA => self::bendahara(),
                    RoleEnum::USER     => self::accountingUser(),
                },
            ],
        ];
    }

    /* ================= SUPER ADMIN ================= */

    private static function superAdmin(): array
    {
        return [
            self::item(
                'Dashboard',
                'dashboard',
                '/superadmin/dashboard'
            ),
            self::item(
                'Pengguna',
                'user-profile',
                '/superadmin/users',
                ['superadmin/users*'],
            ),
            self::item(
                'Peran & Izin',
                'roles',
                '/superadmin/roles',
                ['superadmin/roles*'],
            ),
            self::item(
                'Log Aktifitas',
                'logs',
                '/superadmin/activity-logs',
                ['superadmin/activity-logs*'],
            )
        ];
    }

    /* ================= BENDAHARA ================= */

    private static function bendahara(): array
    {
        return [
            self::item(
                'Dashboard',
                'dashboard',
                '/bendahara/dashboard',
                ['bendahara/dashboard*']
            ),

            [
                'name' => 'Periode',
                'icon' => 'calendar',
                'active_on' => [
                    'bendahara/periods*',
                    'bendahara/sub-periods*',
                ],
                'subItems' => [
                    self::item(
                        'Periode',
                        null,
                        '/bendahara/periods',
                        ['bendahara/periods*']
                    ),

                    self::item(
                        'Sub Periode',
                        null,
                        '/bendahara/sub-periods',
                        ['bendahara/sub-periods*']
                    ),
                ]
            ],
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
                        'COA (Chart of Account)',
                        null,
                        '/bendahara/master/coas',
                        ['bendahara/master/coas*'],
                        PermissionEnum::COA_VIEW
                    ),
                    self::item(
                        'Pengguna COA',
                        null,
                        '/bendahara/master/account-users',
                        ['bendahara/master/account-users*'],
                        PermissionEnum::COA_ASSIGN_USER
                    ),
                    // self::item(
                    //     'Hirarki Dana',
                    //     null,
                    //     '/bendahara/master/taxes',
                    //     ['bendahara/master/taxes*'],
                    // ),
                ],
            ],
            [
                'name' => 'Saldo & Alokasi Dana',
                'icon' => 'money',
                'active_on' => [
                    'bendahara/opening-balances*',
                    'bendahara/budget-allocations*',
                    'bendahara/user-account-balances*',
                ],
                'subItems' => [
                    self::item(
                        'Saldo Awal',
                        null,
                        '/bendahara/opening-balances',
                        ['bendahara/opening-balances*']
                    ),
                    self::item(
                        'Distribusi Saldo',
                        null,
                        '/bendahara/budget-allocations',
                        ['bendahara/budget-allocations*']
                    ),
                    self::item(
                        'Pembagian Saldo Ke Pengguna',
                        null,
                        '/bendahara/user-account-balances',
                        ['bendahara/user-account-balances*']
                    ),
                    self::item(
                        'Permintaan Dana',
                        null,
                        '/bendahara/budgetasd',
                        ['bendahara/budgetasd*']
                    ),
                ]
            ],
            

            // REPORTS
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
                'Laporan Aktifitas',
                'ledger',
                '/bendahara/reports/activity',
                ['bendahara/reports/activity*']
            ),

            self::item(
                'Laporan Neraca',
                'balance',
                '/bendahara/reports/trial-balance',
                ['bendahara/reports/trial-balance*']
            ),
            self::item(
                'Laporan Transaksi',
                'report',
                '/bendahara/reports/transactions',
                ['bendahara/reports/transactions*']
            )
        ];
    }

    /* ================= ACCOUNTING USER ================= */

    private static function accountingUser(): array
    {
        return [
            self::item(
                'Dashboard',
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
                    // 'user/transactions/draft*',
                    'user/transactions/create*',
                    'user/transactions/histories*'
                ],
                'subItems' => [
                    // self::item(
                    //     'Darft Transaksi',
                    //     null,
                    //     '/user/trnsaction-drafs',
                    //     ['user/trnsaction-drafs*']
                    // ),
                    self::item(
                        'Buat Transaksi',
                        null,
                        '/user/transactions/create',
                        ['user/transactions/create*']
                    ),
                    self::item(
                        'Riwayat Transaksi',
                        null,
                        '/user/transactions/histories',
                        ['user/transactions/histories*']
                    ),
                ]
            ],
            [
                'name' => 'Pengajuan',
                'icon' => 'request',
                'active_on' => [

                ],
                'subItems' => [
                    self::item(
                        'Pengajuan COA Baru',
                        null,
                        '/user/trnsaction-drafs',
                        ['user/trnsaction-drafs*']
                    ),
                    self::item(
                        'Pengajuan Penambahan Dana',
                        null,
                        '/user/transactions/create',
                        ['user/transactions/create*']
                    ),
                    self::item(
                        'Riwayat Pengajuan',
                        null,
                        '/user/transactions/histories',
                        ['user/transactions/histories*']
                    ),
                ]
            ],

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
