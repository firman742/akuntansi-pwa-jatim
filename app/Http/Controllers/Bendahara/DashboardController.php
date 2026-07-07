<?php

namespace App\Http\Controllers\Bendahara;

use App\Enums\TransactionType;
use App\Http\Controllers\Controller;
use App\Models\Journal;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;

class DashboardController extends Controller
{
    public function index()
    {
        /**
         * Active Period
         */
        $activePeriod = Period::where('start_date', '<=', now())
            ->where('end_date', '>=', now())
            ->first();

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

        /*
        * Closing Reminder: minimum 3 days before sub period end date, if sub period is not closed yet
        */
        $closingReminder = SubPeriod::query()
            ->where('period_id', $activePeriod?->id)
            ->where('is_closed', false)
            ->whereDate('end_date', '<=', now()->addDays(3))
            ->orderBy('end_date')
            ->first();

        $closingStatus = null;
        if ($closingReminder) {
            if ($closingReminder->end_date->isToday()) {

                $closingStatus = 'today';
            } elseif ($closingReminder->end_date->isPast()) {

                $closingStatus = 'expired';
            } else {

                $closingStatus = 'warning';
            }
        }

        /**
         * Closing Checks label
         * TODO: Need Improve with actual checks from database, not hardcoded
         */
        $closingChecks = [
            [
                'label' => 'Seluruh transaksi penerimaan dan pengeluaran telah tercatat',
                'passed' => true,
            ],
            [
                'label' => 'Seluruh jurnal telah diposting',
                'passed' => true,
            ],
            [
                'label' => 'Tidak ada draft transaksi',
                'passed' => true,
            ],
            [
                'label' => 'Saldo kas telah sesuai',
                'passed' => true,
            ],
            [
                'label' => 'Seluruh aktivitas pada sub periode telah selesai',
                'passed' => true,
            ],
        ];

        // dd($closingReminder, $closingStatus);

        return view('pages.menus.bendahara.dashboard', compact(
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
            'transferType',

            'closingReminder',
            'closingStatus',
            'closingChecks'
        ));
    }
}
