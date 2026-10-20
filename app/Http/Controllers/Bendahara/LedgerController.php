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
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class LedgerController extends Controller
{
    /**
     * Helper privat untuk mengolah data ledger (DRY principle)
     */
    private function getLedgerData(Request $request): array
    {
        $periods = Period::orderBy('created_at', 'desc')->get();

        $periodId = $request->period_id ?? optional(Period::first())->id;
        $coaId = $request->coa_id;
        $subPeriodId = $request->sub_period_id;
        $startDate = $request->start_date;
        $endDate = $request->end_date;

        $coas = ChartOfAccount::orderBy('code', 'asc')->get();

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
        $openingDebit = 0;
        $openingCredit = 0;

        if ($coaId) {
            $coa = ChartOfAccount::findOrFail($coaId);
            $normalBalance = is_object($coa->normal_balance) ? $coa->normal_balance->value : $coa->normal_balance;

            // 1. OPENING BALANCE
            $opening = OpeningBalance::where('chart_of_account_id', $coaId)
                ->where('period_id', $periodId)
                ->when($subPeriodId, fn($q) => $q->where('sub_period_id', $subPeriodId))
                ->first();

            if ($opening) {
                $openingType = is_object($opening->balance_type) ? $opening->balance_type->value : $opening->balance_type;
                $isOpeningDebit = ($openingType === NormalBalanceEnum::DEBIT->value || strtoupper((string)$openingType) === 'DEBIT');

                if ($isOpeningDebit) {
                    $openingDebit = $opening->amount;
                    $openingBalance = $opening->amount;
                } else {
                    $openingCredit = $opening->amount;
                    $openingBalance = -1 * $opening->amount;
                }
            }

            $openingBalanceCreatedBy = $opening?->creator?->name ?? '-';
            $openingBalanceDate = $opening?->created_at ? Carbon::parse($opening->created_at)->format('d/m/Y') : '-';

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
                        $q->whereNotNull('transaction_id');
                    });

                $priorDebit = (clone $priorMutation)->sum('debit');
                $priorCredit = (clone $priorMutation)->sum('credit');

                if (strtoupper($normalBalance) === 'DEBIT') {
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
                    $q->whereNotNull('transaction_id');
                })
                ->join('journals', 'journals.id', '=', 'journal_details.journal_id')
                ->orderBy('journals.journal_date', 'asc')
                ->orderBy('journals.created_at', 'asc')
                ->select('journal_details.*')
                ->get();

            // 4. HITUNG RUNNING BALANCE & BREAKDOWN TRANSAKSI
            foreach ($transactions as $trx) {
                $totalDebitMutation += $trx->debit;
                $totalCreditMutation += $trx->credit;

                $opposingDetails = JournalDetail::where('journal_id', $trx->journal_id)
                    ->where('chart_of_account_id', '!=', $coaId)
                    ->with('chartOfAccount')
                    ->get();

                $oppCount = $opposingDetails->count();

                if ($oppCount <= 1) {
                    if (strtoupper($normalBalance) === 'DEBIT') {
                        $runningBalance += ($trx->debit - $trx->credit);
                    } else {
                        $runningBalance += ($trx->credit - $trx->debit);
                    }

                    $opp = $opposingDetails->first();

                    $ledger[] = [
                        'date'                  => $trx->journal->journal_date,
                        'journal_number'        => $trx->journal->journal_number ?? '-',
                        'description'           => $trx->description ?? $trx->journal->description ?? '-',
                        'posted_by'             => $trx->journal->postedBy?->name ?? '-',
                        'debit'                 => $trx->debit,
                        'credit'                => $trx->credit,
                        'current_balance'       => $runningBalance,
                        'normal_balance'        => $normalBalance,
                        'opposing_account_code' => $opp?->chartOfAccount?->code ?? '-',
                        'opposing_account_name' => $opp?->chartOfAccount?->name ?? '-',
                    ];
                } else {
                    $totalOpposingAmount = $opposingDetails->sum(fn($d) => $d->debit + $d->credit);

                    foreach ($opposingDetails as $opp) {
                        $oppAmount = $opp->debit + $opp->credit;
                        $ratio = $totalOpposingAmount > 0 ? ($oppAmount / $totalOpposingAmount) : (1 / $oppCount);

                        $splitDebit = $trx->debit * $ratio;
                        $splitCredit = $trx->credit * $ratio;

                        if (strtoupper($normalBalance) === 'DEBIT') {
                            $runningBalance += ($splitDebit - $splitCredit);
                        } else {
                            $runningBalance += ($splitCredit - $splitDebit);
                        }

                        $ledger[] = [
                            'date'                  => $trx->journal->journal_date,
                            'journal_number'        => $trx->journal->journal_number ?? '-',
                            'description'           => $opp->description ?? $trx->description ?? $trx->journal->description ?? '-',
                            'posted_by'             => $trx->journal->postedBy?->name ?? '-',
                            'debit'                 => $splitDebit,
                            'credit'                => $splitCredit,
                            'current_balance'       => $runningBalance,
                            'normal_balance'        => $normalBalance,
                            'opposing_account_code' => $opp->chartOfAccount?->code ?? '-',
                            'opposing_account_name' => $opp->chartOfAccount?->name ?? '-',
                        ];
                    }
                }
            }
            $endingBalance = $runningBalance;
        }

        $selectedPeriod = Period::find($periodId);
        $selectedSubPeriod = $subPeriodId ? SubPeriod::find($subPeriodId) : null;

        return compact(
            'periods',
            'periodId',
            'selectedPeriod',
            'selectedSubPeriod',
            'coas',
            'coa',
            'ledger',
            'openingBalance',
            'openingDebit',
            'openingCredit',
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
        );
    }

    public function index(Request $request)
    {
        $data = $this->getLedgerData($request);
        return view('pages.menus.bendahara.ledgers.index', $data);
    }

    public function export(Request $request)
    {
        $data = $this->getLedgerData($request);

        if (!$data['coa']) {
            return redirect()->back()->with('error', 'Silakan pilih akun terlebih dahulu untuk mengeksport PDF.');
        }

        $pdf = Pdf::loadView('pages.menus.bendahara.ledgers.pdf', $data)
            ->setPaper('a4', 'portrait')
            ->setOption([
                'isHtml5ParserEnabled' => true,
                'isRemoteEnabled'      => true,
            ]);

        $fileName = 'Buku_Besar_' . Str::slug($data['coa']->code . '_' . $data['coa']->name) . '.pdf';

        return $pdf->stream($fileName);
    }
}
