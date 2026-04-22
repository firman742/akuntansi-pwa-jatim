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

            self::item(
                'Periode',
                'calendar',
                '/bendahara/periods',
                ['bendahara/periods*']
            ),
            
            self::item(
                'Sub Periode',
                'calendar',
                '/bendahara/sub-periods',
                ['bendahara/sub-periods*']
            ),
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
                    // pajak
                    self::item(
                        'Pajak',
                        null,
                        '/bendahara/master/taxes',
                        ['bendahara/master/taxes*'],
                    ),
                    // bunga
                    self::item(
                        'Bunga',
                        null,
                        '/bendahara/master/interests',
                        ['bendahara/master/interests*'],
                    ),
                ],
            ],
            self::item(
                'Neraca Saldo Awal',
                'wallet',
                '/bendahara/opening-balances',
                ['bendahara/opening-balances*']
            ),

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
                'Neraca',
                'balance',
                '/bendahara/reports/trial-balance',
                ['bendahara/reports/trial-balance*']
            ),
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
            self::item(
                'Buat Transaksi',
                'income',
                '/user/transactions/create',
                ['user/transactions/create*']
            ),
            // self::item(
            //     'Penerimaan',
            //     'income',
            //     '/user/transactions/incomes',
            //     ['user/transactions/incomes*']
            // ),
            // self::item(
            //     'Pengeluaran',
            //     'expense',
            //     '/user/transactions/expenses',
            //     ['user/transactions/expenses*']
            // ),
            self::item(
                'Riwayat Transaksi',
                'cash',
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
