<?php

namespace App\Http\Controllers\Superadmin;

use App\Enums\TransactionType;
use App\Http\Controllers\Controller;
use App\Models\Journal;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;
use Illuminate\View\View;

class DashboardController extends Controller
{
    /**
     * Show all data dashboard realtime
     *
     * @return View
     */
    public function index(): View
    {
        /**
         * Active Period
         */
        $activePeriod = Period::active()->first();

        /**
         * Active Sub Periods
         */
        $subPeriods = SubPeriod::query()
            ->where('period_id', $activePeriod?->id)
            ->orderBy('start_date')
            ->get();

        /**
         * Selected Sub Period
         */
        $selectedSubPeriodId = request()->sub_period_id;

        /**
         * Base Transaction Query
         */
        $transactionQuery = Transaction::query()
            ->where('period_id', $activePeriod?->id);

        /**
         * Base Journal Query
         */
        $journalQuery = Journal::query()
            ->where('period_id', $activePeriod?->id);

        /**
         * Opening Balance Query
         */
        $openingBalanceQuery = OpeningBalance::query()
            ->where('period_id', $activePeriod?->id);

        /**
         * Filter by Sub Period
         */
        if ($selectedSubPeriodId) {
            $transactionQuery->where('sub_period_id', $selectedSubPeriodId);

            $journalQuery->where('sub_period_id', $selectedSubPeriodId);

            $openingBalanceQuery->where('sub_period_id', $selectedSubPeriodId);
        }

        /**
         * Summary
         */
        $totalIncome = (clone $transactionQuery)
            ->where('transaction_type', TransactionType::INCOME)
            ->sum('gross_amount');

        $totalExpense = (clone $transactionQuery)
            ->where('transaction_type', TransactionType::EXPENSE)
            ->sum('gross_amount');

        $totalOpeningBalance = $openingBalanceQuery
            ->sum('amount');

        $netBalance = $totalIncome - $totalExpense;

        $totalCashBalance = $totalOpeningBalance + $netBalance;

        /**
         * Recent Data
         */
        $recentTransactions = (clone $transactionQuery)
            ->latest()
            ->take(5)
            ->get();

        $recentJournals = (clone $journalQuery)
            ->latest()
            ->take(5)
            ->get();

        $transferType = TransactionType::TRANSFER->value;

        return view('pages.menus.superadmin.dashboard', compact(
            'activePeriod',
            'subPeriods',
            'selectedSubPeriodId',
            'totalIncome',
            'totalExpense',
            'totalOpeningBalance',
            'netBalance',
            'totalCashBalance',
            'recentTransactions',
            'recentJournals',
            'transferType'
        ));
    }
}
