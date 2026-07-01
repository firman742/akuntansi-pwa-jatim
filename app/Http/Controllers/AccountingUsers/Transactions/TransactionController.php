<?php

namespace App\Http\Controllers\AccountingUsers\Transactions;

use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionType;
use App\Http\Controllers\Controller;
use App\Http\Requests\AccountingUsers\StoreTransactionRequest;
use App\Models\ChartOfAccount;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;
use App\Models\UserAccountBalance;
use App\Services\AccountingUsers\TransactionService;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class TransactionController extends Controller
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
                'userAccount.coa'
            ])
            ->whereHas('userAccount', function ($q) use ($userId) {
                $q->where('user_id', $userId);
            })
            ->where('period_id', $selectedPeriodId)
            ->where('sub_period_id', $selectedSubPeriodId)
            ->where('remaining_balance', '>', 0)
            ->get()
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
                ->route('user.histories.index')
                ->with('success', 'Transaksi berhasil disimpan');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat menyimpan transaksi: ' . $e->getMessage());
        }
    }

    /**
     * Display the specified resource.
     *
     * @param string $id
     * @return View
     */
    public function show(string $id): View
    {
        $transaction = Transaction::where(
            'transaction_type',
            TransactionType::EXPENSE->value
        )
            ->findOrFail($id);

        $transaction->load([
            'creator:id,name',
            'period:id,name',
            'subPeriod:id,name',
            'transactionLines.chartOfAccount:id,code,name,normal_balance',
            'journal.details.coa',
        ]);

        return view(
            'pages.menus.user.histories.show',
            compact('transaction')
        );
    }

    /**
     * Get cash balance for a specific user account balance.
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function getCashBalance(Request $request): JsonResponse
    {
        $balance = UserAccountBalance::query()
            ->where('id', $request->user_account_balance_id)
            ->value('remaining_balance');

        return response()->json([
            'balance' => $balance ?? 0
        ]);
    }
}
