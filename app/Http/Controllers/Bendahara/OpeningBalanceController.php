<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\OpeningBalances\StoreOpeningBalanceRequest;
use App\Models\ClosingBalance;
use App\Models\SubPeriod;
use App\Services\Bendahara\OpeningBalanceService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class OpeningBalanceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(OpeningBalanceService $service): View
    {
        $periodId = request('period_id');
        $subPeriodId = request('sub_period_id');

        $data = $service->getIndexData($periodId, $subPeriodId);

        return view('pages.menus.bendahara.opening_balances.index',
            array_merge($data, [
                'periodId' => $periodId,
                'subPeriodId' => $subPeriodId,
            ])
        );
    }

    /**
     * Show the form for creating a new resource.
     * 
     * @param OpeningBalanceService $service
     * @return View
     */
    public function create(OpeningBalanceService $service): View
    {
        return view('pages.menus.bendahara.opening_balances.create',
            $service->getCreateData()
        );
    }

    /**
     * Store a newly created resource in storage.
     * @param OpeningBalanceService $service
     * @param StoreOpeningBalanceRequest $request
     * @return RedirectResponse
     * @throws Exception
     * 
     */
    public function store(OpeningBalanceService $service, StoreOpeningBalanceRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()->route('bendahara.opening-balances.index')
                ->with('success', 'Opening balance berhasil disimpan.');
        } catch (Exception $e) {
            return back()->withErrors(['error' => 'Gagal simpan: ' . $e->getMessage()])->withInput();
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
        $openingBalance = ClosingBalance::findOrFail($id);

        return view('pages.menus.bendahara.opening_balances.edit', compact('openingBalance'));
    }


    public function update(string $id, OpeningBalanceService $service, StoreOpeningBalanceRequest $request): RedirectResponse
    {
        try {
            $service->update($id, $request->validated());

            return redirect()->route('bendahara.opening-balances.index')
                ->with('success', 'Opening balance berhasil diperbarui.');
        } catch (Exception $e) {
            return back()->withErrors(['error' => 'Gagal update: ' . $e->getMessage()])->withInput();
        }
    }

    /**
     * Endpoint Baru untuk AJAX: Mengambil Saldo Terakhir
     * Berguna untuk tombol "Lihat Saldo Sebelumnya"
     */
    public function getLastClosingBalance(Request $request)
    {
        $coaId = $request->coa_id;
        $currentSubPeriodId = $request->sub_period_id;

        $currentSubPeriod = SubPeriod::findOrFail($currentSubPeriodId);

        // Mencari sub periode terakhir sebelum tanggal mulai sub periode saat ini
        $lastSubPeriod = SubPeriod::where('end_date', '<', $currentSubPeriod->start_date)
            ->orderBy('end_date', 'desc')
            ->first();

        if (!$lastSubPeriod) {
            return response()->json(['amount' => 0, 'balance_type' => 'DEBIT']);
        }

        $closing = ClosingBalance::where('chart_of_account_id', $coaId)
            ->where('period_id', $lastSubPeriod->period_id)
            ->first();

        return response()->json([
            'amount' => $closing ? $closing->amount : 0,
            'balance_type' => $closing ? $closing->balance_type : 'DEBIT'
        ]);
    }
}
