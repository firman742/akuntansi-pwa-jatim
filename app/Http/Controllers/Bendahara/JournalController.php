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
        $periodId = $request->input('period_id');
        $subPeriodId = $request->input('sub_period_id');
        $startDate = $request->input('start_date');
        $endDate = $request->input('end_date');
        $search = $request->input('search');

        // Dynamic Sorting - Default diubah menjadi 'asc' (Terlama ke Terbaru)
        $sortBy = $request->get('sort_by', 'journal_date');
        $sortDir = $request->get('sort_dir', 'asc');

        // Eager load relations secara efisien
        $query = Journal::with([
            'details.chartOfAccount.accountType',
            'postedBy',
        ]);

        // ================= FILTERS =================
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

        if ($request->filled('search')) {
            $query->where(function ($q) use ($search) {
                $q->where('description', 'like', "%{$search}%")
                    ->orWhere('journal_number', 'like', "%{$search}%")
                    ->orWhereHas('postedBy', function ($qUser) use ($search) {
                        $qUser->where('name', 'like', "%{$search}%");
                    })
                    ->orWhereHas('details.chartOfAccount', function ($q2) use ($search) {
                        $q2->where('name', 'like', "%{$search}%")
                            ->orWhere('code', 'like', "%{$search}%");
                    });
            });
        }

        // QUERY ORDERING: Utama berdasar kolom pilihan (default: journal_date ASC), sekunder berdasar ID ASC
        $journals = $query->orderBy($sortBy, $sortDir)
            ->orderBy('id', 'asc')
            ->get();

        // Master Data Periode
        $periods = Period::all();
        $subPeriods = collect();
        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date')
                ->get();
        }

        // ================= GROUPING KHUSUS COA BERTIPE ASET =================
        $groupedJournals = [];
        $grandTotalDebit = 0;
        $grandTotalCredit = 0;

        foreach ($journals as $journal) {
            foreach ($journal->details as $detail) {
                $coa = $detail->chartOfAccount;
                if (! $coa) {
                    continue;
                }

                $typeName = strtoupper($coa->accountType->name ?? '');
                $isAsset = str_contains($typeName, 'ASET') ||
                    str_contains($typeName, 'ASSET') ||
                    str_starts_with((string) $coa->code, '1');

                if (! $isAsset) {
                    continue;
                }

                $coaId = $detail->chart_of_account_id;
                $coaCode = $coa->code ?? '-';
                $coaName = $coa->name ?? 'Tanpa Nama Akun';

                if (! isset($groupedJournals[$coaId])) {
                    $groupedJournals[$coaId] = [
                        'account_id' => $coaId,
                        'account_code' => $coaCode,
                        'account_name' => $coaName,
                        'account_info' => "{$coaName} ({$coaCode})",
                        'subtotal_debit' => 0,
                        'subtotal_credit' => 0,
                        'data' => [],
                    ];
                }

                // Masukkan jurnal ke grup COA terkait (cekal duplikasi jurnal dalam grup yang sama)
                $alreadyAdded = collect($groupedJournals[$coaId]['data'])->contains('id', $journal->id);
                if (! $alreadyAdded) {
                    $groupedJournals[$coaId]['data'][] = $journal;
                }
            }
        }

        // Kalkulasi Subtotal per Grup COA dan Grand Total Keseluruhan
        foreach ($groupedJournals as $coaId => &$group) {
            foreach ($group['data'] as $journal) {
                foreach ($journal->details as $detail) {
                    $group['subtotal_debit'] += $detail->debit;
                    $group['subtotal_credit'] += $detail->credit;
                }
            }
            $grandTotalDebit += $group['subtotal_debit'];
            $grandTotalCredit += $group['subtotal_credit'];
        }
        unset($group);

        // Urutkan grup secara alami berdasarkan Kode COA (misal: 11100, 11110, 11120, dst.)
        uasort($groupedJournals, function ($a, $b) {
            return strnatcmp($a['account_code'], $b['account_code']);
        });

        return view('pages.menus.bendahara.journals.index', [
            'journals' => $journals,
            'groupedJournals' => $groupedJournals,
            'grandTotalDebit' => $grandTotalDebit,
            'grandTotalCredit' => $grandTotalCredit,
            'periods' => $periods,
            'subPeriods' => $subPeriods,
            'periodId' => $periodId,
            'subPeriodId' => $subPeriodId,
            'startDate' => $startDate,
            'endDate' => $endDate,
            'sortBy' => $sortBy,
            'sortDir' => $sortDir,
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
        $periodId = $request->period_id;
        $startMonth = $request->start_month; // format: Y-m
        $endMonth = $request->end_month;   // format: Y-m

        $query = Journal::with(['details.chartOfAccount.accountType']);

        if ($periodId) {
            $query->where('period_id', $periodId);
        }

        if ($startMonth && $endMonth) {
            $start = Carbon::parse($startMonth)->startOfMonth();
            $end = Carbon::parse($endMonth)->endOfMonth();

            $query->whereBetween('journal_date', [$start, $end]);
        }

        // Query export diubah dari desc ke asc
        $journals = $query
            ->orderBy('journal_date', 'asc')
            ->orderBy('id', 'asc')
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
                .' - '.
                Carbon::parse($endMonth)->translatedFormat('F Y')
                : null,
            'year' => ($startMonth)
                ? Carbon::parse($startMonth)->year
                : now()->year,
            'user_name' => Auth::user()?->name,
        ];

        return match ($type) {
            'pdf' => app(JournalPdfExport::class)->download($groupedJournals, $meta),
            default => abort(404),
        };
    }

    private function groupJournals($journals)
    {
        $grouped = [];
        foreach ($journals as $journal) {
            $kasDetail = $journal->details->first(fn ($d) => $d->chartOfAccount?->accountType?->name === 'ASET');

            if ($kasDetail) {
                $coaId = $kasDetail->coa_id;
                $coaName = $kasDetail->chartOfAccount->name.' ('.$kasDetail->chartOfAccount->code.')';

                if (! isset($grouped[$coaId])) {
                    $grouped[$coaId] = [
                        'account_info' => $coaName,
                        'data' => [],
                    ];
                }
                $grouped[$coaId]['data'][] = $journal;
            }
        }

        return $grouped;
    }
}
