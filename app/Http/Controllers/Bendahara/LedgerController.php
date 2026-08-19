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
        $periods = Period::orderBy('created_at', 'desc')->get();

        $periodId = $request->period_id ?? optional(Period::first())->id;
        $coaId = $request->coa_id;
        $subPeriodId = $request->sub_period_id;
        $startDate = $request->start_date;
        $endDate = $request->end_date;

        $coas = ChartOfAccount::orderBy('code')->get();

        $subPeriods = collect();
        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->where('is_closed', false)
                ->orderBy('start_date')
                ->get();
        }

        $ledger = [];
        $openingBalance = 0;
        $runningBalance = 0;
        $endingBalance = 0;
        $totalDebitMutation = 0;
        $totalCreditMutation = 0;
        $coa = null;
        $openingBalanceCreatedBy = '-';
        $openingBalanceDate = '-';

        if ($coaId) {
            $coa = ChartOfAccount::findOrFail($coaId);
            $normalBalance = is_object($coa->normal_balance) ? $coa->normal_balance->value : $coa->normal_balance;

            // 1. OPENING BALANCE
            $opening = OpeningBalance::where('chart_of_account_id', $coaId)
                ->where('period_id', $periodId)
                ->when($subPeriodId, fn ($q) => $q->where('sub_period_id', $subPeriodId))
                ->first();

            if ($opening) {
                $openingType = is_object($opening->balance_type) ? $opening->balance_type->value : $opening->balance_type;
                $openingBalance = ($openingType === NormalBalanceEnum::DEBIT->value || $openingType === 'DEBIT')
                    ? $opening->amount
                    : -1 * $opening->amount;
            }

            $openingBalanceCreatedBy = $opening?->creator?->name ?? '-';
            $openingBalanceDate = $opening?->created_at ? Carbon::parse($opening->created_at)->format('d M Y') : '-';

            // 2. MUTASI SEBELUM START DATE
            $runningBalance = $openingBalance;
            if ($startDate) {
                $priorMutation = JournalDetail::where('chart_of_account_id', $coaId)
                    ->whereHas('journal', function ($q) use ($periodId, $subPeriodId, $startDate) {
                        $q->where('period_id', $periodId);
                        if ($subPeriodId) {
                            $q->where('sub_period_id', $subPeriodId);
                        }
                        $q->where('journal_date', '<', Carbon::parse($startDate)->startOfDay());

                        // ── FILTER HANYA TRANSAKSI ───────────────────────────────────────
                        // Opsi A: Jika jurnal transaksi memiliki relasi/kolom transaction_id
                        $q->whereNotNull('transaction_id');

                        // Opsi B: Jika ada kolom type / source_type di tabel journals
                        // $q->where('type', 'TRANSACTION');
                        // ─────────────────────────────────────────────────────────────────
                    });

                $priorDebit = (clone $priorMutation)->sum('debit');
                $priorCredit = (clone $priorMutation)->sum('credit');

                if ($normalBalance === 'DEBIT') {
                    $runningBalance += ($priorDebit - $priorCredit);
                } else {
                    $runningBalance += ($priorCredit - $priorDebit);
                }
            }

            // 3. TRANSAKSI PERIODE BERJALAN
            $transactions = JournalDetail::with(['journal.postedBy'])
                ->where('chart_of_account_id', $coaId)
                ->whereHas('journal', function ($q) use ($periodId, $subPeriodId, $startDate, $endDate) {
                    $q->where('period_id', $periodId);
                    if ($subPeriodId) {
                        $q->where('sub_period_id', $subPeriodId);
                    }
                    if ($startDate && $endDate) {
                        $q->whereBetween('journal_date', [
                            Carbon::parse($startDate)->startOfDay(),
                            Carbon::parse($endDate)->endOfDay(),
                        ]);
                    }

                    // ── FILTER HANYA TRANSAKSI ───────────────────────────────────────
                    // Opsi A: Jika jurnal transaksi memiliki relasi/kolom transaction_id
                    $q->whereNotNull('transaction_id');

                    // Opsi B: Jika ada kolom type / source_type di tabel journals
                    // $q->where('type', 'TRANSACTION');
                    // ─────────────────────────────────────────────────────────────────
                })
                ->join('journals', 'journals.id', '=', 'journal_details.journal_id')
                ->orderBy('journals.journal_date', 'asc')
                ->orderBy('journals.created_at', 'asc')
                ->select('journal_details.*')
                ->get();

            // 4. HITUNG RUNNING BALANCE & AKUN LAWAN
            foreach ($transactions as $trx) {
                $totalDebitMutation += $trx->debit;
                $totalCreditMutation += $trx->credit;

                if ($normalBalance === 'DEBIT') {
                    $runningBalance += ($trx->debit - $trx->credit);
                } else {
                    $runningBalance += ($trx->credit - $trx->debit);
                }

                $opposingTrx = JournalDetail::where('journal_id', $trx->journal_id)
                    ->where('chart_of_account_id', '!=', $coaId)
                    ->with('chartOfAccount')
                    ->first();

                $ledger[] = [
                    'date' => $trx->journal->journal_date,
                    'description' => $trx->description ?? $trx->journal->description,
                    'posted_by' => $trx->journal->postedBy?->name ?? '-',
                    'ref_code' => $opposingTrx?->chartOfAccount?->code ?? '-',
                    'ref_name' => $opposingTrx?->chartOfAccount?->name ?? '-',
                    'debit' => $trx->debit,
                    'credit' => $trx->credit,
                    'current_balance' => $runningBalance,
                    'normal_balance' => $normalBalance,
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
            'runningBalance',
            'endingBalance',
            'totalDebitMutation',
            'totalCreditMutation',
            'subPeriods',
            'subPeriodId',
            'startDate',
            'endDate',
            'openingBalanceCreatedBy',
            'openingBalanceDate'
        ));
    }

    public function export(Request $request, string $type)
    {
        $periodId = $request->period_id;
        $month = $request->month;

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
            'pdf' => app()->download($journals),
            default => abort(404),
        };
    }
}
