<?php

namespace App\Http\Controllers\Bendahara;

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

        /*
        |--------------------------------------------------------------------------
        | Get SUB PERIOD 
        |--------------------------------------------------------------------------
        */
        $subPeriods = SubPeriod::where('period_id', $periodId)
            ->orderBy('id')
            ->get();

        $coas = ChartOfAccount::orderBy('code')->get();

        /*
        |--------------------------------------------------------------------------
        | INIT DATA
        |--------------------------------------------------------------------------
        */
        $data = [
            'aset_lancar' => [],
            'aset_tidak_lancar' => [],
            'hutang' => [],
            'modal' => []
        ];

        foreach ($coas as $coa) {

            /*
            |--------------------------------------------------------------------------
            | OPENING BALANCE
            |--------------------------------------------------------------------------
            */
            $opening = OpeningBalance::where('chart_of_account_id', $coa->id)
                ->where('period_id', $periodId)
                ->where('sub_period_id', $subPeriodId)
                ->first();

            $openingAmount = $opening ? $opening->amount : 0;

            /*
            |--------------------------------------------------------------------------
            | MUTATION QUERY (SUDAH PAKAI FILTER BARU)
            |--------------------------------------------------------------------------
            */
            $mutationQuery = JournalDetail::where('coa_id', $coa->id)
                ->whereHas('journal', function ($q) use ($periodId, $subPeriodId) {

                    $q->where('period_id', $periodId);

                    if ($subPeriodId) {
                        $q->where('sub_period_id', $subPeriodId);
                    }
                });

            $debit  = (clone $mutationQuery)->sum('debit');
            $credit = (clone $mutationQuery)->sum('credit');

            /*
            |--------------------------------------------------------------------------
            | ENDING BALANCE
            |--------------------------------------------------------------------------
            */
            if ($coa->normal_balance === 'DEBIT') {
                $balance = $openingAmount + $debit - $credit;
            } else {
                $balance = $openingAmount + $credit - $debit;
            }

            $row = [
                'code' => $coa->code,
                'name' => $coa->name,
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

        /*
        |--------------------------------------------------------------------------
        | SURPLUS DEFICIT (PAKAI FILTER)
        |--------------------------------------------------------------------------
        */
        $journalFilter = function ($q) use ($periodId, $subPeriodId) {
            $q->where('period_id', $periodId);

            if ($subPeriodId) {
                $q->where('sub_period_id', $subPeriodId);
            }

        };

        $totalRevenue = JournalDetail::whereHas('coa', fn($q) => $q->where('code', 'like', '4%'))
            ->whereHas('journal', $journalFilter)
            ->sum(DB::raw('credit - debit'));

        $totalExpense = JournalDetail::whereHas('coa', fn($q) => $q->where('code', 'like', '5%'))
            ->whereHas('journal', $journalFilter)
            ->sum(DB::raw('debit - credit'));

        $surplusDeficit = $totalRevenue - $totalExpense;

        /*
        |--------------------------------------------------------------------------
        | MODAL LOGIC
        |--------------------------------------------------------------------------
        */
        $totalAsetLancar      = collect($data['aset_lancar'])->sum('amount');
        $totalAsetTidakLancar = collect($data['aset_tidak_lancar'])->sum('amount');
        $totalAset            = $totalAsetLancar + $totalAsetTidakLancar;
        $totalHutang          = collect($data['hutang'])->sum('amount');

        $modalTetap  = $totalAsetTidakLancar;
        $modalLancar = $totalAset - $modalTetap - $surplusDeficit - $totalHutang;

        return view('pages.menus.bendahara.trial-balances.index', compact(
            'data',
            'surplusDeficit',
            'modalTetap',
            'modalLancar',
            'periods',
            'periodId',
            'subPeriods',
            'subPeriodId',
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
