<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Http\Controllers\Controller;
use App\Models\Transaction;
use App\Models\UserAccountBalance;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class UserAccountBalanceController extends Controller
{
    /**
     * Display a listing of the resource.
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
     */
    public function show(string $id): View
    {
        $user = Auth::user();

        $userAccountBalance = UserAccountBalance::with([
            'coaBalance.chartOfAccount',
            'subPeriod',
            'allocatedBy',
            'userAccount',
            'userAccount.user',
        ])->findOrFail($id);

        if ($userAccountBalance->userAccount->user_id !== $user->id) {
            abort(403, 'Unauthorized action.');
        }

        // Ambil ID COA dan Sub Period terkait
        $coaId = $userAccountBalance->coaBalance?->chart_of_account_id;
        $subPeriodId = $userAccountBalance->sub_period_id;

        // Query transaksi yang menggunakan COA dan sub-periode saldo ini
        $transactions = Transaction::query()
            ->where('created_by', $user->id)
            ->when($subPeriodId, fn ($q) => $q->where('sub_period_id', $subPeriodId))
            ->whereHas('transactionLines', function ($q) use ($coaId) {
                $q->where('chart_of_account_id', $coaId);
            })
            ->with(['transactionLines' => function ($q) use ($coaId) {
                $q->where('chart_of_account_id', $coaId);
            }])
            ->orderBy('transaction_date', 'desc')
            ->paginate(10);

        return view('pages.menus.user.userAccountBalances.show', compact('userAccountBalance', 'transactions'));
    }
}
