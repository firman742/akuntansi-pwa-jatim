<?php

namespace App\Http\Controllers\Bendahara;

use App\Enums\TransactionType;
use App\Http\Controllers\Controller;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\View\View;

class TransactionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @param Request $request
     * @return View
     */
    public function index(Request $request): View
    {
        $query = Transaction::with([
            'creator:id,name',
            'transactionLines.chartOfAccount:id,code,name',
            'period:id,name,start_date,end_date',
            'subPeriod:id,name,start_date,end_date'
        ]);

        // ================= SEARCH (No. Transaksi / Deskripsi / COA) =================
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('transaction_number', 'like', "%{$search}%")
                    ->orWhere('description', 'like', "%{$search}%")
                    ->orWhereHas('transactionLines.chartOfAccount', function ($qCoa) use ($search) {
                        $qCoa->where('code', 'like', "%{$search}%")
                            ->orWhere('name', 'like', "%{$search}%");
                    });
            });
        }

        // ================= FILTERS =================
        if ($request->filled('period_id')) {
            $query->where('period_id', $request->period_id);
        }

        if ($request->filled('sub_period_id')) {
            $query->where('sub_period_id', $request->sub_period_id);
        }

        if ($request->filled('start_date')) {
            $query->whereDate('transaction_date', '>=', $request->start_date);
        }

        if ($request->filled('end_date')) {
            $query->whereDate('transaction_date', '<=', $request->end_date);
        }

        if ($request->filled('transaction_type')) {
            $query->where('transaction_type', $request->transaction_type);
        }

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        // ================= STATS AGGREGATION =================
        $statsQuery = clone $query;

        $totalIncome = (clone $statsQuery)->where('transaction_type', TransactionType::INCOME)->sum('net_amount');
        $totalExpense = (clone $statsQuery)->where('transaction_type', TransactionType::EXPENSE)->sum('net_amount');

        $stats = [
            'total_count'   => (clone $statsQuery)->count(),
            'total_income'  => $totalIncome,
            'total_expense' => $totalExpense,
            'net_balance'   => $totalIncome - $totalExpense,
        ];

        // ================= GET TRANSACTIONS =================
        $transactions = $query
            ->latest('transaction_date')
            ->latest('created_at')
            ->get();

        // ================= FILTER DATA =================
        $periods = Period::query()->select('id', 'name', 'start_date', 'end_date')->get();

        $subPeriods = collect();
        if ($request->filled('period_id')) {
            $subPeriods = SubPeriod::where('period_id', $request->period_id)
                ->orderBy('start_date')
                ->get();
        }

        return view('pages.menus.bendahara.transactions.index', compact(
            'transactions',
            'stats',
            'periods',
            'subPeriods'
        ));
    }



    /**
     * Display the specified resource.
     *
     * @param string $id
     * @return View
     */
    public function show(string $id): View
    {
        $transaction = Transaction::findOrFail($id);

        $transaction->load([
            'creator:id,name',
            'period:id,name',
            'subPeriod:id,name',
            'transactionLines.chartOfAccount',
            'journal.details.chartOfAccount',
        ]);

        return view(
            'pages.menus.bendahara.transactions.show',
            compact('transaction')
        );
    }
}
