<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Models\ChartOfAccount;
use App\Models\Period;
use Carbon\Carbon;
use Illuminate\Http\Request;


class ActivityReportController extends Controller
{
    // ActivityReportController.php
    public function index(Request $request)
    {
        $periods = Period::orderBy('start_date', 'desc')->get();
        $periodId = $request->period_id;
        $period = $periodId ? Period::findOrFail($periodId) : Period::active()->firstOrFail();
        $month = $request->month;

        // Ambil semua COA Pendapatan & Biaya dengan sum mutasi
        $query = ChartOfAccount::query()
            ->withSum(['journal_details as total_debit' => function ($q) use ($period, $month) {
                $q->whereHas('journal', function ($j) use ($period, $month) {
                    $j->where('period_id', $period->id);
                    if ($month) {
                        $start = \Carbon\Carbon::createFromFormat('Y-m', $month)->startOfMonth();
                        $end = \Carbon\Carbon::createFromFormat('Y-m', $month)->endOfMonth();
                        $j->whereBetween('journal_date', [$start, $end]);
                    }
                });
            }], 'debit')
            ->withSum(['journal_details as total_credit' => function ($q) use ($period, $month) {
                $q->whereHas('journal', function ($j) use ($period, $month) {
                    $j->where('period_id', $period->id);
                    if ($month) {
                        $start = \Carbon\Carbon::createFromFormat('Y-m', $month)->startOfMonth();
                        $end = \Carbon\Carbon::createFromFormat('Y-m', $month)->endOfMonth();
                        $j->whereBetween('journal_date', [$start, $end]);
                    }
                });
            }], 'credit')
            ->orderBy('code');

        $revenueData = (clone $query)->where('code', 'like', '4%')->get();
        $expenseData = (clone $query)->where('code', 'like', '5%')->get();

        // Hitung Total
        $totalRevenue = 0;
        foreach ($revenueData as $r) {
            $totalRevenue += ($r->total_credit - $r->total_debit);
        }

        $totalExpense = 0;
        foreach ($expenseData as $e) {
            $totalExpense += ($e->total_debit - $e->total_credit);
        }

        $surplusDeficit = $totalRevenue - $totalExpense;

        return view('pages.menus.bendahara.activity-reports.index', compact(
            'periods',
            'period',
            'month',
            'revenueData',
            'expenseData',
            'totalRevenue',
            'totalExpense',
            'surplusDeficit'
        ));
    }
}
