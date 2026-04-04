<?php

namespace App\Services\Bendahara;

use App\Models\ChartOfAccount;
use App\Models\ClosingBalance;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\OpeningBalance;
use App\Models\Period;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class PeriodService
{
    /**
     * Close the specified period.
     * TODO: Need to optimize for large data sets (e.g. chunking, indexing) and add more detailed logging for debugging.
     *
     * @param  Period  $period
     * @return void
     * @throws Exception
     */
    public function close($period)
    {
        Log::info('Closing period started', [
            'period_id' => $period->id,
            'period_name' => $period->name,
            'user_id' => Auth::id(),
        ]);

        if ($period->is_closed) {
            Log::warning('Closing failed: period already closed', [
                'period_id' => $period->id,
            ]);
            throw new Exception('Periode sudah ditutup.');
        }

        $hasDraft = Journal::where('period_id', $period->id)
            ->whereNull('posted_at')
            ->exists();

        if ($hasDraft) {
            Log::warning('Closing failed: journal draft exists', [
                'period_id' => $period->id,
            ]);
            throw new Exception('Masih ada jurnal yang belum diposting.');
        }

        $alreadyClosed = ClosingBalance::where('period_id', $period->id)->exists();

        if ($alreadyClosed) {
            Log::warning('Closing failed: closing balance already exists', [
                'period_id' => $period->id,
            ]);
            throw new Exception('Closing balance untuk periode ini sudah pernah dibuat.');
        }

        DB::transaction(function () use ($period) {

            $coas = ChartOfAccount::pluck('id');

            $openings = OpeningBalance::where('period_id', $period->id)
                ->selectRaw("
                chart_of_account_id,
                SUM(CASE WHEN balance_type = 'DEBIT' THEN amount ELSE -amount END) as total
            ")
                ->groupBy('chart_of_account_id')
                ->pluck('total', 'chart_of_account_id');

            $mutations = JournalDetail::whereHas('journal', function ($q) use ($period) {
                $q->where('period_id', $period->id);
            })
                ->selectRaw("
                coa_id,
                SUM(debit - credit) as total
            ")
                ->groupBy('coa_id')
                ->pluck('total', 'coa_id');

            Log::info('Computed balances', [
                'period_id' => $period->id,
                'total_coa' => $coas->count(),
                'opening_count' => count($openings),
                'mutation_count' => count($mutations),
            ]);

            $dataInsert = [];

            foreach ($coas as $coaId) {
                $opening  = $openings[$coaId] ?? 0;
                $mutation = $mutations[$coaId] ?? 0;
                $ending   = $opening + $mutation;

                // 🔥 Optional detail log (hati-hati kalau data besar)
                Log::debug('Closing detail per COA', [
                    'coa_id' => $coaId,
                    'opening' => $opening,
                    'mutation' => $mutation,
                    'ending' => $ending,
                ]);

                $dataInsert[] = [
                    'id' => (string) Str::uuid(),
                    'chart_of_account_id' => $coaId,
                    'period_id' => $period->id,
                    'balance_type' => $coaId ? ChartOfAccount::find($coaId)->normal_balance : 'DEBIT',
                    'amount' => $ending,
                    'created_by' => Auth::id(),
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }

            ClosingBalance::insert($dataInsert);

            $period->update([
                'is_closed' => true,
                'closed_at' => now(),
                'closed_by' => Auth::id(),
            ]);

            Log::info('Closing period success', [
                'period_id' => $period->id,
                'inserted_rows' => count($dataInsert),
            ]);
        });
    }
}
