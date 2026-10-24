<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Enums\NormalBalanceEnum;
use App\Http\Controllers\Controller;
use App\Models\ChartOfAccount;
use App\Models\CoaBalance;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\TransactionLine;
use Illuminate\Http\Request;
use Illuminate\View\View;

class CoaBalanceController extends Controller
{
    /**
     * Tampilan Utama Saldo Akun (POV Akuntan)
     */
    public function index(Request $request): View
    {
        $periodId    = $request->query('period_id');
        $subPeriodId = $request->query('sub_period_id');
        $coaId       = $request->query('coa_id');
        $search      = $request->query('search');

        $periods = Period::all();

        // Auto select sub-periode terbaru jika belum ada filter
        if (! $subPeriodId && ! $periodId) {
            $latestSubPeriod = SubPeriod::orderBy('start_date', 'desc')->first();
            if ($latestSubPeriod) {
                $subPeriodId = $latestSubPeriod->id;
                $periodId    = $latestSubPeriod->period_id;
            }
        } elseif ($periodId && ! $subPeriodId) {
            $latestSubPeriod = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date', 'desc')
                ->first();
            if ($latestSubPeriod) {
                $subPeriodId = $latestSubPeriod->id;
            }
        }

        $subPeriods = collect();
        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)->orderBy('start_date')->get();
        }

        $coas = ChartOfAccount::where('is_active', true)->orderBy('code')->get();

        // Query COA
        $coaQuery = ChartOfAccount::where('is_active', true)->orderBy('code', 'asc');
        if ($coaId) {
            $coaQuery->where('id', $coaId);
        }
        if ($search) {
            $coaQuery->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhere('code', 'like', "%{$search}%");
            });
        }
        $allCoas = $coaQuery->get();

        // Data CoaBalance
        $existingBalances = collect();
        if ($subPeriodId || $periodId) {
            $balanceQuery = CoaBalance::query();
            if ($subPeriodId) {
                $balanceQuery->where('sub_period_id', $subPeriodId);
            } elseif ($periodId) {
                $balanceQuery->where('period_id', $periodId);
            }
            $existingBalances = $balanceQuery->get()->keyBy('chart_of_account_id');
        }

        // Mapping Data COA + Balance
        $coaBalances = $allCoas->map(function ($coa) use ($existingBalances) {
            /** @var CoaBalance|null $balance */
            $balance = $existingBalances->get($coa->id);

            return [
                'id'                  => $balance?->id,
                'chart_of_account_id' => $coa->id,
                'chart_of_account'    => [
                    'id'   => $coa->id,
                    'name' => $coa->name,
                    'code' => $coa->code,
                ],
                'opening_balance' => $balance ? (float) $balance->opening_balance : 0,
                'debit_total'     => $balance ? (float) $balance->debit_total : 0,
                'credit_total'    => $balance ? (float) $balance->credit_total : 0,
                'current_balance' => $balance ? (float) $balance->current_balance : 0,
            ];
        });

        $selectedSubPeriodName = null;
        if ($subPeriodId && $subPeriods->isNotEmpty()) {
            $activeSub = $subPeriods->firstWhere('id', $subPeriodId);
            if ($activeSub) {
                $selectedSubPeriodName = $activeSub->name;
            }
        } elseif ($periodId && $periods->isNotEmpty()) {
            $activePeriod = $periods->firstWhere('id', $periodId);
            if ($activePeriod) {
                $selectedSubPeriodName = 'PERIODE ' . $activePeriod->name;
            }
        }

        return view('pages.menus.user.coa_balances.index', compact(
            'subPeriodId',
            'periodId',
            'coaId',
            'subPeriods',
            'periods',
            'coas',
            'coaBalances',
            'selectedSubPeriodName'
        ));
    }

    /**
     * Tampilan Detail Saldo Akun (POV Akuntan)
     */
    public function show(string $id): View
    {
        $coaBalance = CoaBalance::with([
            'chartOfAccount:id,name,code,normal_balance,is_active',
            'period:id,name',
            'subPeriod:id,name,period_id,start_date,end_date',
        ])->findOrFail($id);

        $account = $coaBalance->chartOfAccount;

        // ---------------------------------------------------------------------
        // 1. Kalkulasi Saldo Terpakai & Sisa Saldo Tersedia
        // ---------------------------------------------------------------------
        $openingBalance = (float) $coaBalance->opening_balance;
        $debitTotal     = (float) $coaBalance->debit_total;
        $creditTotal    = (float) $coaBalance->credit_total;
        $currentBalance = (float) $coaBalance->current_balance;

        // Tentukan batas total dana masuk/kapasitas berdasarkan Normal Balance
        $isDebitNormal = ($account->normal_balance?->value ?? $account->normal_balance) === NormalBalanceEnum::DEBIT->value
            || $account->normal_balance === NormalBalanceEnum::DEBIT;

        if ($isDebitNormal) {
            // Untuk akun DEBIT (Aset/Beban): Tambahan dana dari Debit, terpakai via Kredit
            $totalFunds   = $openingBalance + $debitTotal;
            $usedBalance  = $creditTotal;
        } else {
            // Untuk akun KREDIT (Kewajiban/Ekuitas/Pendapatan): Tambahan dana dari Kredit, terpakai via Debit
            $totalFunds   = $openingBalance + $creditTotal;
            $usedBalance  = $debitTotal;
        }

        $usedPercentage = $totalFunds > 0 ? min(100, round(($usedBalance / $totalFunds) * 100, 1)) : 0;
        $remainingPercentage = max(0, 100 - $usedPercentage);

        // ---------------------------------------------------------------------
        // 2. Query Timeline Aktifitas Saldo
        // ---------------------------------------------------------------------
        // A. Riwayat Saldo Awal
        $openingBalancesHistory = OpeningBalance::with(['creator:id,name'])
            ->where('chart_of_account_id', $coaBalance->chart_of_account_id)
            ->where('sub_period_id', $coaBalance->sub_period_id)
            ->latest()
            ->get();

        // B. Riwayat Transaksi Debit (Perspektif Akun)
        $debitTransactions = TransactionLine::with([
            'transaction' => function ($q) {
                $q->with('creator:id,name');
            }
        ])
            ->where('chart_of_account_id', $coaBalance->chart_of_account_id)
            ->where('position', NormalBalanceEnum::DEBIT)
            ->whereHas('transaction', function ($q) use ($coaBalance) {
                $q->where('sub_period_id', $coaBalance->sub_period_id);
            })
            ->latest()
            ->get();

        // C. Riwayat Transaksi Kredit (Perspektif Akun)
        $creditTransactions = TransactionLine::with([
            'transaction' => function ($q) {
                $q->with('creator:id,name');
            }
        ])
            ->where('chart_of_account_id', $coaBalance->chart_of_account_id)
            ->where('position', NormalBalanceEnum::CREDIT)
            ->whereHas('transaction', function ($q) use ($coaBalance) {
                $q->where('sub_period_id', $coaBalance->sub_period_id);
            })
            ->latest()
            ->get();

        // ---------------------------------------------------------------------
        // 3. Ringkasan Statistik Tambahan
        // ---------------------------------------------------------------------
        $summary = [
            'opening_balance'      => $openingBalance,
            'debit_total'          => $debitTotal,
            'credit_total'         => $creditTotal,
            'current_balance'      => $currentBalance,
            'used_balance'         => $usedBalance,
            'total_funds'          => $totalFunds,
            'used_percentage'      => $usedPercentage,
            'remaining_percentage' => $remainingPercentage,
            'debit_count'          => $debitTransactions->count(),
            'credit_count'         => $creditTransactions->count(),
            'avg_debit_amount'     => $debitTransactions->avg('amount') ?? 0,
            'avg_credit_amount'    => $creditTransactions->avg('amount') ?? 0,
            'last_transaction_at'  => $coaBalance->last_transaction_at,
        ];

        return view('pages.menus.user.coa_balances.show', compact(
            'coaBalance',
            'account',
            'summary',
            'openingBalancesHistory',
            'debitTransactions',
            'creditTransactions'
        ));
    }
}