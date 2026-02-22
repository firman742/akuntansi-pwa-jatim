<?php

namespace App\Http\Controllers\Bendahara;

use App\Exports\JournalPdfExport;
use Carbon\Carbon;
use App\Models\Period;
use App\Models\Journal;
use Illuminate\Http\Request;
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
        // =====================
        // FILTER INPUT
        // =====================
        $periodId   = $request->period_id;
        $startMonth = $request->start_month; // format: Y-m
        $endMonth   = $request->end_month;   // format: Y-m

        $query = Journal::with(['details.coa.accountType']);

        if ($periodId) {
            $query->where('period_id', $periodId);
        }

        if ($startMonth && $endMonth) {
            $start = Carbon::parse($startMonth)->startOfMonth();
            $end   = Carbon::parse($endMonth)->endOfMonth();

            $query->whereBetween('journal_date', [$start, $end]);
        }

        $journals = $query
            ->orderBy('journal_date')
            ->get();

        // =====================
        // METADATA EXPORT
        // =====================
        $period = $periodId ? Period::find($periodId) : null;

        $meta = [
            'period_name' => $period?->name,
            'month_label' => ($startMonth && $endMonth)
                ? Carbon::parse($startMonth)->translatedFormat('F Y')
                    . ' - ' .
                  Carbon::parse($endMonth)->translatedFormat('F Y')
                : null,
            'year' => ($startMonth)
                ? Carbon::parse($startMonth)->year
                : now()->year,
            'user_name' => Auth::user()?->name,
        ];

        return match ($type) {
            'pdf' => app(JournalPdfExport::class)->download($journals, $meta),
            default => abort(404),
        };
    }
}
