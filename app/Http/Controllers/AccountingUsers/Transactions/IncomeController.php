<?php

namespace App\Http\Controllers\AccountingUsers\Transactions;

use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Helpers\CashBalanceHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\AccountingUsers\Transactions\Incomes\StoreIncomeRequest;
use App\Http\Requests\AccountingUsers\Transactions\Incomes\UpdateIncomeRequest;
use App\Models\ChartOfAccount;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;
use App\Services\AccountingUsers\GoogleDriveService;
use App\Services\AccountingUsers\Incomes\DeleteIncomeService;
use App\Services\AccountingUsers\Incomes\IncomeService;
use App\Services\AccountingUsers\Incomes\UpdateIncomeService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class IncomeController extends Controller
{
    // /**
    //  * ExpenseController constructor.
    //  * Force refresh Google Drive access token for receipt transactions and set it in the filesystem configuration.
    //  *
    //  * @param GoogleDriveService $googleDriveService
    //  */
    // public function __construct(public GoogleDriveService $googleDriveService)
    // {
    //     config(['filesystems.disks.google_receipt_transaction.accessToken' => $this->googleDriveService->getAccessToken()]);
    // }

    /**
     * Display a listing of the income transactions for the authenticated user.
     *
     * @param Request $request
     * @return View
     */
    public function index(Request $request): View
    {
        $query = Transaction::with([
            'creator:id,name',
            'transactionLines.chartOfAccount:id,code,name',
            'period:id,name,start_date,end_date',
            'subPeriod:id,name,start_date,end_date,is_closed',
        ])
            ->where('transaction_type', TransactionType::INCOME)
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

        // ================= MONITORING STATS (SPESIFIK PENERIMAAN) =================
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
        $periods = Period::query()->select(['id', 'name', 'start_date', 'end_date'])->get();

        $subPeriods = collect();
        if ($request->filled('period_id')) {
            $subPeriods = SubPeriod::where('period_id', $request->period_id)
                ->orderBy('start_date')
                ->get();
        }

        return view(
            'pages.menus.user.transactions.incomes.index',
            compact(
                'transactions',
                'periods',
                'subPeriods',
                'stats'
            )
        );
    }

    /**
     * Display the specified income transaction.
     *
     * @param string $id
     * @return View
     */
    public function show(string $id): View
    {
        $transaction = Transaction::with([
            'creator:id,name',
            'transactionLines.chartOfAccount:id,code,name',
            'period:id,name,start_date,end_date',
            'subPeriod:id,name,start_date,end_date',
        ])
            ->where('transaction_type', TransactionType::INCOME)
            ->findOrFail($id);

        return view('pages.menus.user.transactions.incomes.show', compact('transaction'));
    }

    /**
     * Show the form for creating a new income transaction.
     *
     * @return View
     * @throws Exception
     */
    public function create(): View
    {
        $userId = Auth::id();

        $activePeriod = Period::query()
            ->orderByDesc('start_date')
            ->first();

        if (! $activePeriod) {
            throw new Exception(
                'Anda tidak bisa melakukan transaksi karena tidak ada periode aktif.'
            );
        }

        $selectedPeriodId = $activePeriod->id;

        $subPeriods = SubPeriod::query()
            ->where('period_id', $selectedPeriodId)
            ->where('is_closed', false)
            ->orderBy('start_date')
            ->get();

        $selectedSubPeriodId = request('sub_period_id')
            ?? $subPeriods->first()?->id;

        // 1. Ambil COA kas yang diizinkan untuk User dari user_accounts
        // 2. Join/With ke coa_balances untuk mengambil saldo periode berjalan
        $cashCoas = ChartOfAccount::query()
            ->whereHas('userAccounts', function ($q) use ($userId) {
                $q->where('user_id', $userId);
            })
            ->with(['coaBalances' => function ($q) use ($selectedPeriodId, $selectedSubPeriodId) {
                $q->where('period_id', $selectedPeriodId)
                    ->where('sub_period_id', $selectedSubPeriodId);
            }])
            ->orderBy('code')
            ->get()
            ->map(function ($coa) {
                $coaBalance = $coa->coaBalances->first();
                return [
                    'coa_id' => $coa->id,
                    'coa_code' => $coa->code,
                    'coa_name' => $coa->name,
                    'remaining_balance' => $coaBalance ? $coaBalance->current_balance : 0,
                ];
            });

        $cashCoaIds = $cashCoas->pluck('coa_id')->toArray();

        // 2. Query Akun Penerimaan (DEBIT) dengan mengecualikan semua COA Kas milik user
        $incomeCoas = ChartOfAccount::query()
            ->where('is_active', true)
            ->orderBy('code', 'asc')
            ->get();

        return view(
            'pages.menus.user.transactions.incomes.create',
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
     * including updating the relevant account balances and ensuring data integrity.
     *
     * @param IncomeService $service
     * @param StoreIncomeRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function store(IncomeService $service, StoreIncomeRequest $request): RedirectResponse
    {
        try {
            $service->handle($request->validated());

            return redirect()
                ->route('user.transactions.incomes.index')
                ->with('success', 'Transaksi penerimaan berhasil disimpan');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat menyimpan transaksi penerimaan: ' . $e->getMessage());
        }
    }

    /**
     * Show the form for editing an existing income transaction.
     *
     * @param string $id
     * @return View
     * @throws Exception
     */
    public function edit(string $id): View
    {
        $userId = Auth::id();

        $transaction = Transaction::with(['transactionLines'])
            ->where('transaction_type', TransactionType::INCOME)
            ->where('created_by', $userId)
            ->findOrFail($id);

        $activePeriod = Period::query()->orderByDesc('start_date')->first();
        $selectedPeriodId = $transaction->period_id;

        $subPeriods = SubPeriod::query()
            ->where('period_id', $selectedPeriodId)
            ->orderBy('start_date')
            ->get();

        // Fetch COA Kas milik user beserta saldo CoaBalance pada periode berjalan
        $cashCoas = ChartOfAccount::query()
            ->whereHas('userAccounts', fn($q) => $q->where('user_id', $userId))
            ->with(['coaBalances' => function ($q) use ($selectedPeriodId, $transaction) {
                $q->where('period_id', $selectedPeriodId)
                    ->where('sub_period_id', $transaction->sub_period_id);
            }])
            ->orderBy('code')
            ->get()
            ->map(fn($coa) => [
                'coa_id' => $coa->id,
                'coa_code' => $coa->code,
                'coa_name' => $coa->name,
                'remaining_balance' => $coa->coaBalances->first()?->current_balance ?? 0,
            ]);

        $incomeCoas = ChartOfAccount::query()
            ->where('is_active', true)
            ->orderBy('code', 'asc')
            ->get();

        // Ambil data line lama
        $selectedDebitLine = $transaction->transactionLines->where('position', NormalBalanceEnum::DEBIT)->first();
        $selectedCreditLine = $transaction->transactionLines->where('position', NormalBalanceEnum::CREDIT)->first();

        $selectedDebitCoaId = $selectedDebitLine?->chart_of_account_id;
        $selectedCreditCoaId = $selectedCreditLine?->chart_of_account_id;

        return view('pages.menus.user.transactions.incomes.edit', compact(
            'transaction',
            'cashCoas',
            'incomeCoas',
            'subPeriods',
            'selectedPeriodId',
            'selectedDebitCoaId',
            'selectedCreditCoaId'
        ));
    }

    /**
     * Update the specified income transaction in storage. This method handles the complex logic of updating the transaction,
     * including adjusting the relevant account balances and ensuring data integrity.
     *
     * @param UpdateIncomeService $service
     * @param UpdateIncomeRequest $request
     * @param string $id
     * @return RedirectResponse
     */
    public function update(UpdateIncomeService $service, UpdateIncomeRequest $request, string $id): RedirectResponse
    {
        try {
            $transaction = Transaction::where('transaction_type', TransactionType::INCOME)
                ->where('created_by', Auth::id())
                ->findOrFail($id);

            $service->handle($transaction, $request->validated());

            return redirect()
                ->route('user.transactions.incomes.index')
                ->with('success', 'Transaksi penerimaan berhasil diperbarui.');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat memperbarui transaksi: ' . $e->getMessage());
        }
    }

    /**
     * Remove the specified income transaction from storage.
     *
     * @param DeleteIncomeService $service
     * @param string $id
     * @return RedirectResponse
     */
    public function destroy(DeleteIncomeService $service, string $id): RedirectResponse
    {
        try {
            $transaction = Transaction::with(['subPeriod'])
                ->where('transaction_type', TransactionType::INCOME)
                ->where('created_by', Auth::id())
                ->findOrFail($id);

            // Validasi: pastikan sub periode belum ditutup
            if ($transaction->subPeriod && $transaction->subPeriod->is_closed) {
                throw new Exception('Tidak dapat menghapus transaksi karena sub periode sudah ditutup.');
            }

            $service->handle($transaction);

            return redirect()
                ->route('user.transactions.incomes.index')
                ->with('success', 'Transaksi penerimaan berhasil dihapus.');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->with('error', 'Terjadi kesalahan saat menghapus transaksi: ' . $e->getMessage());
        }
    }

    /**
     * FOR AJAX:
     * Get the current cash balance for a given chart of account and period. This is used for real-time validation when creating income transactions.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function getCashBalance(Request $request)
    {
        $coaId = $request->coa_id;
        $periodId = $request->period_id;
        $subPeriodId = $request->sub_period_id;

        if (! $coaId || ! $periodId) {
            return response()->json(['balance' => 0]);
        }

        $balance = CashBalanceHelper::getBalance($coaId, $periodId, $subPeriodId);

        return response()->json(['balance' => $balance]);
    }
}
