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
                '/dashboard'
            ),
            self::item(
                'Pengguna',
                'user-profile',
                '/users'
            ),
            self::item(
                'Peran & Izin',
                'roles',
                '/roles'
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
                '/bendahara/periode',
                ['bendahara/periode*']
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
                        '/bendahara/master/account-type',
                        ['bendahara/master/account-type*']
                    ),
                    self::item(
                        'COA (Chart of Account)',
                        null,
                        '/bendahara/master/coa',
                        ['bendahara/master/coa*'],
                        PermissionEnum::COA_VIEW
                    ),
                    self::item(
                        'Pengguna COA',
                        null,
                        '/bendahara/master/account-user',
                        ['bendahara/master/account-user*'],
                        PermissionEnum::COA_ASSIGN_USER
                    ),
                ],
            ],
            self::item(
                'Neraca Saldo Awal',
                'wallet',
                '/bendahara/saldo-awal',
                ['bendahara/saldo-awal*']
            ),
            self::item(
                'Jurnal Umum',
                'database',
                '/bendahara/jurnal-umum',
                ['bendahara/jurnal-umum*']
            ),

            self::item(
                'Buku Besar',
                'ledger',
                '/bendahara/buku-besar',
                ['bendahara/buku-besar*']
            ),
            
            self::item(
                'Laporan Aktifitas',
                'ledger',
                '/bendahara/laporan-aktifitas',
                ['bendahara/laporan-aktifitas*']
            ),

            self::item(
                'Neraca',
                'balance',
                '/bendahara/neraca-saldo',
                ['bendahara/neraca-saldo*']
            ),


            // [
            //     'name' => 'Laporan',
            //     'icon' => 'report',
            //     'active_on' => [
            //         'bendahara/report*'
            //     ],
            //     'subItems' => [
            //         self::item(
            //             'Buku Besar',
            //             null,
            //             '/bendahara/report/buku-besar',
            //             ['bendahara/report/buku-besar*']
            //         ),
            //         self::item(
            //             'Neraca Saldo',
            //             null,
            //             '/bendahara/report/neraca-saldo',
            //             ['bendahara/report/neraca-saldo*']
            //         ),
            //     ],
            // ],
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
                'Penerimaan',
                'income',
                '/user/transaksi/penerimaan',
                ['user/transaksi/penerimaan*']
            ),
            self::item(
                'Pengeluaran',
                'expense',
                '/user/transaksi/pengeluaran',
                ['user/transaksi/pengeluaran*']
            ),
            self::item(
                'Riwayat Transaksi',
                'cash',
                '/user/transaksi/history',
                ['user/transaksi/history*']
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
