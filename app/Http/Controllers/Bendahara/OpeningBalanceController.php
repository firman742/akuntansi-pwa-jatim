<?php

namespace App\Http\Controllers\Bendahara;

use App\Models\Period;
use Illuminate\Http\Request;
use App\Models\ChartOfAccount;
use App\Models\OpeningBalance;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class OpeningBalanceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // Ambil periode aktif (1 saja)
        $activePeriod = Period::where('is_closed', false)
            ->orderBy('start_date')
            ->first();

        // Ambil semua periode untuk filter
        $periods = Period::orderBy('start_date', 'desc')->get();

        // Jika tidak ada periode aktif, fallback ke periode terbaru
        $periodId = request('period_id')
            ?? optional($activePeriod)->id
            ?? optional($periods->first())->id;

        $openingBalances = OpeningBalance::with(['chartOfAccount'])
            ->where('period_id', $periodId)
            ->get()
            ->map(function ($item) {
                return [
                    'id'        => $item->id,
                    'account_name' => $item->chartOfAccount->name,
                    'account_code' => $item->chartOfAccount->code,
                    'debit'     => $item->balance_type === 'debit' ? $item->amount : 0,
                    'credit'    => $item->balance_type === 'credit' ? $item->amount : 0,
                ];
            });

        return view('pages.menus.bendahara.opening_balances.index',
            compact('openingBalances', 'periods', 'periodId')
        );
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $periods = Period::where('is_closed', false)
            ->orderBy('start_date', 'desc')
            ->get();

        $coaLists = ChartOfAccount::orderBy('code')->get();

        return view('pages.menus.bendahara.opening_balances.create', compact('periods', 'coaLists'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'chart_of_account_id' => 'required|exists:chart_of_accounts,id',
            'period_id' => 'required|exists:periods,id',
            'balance_type' => 'required|in:DEBIT,CREDIT',
            'amount' => 'required|numeric|min:0',
        ]);

        $validated['created_by'] = Auth::id();
        OpeningBalance::create($validated);

        return redirect()->route('bendahara.opening-balances.index')
            ->with('success', 'Opening balance created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(OpeningBalance $openingBalance)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(OpeningBalance $openingBalance)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, OpeningBalance $openingBalance)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(OpeningBalance $openingBalance)
    {
        //
    }
}
