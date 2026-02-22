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
use App\Models\OpeningBalance;
use App\Models\Period;
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
    public function index()
    {
        $expenses = Transaction::with(['transactionLines', 'creator'])
            ->where('transaction_type', TransactionType::EXPENSE->value)
            ->orderBy('created_at', 'desc')
            ->get();

        return view('pages.menus.user.expenses.index', compact('expenses'));
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


            $period = Period::active()->first();

            $cashBalances = collect();
            
            if ($period) {
                foreach ($cashCoas as $coa) {
                    $cashBalances[$coa->id] = CashBalanceHelper::getBalance(
                        $coa->id,
                        $period->id
                    );
                }
            }

        return view('pages.menus.user.expenses.create', compact(
            'cashCoas',
            'expenseCoas',
            'cashBalances'
        ));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $period = Period::active()->first();

        if (! $period) {
            return back()->withErrors([
                'period' => 'Tidak ada periode aktif. Silakan hubungi bendahara.',
            ]);
        }

        $request->validate([
            'transaction_date' => 'required|date',
            'cash_coa_id' => 'required|exists:chart_of_accounts,id',
            'expense_lines.*.coa_id' => 'required|exists:chart_of_accounts,id',
            'expense_lines.*.amount' => 'required|numeric|min:1',
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
                'period_id' => $period->id,
                'created_by' => Auth::id(),
            ]);

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
            ->route('user.expenses.index')
            ->with('success', 'Transaksi pengeluaran berhasil disimpan');
    }

    /**
     * Display the specified resource.
     */
    public function show(Transaction $transaction)
    {
        //
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
