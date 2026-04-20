<?php

namespace App\Helpers;

use App\Models\OpeningBalance;
use App\Models\TransactionLine;
use App\Enums\NormalBalanceEnum;

class CashBalanceHelper
{
    /**
     * Calculate the cash balance for a given chart of account and period (with optional sub-period).
     *
     * The balance is calculated as:
     *   Balance = Opening Balance + Total Debits - Total Credits
     *
     * @param string $coaId The ID of the chart of account.
     * @param string $periodId The ID of the period.
     * @param string|null $subPeriodId Optional ID of the sub-period.
     * @return float The calculated cash balance.
     */
    public static function getBalance(string $coaId, string $periodId, ?string $subPeriodId = null): float
    {
        // Opening balance
        $opening = OpeningBalance::query()
            ->where('chart_of_account_id', $coaId)
            ->where('period_id', $periodId)
            ->when($subPeriodId, fn($q) => $q->where('sub_period_id', $subPeriodId))
            ->value('amount') ?? 0;

        // Base query (biar tidak duplicate logic)
        $baseQuery = TransactionLine::query()
            ->where('chart_of_account_id', $coaId)
            ->whereHas('transaction', function ($q) use ($periodId, $subPeriodId) {
                $q->where('period_id', $periodId)
                  ->where('status', 'POSTED')
                  ->when($subPeriodId, fn($q) => $q->where('sub_period_id', $subPeriodId));
            });

        // Total Debit
        $totalDebit = (clone $baseQuery)
            ->where('position', NormalBalanceEnum::DEBIT)
            ->sum('amount');

        // Total Credit
        $totalCredit = (clone $baseQuery)
            ->where('position', NormalBalanceEnum::CREDIT)
            ->sum('amount');

        return ($opening + $totalDebit) - $totalCredit;
    }
}