<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Enums\TransactionType;
use App\Http\Controllers\Controller;
use App\Models\ChartOfAccount;
use App\Models\Journal;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class DashboardController extends Controller
{
    /**
     * Show user dashboard with personalized data
     */
    public function index(): View
    {
        $user = Auth::user();

        /**
         * Active Period & Sub Periods
         */
        $activePeriod = Period::query()
            ->latest()
            ->first();

        $subPeriods = SubPeriod::query()
            ->where('period_id', $activePeriod?->id)
            ->orderBy('start_date')
            ->get();

        $selectedSubPeriodId = request()->sub_period_id;

        /**
         * Get COA IDs assigned specifically to this user
         */
        $userCoaIds = ChartOfAccount::query()
            ->whereHas('userAccounts', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->pluck('id');

        /**
         * Base Transaction Query - Strictly personalized by logged-in user
         */
        $transactionQuery = Transaction::query()
            ->where('created_by', $user->id)
            ->where('period_id', $activePeriod?->id);

        $transactionQuery->whereHas('transactionLines', function ($query) use ($userCoaIds) {
            $query->whereIn('chart_of_account_id', $userCoaIds);
        });

        if ($selectedSubPeriodId) {
            $transactionQuery->where('sub_period_id', $selectedSubPeriodId);
        }

        /**
         * Summary Metrics (Personal)
         */
        $totalTransactions = (clone $transactionQuery)->count();

        $totalIncome = (clone $transactionQuery)
            ->where('transaction_type', TransactionType::INCOME)
            ->sum('gross_amount');

        $totalExpense = (clone $transactionQuery)
            ->where('transaction_type', TransactionType::EXPENSE)
            ->sum('gross_amount');

        $netBalance = $totalIncome - $totalExpense;

        /**
         * Recent Personalized Transactions
         */
        $recentTransactions = (clone $transactionQuery)
            ->with('transactionLines.chartOfAccount')
            ->latest()
            ->take(5)
            ->get();

        /**
         * Related Journals created/posted from user transactions
         */
        $recentJournals = Journal::query()
            ->whereHas('transaction', function ($query) use ($user) {
                $query->where('created_by', $user->id);
            })
            ->with('postedBy')
            ->latest()
            ->take(5)
            ->get();

        /**
         * User COA List (Active accounts assigned to user)
         */
        $userCoas = ChartOfAccount::query()
            ->whereIn('id', $userCoaIds)
            ->where('is_active', true)
            ->orderBy('code')
            ->take(5)
            ->get();

        /**
         * Personal Cashflow Chart Data across Sub-Periods
         */
        $chartLabels = [];
        $chartIncomeData = [];
        $chartExpenseData = [];

        foreach ($subPeriods as $sp) {
            $chartLabels[] = $sp->name;
            $chartIncomeData[] = Transaction::where('created_by', $user->id)
                ->where('sub_period_id', $sp->id)
                ->where('transaction_type', TransactionType::INCOME)
                ->sum('gross_amount');
            $chartExpenseData[] = Transaction::where('created_by', $user->id)
                ->where('sub_period_id', $sp->id)
                ->where('transaction_type', TransactionType::EXPENSE)
                ->sum('gross_amount');
        }

        return view('pages.menus.user.dashboard', compact(
            'activePeriod',
            'subPeriods',
            'selectedSubPeriodId',
            'totalTransactions',
            'totalIncome',
            'totalExpense',
            'netBalance',
            'recentTransactions',
            'recentJournals',
            'userCoas',
            'chartLabels',
            'chartIncomeData',
            'chartExpenseData'
        ));
    }
}
