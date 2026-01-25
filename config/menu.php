<?php

namespace App\Config;

use App\Enums\RoleEnum;
use App\Enums\PermissionEnum;

class Menu
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
                'Saldo Awal',
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
                'Neraca Saldo',
                'balance',
                '/bendahara/neraca-saldo',
                ['bendahara/neraca-saldo*']
            ),

            [
                'name' => 'Laporan',
                'icon' => 'report',
                'active_on' => [
                    'bendahara/jurnal*'
                ],
                'subItems' => [
                    self::item(
                        'Buku Besar',
                        null,
                        '/bendahara/jurnal/buku-besar',
                        ['bendahara/jurnal/buku-besar*']
                    ),
                    self::item(
                        'Neraca Saldo',
                        null,
                        '/bendahara/jurnal/neraca-saldo',
                        ['bendahara/jurnal/neraca-saldo*']
                    ),
                ],
            ],
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
                'name' => 'Transaksi',
                'icon' => 'cash',
                'active_on' => ['user/transaksi*'],
                'subItems' => [
                    self::item(
                        'Penerimaan',
                        null,
                        '/user/transaksi/penerimaan'
                    ),
                    self::item(
                        'Pengeluaran',
                        null,
                        '/user/transaksi/pengeluaran'
                    ),
                    self::item(
                        'Pindah Kas',
                        null,
                        '/user/transaksi/pindah-kas'
                    ),
                ],
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
