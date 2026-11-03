<?php

namespace App\Http\Controllers\Bendahara;

use App\Enums\NormalBalanceEnum;
use App\Http\Controllers\Controller;
use App\Models\ChartOfAccount;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TrialBalanceController extends Controller
{
    public function index(Request $request)
    {
        $periods = Period::orderBy('created_at', 'desc')->get();
        $periodId = $request->period_id ?? optional(Period::first())->id;
        $subPeriodId = $request->sub_period_id;

        $selectedPeriod = Period::find($periodId);

        $subPeriods = SubPeriod::where('period_id', $periodId)
            ->orderBy('id')
            ->get();

        $coas = ChartOfAccount::orderBy('code')->get();

        $data = [
            'aset_lancar'       => [],
            'aset_tidak_lancar' => [],
            'hutang'            => [],
            'modal'             => []
        ];

        foreach ($coas as $coa) {
            // 1. OPENING BALANCE (Diselaraskan dengan LedgerController)
            $opening = OpeningBalance::where('chart_of_account_id', $coa->id)
                ->where('period_id', $periodId)
                ->when($subPeriodId, fn($q) => $q->where('sub_period_id', $subPeriodId))
                ->first();

            $openingDebit = 0;
            $openingCredit = 0;

            if ($opening) {
                $openingType = is_object($opening->balance_type) ? $opening->balance_type->value : $opening->balance_type;
                $isOpeningDebit = ($openingType === NormalBalanceEnum::DEBIT->value || strtoupper((string)$openingType) === 'DEBIT');

                if ($isOpeningDebit) {
                    $openingDebit = (float) $opening->amount;
                } else {
                    $openingCredit = (float) $opening->amount;
                }
            }

            // 2. QUERY MUTASI JURNAL (Disaring transaction_id != null persis seperti Buku Besar)
            $mutationQuery = JournalDetail::where('chart_of_account_id', $coa->id)
                ->whereHas('journal', function ($q) use ($periodId, $subPeriodId) {
                    $q->where('period_id', $periodId);
                    if ($subPeriodId) {
                        $q->where('sub_period_id', $subPeriodId);
                    }
                    $q->whereNotNull('transaction_id');
                });

            $debit  = (float) (clone $mutationQuery)->sum('debit');
            $credit = (float) (clone $mutationQuery)->sum('credit');

            // 3. HITUNG AKUMULASI SALDO (Sinkron Realtime dengan Buku Besar / Ledger)
            $isAktiva = str_starts_with($coa->code, '1');

            if ($isAktiva) {
                // Sisi Aktiva (Perspektif DEBIT)
                // Total Akumulasi = (Opening Debit - Opening Credit) + (Mutasi Debit - Mutasi Kredit)
                $balance = ($openingDebit - $openingCredit) + ($debit - $credit);
            } else {
                // Sisi Pasiva (Perspektif KREDIT)
                // Total Akumulasi = (Opening Credit - Opening Debit) + (Mutasi Kredit - Mutasi Debit)
                $balance = ($openingCredit - $openingDebit) + ($credit - $debit);
            }

            $row = [
                'code'   => $coa->code,
                'name'   => $coa->name,
                'amount' => $balance
            ];

            if (str_starts_with($coa->code, '11')) {
                $data['aset_lancar'][] = $row;
            } elseif (str_starts_with($coa->code, '12')) {
                $data['aset_tidak_lancar'][] = $row;
            } elseif (str_starts_with($coa->code, '2')) {
                $data['hutang'][] = $row;
            } elseif (str_starts_with($coa->code, '3')) {
                $data['modal'][] = $row;
            }
        }

        // Surplus / Defisit Query (Tambahkan filter transaction_id agar valid)
        $journalFilter = function ($q) use ($periodId, $subPeriodId) {
            $q->where('period_id', $periodId);
            if ($subPeriodId) {
                $q->where('sub_period_id', $subPeriodId);
            }
            $q->whereNotNull('transaction_id');
        };

        $totalRevenue = JournalDetail::whereHas('chartOfAccount', fn($q) => $q->where('code', 'like', '4%'))
            ->whereHas('journal', $journalFilter)
            ->sum(DB::raw('credit - debit'));

        $totalExpense = JournalDetail::whereHas('chartOfAccount', fn($q) => $q->where('code', 'like', '5%'))
            ->whereHas('journal', $journalFilter)
            ->sum(DB::raw('debit - credit'));

        $surplusDeficit = $totalRevenue - $totalExpense;

        // Balance Totals
        $totalAsetLancar      = collect($data['aset_lancar'])->sum('amount');
        $totalAsetTidakLancar = collect($data['aset_tidak_lancar'])->sum('amount');
        $totalAktiva          = $totalAsetLancar + $totalAsetTidakLancar;
        $totalHutang          = collect($data['hutang'])->sum('amount');

        $modalTetap  = $totalAsetTidakLancar;
        $modalLancar = $totalAktiva - $modalTetap - $surplusDeficit - $totalHutang;
        $totalPasiva = $modalTetap + $modalLancar + $surplusDeficit + $totalHutang;

        $isBalanced = abs($totalAktiva - $totalPasiva) < 0.01;

        return view('pages.menus.bendahara.trial-balances.index', compact(
            'data',
            'surplusDeficit',
            'modalTetap',
            'modalLancar',
            'totalAsetLancar',
            'totalAsetTidakLancar',
            'totalAktiva',
            'totalHutang',
            'totalPasiva',
            'isBalanced',
            'periods',
            'periodId',
            'selectedPeriod',
            'subPeriods',
            'subPeriodId'
        ));
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
            'excel' => app()->download($journals),
            'pdf'   => app()->download($journals),
            default => abort(404),
        };
    }
}