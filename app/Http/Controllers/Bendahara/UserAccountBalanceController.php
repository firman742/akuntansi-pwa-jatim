<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\UserAccountBalances\StoreUserAccountBalanceRequest;
use App\Models\UserAccount;
use App\Services\Bendahara\UserAccountBalanceService;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class UserAccountBalanceController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @param UserAccountBalanceService $service
     * @return View
     */
    public function index(UserAccountBalanceService $service): View
    {
        $periodId = request('period_id');
        $subPeriodId = request('sub_period_id');

        $data = $service->getIndexData($periodId, $subPeriodId);

        return view(
            'pages.menus.bendahara.user_account_balances.index',
            array_merge($data, [
                'periodId' => $periodId,
                'subPeriodId' => $subPeriodId,
            ])
        );
    }

    /**
     * Show the form for creating a new resource.
     * 
     * @param UserAccountBalanceService $service
     * @return View
     */
    public function create(UserAccountBalanceService $service): View
    {
        return view(
            'pages.menus.bendahara.user_account_balances.create',
            $service->getCreateData()
        );
    }

    /**
     * Store a newly created resource in storage.
     * @param UserAccountBalanceService $service
     * @param StoreUserAccountBalanceRequest $request
     * @return RedirectResponse
     * @throws Exception
     * 
     */
    public function store(UserAccountBalanceService $service, StoreUserAccountBalanceRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()->route('bendahara.user-account-balances.index')
                ->with('success', 'Opening balance berhasil disimpan.');
        } catch (Exception $e) {
            return back()->withErrors(['error' => 'Gagal simpan: ' . $e->getMessage()])->withInput();
        }
    }

    /**
     * Get user accounts by COA ID FOR API
     * @param string $coaId
     * @return JsonResponse
     */
    public function getUserAccountsByCoa(string $coaId): JsonResponse
    {
        $users = UserAccount::with('user')
            ->where('coa_id', $coaId)
            ->get()
            ->map(function ($item) {
                return [
                    'id' => $item->id,
                    'name' => $item->user->name,
                ];
            });

        return response()->json($users);
    }
}
