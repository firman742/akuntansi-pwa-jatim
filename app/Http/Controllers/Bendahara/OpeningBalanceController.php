<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\OpeningBalances\CorrectionOpeningBalanceRequest;
use App\Http\Requests\Bendahara\OpeningBalances\StoreOpeningBalanceRequest;
use App\Http\Requests\Bendahara\OpeningBalances\UpdateOpeningBalanceRequest;
use App\Models\ClosingBalance;
use App\Models\OpeningBalance;
use App\Models\SubPeriod;
use App\Services\Bendahara\OpeningBalanceService;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class OpeningBalanceController extends Controller
{
    /**
     * Display a listing of the resource.
     * @param OpeningBalanceService $service
     * @return View
     */
    public function index(OpeningBalanceService $service): View
    {
        $periodId = request('period_id');
        $subPeriodId = request('sub_period_id');
        $search = request('search');

        $data = $service->getIndexData($periodId, $subPeriodId, $search);

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
     * @param OpeningBalanceService $service
     * @return View
     */
    public function edit(string $id, OpeningBalanceService $service): View
    {
        return view(
            'pages.menus.bendahara.opening_balances.edit',
            $service->getEditData($id)
        );
    }


    /**
     * Update the specified resource in storage.
     *
     * @param string $id
     * @param OpeningBalanceService $service
     * @param UpdateOpeningBalanceRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function update(string $id, OpeningBalanceService $service, UpdateOpeningBalanceRequest $request): RedirectResponse
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
     * Koreksi opening balance untuk periode sebelumnya
     *
     * @param string $id
     * @param OpeningBalanceService $service
     * @param CorrectionOpeningBalanceRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function correction(string $id, OpeningBalanceService $service, CorrectionOpeningBalanceRequest $request): RedirectResponse
    {
        try {
            $service->correction($id, $request->validated());

            return redirect()->route('bendahara.opening-balances.index')
                ->with('success', 'Opening balance berhasil dikoreksi.');
        } catch (Exception $e) {
            return back()->withErrors(['error' => 'Gagal koreksi: ' . $e->getMessage()])->withInput();
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

    /**
     * Check opening balance existence.
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function checkExisting(Request $request): JsonResponse
    {
        $request->validate([
            'coa_id' => ['required', 'uuid'],
            'sub_period_id' => ['required', 'uuid'],
        ]);

        $exists = OpeningBalance::where([
            'chart_of_account_id' => $request->coa_id,
            'sub_period_id'       => $request->sub_period_id,
        ])->exists();

        return response()->json([
            'exists' => $exists,
            'message' => $exists
                ? 'Saldo awal untuk akun dan sub periode ini sudah dibuat.'
                : 'Saldo awal belum ada.',
        ]);
    }
}
