<?php

namespace App\Http\Controllers\Bendahara;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\OpeningBalances\StoreOpeningBalanceRequest;
use App\Models\ClosingBalance;
use App\Models\SubPeriod;
use App\Services\Bendahara\OpeningBalanceService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class OpeningBalanceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(OpeningBalanceService $service): View
    {
        $periodId = request('period_id');
        $subPeriodId = request('sub_period_id');

        $data = $service->getIndexData($periodId, $subPeriodId);

        return view('pages.menus.bendahara.opening_balances.index',
            array_merge($data, [
                'periodId' => $periodId,
                'subPeriodId' => $subPeriodId,
            ])
        );
    }

    /**
     * Show the form for creating a new resource.
     * 
     * @param OpeningBalanceService $service
     * @return View
     */
    public function create(OpeningBalanceService $service): View
    {
        return view('pages.menus.bendahara.opening_balances.create',
            $service->getCreateData()
        );
    }

    /**
     * Store a newly created resource in storage.
     * @param OpeningBalanceService $service
     * @param StoreOpeningBalanceRequest $request
     * @return RedirectResponse
     * @throws Exception
     * 
     */
    public function store(OpeningBalanceService $service, StoreOpeningBalanceRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()->route('bendahara.opening-balances.index')
                ->with('success', 'Opening balance berhasil disimpan.');
        } catch (Exception $e) {
            return back()->withErrors(['error' => 'Gagal simpan: ' . $e->getMessage()])->withInput();
        }
    }

    // public function createBulk()
    // {
    //     $periods = Period::where('is_closed', false)->get();
    //     $coaLists = ChartOfAccount::orderBy('code')->get();

    //     return view('pages.menus.bendahara.opening_balances.create_bulk', compact('periods', 'coaLists'));
    // }

    // public function storeBulk(Request $request)
    // {
    //     $validated = $request->validate([
    //         'period_ids' => 'required|array|min:1',
    //         'period_ids.*' => 'exists:periods,id',
    //         'chart_of_account_id' => 'required|exists:chart_of_accounts,id',
    //         'balance_type' => 'required|in:DEBIT,CREDIT',
    //         'amount' => 'required|numeric|min:0', // Ini bertindak sebagai nilai tambahan/manual
    //     ]);

    //     DB::beginTransaction();
    //     try {
    //         foreach ($validated['period_ids'] as $periodId) {
    //             // 1. Cari sub periode pertama di tahun tersebut
    //             $firstSubPeriod = SubPeriod::where('period_id', $periodId)
    //                 ->orderBy('start_date')
    //                 ->first();

    //             if (!$firstSubPeriod) continue;

    //             // 2. Validasi: Jangan timpa jika sudah ada atau ada jurnal
    //             $exists = OpeningBalance::where([
    //                 'chart_of_account_id' => $validated['chart_of_account_id'],
    //                 'sub_period_id' => $firstSubPeriod->id
    //             ])->exists();

    //             $journalExists = Journal::where('sub_period_id', $firstSubPeriod->id)->exists();

    //             if ($exists || $journalExists) continue;

    //             // 3. CARI SALDO SISA PERIODE SEBELUMNYA (Masing-masing periode)
    //             $lastSubPeriod = SubPeriod::where('end_date', '<', $firstSubPeriod->start_date)
    //                 ->orderBy('end_date', 'desc')
    //                 ->first();

    //             $lastClosingAmount = 0;
    //             if ($lastSubPeriod) {
    //                 $closing = ClosingBalance::where('chart_of_account_id', $validated['chart_of_account_id'])
    //                     ->where('period_id', $lastSubPeriod->period_id)
    //                     ->first();
    //                 $lastClosingAmount = $closing ? $closing->amount : 0;
    //             }

    //             // 4. TOTAL = Saldo Sisa + Input Nominal
    //             $finalAmount = (float) $lastClosingAmount + (float) $validated['amount'];

    //             if ($finalAmount > 0) {
    //                 OpeningBalance::create([
    //                     'chart_of_account_id' => $validated['chart_of_account_id'],
    //                     'period_id' => $periodId,
    //                     'sub_period_id' => $firstSubPeriod->id,
    //                     'balance_type' => $validated['balance_type'],
    //                     'amount' => $finalAmount,
    //                     'created_by' => Auth::id()
    //                 ]);
    //             }
    //         }

    //         DB::commit();
    //         return redirect()->route('bendahara.opening-balances.index')
    //             ->with('success', 'Bulk Opening balance berhasil diproses.');
    //     } catch (\Exception $e) {
    //         DB::rollBack();
    //         return back()->withErrors(['error' => 'Gagal simpan bulk: ' . $e->getMessage()])->withInput();
    //     }
    // }

    /**
     * Endpoint Baru untuk AJAX: Mengambil Saldo Terakhir
     * Berguna untuk tombol "Lihat Saldo Sebelumnya"
     */
    public function getLastClosingBalance(Request $request)
    {
        $coaId = $request->coa_id;
        $currentSubPeriodId = $request->sub_period_id;

        $currentSubPeriod = SubPeriod::findOrFail($currentSubPeriodId);

        // Mencari sub periode terakhir sebelum tanggal mulai sub periode saat ini
        $lastSubPeriod = SubPeriod::where('end_date', '<', $currentSubPeriod->start_date)
            ->orderBy('end_date', 'desc')
            ->first();

        if (!$lastSubPeriod) {
            return response()->json(['amount' => 0, 'balance_type' => 'DEBIT']);
        }

        $closing = ClosingBalance::where('chart_of_account_id', $coaId)
            ->where('period_id', $lastSubPeriod->period_id)
            ->first();

        return response()->json([
            'amount' => $closing ? $closing->amount : 0,
            'balance_type' => $closing ? $closing->balance_type : 'DEBIT'
        ]);
    }
}
