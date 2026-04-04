<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Models\Period;
use App\Models\SubPeriod;
use Illuminate\Http\Request;

class SubPeriodController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
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
     */
    public function create()
    {
        $periods = Period::where('is_closed', false)->get();

        return view(
            'pages.menus.bendahara.sub_periods.create',
            compact('periods')
        );
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'period_id' => 'required|exists:periods,id',
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'start_date' => 'required|date',
            'end_date' => 'required|date|after_or_equal:start_date',
            'is_active' => 'nullable|boolean',
        ]);

        // validation check sub period in range of period
        $period = Period::findOrFail($validated['period_id']);

        if (
            $validated['start_date'] < $period->start_date ||
            $validated['end_date'] > $period->end_date
        ) {
            return back()->withErrors([
                'start_date' => 'Sub periode harus berada dalam rentang periode utama.'
            ]);
        }

        SubPeriod::create([
            'period_id' => $validated['period_id'],
            'name' => $validated['name'],
            'description' => $validated['description'],
            'start_date' => $validated['start_date'],
            'end_date' => $validated['end_date'],
            'is_active' => $request->boolean('is_active'),
        ]);

        return redirect()
            ->route('bendahara.sub-periods.index')
            ->with('success', 'Sub Periode berhasil ditambahkan');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $subPeriod = SubPeriod::findOrFail($id);
        $subPeriod->delete();

        return redirect()
            ->route('bendahara.sub-periods.index')
            ->with('success', 'Sub Periode berhasil dihapus');
    }
}
