<?php

namespace App\Helpers;

use App\Models\OpeningBalance;
use App\Models\TransactionLine;

class CashBalanceHelper
{
    public static function getBalance(string $coaId, string $periodId, string $subPeriodId): float
    {
        // Opening balance
        $opening = OpeningBalance::query()
            ->where('chart_of_account_id', $coaId)
            ->where('period_id', $periodId)
            ->when($subPeriodId, fn($q) => $q->where('sub_period_id', $subPeriodId))
            ->value('amount') ?? 0;

        // Total debit kas
        $totalDebit = TransactionLine::query()
            ->where('chart_of_account_id', $coaId)
            ->whereHas(
                'transaction',
                fn($q) =>
                $q->where('period_id', $periodId)
                    ->where('status', 'POSTED')
                    ->when(
                        $subPeriodId,
                        fn($q) =>
                        $q->where('sub_period_id', $subPeriodId)
                    )
            )
            ->sum('debit_amount');

        // Total credit kas
        $totalCredit = TransactionLine::query()
            ->where('chart_of_account_id', $coaId)
            ->whereHas(
                'transaction',
                fn($q) =>
                $q->where('period_id', $periodId)
                    ->where('status', 'POSTED')
                    ->when(
                        $subPeriodId,
                        fn($q) =>
                        $q->where('sub_period_id', $subPeriodId)
                    )
            )
            ->sum('credit_amount');

        return ($opening + $totalDebit) - $totalCredit;
    }
}
