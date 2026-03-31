<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Models\Period;
use App\Models\SubPeriod;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class PeriodController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $periods = Period::orderBy('is_closed', 'desc')->get();

        return view('pages.menus.bendahara.periods.index', compact('periods'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('pages.menus.bendahara.periods.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store()
    {
        $validated = request()->validate([
            'name' => 'required',
            'description'   => 'required',
        ]);

        Period::create([
            'name' => $validated['name'],
            'description' => $validated['description'],
            'is_closed' => false,
        ]);


        return redirect()
            ->route('bendahara.periods.index')
            ->with('success', 'Periode berhasil ditambahkan');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $period = Period::findOrFail($id);

        return view('pages.menus.bendahara.periods.edit', compact('period'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(string $id)
    {
        $period = Period::findOrFail($id);

        $validated = request()->validate([
            'name'       => 'required|string|max:255',
            'description' => 'nullable|string',
            'is_active'  => 'required|boolean',
            'start_date' => 'required|date',
            'end_date'   => 'required|date|after_or_equal:start_date',
        ]);

        $period->update($validated);

        return redirect()
            ->route('bendahara.periods.index')
            ->with('success', 'Periode berhasil diperbarui');
    }

    /**
     * Close the specified resource.
     * TODO: Add validation to prevent closing if there are pending transactions.
     */
    public function close(string $id)
    {
        $period = Period::findOrFail($id);

        $period->is_closed = true;
        $period->closed_at = now();
        $period->closed_by = Auth::id();
        $period->save();

        return redirect()
            ->route('bendahara.periods.index')
            ->with('success', 'Periode berhasil ditutup');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $period = Period::findOrFail($id);
        $period->delete();

        return redirect()
            ->route('bendahara.periods.index')
            ->with('success', 'Periode berhasil dihapus');
    }

    public function getSubPeriods($periodId)
    {
        return SubPeriod::where('period_id', $periodId)
            ->orderBy('start_date')
            ->get();
    }
}
