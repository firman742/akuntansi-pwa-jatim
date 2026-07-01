<?php

namespace App\Http\Controllers\AccountingUsers\Transactions;

use App\Helpers\CashBalanceHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\AccountingUsers\StoreIncomeRequest;
use App\Models\ChartOfAccount;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\UserAccountBalance;
use App\Services\AccountingUsers\TransactionService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class IncomeController extends Controller
{
    /**
     * Show the form for creating a new income transaction.
     *
     * @return View
     */
    public function create(): View
    {
        $userId = Auth::id();

        $activePeriod = Period::query()
            ->where('is_closed', false)
            ->latest()
            ->first();

        if (!$activePeriod) {
            throw new Exception(
                'Anda tidak bisa melakukan transaksi karena tidak ada periode aktif.'
            );
        }

        $selectedPeriodId = $activePeriod->id;

        $subPeriods = SubPeriod::query()
            ->where('period_id', $selectedPeriodId)
            ->active()
            ->orderBy('start_date')
            ->get();

        $selectedSubPeriodId = request('sub_period_id')
            ?? $subPeriods->first()?->id;

        $cashCoas = UserAccountBalance::query()
            ->with('userAccount.coa')
            ->whereHas('userAccount', function ($q) use ($userId) {
                $q->where('user_id', $userId);
            })
            ->where('period_id', $selectedPeriodId)
            ->where('sub_period_id', $selectedSubPeriodId)
            ->get()
            ->sortBy(fn($balance) => $balance->userAccount->coa->code)
            ->values()
            ->map(function ($balance) {
                return [
                    'user_account_balance_id' => $balance->id,
                    'coa_id' => $balance->userAccount->coa->id,
                    'coa_code' => $balance->userAccount->coa->code,
                    'coa_name' => $balance->userAccount->coa->name,
                    'remaining_balance' => $balance->remaining_balance,
                ];
            });

        $incomeCoas = ChartOfAccount::query()
            ->whereHas('accountType', function ($q) {
                $q->where('name', 'PENDAPATAN');
            })
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->orderBy('code')
            ->get();

        return view('pages.menus.user.transactions.create-income',
            compact(
                'cashCoas',
                'incomeCoas',
                'subPeriods',
                'selectedPeriodId',
                'selectedSubPeriodId'
            )
        );
    }

    /**
     * Store a newly created income transaction in storage. This method handles the complex logic of saving the transaction,
     * 
     * @param TransactionService $service
     * @param StoreIncomeRequest $request
     * @return RedirectResponse
     */
    public function store(TransactionService $service, StoreIncomeRequest $request): RedirectResponse
    {
        try {
            $service->handleIncome($request->validated());

            return redirect()
                ->route('user.transactions.incomes.create')
                ->with('success', 'Transaksi penerimaan berhasil disimpan');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat menyimpan transaksi penerimaan: ' . $e->getMessage());
        }
    }


    /**
     * FOR AJAX:
     * Get the current cash balance for a given chart of account and period. This is used for real-time validation when creating income transactions.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getCashBalance(Request $request)
    {
        $coaId       = $request->coa_id;
        $periodId    = $request->period_id;
        $subPeriodId = $request->sub_period_id;

        if (! $coaId || ! $periodId) {
            return response()->json(['balance' => 0]);
        }

        $balance = CashBalanceHelper::getBalance($coaId, $periodId, $subPeriodId);

        return response()->json(['balance' => $balance]);
    }
}
