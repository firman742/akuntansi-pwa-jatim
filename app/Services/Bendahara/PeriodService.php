<?php

namespace App\Services\Bendahara;

use App\Enums\ActivityLogAction;
use App\Models\Period;
use App\Services\BaseService;
use Exception;
use Illuminate\Support\Facades\Auth;

class PeriodService extends BaseService
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

        // activity log
        $this->logger->log(
            action: ActivityLogAction::CREATED->value,
            module: "PERIOD",
            subject: $period,
            description: "Periode {$period->name} berhasil dibuat.",
            old: [],
            new: $period->toArray(),
            additionalData: [
                'start_date' => $period->start_date->toDateString(),
                'end_date' => $period->end_date->toDateString(),
            ]
        );

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

        if (!$period->is_active) {
            throw new Exception('Periode sudah ditutup dan tidak dapat diubah.');
        }

        if ($period->hasTransactions()) {
            throw new Exception('Periode tidak dapat diubah karena sudah memiliki transaksi.');
        }

        $existing = Period::query()
            ->where('id', '!=', $period->id)
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

        $oldPeriod = $period->replicate();
        
        $period->update([
            'name' => $data['name'],
            'description' => $data['description'],
            'start_date' => $data['start_date'],
            'end_date' => $data['end_date'],
        ]);


        // activity log
        $this->logger->log(
            action: ActivityLogAction::UPDATED->value,
            module: "PERIOD",
            subject: $period,
            description: "Periode {$period->name} berhasil diubah.",
            old: $oldPeriod->toArray(),
            new: $period->toArray(),
            additionalData: [
                'start_date' => $period->start_date->toDateString(),
                'end_date' => $period->end_date->toDateString(),
            ]
        );

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
        if (!$period->is_active) {
            throw new Exception('Periode sudah ditutup dan tidak dapat dihapus.');
        }

        // activity log
        $this->logger->log(
            action: ActivityLogAction::DELETED->value,
            module: "PERIOD",
            subject: $period,
            description: "Periode {$period->name} berhasil dihapus.",
            old: $period->toArray(),
            new: [],
            additionalData: [
                'start_date' => $period->start_date->toDateString(),
                'end_date' => $period->end_date->toDateString(),
            ]
        );

        $period->delete();
    }
}
