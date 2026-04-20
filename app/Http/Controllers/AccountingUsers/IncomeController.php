<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionType;
use App\Helpers\CashBalanceHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\AccountingUsers\StoreIncomeRequest;
use App\Http\Requests\AccountingUsers\StoreTransactionRequest;
use App\Models\AccountType;
use App\Models\ChartOfAccount;
use App\Models\Interest;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Tax;
use App\Models\Transaction;
use App\Services\AccountingUsers\TransactionService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class IncomeController extends Controller
{
    /**
     * Display a listing of the income transactions, with optional filtering by period and sub-period.
     *
     * @param Request $request
     * @return \Illuminate\View\View
     */
    public function index(Request $request)
    {
        $query = Transaction::with(['transactionLines.chartOfAccount', 'creator', 'period', 'subPeriod'])
            ->where('transaction_type', TransactionType::INCOME->value);

        if ($request->filled('period_id')) {
            $query->where('period_id', $request->period_id);
        }

        if ($request->filled('sub_period_id')) {
            $query->where('sub_period_id', $request->sub_period_id);
        }

        $incomes   = $query->orderBy('transaction_date', 'desc')->get();
        $periods   = Period::where('is_closed', false)->get();
        $subPeriods = collect();

        if ($request->period_id) {
            $subPeriods = SubPeriod::where('period_id', $request->period_id)
                ->active()->orderBy('start_date')->get();
        }

        return view('pages.menus.user.incomes.index', compact('incomes', 'periods', 'subPeriods'));
    }

    /**
     * Show the form for creating a new income transaction. This method prepares all necessary data for the form, including available accounts, periods, and tax/interest options.
     *
     * @return \Illuminate\View\View
     */
    // public function create()
    // {
    //     $userId       = Auth::id();
    //     $assetTypeId  = AccountType::where('name', 'ASET')->value('id');
    //     $incomeTypeId = AccountType::where('name', 'PENDAPATAN')->value('id');

    //     $periods          = Period::where('is_closed', false)->orderBy('created_at', 'desc')->get();
    //     $selectedPeriodId = request('period_id') ?? $periods->first()?->id;

    //     if (! $selectedPeriodId) {
    //         return back()->withErrors(['period' => 'Tidak ada periode aktif.']);
    //     }

    //     $subPeriods = SubPeriod::where('period_id', $selectedPeriodId)
    //         ->active()->orderBy('start_date')->get();

    //     // Akun Kas/Bank milik user (ASET DEBIT, leaf node)
    //     $cashCoas = ChartOfAccount::where('account_type_id', $assetTypeId)
    //         ->where('normal_balance', NormalBalanceEnum::DEBIT->value)
    //         ->where('is_active', true)
    //         ->whereDoesntHave('children')
    //         ->whereHas('userAccounts', fn($q) => $q->where('user_id', $userId))
    //         ->orderBy('code')->get();

    //     // Akun Pendapatan milik user (PENDAPATAN CREDIT, leaf node)
    //     $incomeCoas = ChartOfAccount::where('account_type_id', $incomeTypeId)
    //         ->where('normal_balance', NormalBalanceEnum::CREDIT->value)
    //         ->where('is_active', true)
    //         ->whereDoesntHave('children')
    //         ->whereHas('userAccounts', fn($q) => $q->where('user_id', $userId))
    //         ->orderBy('code')->get();

    //     // Daftar pajak & bunga untuk pilihan opsional
    //     $taxes     = Tax::with(['accountPayable', 'accountExpense', 'accountPrepaid'])->get();
    //     $interests = Interest::with(['accountInterest', 'accountExpense'])->get();

    //     // Map tax data untuk memudahkan akses di view (prepaid_id & prepaid_name)
    //     $taxesData = $taxes->map(function ($t) {
    //         return [
    //             'id' => $t->id,
    //             'name' => $t->name,
    //             'rate' => $t->rate,
    //             'prepaid_id' => optional($t->accountPrepaid)->id,
    //             'prepaid_name' => optional($t->accountPrepaid)->name,
    //         ];
    //     })->values();

    //     return view('pages.menus.user.incomes.create', compact(
    //         'cashCoas',
    //         'incomeCoas',
    //         'periods',
    //         'subPeriods',
    //         'selectedPeriodId',
    //         'taxes',
    //         'interests',
    //         'taxesData'
    //     ));
    // }

    public function create()
    {
        $userId = Auth::id();

        // ── Account Type IDs ───────────────────────────────
        $assetTypeId   = AccountType::where('name', 'ASET')->value('id');
        $incomeTypeId  = AccountType::where('name', 'PENDAPATAN')->value('id');
        $expenseTypeId = AccountType::where('name', 'BEBAN')->value('id');

        // ── Period ─────────────────────────────────────────
        $periods          = Period::where('is_closed', false)->latest()->get();
        $selectedPeriodId = request('period_id') ?? $periods->first()?->id;

        if (!$selectedPeriodId) {
            return back()->withErrors(['period' => 'Tidak ada periode aktif.']);
        }

        $subPeriods = SubPeriod::where('period_id', $selectedPeriodId)
            ->active()
            ->orderBy('start_date')
            ->get();

        // ── COA: Kas / Bank (ASET - DEBIT) ────────────────
        $cashCoas = ChartOfAccount::where('account_type_id', $assetTypeId)
            ->where('normal_balance', NormalBalanceEnum::DEBIT->value)
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->whereHas('userAccounts', fn($q) => $q->where('user_id', $userId))
            ->orderBy('code')
            ->get();

        // ── COA: Pendapatan ───────────────────────────────
        $incomeCoas = ChartOfAccount::where('account_type_id', $incomeTypeId)
            ->where('normal_balance', NormalBalanceEnum::CREDIT->value)
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->whereHas('userAccounts', fn($q) => $q->where('user_id', $userId))
            ->orderBy('code')
            ->get();

        // ── COA: Beban ────────────────────────────────────
        $expenseCoas = ChartOfAccount::where('account_type_id', $expenseTypeId)
            ->where('normal_balance', NormalBalanceEnum::DEBIT->value)
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->whereHas('userAccounts', fn($q) => $q->where('user_id', $userId))
            ->orderBy('code')
            ->get();

        // ── Tax & Interest ────────────────────────────────
        $taxes = Tax::with(['accountPayable', 'accountExpense', 'accountPrepaid'])->get();

        $interests = Interest::with(['accountInterest', 'accountExpense'])->get();

        $taxesData = $taxes->map(fn($t) => [
            'id' => $t->id,
            'name' => $t->name,
            'rate' => $t->rate,
            'prepaid_id' => optional($t->accountPrepaid)->id,
            'prepaid_name' => optional($t->accountPrepaid)->name,
        ])->values();

        return view('pages.menus.user.incomes.create', compact(
            'cashCoas',
            'incomeCoas',
            'expenseCoas',
            'periods',
            'subPeriods',
            'selectedPeriodId',
            'taxes',
            'interests',
            'taxesData'
        ));
    }

    /**
     * Store a newly created income transaction in storage. This method handles the complex logic of saving the transaction,
     * 
     * @param TransactionService $service
     * @param StoreTransactionRequest $request
     * @return RedirectResponse
     */
    public function store(TransactionService $service, StoreTransactionRequest $request): RedirectResponse
    {
        // ── Proses Simpan ───────────────────────────────────
        $service->handle($request->validated());

        return redirect()
            ->route('user.transactions.incomes.index')
            ->with('success', 'Transaksi penerimaan berhasil disimpan.');
    }

    /**
     * Display the specified income transaction, including all related lines and journal entries.
     *
     * @param string $id
     * @return \Illuminate\View\View
     */
    public function show(string $id)
    {
        $transaction = Transaction::where('transaction_type', TransactionType::INCOME->value)
            ->findOrFail($id);

        $transaction->load([
            'creator:id,name',
            'period:id,name',
            'subPeriod:id,name',
            'transactionLines.chartOfAccount:id,code,name,normal_balance',
            'journal.details.coa',
        ]);

        return view('pages.menus.user.incomes.show', compact('transaction'));
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
