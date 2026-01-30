<?php

namespace App\Http\Controllers\Bendahara;

use Carbon\Carbon;
use App\Models\Period;
use App\Models\Journal;
use Illuminate\Http\Request;
use App\Models\JournalDetail;
use App\Models\ChartOfAccount;
use App\Models\OpeningBalance;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class TrialBalanceController extends Controller
{
    public function index(Request $request)
    {
        $periods = Period::orderBy('start_date', 'desc')->get();

        $periodId = $request->period_id;
        $period   = $periodId
            ? Period::findOrFail($periodId)
            : Period::active()->firstOrFail();

        $month = $request->month;

        $trialBalance = [];
        $totalDebit   = 0;
        $totalCredit  = 0;

        $coas = ChartOfAccount::with('accountType')
            ->orderBy('code')
            ->get();

        foreach ($coas as $coa) {

            /*
            |--------------------------------------------------------------------------
            | 1️⃣ OPENING BALANCE (MANUAL)
            |--------------------------------------------------------------------------
            */
            $opening = OpeningBalance::where('chart_of_account_id', $coa->id)
                ->where('period_id', $period->id)
                ->first();

            $openingAmount = $opening ? $opening->amount : 0;

            /*
            |--------------------------------------------------------------------------
            | 2️⃣ MUTASI PERIODE
            |--------------------------------------------------------------------------
            */
            $mutationQuery = JournalDetail::where('coa_id', $coa->id)
                ->whereHas('journal', function ($q) use ($period, $month) {
                    $q->where('period_id', $period->id);

                    if ($month) {
                        $start = Carbon::createFromFormat('Y-m', $month)->startOfMonth();
                        $end   = Carbon::createFromFormat('Y-m', $month)->endOfMonth();

                        $q->whereBetween('journal_date', [$start, $end]);
                    }
                });

            $debit  = (clone $mutationQuery)->sum('debit');
            $credit = (clone $mutationQuery)->sum('credit');

            /*
            |--------------------------------------------------------------------------
            | 3️⃣ HITUNG SALDO AKHIR
            |--------------------------------------------------------------------------
            */
            if ($coa->normal_balance === 'DEBIT') {
                $balance = $openingAmount + $debit - $credit;
            } else {
                $balance = $openingAmount + $credit - $debit;
            }

            if ($balance == 0) {
                continue;
            }

            $debitBalance  = $balance > 0 && $coa->normal_balance === 'DEBIT' ? $balance : 0;
            $creditBalance = $balance > 0 && $coa->normal_balance === 'CREDIT' ? $balance : 0;

            $totalDebit  += $debitBalance;
            $totalCredit += $creditBalance;

            $trialBalance[] = [
                'code'   => $coa->code,
                'name'   => $coa->name,
                'debit'  => $debitBalance,
                'credit' => $creditBalance,
            ];
        }

        return view('pages.menus.bendahara.trial-balances.index',
            compact(
                'trialBalance',
                'totalDebit',
                'totalCredit',
                'periods',
                'periodId',
                'month'
            )
        );
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
