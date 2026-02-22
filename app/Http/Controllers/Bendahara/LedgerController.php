<?php

namespace App\Http\Controllers\Bendahara;

use App\Enums\NormalBalanceEnum;
use Carbon\Carbon;
use App\Models\Period;
use App\Models\Journal;
use Illuminate\Http\Request;
use App\Models\JournalDetail;
use App\Models\ChartOfAccount;
use App\Models\OpeningBalance;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class LedgerController extends Controller
{
    public function index(Request $request)
    {
        /*
        |--------------------------------------------------------------------------
        | MASTER DATA
        |--------------------------------------------------------------------------
        */
        $periods = Period::orderBy('start_date', 'desc')->get();

        $periodId = $request->period_id;
        $period   = $periodId
            ? Period::findOrFail($periodId)
            : Period::active()->firstOrFail();

        $coaId = $request->coa_id;
        $month = $request->month;

        $coas = ChartOfAccount::orderBy('code')->get();

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
                ->where('period_id', $period->id)
                ->first();


            if ($opening) {
                $openingBalance = $opening->balance_type === NormalBalanceEnum::DEBIT->value
                    ? $opening->amount
                    : -1 * $opening->amount;
            }

            /*
            |--------------------------------------------------------------------------
            | 2️⃣ MUTASI SEBELUM BULAN (JIKA FILTER BULAN)
            |--------------------------------------------------------------------------
            */
            if ($month) {
                $startDate = Carbon::createFromFormat('Y-m', $month)->startOfMonth();

                $mutationQuery = JournalDetail::where('coa_id', $coaId)
                    ->whereHas('journal', function ($q) use ($period, $startDate) {
                        $q->where('period_id', $period->id)
                            ->where('journal_date', '>=', $period->start_date)
                            ->where('journal_date', '<', $startDate);
                    });

                $mutationDebit  = (clone $mutationQuery)->sum('debit');
                $mutationCredit = (clone $mutationQuery)->sum('credit');

                if ($coa->normal_balance === 'DEBIT') {
                    $openingBalance += $mutationDebit - $mutationCredit;
                } else {
                    $openingBalance += $mutationCredit - $mutationDebit;
                }
            }

            /*
            |--------------------------------------------------------------------------
            | 3️⃣ TRANSAKSI BULAN BERJALAN
            |--------------------------------------------------------------------------
            */
            $transactions = JournalDetail::with('journal')
                ->where('coa_id', $coaId)
                ->whereHas('journal', function ($q) use ($period, $month) {
                    $q->where('period_id', $period->id);

                    if ($month) {
                        $start = Carbon::createFromFormat('Y-m', $month)->startOfMonth();
                        $end   = Carbon::createFromFormat('Y-m', $month)->endOfMonth();
                        $q->whereBetween('journal_date', [$start, $end]);
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
            $ledger = [];
            $runningBalance = $openingBalance;

            foreach ($transactions as $trx) {
                // 1. Hitung Saldo Berjalan
                // Jika akun DEBIT (Kas): Saldo + Debit - Kredit
                // Jika akun KREDIT (Hutang): Saldo + Kredit - Debit
                if ($coa->normal_balance === NormalBalanceEnum::DEBIT->value) {
                    $runningBalance += ($trx->debit - $trx->credit);
                } else {
                    $runningBalance += ($trx->credit - $trx->debit);
                }

                // 2. Ambil Akun Lawan untuk kolom REF
                // Mencari detail lain di jurnal yang sama yang COA-nya bukan akun ini
                $opposingTrx = \App\Models\JournalDetail::where('journal_id', $trx->journal_id)
                    ->where('coa_id', '!=', $coaId)
                    ->with('coa')
                    ->first();

                $ledger[] = [
                    'date'           => $trx->journal->journal_date,
                    'description'    => $trx->description ?? $trx->journal->description,
                    'ref_code'       => $opposingTrx?->coa?->code ?? '-',
                    'ref_name'       => $opposingTrx?->coa?->name ?? '-',
                    'debit'          => $trx->debit,
                    'credit'         => $trx->credit,
                    'current_balance' => $runningBalance, // Ini nilai saldo setelah transaksi ini
                    'normal_balance' => $coa->normal_balance
                ];
            }

            $endingBalance = $runningBalance;
        }

        return view('pages.menus.bendahara.ledgers.index', compact(
            'periods',
            'periodId',
            'period',
            'coas',
            'coa',
            'ledger',
            'openingBalance',
            'endingBalance',
            'month'
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
