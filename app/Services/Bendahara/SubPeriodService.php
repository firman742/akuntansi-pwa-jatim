<?php

namespace App\Services\Bendahara;

use App\Models\Period;
use App\Models\SubPeriod;
use Carbon\Carbon;
use Exception;

class SubPeriodService
{
    /**
     * Store a newly created sub-period in storage. This method validates that the sub-period's date range falls within the parent period's date range before creating the record.
     *
     * @param array $data
     * @return SubPeriod
     */
    public function store(array $data): SubPeriod
    {
        $this->validateSubPeriodDates($data);

        $SubPeriod = SubPeriod::create([
            'period_id' => $data['period_id'],
            'name' => $data['name'],
            'description' => $data['description'],
            'start_date' => $data['start_date'],
            'end_date' => $data['end_date'],
            'is_active' => (bool) ($data['is_active'] ?? false),
        ]);

        return $SubPeriod;
    }

    /**
     * Update the specified sub-period in storage. This method validates that the updated sub-period's date range falls within the parent period's date range before saving the changes.
     *
     * @param string $id
     * @param array $data
     * @return SubPeriod
     * @throws Exception if the sub-period dates are outside the parent period's date range.
     */
    public function update(string $id, array $data): SubPeriod
    {
        $SubPeriod = SubPeriod::findOrFail($id);

        $this->validateSubPeriodDates($data);

        $SubPeriod->update([
            'period_id' => $data['period_id'],
            'name' => $data['name'],
            'description' => $data['description'],
            'start_date' => $data['start_date'],
            'end_date' => $data['end_date'],
            'is_active' => (bool) ($data['is_active'] ?? false),
        ]);

        return $SubPeriod;
    }

    /**
     * Remove the specified sub-period from storage. This method checks if the sub-period has any related transactions or journals before allowing deletion to maintain data integrity.
     *
     * @param string $id
     * @throws Exception if the sub-period has related transactions or journals.
     */
    public function delete(string $id): void
    {
        $subPeriod = SubPeriod::findOrFail($id);
        $hasTransactions = $subPeriod->transactions()->exists();
        $hasJournals = $subPeriod->journals()->exists();

        if ($hasTransactions || $hasJournals) {
            throw new Exception('Sub periode tidak dapat dihapus karena memiliki transaksi atau jurnal terkait.');
        }

        $subPeriod->delete();
    }

    /**
     * Validates that the sub-period's start and end dates fall within the parent period's date range. This method is used to ensure data integrity when creating or updating sub-periods.
     *
     * @param array $data
     * @throws Exception if the sub-period dates are outside the parent period's date range.
     */
    private function validateSubPeriodDates(array $data): void
    {
        $period = Period::findOrFail($data['period_id']);

        $subStartDate = Carbon::parse($data['start_date']);
        $subEndDate = Carbon::parse($data['end_date']);

        $periodStartDate = Carbon::parse($period->start_date);
        $periodEndDate = Carbon::parse($period->end_date);

        // start_date tidak boleh sebelum period start_date
        if ($subStartDate->lt($periodStartDate)) {
            throw new Exception('Tanggal mulai sub periode tidak boleh sebelum periode utama.');
        }

        // end_date tidak boleh melebihi period end_date
        if ($subEndDate->gt($periodEndDate)) {
            throw new Exception('Tanggal selesai sub periode tidak boleh melebihi periode utama.');
        }
    }
}
