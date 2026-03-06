<?php

namespace App\Http\Controllers\Bendahara;

use Carbon\Carbon;
use App\Models\Period;
use App\Models\Journal;
use Illuminate\Http\Request;
use App\Models\JournalDetail;
use App\Models\ChartOfAccount;
use App\Models\OpeningBalance;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;

class TrialBalanceController extends Controller
{
    public function index(Request $request)
    {
        $periods = Period::orderBy('start_date', 'desc')->get();
        $periodId = $request->period_id ?? Period::active()->first()->id;
        $period = Period::findOrFail($periodId);
        $month = $request->month;

        $coas = ChartOfAccount::orderBy('code')->get();

        // Inisialisasi Kategori
        $data = [
            'aset_lancar' => [],
            'aset_tidak_lancar' => [],
            'hutang' => [],
            'modal' => []
        ];

        foreach ($coas as $coa) {
            // 1. Ambil Saldo Awal
            $opening = OpeningBalance::where('chart_of_account_id', $coa->id)
                ->where('period_id', $period->id)->first();
            $openingAmount = $opening ? $opening->amount : 0;

            // 2. Hitung Mutasi
            $mutationQuery = JournalDetail::where('coa_id', $coa->id)
                ->whereHas('journal', function ($q) use ($period, $month) {
                    $q->where('period_id', $period->id);
                    if ($month) {
                        $q->whereMonth('journal_date', Carbon::parse($month)->month)
                            ->whereYear('journal_date', Carbon::parse($month)->year);
                    }
                });

            $debit = (clone $mutationQuery)->sum('debit');
            $credit = (clone $mutationQuery)->sum('credit');

            // 3. Saldo Akhir
            if ($coa->normal_balance === 'DEBIT') {
                $balance = $openingAmount + $debit - $credit;
            } else {
                $balance = $openingAmount + $credit - $debit;
            }

            // Pengelompokan berdasarkan Kode Akun (Header)
            $row = ['code' => $coa->code, 'name' => $coa->name, 'amount' => $balance];

            if (str_starts_with($coa->code, '11')) $data['aset_lancar'][] = $row;
            elseif (str_starts_with($coa->code, '12')) $data['aset_tidak_lancar'][] = $row;
            elseif (str_starts_with($coa->code, '2')) $data['hutang'][] = $row;
            elseif (str_starts_with($coa->code, '3')) $data['modal'][] = $row;
        }

        // Hitung Selisih Pendapatan & Biaya (Surplus/Defisit)
        $totalRevenue = JournalDetail::whereHas('coa', fn($q) => $q->where('code', 'like', '4%'))
            ->whereHas('journal', fn($q) => $q->where('period_id', $period->id))->sum(DB::raw('credit - debit'));
        $totalExpense = JournalDetail::whereHas('coa', fn($q) => $q->where('code', 'like', '5%'))
            ->whereHas('journal', fn($q) => $q->where('period_id', $period->id))->sum(DB::raw('debit - credit'));
        $surplusDeficit = $totalRevenue - $totalExpense;

        // LOGIKA BARU UNTUK MODAL
        $totalAsetLancar = collect($data['aset_lancar'])->sum('amount');
        $totalAsetTidakLancar = collect($data['aset_tidak_lancar'])->sum('amount');
        $totalKeseluruhanAset = $totalAsetLancar + $totalAsetTidakLancar;
        $totalHutang = collect($data['hutang'])->sum('amount');

        // 1. Modal Tetap = Jumlah Aset Tidak Lancar
        $modalTetap = $totalAsetTidakLancar;

        // 2. Modal Lancar = Total Aset - Modal Tetap - Surplus/Defisit - Hutang
        $modalLancar = $totalKeseluruhanAset - $modalTetap - $surplusDeficit - $totalHutang;

        return view('pages.menus.bendahara.trial-balances.index', compact(
            'data',
            'surplusDeficit',
            'modalTetap',   // Kirim ke view
            'modalLancar',  // Kirim ke view
            'periods',
            'periodId',
            'month',
            'period'
        ));
    }

    public function export(Request $request, string $type)
    {
        $periodId = $request->period_id;
        $month    = $request->month;

        $journals = Journal::with(['details.coa.accountType'])
            ->where('period_id', $periodId)
            ->when($month, function ($q) use ($month) {
                [$year, $m] = explode('-', $month);
                $q->whereYear('journal_date', $year)
                    ->whereMonth('journal_date', $m);
            })
            ->orderBy('journal_date')
            ->get();

        return match ($type) {
            'excel' => app()->download($journals),
            'pdf'   => app()->download($journals),
            default => abort(404),
        };
    }
}
