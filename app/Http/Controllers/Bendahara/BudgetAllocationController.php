<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\BudgetAllocations\StoreBudgetAllocationRequest;
use App\Services\Bendahara\BudgetAllocationService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class BudgetAllocationController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @param BudgetAllocationService $service
     * @return View
     */
    public function index(BudgetAllocationService $service, Request $request): View
    {
        $periodId = $request->query('period_id', null);
        $subPeriodId = $request->query('sub_period_id', null);
        $search = $request->query('search', null);

        $data = $service->getIndexData($periodId, $subPeriodId, $search);

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

            return redirect()
                ->route('bendahara.budget-allocations.index')
                ->with('success', 'Distribusi Saldo berhasil disimpan.');
        } catch (Exception $e) {
            return back()
                ->withInput()
                ->withErrors(['error' => 'Gagal simpan: ' . $e->getMessage()]);
        }
    }
}
