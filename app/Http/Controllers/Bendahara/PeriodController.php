<?php

namespace App\Http\Controllers\Bendahara;

use Carbon\Carbon;
use App\Models\Period;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests\StorePeriodRequest;
use App\Http\Requests\UpdatePeriodRequest;

class PeriodController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $periods = Period::with('closedByUser')->get()->map(function ($period) {
            return [
                'id' => $period->id,
                'name' => $period->name,
                'description' => $period->description,
                'start_date' => $period->start_date?->format('Y-m-d'),
                'end_date' => $period->end_date?->format('Y-m-d'),
                'is_closed' => $period->is_closed,

                'closed_at' => $period->closed_at
                    ? $period->closed_at->format('d M Y H:i')
                    : '-',

                'closed_by' => $period->closedByUser
                    ? $period->closedByUser->name
                    : '-',
            ];
        });


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
            'start_date' => 'required|date',
            'end_date'   => 'required|date|after_or_equal:start_date',
        ]);

        $start = Carbon::parse($validated['start_date']);
        $end   = Carbon::parse($validated['end_date']);

        /**
         * Generate nama periode otomatis
         */
        if ($start->year === $end->year && $start->month === $end->month) {
            // Periode bulanan
            $name = $start->translatedFormat('F Y');
            $description = 'Periode ' . $name;
        } else {
            // Periode rentang
            $name = sprintf(
                '%s %d – %s %d',
                $start->translatedFormat('M'),
                $start->year,
                $end->translatedFormat('M'),
                $end->year
            );

            $description = sprintf(
                'Periode %s %d sampai %s %d',
                $start->translatedFormat('F'),
                $start->year,
                $end->translatedFormat('F'),
                $end->year
            );
        }

        Period::create([
            'name'        => $name,
            'description' => $description,
            'start_date'  => $start->toDateString(),
            'end_date'    => $end->toDateString(),

     
        ]);

        return redirect()
            ->route('bendahara.periode.index')
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
            ->route('bendahara.periode.index')
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
            ->route('bendahara.periode.index')
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
            ->route('bendahara.periode.index')
            ->with('success', 'Periode berhasil dihapus');
    }
}
