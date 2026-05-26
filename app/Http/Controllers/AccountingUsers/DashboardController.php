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
     *
     * @return View
     */
    public function index(): View
    {
        $user = Auth::user();

        /**
         * Active Period
         */
        $activePeriod = Period::active()->first();

        /**
         * Sub Periods
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
         * User COA
         */
        $userCoaIds = ChartOfAccount::query()
            ->whereHas('userAccounts', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->pluck('id');

        /**
         * Transaction Query
         */
        $transactionQuery = Transaction::query()
            ->where('created_by', $user->id)
            ->where('period_id', $activePeriod?->id);

        /**
         * Optional:
         * Pastikan transaksi memang menggunakan COA milik user
         */
        $transactionQuery->whereHas('transactionLines', function ($query) use ($userCoaIds) {
            $query->whereIn('chart_of_account_id', $userCoaIds);
        });

        /**
         * Filter sub period
         */
        if ($selectedSubPeriodId) {
            $transactionQuery->where('sub_period_id', $selectedSubPeriodId);
        }

        /**
         * Summary
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
         * Recent Transactions
         */
        $recentTransactions = (clone $transactionQuery)
            ->with('transactionLines.chartOfAccount')
            ->latest()
            ->take(5)
            ->get();

        /**
         * Related Journals
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
         * User COA List
         */
        $userCoas = ChartOfAccount::query()
            ->whereIn('id', $userCoaIds)
            ->where('is_active', true)
            ->orderBy('code')
            ->limit(5)
            ->get();

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

            'userCoas'
        ));
    }
}
