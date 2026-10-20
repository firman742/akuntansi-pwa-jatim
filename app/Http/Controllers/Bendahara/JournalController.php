<?php

namespace App\Http\Controllers\Bendahara;

use App\Exports\JournalPdfExport;
use App\Http\Controllers\Controller;
use App\Models\Journal;
use App\Models\Period;
use App\Models\SubPeriod;
use Barryvdh\DomPDF\Facade\Pdf;
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

        $sortBy = $request->get('sort_by', 'journal_date');
        $sortDir = $request->get('sort_dir', 'asc');

        $query = Journal::with([
            'details.chartOfAccount.accountType',
            'postedBy',
        ]);

        // ================= EXCLUDE BALANCING / SALDO AWAL =================
        // 1. Cek pada deskripsi jurnal utama
        $query->where(function ($q) {
            $q->where('description', 'not like', '%Distribusi saldo%')
                ->where('description', 'not like', '%Saldo Awal%');
        })
            // 2. Cek juga pada deskripsi di setiap baris journal_details
            ->whereDoesntHave('details', function ($qDetail) {
                $qDetail->where('description', 'like', '%Distribusi saldo%')
                    ->orWhere('description', 'like', '%Saldo Awal%');
            });
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

        $journals = $query->orderBy($sortBy, $sortDir)
            ->orderBy('id', 'asc')
            ->get();

        $periods = Period::all();
        $subPeriods = collect();
        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date')
                ->get();
        }

        // ================= GROUPING & PAIR SPLITTING KHUSUS COA ASET =================
        $groupedJournals = [];

        foreach ($journals as $journal) {
            // Pecah jurnal majemuk menjadi pasangan (pair) virtual
            $pairs = $this->splitJournalPairs($journal);

            foreach ($pairs as $pair) {
                foreach ($pair['details'] as $detail) {
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

                    // Cekal duplikasi pair pada grup COA yang sama
                    $alreadyAdded = collect($groupedJournals[$coaId]['data'])->contains(function ($item) use ($pair) {
                        return $item === $pair;
                    });

                    if (! $alreadyAdded) {
                        $groupedJournals[$coaId]['data'][] = $pair;
                    }
                }
            }
        }

        // Kalkulasi Subtotal per Grup COA dan Grand Total
        $grandTotalDebit = 0;
        $grandTotalCredit = 0;

        foreach ($groupedJournals as $coaId => &$group) {
            foreach ($group['data'] as $pair) {
                foreach ($pair['details'] as $detail) {
                    $group['subtotal_debit'] += $detail->debit;
                    $group['subtotal_credit'] += $detail->credit;
                }
            }
            $grandTotalDebit += $group['subtotal_debit'];
            $grandTotalCredit += $group['subtotal_credit'];
        }
        unset($group);

        // Urutkan grup secara alami berdasarkan Kode COA
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

    /**
     * Export Jurnal Umum ke File PDF
     */
    public function exportPdf(Request $request)
    {
        $periodId = $request->input('period_id');
        $subPeriodId = $request->input('sub_period_id');
        $startDate = $request->input('start_date');
        $endDate = $request->input('end_date');
        $search = $request->input('search');

        $sortBy = $request->get('sort_by', 'journal_date');
        $sortDir = $request->get('sort_dir', 'asc');

        $query = Journal::with([
            'details.chartOfAccount.accountType',
            'postedBy',
        ]);

        // Exclude Balancing / Saldo Awal
        $query->where(function ($q) {
            $q->where('description', 'not like', '%Distribusi saldo%')
                ->where('description', 'not like', '%Saldo Awal%');
        })->whereDoesntHave('details', function ($qDetail) {
            $qDetail->where('description', 'like', '%Distribusi saldo%')
                ->orWhere('description', 'like', '%Saldo Awal%');
        });

        // Filter Query
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

        $journals = $query->orderBy($sortBy, $sortDir)
            ->orderBy('id', 'asc')
            ->get();

        // Grouping & Split Pairs Khusus COA Aset
        $groupedJournals = [];

        foreach ($journals as $journal) {
            $pairs = $this->splitJournalPairs($journal);

            foreach ($pairs as $pair) {
                foreach ($pair['details'] as $detail) {
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

                    $alreadyAdded = collect($groupedJournals[$coaId]['data'])->contains(function ($item) use ($pair) {
                        return $item === $pair;
                    });

                    if (! $alreadyAdded) {
                        $groupedJournals[$coaId]['data'][] = $pair;
                    }
                }
            }
        }

        // Kalkulasi Subtotal & Grand Total
        $grandTotalDebit = 0;
        $grandTotalCredit = 0;

        foreach ($groupedJournals as $coaId => &$group) {
            foreach ($group['data'] as $pair) {
                foreach ($pair['details'] as $detail) {
                    $group['subtotal_debit'] += $detail->debit;
                    $group['subtotal_credit'] += $detail->credit;
                }
            }
            $grandTotalDebit += $group['subtotal_debit'];
            $grandTotalCredit += $group['subtotal_credit'];
        }
        unset($group);

        uasort($groupedJournals, function ($a, $b) {
            return strnatcmp($a['account_code'], $b['account_code']);
        });

        // Ambil info periode/sub-periode untuk header
        $selectedPeriod = Period::find($periodId);
        $selectedSubPeriod = SubPeriod::find($subPeriodId);

        $pdf = Pdf::loadView('pages.menus.bendahara.journals.pdf', compact(
            'journals',
            'groupedJournals',
            'grandTotalDebit',
            'grandTotalCredit',
            'selectedPeriod',
            'selectedSubPeriod',
            'startDate',
            'endDate'
        ))->setPaper('a4', 'landscape');

        $fileName = 'Laporan_Jurnal_Umum_' . date('Ymd_His') . '.pdf';

        return $pdf->download($fileName);
    }

    /**
     * Memecah jurnal majemuk menjadi pasangan (Debit - Kredit) virtual
     */
    private function splitJournalPairs($journal)
    {
        $debits = $journal->details->filter(fn($d) => (float) $d->debit > 0)->values();
        $credits = $journal->details->filter(fn($d) => (float) $d->credit > 0)->values();

        // Kasus A: 1 Kredit, Banyak Debit (Contoh: 1 Kas Keluar untuk banyak Akun Biaya)
        if ($credits->count() === 1 && $debits->count() > 1) {
            $singleCredit = $credits->first();
            $pairs = collect();

            foreach ($debits as $debit) {
                // Clone detail kredit agar nominalnya menyamai tiap baris debit
                $clonedCredit = clone $singleCredit;
                $clonedCredit->credit = $debit->debit;

                $pairs->push([
                    'journal' => $journal,
                    'details' => collect([$debit, $clonedCredit]),
                ]);
            }

            return $pairs;
        }

        // Kasus B: 1 Debit, Banyak Kredit (Contoh: 1 Kas Masuk dari banyak Akun Pendapatan)
        if ($debits->count() === 1 && $credits->count() > 1) {
            $singleDebit = $debits->first();
            $pairs = collect();

            foreach ($credits as $credit) {
                // Clone detail debit agar nominalnya menyamai tiap baris kredit
                $clonedDebit = clone $singleDebit;
                $clonedDebit->debit = $credit->credit;

                $pairs->push([
                    'journal' => $journal,
                    'details' => collect([$clonedDebit, $credit]),
                ]);
            }

            return $pairs;
        }

        // Kasus C: Transaksi Standar (1 Debit 1 Kredit) atau Majemuk Kompleks N:M
        return collect([
            [
                'journal' => $journal,
                'details' => $journal->details,
            ]
        ]);
    }
    private function groupJournals($journals)
    {
        $grouped = [];
        foreach ($journals as $journal) {
            $kasDetail = $journal->details->first(fn($d) => $d->chartOfAccount?->accountType?->name === 'ASET');

            if ($kasDetail) {
                $coaId = $kasDetail->coa_id;
                $coaName = $kasDetail->chartOfAccount->name . ' (' . $kasDetail->chartOfAccount->code . ')';

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
