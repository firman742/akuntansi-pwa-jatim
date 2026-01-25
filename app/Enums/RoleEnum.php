<?php

namespace App\Enums;

use App\Enums\PermissionEnum;

enum RoleEnum: string
{
    case SUPER_ADMIN = 'SUPER ADMIN';
    case BENDAHARA   = 'BENDAHARA';
    case USER        = 'ACCOUNTING USER';

    /**
     * Permissions attached to role
     */
    public function permissions(): array
    {
        return match ($this) {

            self::SUPER_ADMIN => PermissionEnum::cases(),

            self::BENDAHARA => [
                // Dashboard
                PermissionEnum::VIEW_DASHBOARD_BENDAHARA,

                // COA
                PermissionEnum::COA_VIEW,
                PermissionEnum::COA_CREATE,
                PermissionEnum::COA_UPDATE,
                PermissionEnum::COA_DELETE,
                PermissionEnum::COA_IMPORT,
                PermissionEnum::COA_ASSIGN_USER,
                PermissionEnum::COA_REMOVE_USER,

                // Accounting
                PermissionEnum::JOURNAL_POST,
                PermissionEnum::JOURNAL_VIEW,

                PermissionEnum::LEDGER_CREATE,
                PermissionEnum::LEDGER_VIEW,

                // Reports
                PermissionEnum::REPORT_GENERAL_JOURNAL_VIEW,
                PermissionEnum::REPORT_GENERAL_JOURNAL_EXPORT,
                PermissionEnum::REPORT_TRIAL_BALANCE_VIEW,
                PermissionEnum::REPORT_TRIAL_BALANCE_EXPORT,
                PermissionEnum::REPORT_LEDGER_VIEW,
                PermissionEnum::REPORT_LEDGER_EXPORT,
            ],

            self::USER => [
                // COA
                PermissionEnum::COA_VIEW,
                PermissionEnum::COA_REQUEST_CREATE,

                // Transactions
                PermissionEnum::TRANSACTION_INCOME_CREATE,
                PermissionEnum::TRANSACTION_EXPENSE_CREATE,
                PermissionEnum::TRANSACTION_IMPORT,

                // Journal & Ledger
                PermissionEnum::JOURNAL_VIEW,
                PermissionEnum::LEDGER_VIEW_BY_ACCOUNT,

                // Reports
                PermissionEnum::REPORT_LEDGER_VIEW,
                PermissionEnum::REPORT_LEDGER_EXPORT,
            ],
        };
    }
}
