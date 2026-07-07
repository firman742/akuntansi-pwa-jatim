<?php

namespace App\Http\Controllers\Bendahara;

use App\Enums\RequestStatus;
use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\RequestBalances\ApproveRequestBalanceRequest;
use App\Http\Requests\Bendahara\RequestBalances\RejectRequestBalanceRequest;
use App\Models\BalanceRequest;
use App\Models\CoaBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Services\Bendahara\RequestBalanceService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class BalanceRequestController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @param Request $request
     * @return View
     */
    public function index(Request $request): View
    {
        $periodId = $request->query('period_id', null);
        $subPeriodId = $request->query('sub_period_id', null);
        $search = $request->query('search', null);
        $periods = Period::all();
        $subPeriods = collect();

        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date')
                ->get();
        }

        $query = BalanceRequest::query()
            ->with([
                'approver:id,name',
                'userAccount',
                'userAccount.user',
                'sourceCoa',
                'sourceCoa.chartOfAccount:id,code,name',
                'period:id,name',
                'subPeriod:id,name',
            ]);

        if ($periodId) {
            $query->where('period_id', $periodId);
        }

        if ($subPeriodId) {
            $query->where('sub_period_id', $subPeriodId);
        }

        $requests = $query->where(function ($q) use ($search) {
                if ($search) {
                    $q->whereHas('userAccount.user', function ($q2) use ($search) {
                        $q2->where('name', 'like', "%{$search}%");
                    })->orWhereHas('sourceCoa.chartOfAccount', function ($q3) use ($search) {
                        $q3->where('code', 'like', "%{$search}%")
                            ->orWhere('name', 'like', "%{$search}%");
                    });
                }
            })
            ->orderByDesc('created_at')
            ->get()
            ->map(function ($item) {
                $item->status_label = RequestStatus::from($item->status)->label();

                return $item;
            });

        return view('pages.menus.bendahara.requestBalances.index', compact(
                'requests', 
                'periodId', 
                'subPeriodId',
                'periods',
                'subPeriods'
            ));
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
