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

class LedgerController extends Controller
{
    public function index(Request $request)
    {
        /*
        |--------------------------------------------------------------------------
        | MASTER DATA
        |--------------------------------------------------------------------------
        */
        $periods = Period::where('is_closed', false)->get();

        $periodId = $request->period_id;
        $coaId       = $request->coa_id;
        $subPeriodId = $request->sub_period_id;
        $startDate   = $request->start_date;
        $endDate     = $request->end_date;

        $coas = ChartOfAccount::orderBy('code')->get();

        // Sub Periods (dependent dropdown)
        $subPeriods = collect();
        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->active()
                ->orderBy('start_date')
                ->get();
        }

        /*
        |--------------------------------------------------------------------------
        | DEFAULT RESPONSE
        |--------------------------------------------------------------------------
        */
        $ledger         = [];
        $openingBalance = 0;
        $endingBalance  = 0;
        $coa            = null;

        /*
        |--------------------------------------------------------------------------
        | PROCESS LEDGER
        |--------------------------------------------------------------------------
        */
        if ($coaId) {

            $coa = ChartOfAccount::findOrFail($coaId);

            /*
            |--------------------------------------------------------------------------
            | 1️⃣ OPENING BALANCE (MANUAL)
            |--------------------------------------------------------------------------
            */
            $opening = OpeningBalance::where('chart_of_account_id', $coaId)
                ->where('period_id', $periodId)
                ->first();

            if ($opening) {
                $openingBalance = $opening->balance_type === NormalBalanceEnum::DEBIT->value
                    ? $opening->amount
                    : -1 * $opening->amount;
            }

            /*
            |--------------------------------------------------------------------------
            | 2️⃣ MUTASI SEBELUM FILTER (DATE RANGE)
            |--------------------------------------------------------------------------
            */
            $mutationQuery = JournalDetail::where('coa_id', $coaId)
                ->whereHas('journal', function ($q) use ($periodId, $subPeriodId, $startDate) {
                    $q->where('period_id', $periodId);

                    if ($subPeriodId) {
                        $q->where('sub_period_id', $subPeriodId);
                    }

                    if ($startDate) {
                        $q->where('journal_date', '<', Carbon::parse($startDate)->startOfDay());
                    }
                });

            $mutationDebit  = (clone $mutationQuery)->sum('debit');
            $mutationCredit = (clone $mutationQuery)->sum('credit');

            if ($coa->normal_balance === NormalBalanceEnum::DEBIT->value) {
                $openingBalance += $mutationDebit - $mutationCredit;
            } else {
                $openingBalance += $mutationCredit - $mutationDebit;
            }

            /*
            |--------------------------------------------------------------------------
            | 3️⃣ TRANSAKSI BERJALAN
            |--------------------------------------------------------------------------
            */
            $transactions = JournalDetail::with('journal')
                ->where('coa_id', $coaId)
                ->whereHas('journal', function ($q) use ($periodId, $subPeriodId, $startDate, $endDate) {

                    $q->where('period_id', $periodId);

                    if ($subPeriodId) {
                        $q->where('sub_period_id', $subPeriodId);
                    }

                    if ($startDate && $endDate) {
                        $q->whereBetween('journal_date', [
                            Carbon::parse($startDate)->startOfDay(),
                            Carbon::parse($endDate)->endOfDay()
                        ]);
                    }
                })
                ->join('journals', 'journals.id', '=', 'journal_details.journal_id')
                ->orderBy('journals.journal_date')
                ->orderBy('journals.id')
                ->select('journal_details.*')
                ->get();

            /*
            |--------------------------------------------------------------------------
            | 4️⃣ RUNNING BALANCE
            |--------------------------------------------------------------------------
            */
            $runningBalance = $openingBalance;

            foreach ($transactions as $trx) {

                // Hitung saldo berjalan
                if ($coa->normal_balance === NormalBalanceEnum::DEBIT->value) {
                    $runningBalance += ($trx->debit - $trx->credit);
                } else {
                    $runningBalance += ($trx->credit - $trx->debit);
                }

                // Ambil akun lawan
                $opposingTrx = JournalDetail::where('journal_id', $trx->journal_id)
                    ->where('coa_id', '!=', $coaId)
                    ->with('coa')
                    ->first();

                $ledger[] = [
                    'date'            => $trx->journal->journal_date,
                    'description'     => $trx->description ?? $trx->journal->description,
                    'ref_code'        => $opposingTrx?->coa?->code ?? '-',
                    'ref_name'        => $opposingTrx?->coa?->name ?? '-',
                    'debit'           => $trx->debit,
                    'credit'          => $trx->credit,
                    'current_balance' => $runningBalance,
                    'normal_balance'  => $coa->normal_balance
                ];
            }

            $endingBalance = $runningBalance;
        }

        return view('pages.menus.bendahara.ledgers.index', compact(
            'periods',
            'periodId',
            'coas',
            'coa',
            'ledger',
            'openingBalance',
            'endingBalance',
            'subPeriods',
            'subPeriodId',
            'startDate',
            'endDate'
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
