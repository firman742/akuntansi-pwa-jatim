<?php

namespace App\Enums;

enum PermissionEnum: string
{
    /*
    |--------------------------------------------------------------------------
    | Dashboard
    |--------------------------------------------------------------------------
    */
    case VIEW_DASHBOARD_SUPERADMIN = 'view dashboard superadmin';
    case VIEW_DASHBOARD_BENDAHARA  = 'view dashboard bendahara';

        /*
    |--------------------------------------------------------------------------
    | User Management
    |--------------------------------------------------------------------------
    */
    case USER_VIEW   = 'user view';
    case USER_CREATE = 'user create';
    case USER_UPDATE = 'user update';
    case USER_DELETE = 'user delete';

        /*
    |--------------------------------------------------------------------------
    | Role & Permission Management
    |--------------------------------------------------------------------------
    */
    case ROLE_VIEW   = 'role view';
    case ROLE_CREATE = 'role create';
    case ROLE_UPDATE = 'role update';
    case ROLE_DELETE = 'role delete';

    case PERMISSION_VIEW   = 'permission view';
    case PERMISSION_CREATE = 'permission create';
    case PERMISSION_UPDATE = 'permission update';
    case PERMISSION_DELETE = 'permission delete';

        /*
    |--------------------------------------------------------------------------
    | COA (Chart of Account)
    |--------------------------------------------------------------------------
    */
    case COA_VIEW   = 'coa view';
    case COA_CREATE = 'coa create';
    case COA_UPDATE = 'coa update';
    case COA_DELETE = 'coa delete';
    case COA_IMPORT = 'coa import';

    case COA_ASSIGN_USER   = 'coa assign user';
    case COA_REMOVE_USER  = 'coa remove user';

    case COA_REQUEST_CREATE = 'coa request create';

        /*
    |--------------------------------------------------------------------------
    | Accounting Transactions
    |--------------------------------------------------------------------------
    */
    case JOURNAL_POST = 'journal post';
    case JOURNAL_VIEW = 'journal view';

    case TRANSACTION_INCOME_CREATE  = 'transaction income create';
    case TRANSACTION_EXPENSE_CREATE = 'transaction expense create';
    case TRANSACTION_IMPORT         = 'transaction import';

        /*
    |--------------------------------------------------------------------------
    | Ledger
    |--------------------------------------------------------------------------
    */
    case LEDGER_CREATE = 'ledger create';
    case LEDGER_VIEW   = 'ledger view';
    case LEDGER_VIEW_BY_ACCOUNT = 'ledger view by account';

        /*
    |--------------------------------------------------------------------------
    | Financial Reports
    |--------------------------------------------------------------------------
    */
    case REPORT_GENERAL_JOURNAL_VIEW   = 'report general journal view';
    case REPORT_GENERAL_JOURNAL_EXPORT = 'report general journal export';

    case REPORT_TRIAL_BALANCE_VIEW   = 'report trial balance view';
    case REPORT_TRIAL_BALANCE_EXPORT = 'report trial balance export';

    case REPORT_LEDGER_VIEW   = 'report ledger view';
    case REPORT_LEDGER_EXPORT = 'report ledger export';

    /*
    |--------------------------------------------------------------------------
    | Metadata Helper
    |--------------------------------------------------------------------------
    */
    public function group(): string
    {
        return match ($this) {
            self::VIEW_DASHBOARD_SUPERADMIN,
            self::VIEW_DASHBOARD_BENDAHARA
            => 'Dashboard',

            self::USER_VIEW,
            self::USER_CREATE,
            self::USER_UPDATE,
            self::USER_DELETE
            => 'User Management',

            self::ROLE_VIEW,
            self::ROLE_CREATE,
            self::ROLE_UPDATE,
            self::ROLE_DELETE,
            self::PERMISSION_VIEW,
            self::PERMISSION_CREATE,
            self::PERMISSION_UPDATE,
            self::PERMISSION_DELETE
            => 'Role & Permission',

            self::COA_VIEW,
            self::COA_CREATE,
            self::COA_UPDATE,
            self::COA_DELETE,
            self::COA_IMPORT,
            self::COA_ASSIGN_USER,
            self::COA_REMOVE_USER,
            self::COA_REQUEST_CREATE
            => 'Master COA',

            self::JOURNAL_POST,
            self::JOURNAL_VIEW,
            self::TRANSACTION_INCOME_CREATE,
            self::TRANSACTION_EXPENSE_CREATE,
            self::TRANSACTION_IMPORT
            => 'Transactions',

            self::LEDGER_CREATE,
            self::LEDGER_VIEW,
            self::LEDGER_VIEW_BY_ACCOUNT
            => 'Ledger',

            self::REPORT_GENERAL_JOURNAL_VIEW,
            self::REPORT_GENERAL_JOURNAL_EXPORT,
            self::REPORT_TRIAL_BALANCE_VIEW,
            self::REPORT_TRIAL_BALANCE_EXPORT,
            self::REPORT_LEDGER_VIEW,
            self::REPORT_LEDGER_EXPORT
            => 'Reports',
        };
    }

