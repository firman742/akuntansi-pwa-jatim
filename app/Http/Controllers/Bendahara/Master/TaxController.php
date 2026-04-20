<?php

namespace App\Http\Controllers\Bendahara\Master;

use App\Http\Controllers\Controller;
use App\Models\ChartOfAccount;
use App\Models\Tax;
use Illuminate\Http\Request;

class TaxController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $taxes = Tax::with(['accountPrepaid', 'accountPayable', 'accountExpense'])->get();

        // dd($taxes->toArray());
        return view('pages.menus.bendahara.master.taxes.index', compact('taxes'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $assetCoas = ChartOfAccount::whereHas(
            'accountType',
            fn($q) =>
            $q->where('name', 'ASET')
        )->orderBy('code')->get();

        $liabilityCoas = ChartOfAccount::whereHas(
            'accountType',
            fn($q) =>
            $q->where('name', 'KEWAJIBAN')
        )->orderBy('code')->get();

        $expenseCoas = ChartOfAccount::whereHas(
            'accountType',
            fn($q) =>
            $q->where('name', 'BEBAN')
        )->orderBy('code')->get();

        return view('pages.menus.bendahara.master.taxes.create', compact('assetCoas', 'liabilityCoas', 'expenseCoas'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'type' => 'required|in:PERCENTAGE,FIXED',

            // rate hanya wajib jika percentage
            'rate' => 'nullable|numeric|min:0|max:100|required_if:type,PERCENTAGE',

            'account_prepaid_id' => 'nullable|exists:chart_of_accounts,id',
            'account_payable_id' => 'nullable|exists:chart_of_accounts,id',
            'account_expense_id' => 'nullable|exists:chart_of_accounts,id',
        ]);

        // Jika FIXED, pastikan rate null / 0
        $data = $request->all();

        if ($data['type'] === 'FIXED') {
            $data['rate'] = 0;
        }

        Tax::create($data);

        return redirect()->route('bendahara.master.taxes.index')
            ->with('success', 'Pajak berhasil dibuat');
    }

    public function edit(Tax $tax)
    {
        $coas = ChartOfAccount::where('is_active', true)->get();
        return view('bendahara.master.taxes.edit', compact('tax', 'coas'));
    }

    public function update(Request $request, Tax $tax)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'rate' => 'required|numeric|min:0|max:100',
            'account_prepaid_id' => 'required|exists:chart_of_accounts,id',
            'account_payable_id' => 'nullable|exists:chart_of_accounts,id',
            'account_expense_id' => 'nullable|exists:chart_of_accounts,id',
        ]);

        $tax->update($request->all());

        return redirect()->route('bendahara.master.taxes.index')
            ->with('success', 'Pajak berhasil diupdate');
    }

    public function destroy(Tax $tax)
    {
        $tax->delete();

        return back()->with('success', 'Pajak dihapus');
    }
}
