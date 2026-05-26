<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\BudgetAllocations\StoreBudgetAllocationRequest;
use App\Services\Bendahara\BudgetAllocationService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class BudgetAllocationController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @param BudgetAllocationService $service
     * @return View
     */
    public function index(BudgetAllocationService $service): View
    {
        $periodId = request('period_id');
        $subPeriodId = request('sub_period_id');

        $data = $service->getIndexData($periodId, $subPeriodId);

        return view('pages.menus.bendahara.budget_allocations.index',
            array_merge($data, [
                'periodId' => $periodId,
                'subPeriodId' => $subPeriodId,
            ])
        );
    }

    /**
     * Show the form for creating a new resource.
     * 
     * @param BudgetAllocationService $service
     * @return View
     */
    public function create(BudgetAllocationService $service): View
    {
        return view('pages.menus.bendahara.budget_allocations.create',
            $service->getCreateData()
        );
    }

    /**
     * Store a newly created resource in storage.
     * @param BudgetAllocationService $service
     * @param StoreBudgetAllocationRequest $request
     * @return RedirectResponse
     * @throws Exception
     * 
     */
    public function store(BudgetAllocationService $service, StoreBudgetAllocationRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()->route('bendahara.opening-balances.index')
                ->with('success', 'Distribusi Saldo berhasil disimpan.');
        } catch (Exception $e) {
            return back()->withErrors(['error' => 'Gagal simpan: ' . $e->getMessage()])->withInput();
        }
    }
}
