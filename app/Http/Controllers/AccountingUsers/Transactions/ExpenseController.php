<?php

namespace App\Http\Controllers\AccountingUsers\Transactions;

use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Helpers\CashBalanceHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\AccountingUsers\Transactions\Expenses\StoreExpenseRequest;
use App\Http\Requests\AccountingUsers\Transactions\Expenses\UpdateExpenseRequest;
use App\Models\ChartOfAccount;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;
use App\Models\UserAccountBalance;
use App\Services\AccountingUsers\ExpenseService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class ExpenseController extends Controller
{
    /**
     * Display a listing of expense transactions for monitoring.
     */
    public function index(Request $request): View
    {
        $query = Transaction::with([
            'creator:id,name',
            'transactionLines.chartOfAccount:id,code,name',
            'period:id,name,start_date,end_date',
            'subPeriod:id,name',
        ])
            ->where('transaction_type', TransactionType::EXPENSE)
            ->where('created_by', Auth::id());

        // ================= SEARCH (COA / Deskripsi / No Transaksi) =================
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('transaction_number', 'like', "%{$search}%")
                    ->orWhere('description', 'like', "%{$search}%")
                    ->orWhereHas('transactionLines.chartOfAccount', function ($qCoa) use ($search) {
                        $qCoa->where('code', 'like', "%{$search}%")
                            ->orWhere('name', 'like', "%{$search}%");
                    });
            });
        }

        // ================= FILTERS =================
        if ($request->filled('period_id')) {
            $query->where('period_id', $request->period_id);
        }

        if ($request->filled('sub_period_id')) {
            $query->where('sub_period_id', $request->sub_period_id);
        }

        if ($request->filled('start_date')) {
            $query->whereDate('transaction_date', '>=', $request->start_date);
        }

        if ($request->filled('end_date')) {
            $query->whereDate('transaction_date', '<=', $request->end_date);
        }

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        // ================= MONITORING STATS (SPESIFIK PENGELUARAN) =================
        $statsQuery = clone $query;
        $stats = [
            'total_amount' => (clone $statsQuery)->sum('gross_amount'),
            'total_count' => (clone $statsQuery)->count(),
            'posted_count' => (clone $statsQuery)->where('status', TransactionStatus::POSTED)->count(),
            'draft_count' => (clone $statsQuery)->where('status', TransactionStatus::DRAFT)->count(),
        ];

        // ================= EXECUTE QUERY =================
        $transactions = $query
            ->latest('transaction_date')
            ->latest('created_at')
            ->get();

        // ================= FILTER DATA =================
        $periods = Period::query()->select('id', 'name', 'start_date', 'end_date')->get();

        $subPeriods = collect();
        if ($request->filled('period_id')) {
            $subPeriods = SubPeriod::where('period_id', $request->period_id)
                ->orderBy('start_date')
                ->get();
        }

        return view('pages.menus.user.transactions.expenses.index', compact(
            'transactions',
            'stats',
            'periods',
            'subPeriods'
        ));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @throws Exception
     */
    public function create(): View
    {
        $userId = Auth::id();

        // ── Period ─────────────────────────────────────────
        $activePeriod = Period::query()
            ->latest()
            ->get();

        if (! $activePeriod) {
            throw new Exception(
                'Anda tidak bisa melakukan transaksi karena tidak ada periode aktif. Silakan hubungi administrator.'
            );
        }

        $selectedPeriodId = $activePeriod->id;

        $subPeriods = SubPeriod::where('period_id', $selectedPeriodId)
            ->where('is_closed', false)
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
                    'coa_id' => $balance->userAccount->coa->id,
                    'coa_code' => $balance->userAccount->coa->code,
                    'coa_name' => $balance->userAccount->coa->name,
                    'remaining_balance' => $balance->remaining_balance,
                ];
            });

        // ── Semua akun CREDIT ─────────────────────────────
        $expenseCoas = ChartOfAccount::query()
            ->where('is_active', true)
            ->orderBy('code')
            ->get();

        return view('pages.menus.user.transactions.expenses.create', compact(
            'cashCoas',
            'expenseCoas',
            'subPeriods',
            'selectedPeriodId',
            'selectedSubPeriodId'
        ));
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id): View
    {
        $transaction = Transaction::with([
            'creator:id,name,email',
            'transactionLines.chartOfAccount:id,code,name',
            'period:id,name,start_date,end_date',
            'subPeriod:id,name,start_date,end_date',
        ])
            ->where('transaction_type', TransactionType::EXPENSE)
            ->findOrFail($id);

        return view('pages.menus.user.transactions.expenses.show', compact('transaction'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @throws Exception
     */
    public function edit(string $id): View
    {
        $transaction = Transaction::with([
            'transactionLines.chartOfAccount:id,code,name',
            'period:id,name',
            'subPeriod:id,name',
        ])->findOrFail($id);

        $userId = Auth::id();

        // ── Period ─────────────────────────────────────────
        $activePeriod = Period::query()
            ->where('start_date', '<=', now())
            ->where('end_date', '>=', now())
            ->latest()
            ->first();

        if (! $activePeriod) {
            throw new Exception(
                'Anda tidak bisa melakukan transaksi karena tidak ada periode aktif. Silakan hubungi administrator.'
            );
        }

        $selectedPeriodId = $activePeriod->id;

        $subPeriods = SubPeriod::where('period_id', $selectedPeriodId)
            ->where('is_closed', false)
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
                    'coa_id' => $balance->userAccount->coa->id,
                    'coa_code' => $balance->userAccount->coa->code,
                    'coa_name' => $balance->userAccount->coa->name,
                    'remaining_balance' => $balance->remaining_balance,
                ];
            });

        // ── Semua akun CREDIT ─────────────────────────────
        $expenseCoas = ChartOfAccount::query()
            ->where('normal_balance', NormalBalanceEnum::CREDIT->value)
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->orderBy('code')
            ->get();

        return view('pages.menus.user.transactions.expenses.edit', compact(
            'transaction',
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
     * @throws Exception
     */
    public function store(ExpenseService $service, StoreExpenseRequest $request): RedirectResponse
    {
        try {
            $service->handle($request->validated());

            return redirect()
                ->route('user.transactions.expenses.index')
                ->with('success', 'Transaksi Pengeluaran berhasil disimpan');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat menyimpan transaksi pengeluaran: '.$e->getMessage());
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @throws Exception
     */
    public function update(ExpenseService $service, UpdateExpenseRequest $request, string $id): RedirectResponse
    {
        try {
            $service->update($id, $request->validated());

            return redirect()
                ->route('user.transactions.expenses.index')
                ->with('success', 'Transaksi Pengeluaran berhasil diperbarui');
        } catch (Exception $e) {
            return back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat memperbarui transaksi pengeluaran: '.$e->getMessage());
        }
    }

    /**
     * Post the specified resource in storage.
     */
    public function post(string $id, ExpenseService $service): RedirectResponse
    {
        try {
            $service->postTransaction($id);

            return redirect()
                ->route('user.transactions.expenses.index')
                ->with('success', 'Transaksi Pengeluaran berhasil diposting');
        } catch (Exception $e) {
            return back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat memposting transaksi pengeluaran: '.$e->getMessage());
        }
    }

    /**
     * Cancel the specified resource in storage.
     */
    public function cancel(string $id, ExpenseService $service): RedirectResponse
    {
        try {
            $service->cancelTransaction($id);

            return redirect()
                ->route('user.transactions.expenses.index')
                ->with('success', 'Transaksi Pengeluaran berhasil dibatalkan');
        } catch (Exception $e) {
            return back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat membatalkan transaksi pengeluaran: '.$e->getMessage());
        }
    }

    /**
     * Get the cash balance for a specific COA and period.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function getCashBalance(Request $request)
    {
        $coaId = $request->coa_id;
        $periodId = $request->period_id;
        $subPeriodId = $request->sub_period_id;

        if (! $coaId || ! $periodId) {
            return response()->json([
                'balance' => 0,
            ]);
        }

        $balance = CashBalanceHelper::getBalance(
            $coaId,
            $periodId,
            $subPeriodId
        );

        return response()->json([
            'balance' => $balance,
        ]);
    }
}
