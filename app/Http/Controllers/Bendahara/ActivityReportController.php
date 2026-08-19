<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Models\ChartOfAccount;
use App\Models\Period;
use App\Models\SubPeriod;
use Exception;
use Illuminate\Http\Request;

class ActivityReportController extends Controller
{
    /**
     * Get data untuk laporan aktivitas keuangan (Laporan Laba Rugi) berdasarkan periode dan sub periode yang dipilih.
     *
     * @return void
     *
     * @throws Exception
     */
    public function index(Request $request)
    {
        $periods = Period::orderBy('created_at', 'desc')->get();
        if ($periods->isEmpty()) {
            throw new Exception('Tidak ada periode aktif. Silakan buat periode terlebih dahulu.');
        }

        $periodId = $request->period_id;
        $period = $periodId ? Period::findOrFail($periodId) : Period::first();

        $subPeriodId = $request->sub_period_id;
        $subPeriods = collect();

        if ($period) {
            $subPeriods = SubPeriod::where('period_id', $period->id)
                ->orderBy('id')
                ->get();
        }

        $subPeriod = $subPeriodId
            ? SubPeriod::find($subPeriodId)
            : SubPeriod::where('period_id', $period->id)->where('is_closed', false)->first();

        // Query COA Pendapatan & Biaya beserta mutasinya
        $query = ChartOfAccount::query()
            ->withSum(['journalDetails as total_debit' => function ($q) use ($period, $subPeriodId) {
                $q->whereHas('journal', function ($j) use ($period, $subPeriodId) {
                    $j->where('period_id', $period->id)
                        ->when($subPeriodId, fn ($sq) => $sq->where('sub_period_id', $subPeriodId));
                });
            }], 'debit')
            ->withSum(['journalDetails as total_credit' => function ($q) use ($period, $subPeriodId) {
                $q->whereHas('journal', function ($j) use ($period, $subPeriodId) {
                    $j->where('period_id', $period->id)
                        ->when($subPeriodId, fn ($sq) => $sq->where('sub_period_id', $subPeriodId));
                });
            }], 'credit')
            ->orderBy('code');

        $revenueData = (clone $query)->where('code', 'like', '4%')->get();
        $expenseData = (clone $query)->where('code', 'like', '5%')->get();

        // Hitung Total Pendapatan (Kredit - Debit)
        $totalRevenue = $revenueData->sum(fn ($r) => ($r->total_credit ?? 0) - ($r->total_debit ?? 0));

        // Hitung Total Biaya (Debit - Kredit)
        $totalExpense = $expenseData->sum(fn ($e) => ($e->total_debit ?? 0) - ($e->total_credit ?? 0));

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
