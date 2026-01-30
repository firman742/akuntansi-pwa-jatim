<?php

namespace App\Helpers;

use App\Models\OpeningBalance;
use App\Models\TransactionLine;

class CashBalanceHelper
{
    public static function getBalance(string $coaId, string $periodId): float
    {
        // Opening balance
        $opening = OpeningBalance::query()
            ->where('chart_of_account_id', $coaId)
            ->where('period_id', $periodId)
            ->value('amount') ?? 0;

        // Total debit kas
        $totalDebit = TransactionLine::query()
            ->where('chart_of_account_id', $coaId)
            ->whereHas('transaction', fn ($q) =>
                $q->where('period_id', $periodId)
                  ->where('status', 'POSTED')
            )
            ->sum('debit_amount');

        // Total credit kas
        $totalCredit = TransactionLine::query()
            ->where('chart_of_account_id', $coaId)
            ->whereHas('transaction', fn ($q) =>
                $q->where('period_id', $periodId)
                  ->where('status', 'POSTED')
            )
            ->sum('credit_amount');

        return ($opening + $totalDebit) - $totalCredit;
    }
}
