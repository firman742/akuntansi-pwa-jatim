<?php

namespace App\Http\Controllers\Bendahara;

use Carbon\Carbon;
use App\Models\Period;
use App\Models\Journal;
use Illuminate\Http\Request;
use App\Models\ChartOfAccount;
use App\Models\OpeningBalance;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class JournalController extends Controller
{
    public function index(Request $request)
    {
        $periodId = $request->get('period_id');
        $month    = $request->get('month'); // YYYY-MM

        $periods = Period::orderBy('start_date', 'desc')->get();

        $period = $periodId
            ? Period::findOrFail($periodId)
            : Period::active()->firstOrFail();

        $journals = Journal::with(['details.coa.accountType', 'postedBy'])
            ->where('period_id', $period->id)
            ->when($month, function ($q) use ($month) {
                $startDate = Carbon::createFromFormat('Y-m', $month)->startOfMonth();
                $endDate   = Carbon::createFromFormat('Y-m', $month)->endOfMonth();

                $q->whereBetween('journal_date', [$startDate, $endDate]);
            })
            ->orderBy('journal_date')
            ->orderBy('id')
            ->get();

        return view('pages.menus.bendahara.journals.index', compact(
            'journals',
            'periods',
            'periodId',
            'month'
        ));
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $journal = Journal::with(['postedBy', 'details.coa'])
            ->findOrFail($id);

        return view('pages.menus.bendahara.journals.show', compact('journal'));
    }

    public function export(Request $request, string $type)
    {
        $periodId = $request->period_id;
        $month    = $request->month;

        $journals = Journal::with(['details.coa.accountType'])
            ->where('period_id', $periodId)
            ->when($month, function ($q) use ($month) {
                [$year, $m] = explode('-', $month);
                $q->whereYear('journal_date', $year)
                  ->whereMonth('journal_date', $m);
            })
            ->orderBy('journal_date')
            ->get();

        return match ($type) {
            'excel' => app(JournalExcelExport::class)->download($journals),
            'pdf'   => app(JournalPdfExport::class)->download($journals),
            default => abort(404),
        };
    }
}
