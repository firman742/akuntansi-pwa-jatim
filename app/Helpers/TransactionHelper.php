<?php

namespace App\Helpers;

use App\Enums\NormalBalanceEnum;
use App\Models\ChartOfAccount;

class TransactionHelper
{
    /**
     * Format transaction description for display
     */
    public function formatTrxDesc(string $type, string $context): string
    {
        return "{$type} - {$context}";
    }

    /**
     * Format transaction line description for display
     */
    public function formatLineDesc(string $role, string $from, string $to): string
    {
        return "{$role} - {$from} → {$to}";
    }


    public static function generateLineDescription($coaId, $position, $meta, $reference): string
    {
        $coa = ChartOfAccount::find($coaId);

        if (!$coa) return 'Transaksi';

        $role = $coa->role;
        $name = $coa->name;

        return match ($role) {

            // ======================
            // CASH
            // ======================
            'CASH' => $position === NormalBalanceEnum::DEBIT->value
                ? "Kas Masuk dari {$reference}"
                : "Kas Keluar untuk {$reference}",

            // ======================
            // REVENUE
            // ======================
            'REVENUE' => "Pendapatan dari {$reference}",

            // ======================
            // EXPENSE
            // ======================
            'EXPENSE' => "Beban untuk {$reference}",

            // ======================
            // TAX
            // ======================
            'TAX_PREPAID' => "Pajak Dibayar Dimuka {$reference}",

            'TAX_PAYABLE' => "Utang Pajak {$reference}",

            // ======================
            // INTEREST
            // ======================
            'INTEREST_INCOME' => "Pendapatan Bunga {$reference}",

            'BANK_FEE' => "Biaya Bank {$reference}",

            default => "{$name} {$reference}",
        };
    }
}
