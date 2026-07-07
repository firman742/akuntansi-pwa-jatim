<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\Periods\StorePeriodRequest;
use App\Http\Requests\Bendahara\Periods\UpdatePeriodRequest;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Services\Bendahara\PeriodService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use Illuminate\View\View;

class PeriodController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @param Request $request
     * @return View
     */
    public function index(Request $request): View
    {
        $search = $request->input('search');

        $periods = Period::with('subPeriods')
            ->withCount('transactions')
            ->withCount([
                'subPeriods as sub_period_transactions_count' => function ($query) {
                    $query->join(
                        'transactions',
                        'transactions.sub_period_id',
                        '=',
                        'sub_periods.id'
                    );
                }
            ])
            ->when($search, function ($query, $search) {
                $query->where('name', 'like', "%{$search}%")
                    ->orWhere('description', 'like', "%{$search}%");
            })
            ->orderBy('start_date', 'desc')
            ->get();

        return view('pages.menus.bendahara.periods.index', compact('periods'));
    }

    /**
     * Show the form for creating a new resource.
     * 
     * @return View
     */
    public function create(): View
    {
        return view('pages.menus.bendahara.periods.create');
    }

    /**
     * Store a newly created resource in storage.
     * 
     * @param PeriodService $service
     * @param StorePeriodRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function store(PeriodService $service, StorePeriodRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()
                ->route('bendahara.periods.index')
                ->with('success', 'Periode berhasil ditambahkan');
        } catch (Exception $e) {
            return back()
                ->withInput()
                ->withErrors([
                'period' => $e->getMessage()
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
        $period = Period::findOrFail($id);

        return view('pages.menus.bendahara.periods.edit', compact('period'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(string $id, PeriodService $service, UpdatePeriodRequest $request): RedirectResponse
    {
        try {
            $service->update($id, $request->validated());

            return redirect()
                ->route('bendahara.periods.index')
                ->with('success', 'Periode - ' . ($request->name ?? '-') . ' berhasil diubah');

        } catch (Exception $e) {
            return back()
                ->withInput()->withErrors([
                'period' => $e->getMessage()
            ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id, PeriodService $service): RedirectResponse
    {
        $period = Period::findOrFail($id);

        try {
            $service->delete($period);

            return redirect()
                ->route('bendahara.periods.index')
                ->with('success', 'Periode - ' . ($period->name ?? '-') . ' berhasil dihapus');
        } catch (Exception $e) {
            return back()->withInput()->withErrors([
                'period' => $e->getMessage()
            ]);
        }
    }

    /**
     * Get sub periods by period id
     * @param string $periodId
     * @return Collection
     */
    public function getSubPeriods(string $periodId): Collection
    {
        return SubPeriod::where('period_id', $periodId)
            ->where('is_closed', false)
            ->orderBy('start_date')
            ->get();
    }
}
