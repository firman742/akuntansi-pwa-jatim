<?php

namespace App\Http\Controllers\Bendahara\Master;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\Taxes\StoreTaxRequest;
use App\Http\Requests\Bendahara\Taxes\UpdateTaxRequest;
use App\Models\ChartOfAccount;
use App\Models\Tax;
use App\Services\Bendahara\TaxService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;
use Throwable;

class TaxController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @return View
     */
    public function index(): View
    {
        $taxes = Tax::with(['accountPrepaid', 'accountPayable', 'accountExpense'])->get();
        return view('pages.menus.bendahara.master.taxes.index', compact('taxes'));
    }

    /**
     * Show the form for creating a new resource.
     * 
     * @return View
     */
    public function create(): View
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
     * 
     * @param TaxService $service
     * @param StoreTaxRequest $request
     * @return RedirectResponse
     * @throws Throwable
     */
    public function store(TaxService $service, StoreTaxRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()->route('bendahara.master.taxes.index')
                ->with('success', 'Pajak berhasil ditambahkan');

        } catch (Throwable $th) {
            return back()->with('error', 'Terjadi kesalahan saat menyimpan pajak: ' . $th->getMessage());
        }
    }


    /**
     * Show the form for editing the specified resource.
     * 
     * @param string $id
     * @return View
     */
    public function edit(string $id): View
    {
        $tax = Tax::findOrFail($id);
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

        return view('pages.menus.bendahara.master.taxes.edit', compact('tax', 'assetCoas', 'liabilityCoas', 'expenseCoas'));
    }

    /**
     * Update the specified resource in storage.
     * 
     * @param string $id
     * @param TaxService $service
     * @param UpdateTaxRequest $request
     * @return RedirectResponse
     * @throws Throwable
     */
    public function update(string $id, TaxService $service, UpdateTaxRequest $request): RedirectResponse
    {
        try {
            $service->update($id, $request->validated());

            return redirect()->route('bendahara.master.taxes.index')
                ->with('success', 'Pajak berhasil diperbarui');

        } catch (Throwable $th) {
            return back()->with('error', 'Terjadi kesalahan saat memperbarui pajak: ' . $th->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     * 
     * @param string $id
     * @param TaxService $service
     * @return RedirectResponse
     * @throws Throwable
     */
    public function destroy(string $id, TaxService $service): RedirectResponse
    {
        try {
            $service->delete($id);

            return redirect()->route('bendahara.master.taxes.index')
                ->with('success', 'Pajak berhasil dihapus');

        } catch (Throwable $th) {
            return back()->with('error', 'Terjadi kesalahan saat menghapus pajak: ' . $th->getMessage());
        }
    }
}
