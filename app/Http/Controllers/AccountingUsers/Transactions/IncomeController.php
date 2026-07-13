<?php

namespace App\Http\Controllers\AccountingUsers\Transactions;

use App\Enums\TransactionType;
use App\Helpers\CashBalanceHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\AccountingUsers\Transactions\Incomes\StoreIncomeRequest;
use App\Models\ChartOfAccount;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;
use App\Models\UserAccountBalance;
use App\Services\AccountingUsers\IncomeService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class IncomeController extends Controller
{
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
            'subPeriod:id,name,start_date,end_date'
        ])->where('transaction_type', TransactionType::INCOME);

        // =========== Filter by period and sub-period if provided
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


        // ========= Pagination and sorting
        $transactions = $query
            ->where('created_by', Auth::id())
            ->orderBy('transaction_date', 'desc')
            ->orderBy('created_at', 'desc')
            ->get();

        // ========= Get periods and sub-periods for filter dropdowns
        $periods = Period::orderBy('start_date', 'desc')->get();
        $subPeriods = collect();

        if ($request->filled('period_id')) {
            $subPeriods = SubPeriod::where('period_id', $request->input('period_id'))
                ->orderBy('start_date')
                ->get();
        }

        return view(
            'pages.menus.user.transactions.incomes.index',
            compact(
                'transactions',
                'periods',
                'subPeriods'
            )
        );
    }

    public function show(string $id): View
    {
        $transaction = Transaction::with([
            'creator:id,name',
            'transactionLines.chartOfAccount:id,code,name',
            'period:id,name,start_date,end_date',
            'subPeriod:id,name,start_date,end_date'
        ])
        ->where('transaction_type', TransactionType::INCOME)
        ->findOrFail($id);

        return view('pages.menus.user.transactions.incomes.show', compact('transaction'));
    }

    /**
     * Show the form for creating a new income transaction.
     *
     * @return View
     */
    public function create(): View
    {
        $userId = Auth::id();

        $activePeriod = Period::query()
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
            ->where('is_closed', false)
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


        // All Akun Pendapatan
        $incomeCoas = ChartOfAccount::query()
            ->whereHas('accountType', function ($q) {
                $q->where('name', 'PENDAPATAN');
            })
            ->where('is_active', true)
            ->orderBy('code')
            ->get();

        return view('pages.menus.user.transactions.incomes.create',
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
     * @param IncomeService $service
     * @param StoreIncomeRequest $request
     * @return RedirectResponse
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
