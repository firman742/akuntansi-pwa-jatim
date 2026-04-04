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
use Illuminate\Support\Facades\Log;

class IncomeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Transaction::with(['transactionLines', 'creator', 'period', 'subPeriod'])
            ->where('transaction_type', TransactionType::INCOME->value);

        // ================= FILTER =================
        if ($request->filled('period_id')) {
            $query->where('period_id', $request->period_id);
        }

        if ($request->filled('sub_period_id')) {
            $query->where('sub_period_id', $request->sub_period_id);
        }

        $incomes = $query
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

        return view('pages.menus.user.incomes.index', compact(
            'incomes',
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

        $assetTypeId  = AccountType::where('name', 'ASET')->value('id');
        $incomeTypeId = AccountType::where('name', 'PENDAPATAN')->value('id');

        // ================= PERIOD =================
        $periods = Period::where('is_closed', false)
            ->orderBy('created_at', 'desc')
            ->get();

        $selectedPeriodId = request('period_id') ?? $periods->first()?->id;

        if (!$selectedPeriodId) {
            return back()->withErrors([
                'period' => 'Tidak ada periode aktif.'
            ]);
        }

        // ================= SUB PERIOD =================
        $subPeriods = SubPeriod::query()
            ->where('period_id', $selectedPeriodId)
            ->active()
            ->orderBy('start_date')
            ->get();

        // ================= KAS / BANK =================
        $cashCoas = ChartOfAccount::query()
            ->where('account_type_id', $assetTypeId)
            ->where('normal_balance', 'DEBIT')
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->whereHas('userAccounts', fn($q) => $q->where('user_id', $userId))
            ->orderBy('code')
            ->get();

        // ================= PENDAPATAN =================
        $incomeCoas = ChartOfAccount::query()
            ->where('account_type_id', $incomeTypeId)
            ->where('normal_balance', 'CREDIT')
            ->where('is_active', true)
            ->whereDoesntHave('children')
            ->whereHas('userAccounts', fn($q) => $q->where('user_id', $userId))
            ->orderBy('code')
            ->get();

        return view('pages.menus.user.incomes.create', compact(
            'cashCoas',
            'incomeCoas',
            'periods',
            'subPeriods',
            'selectedPeriodId',
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

        // ================= VALIDATION =================
        $request->validate([
            'period_id' => 'required|exists:periods,id',
            'sub_period_id' => 'required|exists:sub_periods,id',
            'transaction_date' => 'required|date',
            'cash_coa_id' => 'required|exists:chart_of_accounts,id',
            'income_lines' => 'required|array|min:1',
            'income_lines.*.coa_id' => 'required|exists:chart_of_accounts,id',
            'income_lines.*.amount' => 'required|numeric|min:1',
            'receipt' => 'nullable|file|mimes:jpg,jpeg,png,webp|max:2048', // optional, max 2MB
        ]);

        // ================= TOTAL =================
        $totalIncome = collect($request->income_lines)->sum('amount');

        if ($totalIncome <= 0) {
            return back()->withErrors([
                'income_lines' => 'Total penerimaan harus lebih dari 0.',
            ])->withInput();
        }

        DB::transaction(function () use ($request, $period, $totalIncome) {

            // ================= TRANSACTION HEADER =================
            $transaction = Transaction::create([
                'transaction_number' => 'TRX-IN-' . now()->format('YmdHis'),
                'transaction_date'   => $request->transaction_date,
                'transaction_type'   => TransactionType::INCOME,
                'description'        => $request->description,
                'total_amount'       => $totalIncome,
                'status'             => 'POSTED',
                'period_id'          => $request->period_id,
                'sub_period_id'      => $request->sub_period_id,
                'created_by'         => Auth::id(),
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

            // ================= KAS / BANK (DEBIT) =================
            TransactionLine::create([
                'transaction_id'       => $transaction->id,
                'chart_of_account_id'  => $request->cash_coa_id,
                'debit_amount'         => $totalIncome,
                'credit_amount'        => 0,
                'line_type'            => NormalBalanceEnum::DEBIT->value,
            ]);

            // ================= PENDAPATAN (CREDIT) =================
            foreach ($request->income_lines as $line) {
                TransactionLine::create([
                    'transaction_id'      => $transaction->id,
                    'chart_of_account_id' => $line['coa_id'],
                    'debit_amount'        => 0,
                    'credit_amount'       => $line['amount'],
                    'description'         => $line['description'] ?? null,
                    'line_type'           => NormalBalanceEnum::CREDIT->value,
                ]);
            }

            // ================= JOURNAL HEADER =================
            $journal = Journal::create([
                'journal_number' => 'JR-' . now()->format('YmdHis'),
                'journal_date'   => $transaction->transaction_date,
                'description'    => $transaction->description,
                'total_debit'    => $totalIncome,
                'total_credit'   => $totalIncome,
                'period_id'      => $transaction->period_id,
                'sub_period_id'  => $transaction->sub_period_id,
                'transaction_id' => $transaction->id,
                'posted_by'      => Auth::id(),
                'posted_at'      => now(),
            ]);

            // ================= JOURNAL DETAIL =================
            foreach ($transaction->transactionLines as $line) {
                JournalDetail::create([
                    'journal_id' => $journal->id,
                    'coa_id'     => $line->chart_of_account_id,
                    'debit'      => $line->debit_amount,
                    'credit'     => $line->credit_amount,
                    'description' => $line->description ? $transaction->description . " - " . $line->description : $transaction->description,
                ]);
            }
        });

        return redirect()
            ->route('user.transactions.incomes.index')
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
            'period:id,name',
            'subPeriod:id,name',
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

    /**
     * Get cash balance for a specific COA and period.
     */
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
