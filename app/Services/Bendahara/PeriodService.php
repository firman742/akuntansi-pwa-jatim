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
use Illuminate\Support\Str;

class PeriodService
{
    /**
     * Create a new period.
     *
     * @param  array  $data
     * @return Period
     * @throws Exception
     */
    public function store(array $data): Period
    {
        $existing = Period::query()
            ->where('is_closed', false)
            ->where(function ($query) use ($data) {
                $query
                    ->where('start_date', '<=', $data['end_date'])
                    ->where('end_date', '>=', $data['start_date']);
            })
            ->first();

        if ($existing) {
            throw new Exception(
                'Periode tidak dapat dibuat karena rentang tanggal bertabrakan dengan periode aktif yang sudah ada.'
            );
        }

        $period = Period::create([
            'name' => $data['name'],
            'description' => $data['description'],
            'start_date' => $data['start_date'],
            'end_date' => $data['end_date'],
            'created_by' => Auth::id(),
        ]);

        return $period;
    }


    /**
     * Update an existing period.
     *
     * @param  string  $id
     * @param  array  $data
     * @return Period
     * @throws Exception
     */
    public function update(string $id, array $data): Period
    {
        $period = Period::findOrFail($id);

        if ($period->is_closed) {
            throw new Exception('Periode sudah ditutup dan tidak dapat diubah.');
        }

        if ($period->transactions()->exists()) {
            throw new Exception('Periode tidak dapat diubah karena sudah memiliki transaksi.');
        }

        $existing = Period::query()
            ->where('id', '!=', $period->id)
            ->where('is_closed', false)
            ->where(function ($query) use ($data) {
                $query
                    ->where('start_date', '<=', $data['end_date'])
                    ->where('end_date', '>=', $data['start_date']);
            })
            ->first();

        if ($existing) {
            throw new Exception(
                'Periode tidak dapat diubah karena rentang tanggal bertabrakan dengan periode aktif yang sudah ada.'
            );
        }

        $period->update([
            'name' => $data['name'],
            'description' => $data['description'],
            'start_date' => $data['start_date'],
            'end_date' => $data['end_date'],
        ]);

        return $period;
    }

    /**
     * Delete the specified period.
     *
     * @param  Period  $period
     * @return void
     * @throws Exception
     */
    public function delete(Period $period): void
    {
        if ($period->is_closed) {
            throw new Exception('Periode sudah ditutup dan tidak dapat dihapus.');
        }

        $period->delete();
    }

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
        if ($period->is_closed) {
            throw new Exception('Periode sudah ditutup.');
        }

        if ($period->transactions()->exists()) {
            return new Exception('Periode tidak dapat ditutup karena sudah memiliki transaksi.');
        }

        if (now()->lessThanOrEqualTo($period->end_date)) {
            return new Exception('Periode belum dapat ditutup karena tanggal akhir belum lewat.');
        }

        $hasDraft = Journal::where('period_id', $period->id)
            ->whereNull('posted_at')
            ->exists();

        if ($hasDraft) {
            throw new Exception('Masih ada jurnal yang belum diposting.');
        }

        $alreadyClosed = ClosingBalance::where('period_id', $period->id)->exists();

        if ($alreadyClosed) {
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
                chart_of_account_id,
                SUM(debit - credit) as total
            ")
                ->groupBy('chart_of_account_id')
                ->pluck('total', 'chart_of_account_id');

            $dataInsert = [];

            foreach ($coas as $coaId) {
                $opening  = $openings[$coaId] ?? 0;
                $mutation = $mutations[$coaId] ?? 0;
                $ending   = $opening + $mutation;

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
        });
    }
}
