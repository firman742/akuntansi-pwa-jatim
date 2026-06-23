<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Models\BudgetAllocation;
use App\Models\CoaBalance;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;
use App\Models\UserAccountBalance;
use Illuminate\Http\Request;
use Illuminate\View\View;

class CoaBalanceController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @param Request $request
     * @return View
     */
    public function index(Request $request): View
    {
        $periodId = $request->query('period_id');
        $subPeriodId = $request->query('sub_period_id');
        $search = $request->query('search');

        $periods = Period::where('is_closed', false)->get();
        $subPeriods = collect();

        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date')
                ->get();
        }

        $query = CoaBalance::query()->with([
            'chartOfAccount:id,name,code',
            'subPeriod:id,name,period_id,start_date,end_date',
            'subPeriod.period:id,is_closed'
        ]);


        if ($periodId) {
            $query->where('period_id', $periodId);
        }

        if ($subPeriodId) {
            $query->where('sub_period_id', $subPeriodId);
        }

        $coaBalances = $query->whereHas('chartOfAccount', function ($q) use ($search) {
            $q->where('name', 'like', "%{$search}%")
                ->orWhere('code', 'like', "%{$search}%");
        })
            ->orderBy('created_at')
            ->get();

        return view('pages.menus.bendahara.coa_balances.index', compact(
            "subPeriodId",
            "periodId",
            "subPeriods",
            "periods",
            "coaBalances"
        ));
    }

    /**
     * Display the specified resource with details.
     *
     * @param string $id
     * @return View
     */
    public function show(string $id): View
    {
        $coaBalance = CoaBalance::with([
            'chartOfAccount:id,name,code',
            'period:id,name',
            'subPeriod:id,name,period_id,start_date,end_date',
        ])->findOrFail($id);

        /**
         * ==========================================================
         * DETAIL AKUN
         * ==========================================================
         */
        $account = $coaBalance->chartOfAccount;

        /**
         * ==========================================================
         * RINGKASAN SALDO
         * ==========================================================
         */
        $summary = [
            'opening_balance' => $coaBalance->opening_balance,
            'debit_total'     => $coaBalance->debit_total,
            'credit_total'    => $coaBalance->credit_total,
            'current_balance' => $coaBalance->current_balance,
            'last_transaction_at' => $coaBalance->last_transaction_at,
        ];

        /**
         * ==========================================================
         * RIWAYAT SALDO AWAL
         * ==========================================================
         */
        $openingBalances = OpeningBalance::with([
            'creator:id,name',
        ])
            ->where('chart_of_account_id', $coaBalance->chart_of_account_id)
            ->where('sub_period_id', $coaBalance->sub_period_id)
            ->latest()
            ->get();

        /**
         * ==========================================================
         * RIWAYAT TRANSAKSI
         * ==========================================================
         */
        $transactions = Transaction::query()
            ->with([
                'creator:id,name',
                'transactionLines' => function ($query) use ($coaBalance) {
                    $query->where(
                        'chart_of_account_id',
                        $coaBalance->chart_of_account_id
                    );
                },
            ])
            ->where('sub_period_id', $coaBalance->sub_period_id)
            ->whereHas('transactionLines', function ($query) use ($coaBalance) {
                $query->where(
                    'chart_of_account_id',
                    $coaBalance->chart_of_account_id
                );
            })
            ->latest('transaction_date')
            ->get();

        /**
         * ==========================================================
         * RIWAYAT ALOKASI ANTAR AKUN
         * ==========================================================
         */
        $budgetAllocations = BudgetAllocation::with([
            'fromChartOfAccount:id,name,code',
            'toChartOfAccount:id,name,code',
            'creator:id,name',
        ])
            ->where('sub_period_id', $coaBalance->sub_period_id)
            ->where(function ($query) use ($coaBalance) {
                $query->where(
                    'from_chart_of_account_id',
                    $coaBalance->chart_of_account_id
                )
                    ->orWhere(
                        'to_chart_of_account_id',
                        $coaBalance->chart_of_account_id
                    );
            })
            ->latest()
            ->get();

        /**
         * ==========================================================
         * RIWAYAT ALOKASI DANA KE USER
         * ==========================================================
         */
        $userAccountBalances = UserAccountBalance::with([
            'userAccount',
            'userAccount.user:id,name',
            'allocatedBy:id,name',
        ])
            ->where('coa_balance_id', $coaBalance->id)
            ->latest('allocated_at')
            ->get();

        

        

        /**
         * ==========================================================
         * TIMELINE GABUNGAN
         * ==========================================================
         */
        $timeline = collect();

        // Opening Balance
        foreach ($openingBalances as $openingBalance) {
            $timeline->push([
                'type' => 'opening_balance',
                'date' => $openingBalance->created_at,
                'title' => 'Saldo Awal',
                'amount' => $openingBalance->amount,
                'data' => $openingBalance,
            ]);
        }
        

        // Transaction
        foreach ($transactions as $transaction) {
            $timeline->push([
                'type' => 'transaction',
                'date' => $transaction->transaction_date,
                'title' => $transaction->description,
                'amount' => $transaction->net_amount,
                'data' => $transaction,
            ]);
        }

        // Budget Allocation
        foreach ($budgetAllocations as $allocation) {
            $timeline->push([
                'type' => 'allocation',
                'date' => $allocation->created_at,
                'title' => 'Alokasi Antar Akun',
                'amount' => $allocation->amount,
                'data' => $allocation,
            ]);
        }

        // User Allocation
        foreach ($userAccountBalances as $userAllocation) {
            $timeline->push([
                'type' => 'user_allocation',
                'date' => $userAllocation->allocated_at,
                'title' => 'Alokasi ke Pengguna',
                'amount' => $userAllocation->allocated_balance,
                'data' => $userAllocation,
            ]);
        }

        
        $timeline = $timeline
        ->sortByDesc('date')
        ->values();

        /* ==========================================================
         * GRAFIK PERGERAKAN SALDO
         * ==========================================================
         */
        $chartData = [];
        if ($transactions->isEmpty() && $budgetAllocations->isEmpty()) {
            $chartData = [
                'labels' => [
                    $coaBalance->subPeriod->start_date->format('d M'),
                    $coaBalance->subPeriod->end_date->format('d M')
                ],
                'data' => [
                    $coaBalance->opening_balance,
                    $coaBalance->opening_balance
                ]
            ];
        }

        $chartLabels = $chartData['labels'] ?? [];
        $chartValues = $chartData['data'] ?? [];

        $hasChartData = !empty($chartValues) && !empty($chartLabels);

        
        return view('pages.menus.bendahara.coa_balances.show', [
            'coaBalance' => $coaBalance,
            'account' => $account,
            'summary' => $summary,
            'openingBalances' => $openingBalances,
            'transactions' => $transactions,
            'budgetAllocations' => $budgetAllocations,
            'userAccountBalances' => $userAccountBalances,
            'timeline' => $timeline,
            'chartData' => $chartData,
            'hasChartData' => $hasChartData,
        ]);
    }
}
