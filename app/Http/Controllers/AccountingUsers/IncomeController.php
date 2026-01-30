<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Models\Journal;
use App\Models\AccountType;
use App\Models\Transaction;
use Illuminate\Http\Request;
use App\Models\JournalDetail;
use App\Enums\TransactionType;
use App\Models\ChartOfAccount;
use App\Models\TransactionLine;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\Period;
use Illuminate\Support\Facades\Auth;
use Pest\Support\Str;

class IncomeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $incomes = Transaction::with('transactionLines', 'creator')
            ->where('transaction_type', TransactionType::INCOME->value)
            ->orderBy('created_at', 'desc')
            ->get();

        return view('pages.menus.user.incomes.index', compact('incomes'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $userId = Auth::id();
        // Ambil ID Account Type
        $assetTypeId = AccountType::where('name', 'ASET')->value('id');
        $incomeTypeId = AccountType::where('name', 'PENDAPATAN')->value('id');

        /*
        |--------------------------------------------------------------------------
        | AKUN KAS / BANK (ASET - DEBIT)
        |--------------------------------------------------------------------------
        | - ASET
        | - Normal balance DEBIT
        | - Leaf account
        | - Aktif
        | - TERDAFTAR di user_accounts
        */
        $cashCoas = ChartOfAccount::query()
            ->where('account_type_id', $assetTypeId)
            ->where('normal_balance', 'DEBIT')
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->whereHas('userAccounts', function ($q) use ($userId) {
                $q->where('user_id', $userId);
            })
            ->orderBy('code')
            ->get();

        /*
        |--------------------------------------------------------------------------
        | AKUN PENDAPATAN (CREDIT)
        |--------------------------------------------------------------------------
        | - PENDAPATAN
        | - Normal balance CREDIT
        | - Leaf account
        | - Aktif
        | - TERDAFTAR di user_accounts
        */
        $incomeCoas = ChartOfAccount::query()
            ->where('account_type_id', $incomeTypeId)
            ->where('normal_balance', 'CREDIT')
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->whereHas('userAccounts', function ($q) use ($userId) {
                $q->where('user_id', $userId);
            })
            ->orderBy('code')
            ->get();

        return view('pages.menus.user.incomes.create', compact(
            'cashCoas',
            'incomeCoas'
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
            'income_lines.*.coa_id' => 'required|exists:chart_of_accounts,id',
            'income_lines.*.amount' => 'required|numeric|min:1',
        ]);

        DB::transaction(function () use ($request, $period) {

            // 1️⃣ Hitung total
            $total = collect($request->income_lines)->sum('amount');

            // 2️⃣ TRANSACTION HEADER
            $transaction = Transaction::create([
                'transaction_number' => 'TRX-IN-' . now()->format('YmdHis'),
                'transaction_date' => $request->transaction_date,
                'transaction_type' => TransactionType::INCOME,
                'description' => $request->description,
                'total_amount' => $total,
                'status' => 'POSTED',
                'period_id' => $period->id, // asumsi helper activePeriod()->id
                'created_by' => Auth::id(),
            ]);

            // 3️⃣ LINE KAS (DEBIT)
            TransactionLine::create([
                'transaction_id' => $transaction->id,
                'chart_of_account_id' => $request->cash_coa_id,
                'debit_amount' => $total,
                'credit_amount' => 0,
                'line_type' => 'DEBIT',
            ]);

            // 4️⃣ LINE PENDAPATAN (CREDIT)
            foreach ($request->income_lines as $line) {
                TransactionLine::create([
                    'transaction_id' => $transaction->id,
                    'chart_of_account_id' => $line['coa_id'],
                    'debit_amount' => 0,
                    'credit_amount' => $line['amount'],
                    'description' => $line['description'] ?? null,
                    'line_type' => 'CREDIT',
                ]);
            }

            // 5️⃣ JOURNAL HEADER
            $journal = Journal::create([
                'journal_number' => 'JR-' . now()->format('YmdHis'),
                'journal_date' => $transaction->transaction_date,
                'description' => $transaction->description,
                'total_debit' => $total,
                'total_credit' => $total,
                'period_id' => $transaction->period_id,
                'transaction_id' => $transaction->id,
                'posted_by' => Auth::id(),
                'posted_at' => now(),
            ]);

            // 6️⃣ JOURNAL DETAIL (mirror lines)
            foreach ($transaction->transactionLines as $line) {
                JournalDetail::create([
                    'journal_id' => $journal->id,
                    'coa_id' => $line->chart_of_account_id,
                    'debit' => $line->debit_amount,
                    'credit' => $line->credit_amount,
                    'description' => $line->description,
                ]);
            }
        });

        return redirect()
            ->route('user.incomes.index')
            ->with('success', 'Transaksi penerimaan berhasil disimpan');
    }

    /**
     * Display the specified resource.
     */
    public function show(String $id)
    {
        $transaction = Transaction::where('transaction_type', TransactionType::INCOME->value)
            ->findOrFail($id);

        $transaction->load([
            'creator:id,name',
            'period:id,name,start_date,end_date',
            'transactionLines.chartOfAccount:id,code,name,normal_balance',
            'journal.details.coa',
        ]);

        return view('pages.menus.user.incomes.show', compact('transaction'));
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
