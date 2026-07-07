<?php

namespace App\Services\Bendahara;

use App\Enums\ActivityLogAction;
use App\Enums\TransactionStatus;
use App\Models\ChartOfAccount;
use App\Models\ClosingBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Services\BaseService;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class SubPeriodService extends BaseService
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

        // activity log
        $this->logger->log(
            action: ActivityLogAction::CREATED->value,
            module: "SUB_PERIOD",
            subject: $SubPeriod,
            description: "Sub periode {$SubPeriod->name} berhasil dibuat.",
            old: [],
            new: $SubPeriod->toArray(),
            additionalData: [
                'period_id' => $data['period_id'],
                'start_date' => $data['start_date'],
                'end_date' => $data['end_date'],
                'is_active' => (bool) ($data['is_active'] ?? false),
            ]
        );

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

        if ($SubPeriod->transactions()->exists()) {
            throw new Exception('Sub periode tidak bisa diubah karena sudah memiliki transaksi.');
        }

        $this->validateSubPeriodDates($data, $SubPeriod);

        $oldSubPeriodData = $SubPeriod->toArray();

        $SubPeriod->update([
            'period_id' => $data['period_id'],
            'name' => $data['name'],
            'description' => $data['description'],
            'start_date' => $data['start_date'],
            'end_date' => $data['end_date'],
            'is_active' => (bool) ($data['is_active'] ?? false),
        ]);

        // activity log
        $this->logger->log(
            action: ActivityLogAction::UPDATED->value,
            module: "SUB_PERIOD",
            subject: $SubPeriod,
            description: "Sub periode {$SubPeriod->name} berhasil diperbarui.",
            old: $oldSubPeriodData,
            new: $SubPeriod->toArray(),
            additionalData: [
                'period_id' => $data['period_id'],
                'start_date' => $data['start_date'],
                'end_date' => $data['end_date'],
                'is_active' => (bool) ($data['is_active'] ?? false),
            ]
        );

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

        // activity log
        $this->logger->log(
            action: ActivityLogAction::DELETED->value,
            module: "SUB_PERIOD",
            subject: $subPeriod,
            description: "Sub periode {$subPeriod->name} berhasil dihapus.",
            old: $subPeriod->toArray(),
            new: [],
            additionalData: [
                'period_id' => $subPeriod->period_id,
                'start_date' => $subPeriod->start_date,
                'end_date' => $subPeriod->end_date,
                'is_active' => $subPeriod->is_active,
            ]
        );

        $subPeriod->delete();
    }

    /**
     * Close the specified sub-period. This method marks the sub-period as closed and records the closure time and user who performed the action.
     *
     * @param string $id
     * @throws Exception if the sub-period is already closed.
     */
    public function close(string $id): void
    {
        DB::transaction(function () use ($id) {

            $subPeriod = SubPeriod::with([
                'coaBalances.chartOfAccount'
            ])->findOrFail($id);
    
            if ($subPeriod->is_closed) {
                throw new Exception('Sub periode sudah ditutup.');
            }
    
            // cek apakah ada transaction / jurnal yang belum di posting, jika ada maka tidak bisa ditutup
            $hasUnpostedTransactions = $subPeriod->transactions()
                ->where('status', TransactionStatus::DRAFT->value)
                ->exists();
    
            if ($hasUnpostedTransactions) {
                throw new Exception('Sub periode tidak dapat ditutup karena masih ada transaksi yang belum diposting.');
            }
    
            // check if the sub-period's end date is in the future
            if ($subPeriod->end_date->isFuture()) {
                throw new Exception('Sub periode tidak dapat ditutup karena tanggal selesai sub periode masih di masa mendatang.');
            }
    
            // Check if there are any closing balances associated with this sub-period
            $alreadyClosed = ClosingBalance::where('sub_period_id', $subPeriod->id)->exists();
    
            if ($alreadyClosed) {
                throw new Exception('Sub periode sudah ditutup sebelumnya.');
            }
    
            // Cek sisa saldo dari coa yang ada di sub periode ini (via coa balance / saldo berjalan), jika masih memiliki sisa saldo maka masukkan ke closing balance
            $coaBalances = $subPeriod->coaBalances;

            foreach ($coaBalances as $coaBalance) {
                $balanceType = ChartOfAccount::find($coaBalance->chart_of_account_id)->normal_balance;

                if ($coaBalance->current_balance != 0) {
                    ClosingBalance::create([
                        'period_id' => $subPeriod->period_id,
                        'sub_period_id' => $subPeriod->id,
                        'chart_of_account_id' => $coaBalance->chart_of_account_id,
                        'created_by' => Auth::id(),
                        'balance_type' => $balanceType,
                        'amount' => $coaBalance->current_balance,
                    ]);
                }
            }
    
            // Mark the sub-period as closed
            $subPeriod->update([
                'is_closed' => true,
                'closed_at' => now(),
                'closed_by' => Auth::id(),
            ]);
    
            // activity log
            $this->logger->log(
                action: ActivityLogAction::CLOSED->value,
                module: "SUB_PERIOD",
                subject: $subPeriod,
                description: "Sub periode {$subPeriod->name} berhasil ditutup.",
                old: ['is_closed' => false],
                new: ['is_closed' => true],
                additionalData: [
                    'period_id' => $subPeriod->period_id,
                    'start_date' => $subPeriod->start_date,
                    'end_date' => $subPeriod->end_date,
                    'is_active' => $subPeriod->is_active,
                ]
            );
        });
    }

    /**
     * Validates that the sub-period's start and end dates fall within the parent period's date range. This method is used to ensure data integrity when creating or updating sub-periods.
     *
     * @param array $data
     * @throws Exception if the sub-period dates are outside the parent period's date range.
     * @throws ValidationException
     */
    private function validateSubPeriodDates(array $data, ?SubPeriod $subPeriod = null): void
    {
        $period = Period::findOrFail($data['period_id']);

        $subPeriodId = $subPeriod?->id;

        $subStartDate = Carbon::parse($data['start_date']);
        $subEndDate = Carbon::parse($data['end_date']);

        $periodStartDate = Carbon::parse($period->start_date);
        $periodEndDate = Carbon::parse($period->end_date);

        if ($subStartDate->lt($periodStartDate)) {
            throw new Exception(
                'Tanggal mulai sub periode tidak boleh sebelum periode utama.'
            );
        }

        if ($subEndDate->gt($periodEndDate)) {
            throw new Exception(
                'Tanggal selesai sub periode tidak boleh melebihi periode utama.'
            );
        }

        if (
            $subPeriod &&
            $subPeriod->end_date->isPast()
        ) {
            throw new Exception(
                'Sub periode sudah berakhir dan tidak dapat diubah.'
            );
        }

        $overlap = SubPeriod::query()
            ->where('period_id', $data['period_id'])
            ->when($subPeriodId, function ($query) use ($subPeriodId) {
                $query->where('id', '!=', $subPeriodId);
            })
            ->where(function ($query) use ($subStartDate, $subEndDate) {
                $query
                    ->whereBetween('start_date', [$subStartDate, $subEndDate])
                    ->orWhereBetween('end_date', [$subStartDate, $subEndDate])
                    ->orWhere(function ($q) use ($subStartDate, $subEndDate) {
                        $q->where('start_date', '<=', $subStartDate)
                            ->where('end_date', '>=', $subEndDate);
                    });
            })
            ->exists();

        if ($overlap) {
            throw new Exception(
                'Sub periode tidak dapat dibuat karena rentang tanggal bertabrakan dengan sub periode lain pada periode yang sama.'
            );
        }
    }
}
