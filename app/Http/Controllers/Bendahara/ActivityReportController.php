<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Models\ChartOfAccount;
use App\Models\Period;
use App\Models\SubPeriod;
use Carbon\Carbon;
use Illuminate\Http\Request;


class ActivityReportController extends Controller
{
    public function index(Request $request)
    {
        $periods = Period::orderBy('created_at', 'desc')->get();
        $periodId = $request->period_id;
        $period = $periodId ? Period::findOrFail($periodId) : Period::active()->firstOrFail();

        $subPeriodId = $request->sub_period_id;
        $subPeriods = collect();
        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->orderBy('id')
                ->get();
        }
        $subPeriod = $subPeriodId ? SubPeriod::findOrFail($subPeriodId) : SubPeriod::active()->firstOrFail();


        // Ambil semua COA Pendapatan & Biaya dengan sum mutasi
        $query = ChartOfAccount::query()
            ->withSum(['journal_details as total_debit' => function ($q) use ($periodId, $subPeriodId) {
                $q->whereHas('journal', function ($j) use ($periodId, $subPeriodId) {
                    $j->where('period_id', $periodId);
                    if ($subPeriodId) {
                       $j->where('sub_period_id', $subPeriodId);
                    }
                });
            }], 'debit')
            ->withSum(['journal_details as total_credit' => function ($q) use ($periodId, $subPeriodId) {
                $q->whereHas('journal', function ($j) use ($periodId, $subPeriodId) {
                    $j->where('period_id', $periodId);
                    if ($subPeriodId) {
                       $j->where('sub_period_id', $subPeriodId);
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
            'periodId',
            'subPeriodId',
            'periods',
            'period',
            'subPeriods',
            'subPeriod',
            'revenueData',
            'expenseData',
            'totalRevenue',
            'totalExpense',
            'surplusDeficit'
        ));
    }
}
