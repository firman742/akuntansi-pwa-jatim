<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Enums\RequestStatus;
use App\Http\Controllers\Controller;
use App\Http\Requests\AccountingUsers\StoreReqBalanceRequest;
use App\Models\BalanceRequest;
use App\Models\CoaBalance;
use App\Models\SubPeriod;
use App\Models\UserAccount;
use App\Services\AccountingUsers\RequestBalanceService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
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
            ->where('requester_id', Auth::id())
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

        return view('pages.menus.user.requestBalances.index', compact('requests'));
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

        return view('pages.menus.user.requestBalances.show', compact('balanceRequest'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return View
     */
    public function create(): View
    {
        $userAccounts = UserAccount::query()
            ->where('user_accounts.user_id', Auth::id())
            ->join(
                'chart_of_accounts',
                'chart_of_accounts.id',
                '=',
                'user_accounts.coa_id'
            )
            ->with('coa:id,code,name')
            ->orderBy('chart_of_accounts.code')
            ->select('user_accounts.*')
            ->get();

        $sourceCoas = CoaBalance::query()
            ->with([
                'chartOfAccount:id,code,name'
            ])
            ->get();

        $subPeriods = SubPeriod::query()
            ->with('period:id,name')
            ->active()
            ->orderByDesc('start_date')
            ->get();

        return view(
            'pages.menus.user.requestBalances.create',
            compact(
                'userAccounts',
                'sourceCoas',
                'subPeriods'
            )
        );
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param RequestBalanceService $service
     * @param StoreReqBalanceRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function store(RequestBalanceService $service, StoreReqBalanceRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());
           
            return redirect()
                ->route('user.requests.balances.index')
                ->with(
                    'success',
                    'Pengajuan penambahan dana berhasil dibuat.'
                );
        } catch (Exception $e) {
            return back()
                ->withInput()
                ->with(
                    'error',
                    'Gagal membuat pengajuan dana.'
                );
        }
    }
}
