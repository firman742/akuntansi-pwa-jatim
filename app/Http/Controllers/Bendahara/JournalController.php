<?php

namespace App\Http\Controllers\Bendahara;

use App\Models\Period;
use App\Models\Journal;
use Illuminate\Http\Request;
use App\Models\ChartOfAccount;
use App\Models\OpeningBalance;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class JournalController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $periodId = $request->get('period_id');

        $periods = Period::orderBy('start_date', 'desc')->get();

        $period = $periodId ? Period::findOrFail($periodId) : Period::active()->firstOrFail();

        $journals = Journal::with('transaction')
            ->where('period_id', $period->id)
            ->orderBy('journal_date')
            ->get()
            ->map(fn($j) => [
                'id'            => $j->id,
                'journal_date'  => $j->journal_date->toDateString(),
                'journal_number' => $j->journal_number,
                'description'   => $j->description,
                'total_debit'   => $j->total_debit,
                'total_credit'  => $j->total_credit,
                'detail_url'    => route('bendahara.journals.show', $j),
            ]);


        return view('pages.menus.bendahara.journals.index', compact([
                'journals',
                'periods',
                'periodId'
            ]));
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $journal = Journal::with(['postedBy', 'details.coa'])
            ->findOrFail($id);

        return view('pages.menus.bendahara.journals.show', compact('journal'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(OpeningBalance $openingBalance)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, OpeningBalance $openingBalance)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(OpeningBalance $openingBalance)
    {
        //
    }
}
