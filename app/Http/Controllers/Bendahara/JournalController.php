<?php

namespace App\Http\Controllers\Bendahara;

use App\Exports\JournalPdfExport;
use App\Http\Controllers\Controller;
use App\Models\Journal;
use App\Models\Period;
use App\Models\SubPeriod;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class JournalController extends Controller
{
    public function index(Request $request)
    {
        $periodId =  $request->period_id;
        $subPeriodId =  $request->sub_period_id;
        $startDate =  $request->start_date;
        $endDate = $request->end_date;
        $search = $request->search;

        // Initial Query
        $query  = Journal::with(['details.chartOfAccount.accountType', 'postedBy']);

        // ================= FILTER =================
        if ($request->filled('period_id')) {
            $query->where('period_id', $periodId);
        }

        if ($request->filled('sub_period_id')) {
            $query->where('sub_period_id', $subPeriodId);
        }

        if ($request->filled('start_date')) {
            $query->whereDate('journal_date', '>=', $startDate);
        }

        if ($request->filled('end_date')) {
            $query->whereDate('journal_date', '<=', $endDate);
        }

        // ======================= ORDER ============
        $journals = $query
            ->where(function ($q) use ($search) {
                if ($search) {
                    $q->where('description', 'like', "%{$search}%")
                        ->orWhereHas('details.chartOfAccount', function ($q2) use ($search) {
                            $q2->where('name', 'like', "%{$search}%")
                                ->orWhere('code', 'like', "%{$search}%");
                        });
                }
            })
            ->orderBy('journal_date', 'desc')
            ->paginate(20)
            ->withQueryString();

        $periods = Period::get();
        $subPeriods = collect();
        if ($request->period_id) {
            $subPeriods = SubPeriod::where('period_id', $request->period_id)
                ->orderBy('start_date')
                ->get();
        }

        // --- GROUPING (tetap sama) ---
        $groupedJournals = [];

        foreach ($journals->items() as $journal) {
            $kasDetail = $journal->details->first(function ($detail) {
                return $detail->chartOfAccount?->accountType?->name === 'ASET';
            });

            if ($kasDetail) {
                $coaId = $kasDetail->coa_id;
                $coaName = $kasDetail->chartOfAccount->name . ' (' . $kasDetail->chartOfAccount->code . ')';

                if (!isset($groupedJournals[$coaId])) {
                    $groupedJournals[$coaId] = [
                        'account_info' => $coaName,
                        'data' => []
                    ];
                }

                $groupedJournals[$coaId]['data'][] = $journal;
            }
        }

        return view('pages.menus.bendahara.journals.index', [
            'journals' => $journals,
            'groupedJournals' => $groupedJournals,
            'periods' => $periods,
            'subPeriods' => $subPeriods, // ⬅️ tambahan
            'periodId' => $periodId,
            'subPeriodId' => $subPeriodId, // ⬅️ tambahan
            'startDate' => $startDate,
            'endDate' => $endDate
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $journal = Journal::with(['postedBy', 'details.chartOfAccount'])
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

        $query = Journal::with(['details.chartOfAccount.accountType']);

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

        // TERAPKAN GROUPING DISINI
        $groupedJournals = $this->groupJournals($journals);

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
            // Kirim $groupedJournals, bukan $journals mentah
            'pdf' => app(JournalPdfExport::class)->download($groupedJournals, $meta),
            default => abort(404),
        };
    }


    private function groupJournals($journals)
    {
        $grouped = [];
        foreach ($journals as $journal) {
            $kasDetail = $journal->details->first(fn($d) => $d->chartOfAccount?->accountType?->name === 'ASET');

            if ($kasDetail) {
                $coaId = $kasDetail->coa_id;
                $coaName = $kasDetail->chartOfAccount->name . ' (' . $kasDetail->chartOfAccount->code . ')';

                if (!isset($grouped[$coaId])) {
                    $grouped[$coaId] = [
                        'account_info' => $coaName,
                        'data' => []
                    ];
                }
                $grouped[$coaId]['data'][] = $journal;
            }
        }
        return $grouped;
    }
}
