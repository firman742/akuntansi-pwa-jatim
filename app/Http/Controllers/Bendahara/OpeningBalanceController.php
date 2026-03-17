<?php

namespace App\Http\Controllers\Bendahara;

use App\Enums\NormalBalanceEnum;
use App\Http\Controllers\Controller;
use App\Models\ChartOfAccount;
use App\Models\Journal;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class OpeningBalanceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $periods = Period::where('is_closed', false)->get();

        $periodId = request('period_id');
        $subPeriodId = request('sub_period_id');

        $subPeriods = collect();

        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date')
                ->get();
        }

        $openingBalances = OpeningBalance::with(['chartOfAccount', 'subPeriod'])
            ->leftJoin('sub_periods', 'opening_balances.sub_period_id', '=', 'sub_periods.id')

            ->when($periodId, function ($q) use ($periodId) {
                $q->where('opening_balances.period_id', $periodId);
            })

            ->when($subPeriodId, function ($q) use ($subPeriodId) {
                $q->where('opening_balances.sub_period_id', $subPeriodId);
            })

            ->orderBy('sub_periods.start_date')
            ->orderBy('opening_balances.created_at', 'desc')

            ->select('opening_balances.*')
            ->get()

            ->map(function ($item) {
                return [
                    'id' => $item->id,
                    'account_name' => $item->chartOfAccount->name,
                    'account_code' => $item->chartOfAccount->code,
                    'sub_period' => optional($item->subPeriod)->name,
                    'debit' => $item->balance_type === NormalBalanceEnum::DEBIT->value ? $item->amount : 0,
                    'credit' => $item->balance_type === NormalBalanceEnum::CREDIT->value ? $item->amount : 0,
                ];
            });

        return view('pages.menus.bendahara.opening_balances.index',
            compact('openingBalances', 'periods', 'periodId', 'subPeriods', 'subPeriodId')
        );
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $periods = Period::where('is_closed', false)
            ->get();

        $subPeriods = optional($periods->first())->subPeriods()->orderBy('start_date')->get();

        $coaLists = ChartOfAccount::orderBy('code')->get();

        return view('pages.menus.bendahara.opening_balances.create', compact('periods', 'subPeriods', 'coaLists'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'chart_of_account_id' => 'required|exists:chart_of_accounts,id',
            'sub_period_id' => 'required|exists:sub_periods,id',
            'balance_type' => 'required|in:DEBIT,CREDIT',
            'amount' => 'required|numeric|min:0'
        ], [
            'chart_of_account_id.required' => 'Akun wajib dipilih.',
            'sub_period_id.required' => 'Sub periode wajib dipilih.',
            'balance_type.required' => 'Tipe saldo wajib dipilih.',
            'amount.required' => 'Nominal saldo awal wajib diisi.',
            'amount.numeric' => 'Nominal harus berupa angka.',
            'amount.min' => 'Nominal tidak boleh negatif.'
        ]);


        $subPeriod = SubPeriod::findOrFail($validated['sub_period_id']);
        $accountId = $validated['chart_of_account_id'];


        /**
         * ================================
         * VALIDASI 1
         * CEK PERIODE SUDAH DITUTUP
         * ================================
         */
        if ($subPeriod->period->is_closed) {
            return back()->withErrors([
                'sub_period_id' => 'Periode ini sudah ditutup dan tidak dapat diubah.'
            ])->withInput();
        }


        /**
         * ================================
         * VALIDASI 2
         * CEK SUDAH ADA TRANSAKSI JURNAL PADA SUB PERIODE INI
         * ================================
         */
        $journalExists = Journal::where('sub_period_id', $subPeriod->id)->exists();

        if ($journalExists) {
            return back()->withErrors([
                'sub_period_id' => 'Tidak dapat reset saldo karena sudah ada transaksi jurnal pada sub periode ini.'
            ])->withInput();
        }


        /**
         * ================================
         * VALIDASI 3
         * CEK OPENING BALANCE SUDAH ADA
         * ================================
         */

        $existingOpening = OpeningBalance::where([
            'chart_of_account_id' => $accountId,
            'sub_period_id' => $subPeriod->id
        ])->exists();

        if ($existingOpening) {
            return back()->withErrors([
                'chart_of_account_id' => 'Saldo awal untuk akun ini pada sub periode tersebut sudah ada.'
            ])->withInput();
        }


        /**
         * ================================
         * VALIDASI 4
         * CEK APAKAH ADA TRANSAKSI OPENING BALANCE PADA SUB PERIODE SETELAHNYA
         * ================================
         */

        $futureJournalExists = Journal::whereHas('subPeriod', function ($q) use ($subPeriod) {
            $q->where('start_date', '>', $subPeriod->start_date);
        })->exists();
        
        if ($futureJournalExists) {
            return back()->withErrors([
                'sub_period_id' => 'Tidak dapat reset saldo karena sudah ada transaksi setelah periode ini.'
            ])->withInput();
        }


        /**
         * ================================
         * VALIDASI 5
         * NOMINAL TIDAK BOLEH NOL
         * ================================
         */

        if ($validated['amount'] == 0) {
            return back()->withErrors([
                'amount' => 'Nominal saldo awal tidak boleh 0.'
            ])->withInput();
        }

        /**
         * ================================
         * SIMPAN DATA
         * ================================
         */

        OpeningBalance::create([
            'chart_of_account_id' => $accountId,
            'period_id' => $subPeriod->period_id,
            'sub_period_id' => $subPeriod->id,
            'balance_type' => $validated['balance_type'],
            'amount' => $validated['amount'],
            'created_by' => Auth::id()
        ]);

        return redirect()
            ->route('bendahara.opening-balances.index')
            ->with('success', 'Saldo awal berhasil dibuat.');
    }

    public function createBulk()
    {
        $periods = Period::where('is_closed', false)->get();
        $coaLists = ChartOfAccount::orderBy('code')->get();

        return view('pages.menus.bendahara.opening_balances.create_bulk', compact('periods', 'coaLists'));
    }

    public function storeBulk(Request $request)
    {
        $validated = $request->validate([
            'period_ids' => 'required|array|min:1',
            'period_ids.*' => 'exists:periods,id',
            'chart_of_account_id' => 'required|exists:chart_of_accounts,id',
            'balance_type' => 'required|in:DEBIT,CREDIT',
            'amount' => 'required|numeric|min:0',
        ]);

        foreach ($validated['period_ids'] as $periodId) {

            $firstSubPeriod = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date')
                ->first();

            if (!$firstSubPeriod) {
                continue;
            }

            $exists = OpeningBalance::where([
                'chart_of_account_id' => $validated['chart_of_account_id'],
                'sub_period_id' => $firstSubPeriod->id
            ])->exists();

            if ($exists) {
                continue;
            }

            OpeningBalance::create([
                'chart_of_account_id' => $validated['chart_of_account_id'],
                'period_id' => $periodId,
                'sub_period_id' => $firstSubPeriod->id,
                'balance_type' => $validated['balance_type'],
                'amount' => $validated['amount'],
                'created_by' => Auth::id()
            ]);
        }

        return redirect()->route('bendahara.opening-balances.index')
            ->with('success', 'Opening balance berhasil dibuat untuk beberapa periode.');
    }
}
