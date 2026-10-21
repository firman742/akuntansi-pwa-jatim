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
use App\Models\UserAccount;
use App\Services\AccountingUsers\Expenses\ExpenseService;
use App\Services\AccountingUsers\GoogleDriveService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class ExpenseController extends Controller
{
    /**
     * ExpenseController constructor.
     * Force refresh Google Drive access token for receipt transactions and set it in the filesystem configuration.
     *
     * @param GoogleDriveService $googleDriveService
     */
    public function __construct(public GoogleDriveService $googleDriveService)
    {
        config(['filesystems.disks.google_receipt_transaction.accessToken' => $this->googleDriveService->getAccessToken()]);
    }

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
            ->orderByDesc('start_date')
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

        // ── Kas User (Via user_accounts & match saldo di coa_balances) ──
        $cashCoas = UserAccount::query()
            ->with(['coa'])
            ->where('user_id', $userId)
            ->get()
            ->map(function ($account) use ($selectedPeriodId, $selectedSubPeriodId) {
                $coa = $account->coa;
                $balance = CashBalanceHelper::getBalance(
                    $coa->id,
                    $selectedPeriodId,
                    $selectedSubPeriodId
                );

                return [
                    'coa_id' => $coa->id,
                    'coa_code' => $coa->code,
                    'coa_name' => $coa->name,
                    'remaining_balance' => (float) $balance,
                ];
            })
            ->sortBy('coa_code')
            ->values();

        // ── Semua akun Pengeluaran / COA Aktif ────────────────
        $expenseCoas = ChartOfAccount::query()
            ->where('is_active', true)
            ->orderBy('code', 'asc')
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
                ->with('error', 'Terjadi kesalahan saat menyimpan transaksi pengeluaran: ' . $e->getMessage());
        }
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id): View
    {
        $userId = Auth::id();

        $transaction = Transaction::with(['transactionLines.chartOfAccount', 'period', 'subPeriod'])
            ->where('transaction_type', TransactionType::EXPENSE)
            ->where('created_by', $userId)
            ->findOrFail($id);

        if ($transaction->subPeriod && $transaction->subPeriod->is_closed) {
            abort(403, 'Sub periode transaksi ini sudah ditutup, data tidak dapat diedit.');
        }

        $selectedPeriodId = $transaction->period_id;
        $selectedSubPeriodId = $transaction->sub_period_id;

        $subPeriods = SubPeriod::where('period_id', $selectedPeriodId)
            ->where('is_closed', false)
            ->orderBy('start_date')
            ->get();

        // ── Kas User (Via user_accounts & match saldo di coa_balances) ──
        $cashCoas = UserAccount::query()
            ->with(['coa'])
            ->where('user_id', $userId)
            ->get()
            ->map(function ($account) use ($selectedPeriodId, $selectedSubPeriodId) {
                $coa = $account->coa;
                $balance = CashBalanceHelper::getBalance(
                    $coa->id,
                    $selectedPeriodId,
                    $selectedSubPeriodId
                );

                return [
                    'coa_id' => $coa->id,
                    'coa_code' => $coa->code,
                    'coa_name' => $coa->name,
                    'remaining_balance' => (float) $balance,
                ];
            })
            ->sortBy('coa_code')
            ->values();

        $expenseCoas = ChartOfAccount::query()
            ->where('is_active', true)
            ->orderBy('code', 'asc')
            ->get();

        // Format data baris transaksi lama (DEBIT) agar terbaca Alpine.js
        $oldLines = $transaction->transactionLines
            ->where('position', NormalBalanceEnum::DEBIT->value)
            ->map(fn($line) => [
                'coa_id' => $line->chart_of_account_id,
                'amount' => (float) $line->amount,
                'description' => $line->description ?? '',
            ])->values();

        // Ambil COA ID akun kas yang dipakai (CREDIT)
        $currentCashLine = $transaction->transactionLines
            ->where('position', NormalBalanceEnum::CREDIT->value)
            ->first();

        $selectedCashCoaId = $currentCashLine?->chart_of_account_id ?? '';
        $selectedCashName = '-';

        if ($currentCashLine && $currentCashLine->chartOfAccount) {
            $selectedCashName = $currentCashLine->chartOfAccount->code . ' - ' . $currentCashLine->chartOfAccount->name;
        }

        $oldDate = $transaction->transaction_date->format('Y-m-d');
        $oldTotal = (float) $transaction->gross_amount;
        $subPeriodName = $transaction->subPeriod?->name ?? '-';

        return view('pages.menus.user.transactions.expenses.edit', compact(
            'transaction',
            'cashCoas',
            'expenseCoas',
            'subPeriods',
            'selectedPeriodId',
            'selectedSubPeriodId',
            'oldLines',
            'selectedCashCoaId',
            'selectedCashName',
            'oldDate',
            'oldTotal',
            'subPeriodName'
        ));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateExpenseRequest $request, string $id, ExpenseService $service): RedirectResponse
    {
        try {
            $service->update($id, $request->validated());

            return redirect()
                ->route('user.transactions.expenses.index')
                ->with('success', 'Transaksi Pengeluaran berhasil diperbarui');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat memperbarui transaksi pengeluaran: ' . $e->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id, ExpenseService $service): RedirectResponse
    {
        try {
            $service->delete($id);

            return redirect()
                ->route('user.transactions.expenses.index')
                ->with('success', 'Transaksi Pengeluaran berhasil dihapus');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->with('error', 'Terjadi kesalahan saat menghapus transaksi pengeluaran: ' . $e->getMessage());
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
                ->with('error', 'Terjadi kesalahan saat memposting transaksi pengeluaran: ' . $e->getMessage());
        }
    }

    /**
     * Get the cash balance for a specific COA and period.
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
