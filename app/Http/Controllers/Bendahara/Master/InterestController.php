<?php

namespace App\Http\Controllers\Bendahara\Master;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\Interests\StoreInterestRequest;
use App\Http\Requests\Bendahara\Interests\UpdateInterestRequest;
use App\Models\ChartOfAccount;
use App\Models\Interest;
use App\Services\Bendahara\InterestService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;
use Throwable;

class InterestController extends Controller
{
    /**
     * Display a listing of interests.
     * @return View
     */
    public function index(): View
    {
        $interests = Interest::with([
            'accountInterest',
            'accountExpense',
        ])->latest()->get();

        return view('pages.menus.bendahara.master.interests.index',
            compact('interests')
        );
    }

    /**
     * Show the form for creating a new interest.
     * 
     * @return View
     */
    public function create(): View
    {
        $coas = ChartOfAccount::where('is_active', true)->get();

        $revenueCoas = $coas->filter(
            fn($coa) => $coa->accountType?->name === 'PENDAPATAN'
        );

        $expenseCoas = $coas->filter(
            fn($coa) => $coa->accountType?->name === 'BEBAN'
        );

        return view('pages.menus.bendahara.master.interests.create',
            compact('revenueCoas', 'expenseCoas')
        );
    }

    /**
     * Store a newly created interest.
     * 
     * @param InterestService $service
     * @param StoreInterestRequest $request
     * @return RedirectResponse
     * @throws Throwable
     */
    public function store(InterestService $service, StoreInterestRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()
                ->route('bendahara.master.interests.index')
                ->with('success', 'Bunga berhasil ditambahkan.');
        } catch (Throwable $th) {
            return back()
                ->withInput()
                ->with(
                    'error',
                    'Terjadi kesalahan saat menyimpan bunga: ' . $th->getMessage()
                );
        }
    }

    /**
     * Show the form for editing.
     * 
     * @param string $id
     * @return View
     */
    public function edit(string $id): View
    {
        $interest = Interest::findOrFail($id);

        $coas = ChartOfAccount::where('is_active', true)->get();

        $revenueCoas = $coas->filter(
            fn($coa) => $coa->accountType?->name === 'PENDAPATAN'
        );

        $expenseCoas = $coas->filter(
            fn($coa) => $coa->accountType?->name === 'BEBAN'
        );

        return view('pages.menus.bendahara.master.interests.edit',
            compact(
                'interest',
                'revenueCoas',
                'expenseCoas'
            )
        );
    }

    /**
     * Update the specified interest.
     * 
     * @param string $id
     * @param InterestService $service
     * @param UpdateInterestRequest $request
     * @return RedirectResponse
     * @throws Throwable
     */
    public function update(string $id, InterestService $service, UpdateInterestRequest $request): RedirectResponse
    {
        try {
            $service->update($id, $request->validated());

            return redirect()
                ->route('bendahara.master.interests.index')
                ->with('success', 'Bunga berhasil diperbarui.');
        } catch (Throwable $th) {
            return back()
                ->withInput()
                ->with(
                    'error',
                    'Terjadi kesalahan saat memperbarui bunga: ' . $th->getMessage()
                );
        }
    }

    /**
     * Remove interest.
     * 
     * @param string $id
     * @param InterestService $service
     * @return RedirectResponse
     * @throws Throwable
     */
    public function destroy(string $id, InterestService $service): RedirectResponse 
    {
        try {
            $service->delete($id);

            return redirect()
                ->route('bendahara.master.interests.index')
                ->with('success', 'Bunga berhasil dihapus.');
        } catch (Throwable $th) {
            return back()->with(
                'error',
                'Terjadi kesalahan saat menghapus bunga: ' . $th->getMessage()
            );
        }
    }
}
