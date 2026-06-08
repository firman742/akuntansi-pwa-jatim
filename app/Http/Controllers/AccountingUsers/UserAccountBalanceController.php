<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Http\Controllers\Controller;
use App\Models\UserAccountBalance;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class UserAccountBalanceController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return View
     */
    public function index(): View
    {
        $user = Auth::user();

        $userAccountBalances = UserAccountBalance::query()
            ->whereHas('userAccount', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->with(['coaBalance.chartOfAccount', 'subPeriod', 'userAccount'])
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function ($item) {
                return [
                    'id' => $item->id,
                    'account_name' => $item->coaBalance->chartOfAccount->name,
                    'account_code' => $item->coaBalance->chartOfAccount->code,
                    'sub_period' => optional($item->subPeriod)->name,
                    'allocated_balance' => $item->allocated_balance,
                    'used_balance' => $item->used_balance,
                    'remaining_balance' => $item->remaining_balance,
                    'allocated_at' => $item->allocated_at,
                ];
            });

        return view('pages.menus.user.userAccountBalances.index', compact('userAccountBalances'));
    }

    /**
     * Display the specified resource.
     *
     * @param string $id
     * @return View
     */
    public function show(string $id): View
    {
        $user = Auth::user();

        $userAccountBalance = UserAccountBalance::with(
            'coaBalance.chartOfAccount',
            'subPeriod',
            'allocatedBy',
            'userAccount',
            'userAccount.user',
        )->findOrFail($id);

        if ($userAccountBalance->userAccount->user_id !== $user->id) {
            abort(403, 'Unauthorized action.');
        }

        return view('pages.menus.user.userAccountBalances.show', compact('userAccountBalance'));
    }
}
