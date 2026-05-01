<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\SubPeriods\StoreSubPeriodRequest;
use App\Http\Requests\Bendahara\SubPeriods\UpdateSubPeriodRequest;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Services\Bendahara\SubPeriodService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;
use Exception;

class SubPeriodController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @return View
     */
    public function index(): View
    {
        // Ambil periode aktif (1 saja)
        $activePeriod = Period::where('is_closed', false)
            ->first();

        // Ambil semua periode untuk filter
        $periods = Period::orderBy('name')->get();

        // Jika tidak ada periode aktif, fallback ke periode terbaru
        $periodId = request('period_id')
            ?? optional($activePeriod)->id
            ?? optional($periods->first())->id;

        $query = SubPeriod::with('period');

        if (request()->period_id) {
            $query->where('period_id', request()->period_id);
        }

        $sub_periods = $query->get();

        return view(
            'pages.menus.bendahara.sub_periods.index',
            compact('sub_periods', 'periods', 'periodId')
        );
    }

    /**
     * Show the form for creating a new resource.
     * 
     * @return View
     */
    public function create(): View
    {
        $periods = Period::where('is_closed', false)->get();

        return view(
            'pages.menus.bendahara.sub_periods.create',
            compact('periods')
        );
    }

    /**
     * Store a newly created resource in storage.
     * @param SubPeriodService $service
     * @param StoreSubPeriodRequest $request
     * @return RedirectResponse
     * @throws Exception if the sub-period dates are outside the parent period's date range.
     */
    public function store(SubPeriodService $service, StoreSubPeriodRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()
                ->route('bendahara.sub-periods.index')
                ->with('success', 'Sub Periode berhasil ditambahkan');

        } catch (Exception $e) {
            return back()
                ->withInput()
                ->withErrors([
                    'start_date' => $e->getMessage()
                ]);
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
        $subPeriod = SubPeriod::findOrFail($id);
        $periods = Period::where('is_closed', false)->get();

        return view(
            'pages.menus.bendahara.sub_periods.edit',
            compact('subPeriod', 'periods')
        );
    }

    /**
     * Update the specified resource in storage.
     * @param string $id
     * @param SubPeriodService $service
     * @param UpdateSubPeriodRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function update(string $id, SubPeriodService $service, UpdateSubPeriodRequest $request): RedirectResponse
    {
        try {
            $service->update($id, $request->validated());

            return redirect()
                ->route('bendahara.sub-periods.index')
                ->with('success', 'Sub Periode berhasil diperbarui');

        } catch (Exception $e) {
            return back()
                ->withInput()
                ->withErrors([
                    'start_date' => $e->getMessage()
                ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     * 
     * @param string $id
     * @param SubPeriodService $service
     * @return RedirectResponse
     * @throws Exception if the sub-period has related transactions or journals.
     */
    public function destroy(string $id, SubPeriodService $service): RedirectResponse
    {
        try {
            $service->delete($id);

            return redirect()
                ->route('bendahara.sub-periods.index')
                ->with('success', 'Sub Periode berhasil dihapus');

        } catch (Exception $e) {
            return back()
                ->withErrors([
                    'error' => $e->getMessage()
                ]);
        }
    }
}
