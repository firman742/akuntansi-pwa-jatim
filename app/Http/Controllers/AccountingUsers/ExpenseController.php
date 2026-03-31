<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Enums\NormalBalanceEnum;
use App\Enums\TransactionType;
use App\Helpers\CashBalanceHelper;
use App\Http\Controllers\Controller;
use App\Models\AccountType;
use App\Models\ChartOfAccount;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\Transaction;
use App\Models\TransactionLine;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ExpenseController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Transaction::with(['transactionLines.chartOfAccount', 'creator', 'period', 'subPeriod'])
            ->where('transaction_type', TransactionType::EXPENSE);

        if ($request->filled('period_id')) {
            $query->where('period_id', $request->period_id);
        };

        if ($request->filled('sub_period_id')) {
            $query->where('sub_period_id', $request->sub_period_id);
        };

        $expenses = $query
            ->orderBy('transaction_date', 'desc')
            ->get();

        // ================= FILTER DATA =================
        $periods = Period::where('is_closed', false)->get();

        $subPeriods = collect();
        if ($request->period_id) {
            $subPeriods = SubPeriod::where('period_id', $request->period_id)
                ->active()
                ->orderBy('start_date')
                ->get();
        }

        return view('pages.menus.user.expenses.index', compact(
            'expenses',
            'periods',
            'subPeriods'
        ));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $userId = Auth::id();

        // Ambil ID Account Type
        $assetTypeId = AccountType::where('name', 'ASET')->value('id');
        $expenseTypeId = AccountType::where('name', 'BEBAN')->value('id');

        // ================= PERIOD =================
        $periods = Period::where('is_closed', false)
            ->orderBy('created_at', 'desc')
            ->get();

        $selectedPeriodId = request('period_id') ?? $periods->first()?->id;

        // ================= SUB PERIOD =================
        $subPeriods = SubPeriod::query()
            ->where('period_id', $selectedPeriodId)
            ->orderBy('start_date')
            ->get();

        // ==============================
        // KAS / BANK (ASET - CREDIT)
        // ==============================
        $cashCoas = ChartOfAccount::query()
            ->where('account_type_id', $assetTypeId)
            ->where('normal_balance', 'debit')
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->whereHas('userAccounts', fn($q) => $q->where('user_id', $userId))
            ->orderBy('code')
            ->get();

        // ==============================
        // BEBAN (DEBIT)
        // ==============================
        $expenseCoas = ChartOfAccount::query()
            ->where('account_type_id', $expenseTypeId)
            ->where('normal_balance', 'debit')
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->whereHas('userAccounts', fn($q) => $q->where('user_id', $userId))
            ->orderBy('code')
            ->get();



        $cashBalances = collect();

        if ($selectedPeriodId) {
            foreach ($cashCoas as $coa) {
                $cashBalances[$coa->id] = CashBalanceHelper::getBalance(
                    $coa->id,
                    $selectedPeriodId
                );
            }
        }

        return view('pages.menus.user.expenses.create', compact(
            'cashCoas',
            'expenseCoas',
            'cashBalances',
            'periods',
            'subPeriods',
            'selectedPeriodId'
        ));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $period = Period::findOrFail($request->period_id);

        if (! $period) {
            return back()->withErrors([
                'period' => 'Tidak ada periode aktif. Silakan hubungi bendahara.',
            ]);
        }

        $request->validate([
            'period_id' => 'required|exists:periods,id',
            'sub_period_id' => 'nullable|exists:sub_periods,id',
            'transaction_date' => 'required|date',
            'cash_coa_id' => 'required|exists:chart_of_accounts,id',
            'expense_lines.*.coa_id' => 'required|exists:chart_of_accounts,id',
            'expense_lines.*.amount' => 'required|numeric|min:1',
            'receipt' => 'nullable|file|mimes:jpg,jpeg,png|max:2048',
        ]);


        $totalExpense = collect($request->expense_lines)->sum('amount');

        $currentBalance = CashBalanceHelper::getBalance(
            $request->cash_coa_id,
            $period->id
        );

        if ($currentBalance <= 0) {
            return back()->withErrors([
                'cash_coa_id' => 'Saldo kas saat ini sudah habis.',
            ])->withInput();
        }

        if ($totalExpense > $currentBalance) {
            return back()->withErrors([
                'cash_coa_id' => 'Saldo kas tidak mencukupi. Sisa saldo: Rp ' .
                    number_format($currentBalance, 0, ',', '.'),
            ])->withInput();
        }

        DB::transaction(function () use ($request, $period, $totalExpense) {

            // ================= TRANSACTION HEADER =================
            $transaction = Transaction::create([
                'transaction_number' => 'TRX-OUT-' . now()->format('YmdHis'),
                'transaction_date' => $request->transaction_date,
                'transaction_type' => TransactionType::EXPENSE,
                'description' => $request->description,
                'total_amount' => $totalExpense,
                'status' => 'POSTED',
                'period_id' => $request->period_id,
                'sub_period_id' => $request->sub_period_id,
                'created_by' => Auth::id(),
            ]);

            // ========== Handle file upload if receipt is provided =============
            if ($request->hasFile('receipt')) {

                $extension = $request->file('receipt')->getClientOriginalExtension();

                $fileName = $transaction->transaction_number . '.' . $extension;

                $media = $transaction
                    ->addMediaFromRequest('receipt')
                    ->usingFileName($fileName)
                    ->toMediaCollection('receipts');

                dd([
                    'media_id' => $media->id,
                    'file_name' => $media->file_name,
                    'disk' => $media->disk,
                    'path_relative' => $media->getPathRelativeToRoot(),
                    'full_path' => $media->getPath(),
                    'url' => $media->getUrl(),
                ]);


                $transaction->update([
                    'receipt_path' => $media->getPathRelativeToRoot()
                ]);
            }


            // ================= BEBAN (DEBIT) =================
            foreach ($request->expense_lines as $line) {
                TransactionLine::create([
                    'transaction_id' => $transaction->id,
                    'chart_of_account_id' => $line['coa_id'],
                    'debit_amount' => $line['amount'],
                    'credit_amount' => 0,
                    'description' => $line['description'] ?? null,
                    'line_type' => NormalBalanceEnum::DEBIT->value,
                ]);
            }

            // ================= KAS / BANK (CREDIT) =================
            TransactionLine::create([
                'transaction_id' => $transaction->id,
                'chart_of_account_id' => $request->cash_coa_id,
                'debit_amount' => 0,
                'credit_amount' => $totalExpense,
                'line_type' => NormalBalanceEnum::CREDIT->value,
            ]);

            // ================= JOURNAL =================
            $journal = Journal::create([
                'journal_number' => 'JR-' . now()->format('YmdHis'),
                'journal_date' => $transaction->transaction_date,
                'description' => $transaction->description,
                'total_debit' => $totalExpense,
                'total_credit' => $totalExpense,
                'period_id' => $transaction->period_id,
                'sub_period_id' => $transaction->sub_period_id,
                'transaction_id' => $transaction->id,
                'posted_by' => Auth::id(),
                'posted_at' => now(),
            ]);

            foreach ($transaction->transactionLines as $line) {
                JournalDetail::create([
                    'journal_id' => $journal->id,
                    'coa_id' => $line->chart_of_account_id,
                    'debit' => $line->debit_amount,
                    'credit' => $line->credit_amount,
                    'description' => $line->description ? $transaction->description . " - " . $line->description : $transaction->description,
                ]);
            }
        });

        return redirect()
            ->route('user.transactions.expenses.index')
            ->with('success', 'Transaksi pengeluaran berhasil disimpan');
    }

    /**
     * Display the specified resource.
     */
    public function show(String $id)
    {
        $transaction = Transaction::where('transaction_type', TransactionType::EXPENSE)
            ->findOrFail($id);

        $transaction->load([
            'transactionLines.chartOfAccount',
            'creator',
            'period',
            'subPeriod',
        ]);
        
        return view('pages.menus.user.expenses.show', compact('transaction'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Transaction $transaction)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Transaction $transaction)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Transaction $transaction)
    {
        //
    }
}
