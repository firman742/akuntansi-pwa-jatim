<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\AccountTopups\StoreAccountTopupRequest;
use App\Services\Bendahara\AccountTopupService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class AccountTopupController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @param AccountTopupService $service
     * @return View
     */
    public function index(AccountTopupService $service): View
    {
        $periodId = request('period_id');
        $subPeriodId = request('sub_period_id');
        $search = request('search');

        $data = $service->getIndexData($periodId, $subPeriodId, $search);

        return view('pages.menus.bendahara.account_topups.index', array_merge($data, [
            'periodId' => $periodId,
            'subPeriodId' => $subPeriodId,
        ]));
    }

    public function create(AccountTopupService $service): View
    {
        return view('pages.menus.bendahara.account_topups.create', $service->getCreateData());
    }


    /**
     * Store a newly created resource in storage.
     * 
     * @param AccountTopupService $service
     * @param StoreAccountTopupRequest $request
     * @return RedirectResponse
     */
    public function store(AccountTopupService $service, StoreAccountTopupRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());
            return redirect()
                ->route('bendahara.account-topups.index')
                ->with('success', 'Topup akun berhasil ditambahkan.');

        } catch (\Exception $e) {
            return back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat menambahkan topup akun: ' . $e->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     * 
     * @param AccountTopupService $service
     * @param string $id
     * @return RedirectResponse
     */
    public function destroy(AccountTopupService $service, string $id): RedirectResponse
    {
        try {
            $service->destroy($id);
            return redirect()
                ->route('bendahara.account-topups.index')
                ->with('success', 'Topup akun berhasil dihapus.');
        } catch (\Exception $e) {
            return back()
                ->with('error', 'Terjadi kesalahan saat menghapus topup akun: ' . $e->getMessage());
        }
    }
}
