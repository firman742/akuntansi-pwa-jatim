<?php

namespace App\Http\Controllers\Superadmin;

use App\Enums\TransactionType;
use App\Http\Controllers\Controller;
use App\Models\ActivityLog;
use App\Models\Journal;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;
use App\Models\User;
use Illuminate\Contracts\View\View;

class DashboardController extends Controller
{
    /**
     * Show all data dashboard realtime for Superadmin POV
     */
    public function index(): View
    {
        /**
         * Active Period
         */
        $activePeriod = Period::query()->orderByDesc('start_date')->first();

        $subPeriods = SubPeriod::query()
            ->where('period_id', $activePeriod?->id)
            ->orderBy('start_date')
            ->get();

        /**
         * Selected Sub Period Filter
         */
        $selectedSubPeriodId = request()->sub_period_id;

        /**
         * Base Queries
         */
        $transactionQuery = Transaction::query()->where('period_id', $activePeriod?->id);
        $journalQuery = Journal::query()->where('period_id', $activePeriod?->id);
        $openingBalanceQuery = OpeningBalance::query()->where('period_id', $activePeriod?->id);

        if ($selectedSubPeriodId) {
            $transactionQuery->where('sub_period_id', $selectedSubPeriodId);
            $journalQuery->where('sub_period_id', $selectedSubPeriodId);
            $openingBalanceQuery->where('sub_period_id', $selectedSubPeriodId);
        }

        /**
         * Summary Metrics
         */
        $totalIncome = (clone $transactionQuery)
            ->where('transaction_type', TransactionType::INCOME)
            ->sum('gross_amount');

        $totalExpense = (clone $transactionQuery)
            ->where('transaction_type', TransactionType::EXPENSE)
            ->sum('gross_amount');

        $totalOpeningBalance = $openingBalanceQuery->sum('amount');
        $netBalance = $totalIncome - $totalExpense;
        $totalCashBalance = $totalOpeningBalance + $netBalance;

        /**
         * Superadmin Metrics
         */
        $totalUsersCount = User::count();

        /**
         * Recent Financial Data
         */
        $recentTransactions = (clone $transactionQuery)
            ->with('creator')
            ->latest()
            ->take(5)
            ->get();

        $recentJournals = (clone $journalQuery)
            ->with('postedBy')
            ->latest()
            ->take(5)
            ->get();

        /**
         * Recent System Activity Logs (Audit Trail)
         */
        $recentActivityLogs = ActivityLog::query()
            ->with('user')
            ->latest()
            ->take(6)
            ->get();

        $transferType = TransactionType::TRANSFER->value;

        /**
         * Chart Data Generation (Cashflow Trend across Sub-Periods)
         */
        $chartLabels = [];
        $chartIncomeData = [];
        $chartExpenseData = [];

        foreach ($subPeriods as $sp) {
            $chartLabels[] = $sp->name;
            $chartIncomeData[] = Transaction::where('sub_period_id', $sp->id)
                ->where('transaction_type', TransactionType::INCOME)
                ->sum('gross_amount');
            $chartExpenseData[] = Transaction::where('sub_period_id', $sp->id)
                ->where('transaction_type', TransactionType::EXPENSE)
                ->sum('gross_amount');
        }

        return view('pages.menus.superadmin.dashboard', compact(
            'activePeriod',
            'subPeriods',
            'selectedSubPeriodId',
            'totalIncome',
            'totalExpense',
            'totalOpeningBalance',
            'netBalance',
            'totalCashBalance',
            'totalUsersCount',
            'recentTransactions',
            'recentJournals',
            'recentActivityLogs',
            'transferType',
            'chartLabels',
            'chartIncomeData',
            'chartExpenseData'
        ));
    }
}
