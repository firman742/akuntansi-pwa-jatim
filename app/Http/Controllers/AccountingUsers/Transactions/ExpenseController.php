<?php

namespace App\Http\Controllers\AccountingUsers\Transactions;

use App\Enums\NormalBalanceEnum;
use App\Helpers\CashBalanceHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\AccountingUsers\StoreTransactionRequest;
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

class ExpenseController extends Controller
{
    /**
     * Show the form for creating a new resource.
     *
     * @return View
     * @throws Exception
     */
    public function create(): View
    {
        $userId = Auth::id();

        // ── Period ─────────────────────────────────────────
        $activePeriod = Period::query()
            ->where('is_closed', false)
            ->latest()
            ->first();

        if (!$activePeriod) {
            throw new Exception(
                'Anda tidak bisa melakukan transaksi karena tidak ada periode aktif. Silakan hubungi administrator.'
            );
        }

        $selectedPeriodId = $activePeriod->id;

        $subPeriods = SubPeriod::where('period_id', $selectedPeriodId)
            ->active()
            ->orderBy('start_date')
            ->get();

        $selectedSubPeriodId = request('sub_period_id')
            ?? $subPeriods->first()?->id;


        // ── Kas User (Distribusi Bendahara) ────────────────
        $cashCoas = UserAccountBalance::query()
            ->with([
                'userAccount.coa',
            ])
            ->whereHas('userAccount', function ($q) use ($userId) {
                $q->where('user_id', $userId);
            })
            ->where('period_id', $selectedPeriodId)
            ->where('sub_period_id', $selectedSubPeriodId)
            ->where('remaining_balance', '>', 0)
            ->get()
            ->sortBy(function ($balance) {
                return $balance->userAccount->coa->code;
            })
            ->values()
            ->map(function ($balance) {
                return [
                    'user_account_balance_id' => $balance->id,
                    'coa_id'                  => $balance->userAccount->coa->id,
                    'coa_code'                => $balance->userAccount->coa->code,
                    'coa_name'                => $balance->userAccount->coa->name,
                    'remaining_balance'       => $balance->remaining_balance,
                ];
            });

        // ── Semua akun CREDIT ─────────────────────────────
        $expenseCoas = ChartOfAccount::query()
            ->where('normal_balance', NormalBalanceEnum::CREDIT->value)
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->orderBy('code')
            ->get();

        return view('pages.menus.user.transactions.create-expense', compact(
            'cashCoas',
            'expenseCoas',
            'subPeriods',
            'selectedPeriodId',
            'selectedSubPeriodId'
        ));
    }

    /**
     * Store a newly created resource in storage.
     * 
     * @param TransactionService $service
     * @param StoreTransactionRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function store(TransactionService $service, StoreTransactionRequest $request): RedirectResponse
    {
        try {
            $service->handleExpense($request->validated());

            return redirect()
                ->route('user.transactions.expenses.create')
                ->with('success', 'Transaksi Pengeluaran berhasil disimpan');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat menyimpan transaksi pengeluaran: ' . $e->getMessage());
        }
    }

    public function getCashBalance(Request $request)
    {
        $coaId       = $request->coa_id;
        $periodId    = $request->period_id;
        $subPeriodId = $request->sub_period_id;

        if (!$coaId || !$periodId) {
            return response()->json([
                'balance' => 0
            ]);
        }

        $balance = CashBalanceHelper::getBalance(
            $coaId,
            $periodId,
            $subPeriodId
        );

        return response()->json([
            'balance' => $balance
        ]);
    }
}
