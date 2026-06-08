<?php

namespace App\Http\Controllers\Bendahara;

use App\Enums\RequestStatus;
use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\RequestBalances\ApproveRequestBalanceRequest;
use App\Http\Requests\Bendahara\RequestBalances\RejectRequestBalanceRequest;
use App\Models\BalanceRequest;
use App\Models\CoaBalance;
use App\Services\Bendahara\RequestBalanceService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class BalanceRequestController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return View
     */
    public function index(): View
    {
        $requests = BalanceRequest::query()
            ->with([
                'approver:id,name',
                'userAccount',
                'userAccount.user',
                'sourceCoa',
                'sourceCoa.chartOfAccount:id,code,name',
                'period:id,name',
                'subPeriod:id,name',
            ])
            ->orderByDesc('created_at')
            ->get()
            ->map(function ($item) {
                $item->status_label = RequestStatus::from($item->status)->label();

                return $item;
            });

        return view('pages.menus.bendahara.requestBalances.index', compact('requests'));
    }

    /**
     * Display the specified resource.
     *
     * @param string $id
     * @return View
     */
    public function show(string $id): View
    {
        $balanceRequest = BalanceRequest::query()
            ->where('id', $id)
            ->with([
                'approver:id,name',
                'userAccount',
                'userAccount.user',
                'sourceCoa',
                'sourceCoa.chartOfAccount:id,code,name',
                'period:id,name',
                'subPeriod:id,name',
            ])
            ->firstOrFail();

        // Get Source COA
        $sourceCoas = CoaBalance::query()
            ->with('chartOfAccount')
            ->get()
            ->map(function ($item) {
                $item->coa_name = $item->chartOfAccount->code . ' - ' . $item->chartOfAccount->name;
                return $item;
            });


        return view('pages.menus.bendahara.requestBalances.show', compact('balanceRequest', 'sourceCoas'));
    }

    /**
     * Approve the specified resource in storage.
     *
     * @param string $id
     * @param RequestBalanceService $service
     * @param ApproveRequestBalanceRequest $request
     * @return RedirectResponse
     * @throws Exception
     * 
     */
    public function approve(string $id, RequestBalanceService $service, ApproveRequestBalanceRequest $request): RedirectResponse
    {
        try {
            $balanceRequest = BalanceRequest::query()
                ->where('id', $id)
                ->with(
                    'userAccount',
                    'userAccount.user',
                    'userAccount.coa',
                    'sourceCoa',
                    'sourceCoa.chartOfAccount',
                    'period',
                    'subPeriod'
                )
                ->lockForUpdate()
                ->firstOrFail();

            $service->approve($balanceRequest, $request->validated());

            return redirect()->route('bendahara.requests.balances.index')->with('success', 'Permintaan saldo berhasil disetujui.');
        } catch (Exception $e) {
            return redirect()->route('bendahara.requests.balances.index')->with('error', 'Gagal menyetujui permintaan saldo: ' . $e->getMessage());
        }
    }

    /**
     * Reject the specified resource in storage.
     *
     * @param string $id
     * @param RequestBalanceService $service
     * @param RejectRequestBalanceRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function reject(string $id, RequestBalanceService $service, RejectRequestBalanceRequest $request): RedirectResponse
    {
        try {
            $balanceRequest = BalanceRequest::query()
                ->where('id', $id)
                ->with('userAccount')
                ->firstOrFail();

            $service->reject($balanceRequest, $request->validated());
            return redirect()->route('bendahara.requests.balances.index')->with('success', 'Permintaan saldo berhasil ditolak.');
        } catch (Exception $e) {
            return redirect()->route('bendahara.requests.balances.index')->with('error', 'Gagal menolak permintaan saldo: ' . $e->getMessage());
        }
    }
}