    public function description(): string
    {
        return match ($this) {
            self::VIEW_DASHBOARD_SUPERADMIN => 'Akses dashboard superadmin',
            self::VIEW_DASHBOARD_BENDAHARA  => 'Akses dashboard bendahara',

            self::USER_VIEW   => 'Melihat data user',
            self::USER_CREATE => 'Membuat user baru',
            self::USER_UPDATE => 'Mengubah data user',
            self::USER_DELETE => 'Menghapus user',

            self::ROLE_VIEW   => 'Melihat role',
            self::ROLE_CREATE => 'Membuat role',
            self::ROLE_UPDATE => 'Mengubah role',
            self::ROLE_DELETE => 'Menghapus role',

            self::PERMISSION_VIEW   => 'Melihat permission',
            self::PERMISSION_CREATE => 'Membuat permission',
            self::PERMISSION_UPDATE => 'Mengubah permission',
            self::PERMISSION_DELETE => 'Menghapus permission',

            self::COA_VIEW   => 'Melihat chart of account',
            self::COA_CREATE => 'Membuat akun COA',
            self::COA_UPDATE => 'Mengubah akun COA',
            self::COA_DELETE => 'Menghapus akun COA',
            self::COA_IMPORT => 'Import akun COA',

            self::COA_ASSIGN_USER  => 'Menambahkan user ke COA',
            self::COA_REMOVE_USER => 'Menghapus user dari COA',
            self::COA_REQUEST_CREATE => 'Request pembuatan akun COA',

            self::JOURNAL_POST => 'Posting jurnal umum',
            self::JOURNAL_VIEW => 'Melihat jurnal umum',

            self::TRANSACTION_INCOME_CREATE  => 'Input transaksi pemasukan',
            self::TRANSACTION_EXPENSE_CREATE => 'Input transaksi pengeluaran',
            self::TRANSACTION_IMPORT => 'Import transaksi',

            self::LEDGER_CREATE => 'Generate buku besar',
            self::LEDGER_VIEW   => 'Melihat buku besar',
            self::LEDGER_VIEW_BY_ACCOUNT => 'Melihat buku besar per akun',

            self::REPORT_GENERAL_JOURNAL_VIEW   => 'Melihat laporan jurnal umum',
            self::REPORT_GENERAL_JOURNAL_EXPORT => 'Export laporan jurnal umum',
            self::REPORT_TRIAL_BALANCE_VIEW     => 'Melihat neraca saldo',
            self::REPORT_TRIAL_BALANCE_EXPORT   => 'Export neraca saldo',
            self::REPORT_LEDGER_VIEW            => 'Melihat laporan buku besar',
            self::REPORT_LEDGER_EXPORT          => 'Export laporan buku besar',
        };
    }

    public function isDefault(): bool
    {
        return match ($this) {
            self::COA_IMPORT,
            self::COA_ASSIGN_USER,
            self::COA_REMOVE_USER,
            self::COA_REQUEST_CREATE,
            self::TRANSACTION_IMPORT,
            self::REPORT_GENERAL_JOURNAL_EXPORT,
            self::REPORT_TRIAL_BALANCE_EXPORT,
            self::REPORT_LEDGER_EXPORT
            => false,
            default => true,
        };
    }
}
