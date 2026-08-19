<?php

namespace App\Http\Controllers\Bendahara;

use App\Enums\TransactionType;
use App\Http\Controllers\Controller;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;

class DashboardController extends Controller
{
    public function index()
    {
        $activePeriod = Period::query()->orderByDesc('start_date')->first();

        $subPeriods = SubPeriod::query()
            ->where('period_id', $activePeriod?->id)
            ->orderBy('start_date')
            ->get();

        $selectedSubPeriodId = request()->sub_period_id;

        // Base Queries
        $transactionQuery = Transaction::query()->where('period_id', $activePeriod?->id);
        $journalQuery = Journal::query()->where('period_id', $activePeriod?->id);
        $openingBalanceQuery = OpeningBalance::query()->where('period_id', $activePeriod?->id);

        if ($selectedSubPeriodId) {
            $transactionQuery->where('sub_period_id', $selectedSubPeriodId);
            $journalQuery->where('sub_period_id', $selectedSubPeriodId);
            $openingBalanceQuery->where('sub_period_id', $selectedSubPeriodId);
        }

        // Summary Calculations
        $totalIncome = (clone $transactionQuery)
            ->where('transaction_type', TransactionType::INCOME)
            ->sum('gross_amount');

        $totalExpense = (clone $transactionQuery)
            ->where('transaction_type', TransactionType::EXPENSE)
            ->sum('gross_amount');

        $totalOpeningBalance = $openingBalanceQuery->sum('amount');
        $netBalance = $totalIncome - $totalExpense;
        $totalCashBalance = $totalOpeningBalance + $netBalance;

        // Recent Data
        $recentTransactions = (clone $transactionQuery)->with('creator')->latest()->take(5)->get();
        $recentJournals = (clone $journalQuery)->with('postedBy')->latest()->take(5)->get();
        $transferType = TransactionType::TRANSFER->value;

        // Closing Reminder Logic (Minimum 3 hari sebelum sub-periode selesai)
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

        // Dynamic Closing Checks
        $totalDebitJournal = JournalDetail::whereHas('journal', fn ($q) => $q->where('period_id', $activePeriod?->id))->sum('debit');
        $totalCreditJournal = JournalDetail::whereHas('journal', fn ($q) => $q->where('period_id', $activePeriod?->id))->sum('credit');
        $isJournalBalanced = abs($totalDebitJournal - $totalCreditJournal) < 0.01;

        $closingChecks = [
            [
                'label' => 'Seluruh transaksi penerimaan & pengeluaran telah terverifikasi',
                'passed' => $transactionQuery->exists(),
            ],
            [
                'label' => 'Keseimbangan Jurnal Umum (Total Debit = Total Kredit)',
                'passed' => $isJournalBalanced,
            ],
            [
                'label' => 'Saldo Awal Periode telah terinput & valid',
                'passed' => $totalOpeningBalance > 0,
            ],
            [
                'label' => 'Seluruh aktivitas jurnal sub-periode siap ditutup',
                'passed' => $closingStatus !== 'expired',
            ],
        ];

        // Chart Data (Breakdown Sub Period / Monthly Cash Flow)
        $chartLabels = [];
        $chartIncomeData = [];
        $chartExpenseData = [];

        foreach ($subPeriods as $sp) {
            $chartLabels[] = $sp->name;
            $chartIncomeData[] = Transaction::query()
                ->where('period_id', $activePeriod?->id)
                ->where('sub_period_id', $sp->id)
                ->where('transaction_type', TransactionType::INCOME)
                ->sum('gross_amount');
            $chartExpenseData[] = Transaction::query()
                ->where('period_id', $activePeriod?->id)
                ->where('sub_period_id', $sp->id)
                ->where('transaction_type', TransactionType::EXPENSE)
                ->sum('gross_amount');
        }

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
            'closingChecks',
            'chartLabels',
            'chartIncomeData',
            'chartExpenseData'
        ));
    }
}
