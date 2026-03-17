<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Http\Controllers\Controller;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;
use Illuminate\Http\Request;

class HistoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $query = Transaction::with([
            'creator:id,name',
            'transactionLines.chartOfAccount:id,code,name',
            'period:id,name',
            'subPeriod:id,name'
        ]);

        // ================= FILTER =================
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

        // ================= ORDER =================
        $transactions = $query
            ->orderBy('transaction_date', 'desc')
            ->get();

        // ================= FILTER DATA =================
        $periods = Period::where('is_closed', false)->get();

        $subPeriods = collect();
        if ($request->period_id) {
            $subPeriods = SubPeriod::where('period_id', $request->period_id)
                ->orderBy('start_date')
                ->get();
        }

        return view('pages.menus.user.histories.index', compact(
            'transactions',
            'periods',
            'subPeriods'
        ));
    }
}
