<?php

namespace App\Services\Bendahara;

use App\Enums\ActivityLogAction;
use App\Enums\NormalBalanceEnum;
use App\Models\BudgetAllocation;
use App\Models\ChartOfAccount;
use App\Models\CoaBalance;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\TransactionLine;
use App\Services\BaseService;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class OpeningBalanceService extends BaseService
{
    /**
     * Get data for the index page, including periods, sub-periods, and opening balances.
     *
     * @param  string|null  $periodId
     * @param  string|null  $subPeriodId
     * @return array
     */
    public function getIndexData(?string $periodId, ?string $subPeriodId, ?string $search = null): array
    {
        $periods = Period::all();

        $subPeriods = collect();

        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date')
                ->get();
        }
        $openingBalanceQuery = OpeningBalance::with([
            'chartOfAccount:id,name,code',
            'subPeriod:id,name,period_id,start_date,end_date,is_closed',
            'subPeriod.period:id,name,start_date,end_date',
        ]);

        // Filter & search
        if ($periodId) {
            $openingBalanceQuery->where('period_id', $periodId);
        }

        if ($subPeriodId) {
            $openingBalanceQuery->where('sub_period_id', $subPeriodId);
        }

        if ($search) {
            $openingBalanceQuery->whereHas('chartOfAccount', function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                    ->orWhere('code', 'like', "%{$search}%");
            });
        }

        $openingBalance = $openingBalanceQuery
            ->orderByDesc('created_at')
            ->get()
            ->map(function ($item) {

                $hasTransaction = TransactionLine::query()
                    ->where('chart_of_account_id', $item->chart_of_account_id)
                    ->whereHas('transaction', function ($q) use ($item) {
                        $q->where('period_id', $item->period_id)
                            ->where('sub_period_id', $item->sub_period_id);
                    })
                    ->exists();

                $hasAllocation = BudgetAllocation::query()
                    ->where('period_id', $item->period_id)
                    ->where('sub_period_id', $item->sub_period_id)
                    ->where(function ($q) use ($item) {

                        $q->where(
                            'from_chart_of_account_id',
                            $item->chart_of_account_id
                        )->orWhere(
                            'to_chart_of_account_id',
                            $item->chart_of_account_id
                        );
                    })
                    ->exists();

                $subPeriodExpired = $item->subPeriod?->end_date
                    ? Carbon::now()->gt(Carbon::parse($item->subPeriod->end_date))
                    : false;
                $subPeriodClosed = $item->subPeriod->is_closed ?? false;

                return [
                    'id' => $item->id,
                    'account_name' => $item->chartOfAccount->name,
                    'account_code' => $item->chartOfAccount->code,
                    'sub_period' => $item->subPeriod?->name,

                    'debit' => $item->balance_type === NormalBalanceEnum::DEBIT->value
                        ? $item->amount
                        : 0,

                    'credit' => $item->balance_type === NormalBalanceEnum::CREDIT->value
                        ? $item->amount
                        : 0,

                    'has_transaction' => $hasTransaction,
                    'has_allocation' => $hasAllocation,
                    'sub_period_closed' => $subPeriodClosed,
                    'sub_period_expired' => $subPeriodExpired,

                    'can_edit' => ! $hasTransaction
                        && ! $hasAllocation
                        && ! $subPeriodExpired
                        && ! $subPeriodClosed,

                    'can_delete' => ! $hasTransaction
                        && ! $hasAllocation
                        && ! $subPeriodExpired
                        && ! $subPeriodClosed,
                ];
            });

        return [
            'periods' => $periods,
            'subPeriods' => $subPeriods,
            'openingBalances' => $openingBalance,
        ];
    }

    /**
     * Get data for the create form, including active periods, sub-periods, and COA lists.
     *
     * @return array
     */
    public function getCreateData(): array
    {
        $periods = Period::all();
        $subPeriods = optional($periods->first())->subPeriods()->orderBy('start_date')->get();

        // just get coa debit
        $coaLists = ChartOfAccount::query()
            ->where('normal_balance', NormalBalanceEnum::DEBIT->value)
            // ->whereNotNull('parent_id')
            // ->doesntHave('children')
            ->orderBy('code')
            ->get();

        return compact('periods', 'coaLists', 'subPeriods');
    }

    /**
     * Get data for the edit form, including the specific opening balance, active periods, sub-periods, and COA lists.
     *
     * @param  string  $id
     * @return array
     */
    public function getEditData(string $id): array
    {
        $openingBalance = OpeningBalance::with([
            'chartOfAccount',
            'period',
            'subPeriod',
        ])->findOrFail($id);

        $coaBalance = CoaBalance::where([
            'chart_of_account_id' => $openingBalance->chart_of_account_id,
            'period_id'           => $openingBalance->period_id,
            'sub_period_id'       => $openingBalance->sub_period_id,
        ])->first();

        return compact('openingBalance', 'coaBalance');
    }

    /**
     * Create a new opening balance.
     *
     * @param  array  $data
     * @return OpeningBalance
     * @throws Exception
     */
    public function store(array $data): OpeningBalance
    {
        return DB::transaction(function () use ($data) {

            $subPeriod = SubPeriod::with('period')->findOrFail($data['sub_period_id']);
            $accountId = $data['chart_of_account_id'];

            // ================= VALIDATIONS (tetap sama) =================
            $this->validateSubPeriodMutation($subPeriod, $accountId);

            $totalAmount = (float) $data['amount'] + (float) ($data['additional_amount'] ?? 0);

            if ($totalAmount <= 0) {
                throw new Exception('Total saldo harus lebih dari 0.');
            }

            // ================= 1. CREATE OPENING BALANCE =================
            $openingBalance = OpeningBalance::create([
                'chart_of_account_id' => $accountId,
                'period_id'           => $subPeriod->period_id,
                'sub_period_id'       => $subPeriod->id,
                'balance_type'        => $data['balance_type'],
                'amount'              => $totalAmount,
                'created_by'          => Auth::id(),
                'is_correction'       => false,
            ]);

            // ================= 2. CREATE COA BALANCE (STATE SNAPSHOT) =================
            $coaBalance = CoaBalance::create([
                'chart_of_account_id' => $accountId,
                'period_id'           => $subPeriod->period_id,
                'sub_period_id'       => $subPeriod->id,

                // snapshot awal
                'opening_balance'     => $totalAmount,
                'debit_total'         => 0,
                'credit_total'        => 0,
                'current_balance'     => $totalAmount,

                'last_transaction_at' => Carbon::now(),
            ]);

            // ================= 3. ACTIFITY LOG =================
            $this->logger->log(
                action: ActivityLogAction::CREATED->value,
                module: "OPENING_BALANCE",
                subject: $openingBalance,
                description: "Membuat opening balance untuk akun {$openingBalance->chartOfAccount->name} ({$openingBalance->chartOfAccount->code}) pada sub periode {$openingBalance->subPeriod->name} dengan jumlah " . number_format($totalAmount, 2),
                old: [],
                new: $openingBalance->toArray(),
                additionalData: [
                    "coa_balance" => $coaBalance,
                ]
            );


            return $openingBalance;
        });
    }

    /**
     * Update opening balance.
     *
     * Hanya boleh mengubah nominal saldo dan alasan koreksi.
     * Tidak boleh mengubah COA, periode, sub periode, maupun balance type.
     *
     * @param string $id
     * @param array $data
     * @return OpeningBalance
     * @throws Exception
     */
    public function update(string $id, array $data): OpeningBalance
    {
        return DB::transaction(function () use ($id, $data) {

            $openingBalance = OpeningBalance::with([
                'chartOfAccount',
                'period',
                'subPeriod',
            ])->findOrFail($id);

            $oldOpeningBalance = $openingBalance->toArray();

            /*
            |--------------------------------------------------------------------------
            | Validasi Periode / Sub Periode
            |--------------------------------------------------------------------------
            */
            if ($openingBalance->subPeriod?->is_closed) {
                throw new Exception(
                    'Saldo awal tidak dapat diubah karena sub periode sudah ditutup.'
                );
            }

            /*
            |--------------------------------------------------------------------------
            | Ambil Snapshot COA Balance
            |--------------------------------------------------------------------------
            */
            $coaBalance = CoaBalance::where([
                'chart_of_account_id' => $openingBalance->chart_of_account_id,
                'period_id'           => $openingBalance->period_id,
                'sub_period_id'       => $openingBalance->sub_period_id,
            ])->first();

            if (! $coaBalance) {
                throw new Exception(
                    'Data saldo berjalan tidak ditemukan.'
                );
            }

            /*
            |--------------------------------------------------------------------------
            | Validasi Sudah Ada Transaksi
            |--------------------------------------------------------------------------
            */
            if (
                $coaBalance->debit_total > 0 ||
                $coaBalance->credit_total > 0
            ) {
                throw new Exception(
                    'Saldo awal tidak dapat dikoreksi karena akun sudah memiliki transaksi.'
                );
            }

            /*
            |--------------------------------------------------------------------------
            | Validasi Nominal Baru
            |--------------------------------------------------------------------------
            */
            $newAmount = (float) $data['amount'];

            if ($newAmount <= 0) {
                throw new Exception(
                    'Nominal saldo harus lebih dari 0.'
                );
            }

            /*
            |--------------------------------------------------------------------------
            | Update Opening Balance
            |--------------------------------------------------------------------------
            */

            $openingBalance->update([
                'amount'            => $newAmount,
                'is_correction'     => true,
                'correction_reason' => $data['correction_reason'],
                'created_by'        => Auth::id(),
            ]);

            /*
            |--------------------------------------------------------------------------
            | Sinkronisasi Snapshot COA Balance
            |--------------------------------------------------------------------------
            */
            $coaBalance->update([
                'opening_balance'     => $newAmount,
                'current_balance'     => $newAmount,
                'last_transaction_at' => now(),
            ]);

            /*
            |--------------------------------------------------------------------------
            | Refresh Data
            |--------------------------------------------------------------------------
            */
            $openingBalance->refresh();
            $coaBalance->refresh();

            /*
            |--------------------------------------------------------------------------
            | Activity Log
            |--------------------------------------------------------------------------
            */
            $this->logger->log(
                action: ActivityLogAction::UPDATED->value,
                module: 'OPENING_BALANCE',
                subject: $openingBalance,
                description: sprintf(
                    'Koreksi saldo awal akun %s (%s) dari %s menjadi %s',
                    $openingBalance->chartOfAccount->name,
                    $openingBalance->chartOfAccount->code,
                    number_format($oldOpeningBalance['amount'], 2),
                    number_format($newAmount, 2)
                ),
                old: $oldOpeningBalance,
                new: $openingBalance->toArray(),
                additionalData: [
                    'old_amount' => $oldOpeningBalance['amount'],
                    'new_amount' => $newAmount,
                    'correction_reason' => $data['correction_reason'],
                    'coa_balance' => $coaBalance->toArray(),
                ]
            );

            return $openingBalance;
        });
    }


    /**
     * Delete an opening balance.
     *
     * @param  string  $id
     * @return void
     * @throws Exception
     */
    public function delete(string $id): void
    {
        DB::transaction(function () use ($id) {
            $openingBalance = OpeningBalance::findOrFail($id);
            $subPeriod = SubPeriod::with('period')->findOrFail($openingBalance->sub_period_id);

            // Validasi tetap sama, pastikan sub periode masih bisa dimutasi
            $this->validateSubPeriodMutation($subPeriod, $openingBalance->chart_of_account_id);

            // ================= 1. HAPUS OPENING BALANCE =================
            $openingBalance->delete();

            // ================= 2. HAPUS COA BALANCE (STATE SNAPSHOT) =================
            CoaBalance::where([
                'chart_of_account_id' => $openingBalance->chart_of_account_id,
                'period_id'           => $openingBalance->period_id,
                'sub_period_id'       => $openingBalance->sub_period_id,
            ])->delete();

            // ================= 3. ACTIFITY LOG =================
            $this->logger->log(
                action: ActivityLogAction::DELETED->value,
                module: "OPENING_BALANCE",
                subject: $openingBalance,
                description: "Menghapus opening balance untuk akun {$openingBalance->chartOfAccount->name} ({$openingBalance->chartOfAccount->code}) pada sub periode {$openingBalance->subPeriod->name} dengan jumlah " . number_format($openingBalance->amount, 2),
                old: $openingBalance,
                new: [],
            );
        });
    }

    /**
     * Koreksi opening balance dengan menambahkan nominal tambahan.
     *
     * @param string $id
     * @param array $data
     * @return OpeningBalance
     * @throws Exception
     */
    public function correction(string $id, array $data): OpeningBalance
    {
        return DB::transaction(function () use ($id, $data) {
            $openingBalance = OpeningBalance::with([
                'chartOfAccount',
                'period',
                'subPeriod'
            ])->findOrFail($id);

            $oldOpeningBalance = $openingBalance->toArray();

            $additionalAmount = (float) $data['additional_amount'];

            if ($additionalAmount <= 0) {
                throw new Exception(
                    'Nominal tambahan harus lebih dari 0.'
                );
            }

            $newAmount = (float) $data['amount'] + $additionalAmount;

            if ($newAmount <= 0) {
                throw new Exception(
                    'Total saldo harus lebih dari 0.'
                );
            }

            // Update opening balance
            $openingBalance->update([
                'amount'     => $newAmount,
                'created_by' => Auth::id(),
            ]);

            // Activity Log
            $this->logger->log(
                action: ActivityLogAction::UPDATED->value,
                module: 'OPENING_BALANCE',
                subject: $openingBalance,
                description: sprintf(
                    'Mengoreksi saldo awal akun %s (%s) dengan tambahan %s, total menjadi %s',
                    $openingBalance->chartOfAccount->name,
                    $openingBalance->chartOfAccount->code,
                    number_format($additionalAmount, 2),
                    number_format($newAmount, 2)
                ),
                old: $oldOpeningBalance,
                new: $openingBalance->toArray(),
            );

            return $openingBalance->fresh();
        });
    }
}
