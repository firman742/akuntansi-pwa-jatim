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
     * @param  string|null  $search
     * @return array
     */
    public function getIndexData(?string $periodId, ?string $subPeriodId, ?string $search = null): array
    {
        $periods = Period::all();

        // ---------------------------------------------------------------------
        // 1. Set Default: Jika sub_period_id & period_id kosong, ambil Sub Periode terbaru
        // ---------------------------------------------------------------------
        if (! $subPeriodId && ! $periodId) {
            $latestSubPeriod = SubPeriod::orderBy('start_date', 'desc')->first();
            if ($latestSubPeriod) {
                $subPeriodId = $latestSubPeriod->id;
                $periodId = $latestSubPeriod->period_id;
            }
        } elseif ($periodId && ! $subPeriodId) {
            $latestSubPeriod = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date', 'desc')
                ->first();
            if ($latestSubPeriod) {
                $subPeriodId = $latestSubPeriod->id;
            }
        }

        $subPeriods = collect();
        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date')
                ->get();
        }

        // ---------------------------------------------------------------------
        // 2. Ambil Seluruh Chart of Account (COA) Aktif
        // ---------------------------------------------------------------------
        $coaQuery = ChartOfAccount::where('is_active', true)->orderBy('code', 'asc');

        if ($search) {
            $coaQuery->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                    ->orWhere('code', 'like', "%{$search}%");
            });
        }

        $allCoas = $coaQuery->get();

        // ---------------------------------------------------------------------
        // 3. Ambil data OpeningBalance pada Sub Periode / Periode terpilih
        // ---------------------------------------------------------------------
        $existingOpeningBalances = collect();
        if ($subPeriodId || $periodId) {
            $obQuery = OpeningBalance::with([
                'subPeriod:id,name,period_id,start_date,end_date,is_closed',
            ]);

            if ($subPeriodId) {
                $obQuery->where('sub_period_id', $subPeriodId);
            } elseif ($periodId) {
                $obQuery->where('period_id', $periodId);
            }

            $existingOpeningBalances = $obQuery->get()->keyBy('chart_of_account_id');
        }

        // Context status sub periode saat ini untuk akumulasi status
        $currentSubPeriod = $subPeriodId ? SubPeriod::find($subPeriodId) : null;
        $defaultSubPeriodExpired = $currentSubPeriod?->end_date
            ? Carbon::now()->gt(Carbon::parse($currentSubPeriod->end_date))
            : false;
        $defaultSubPeriodClosed = $currentSubPeriod?->is_closed ?? false;

        // ---------------------------------------------------------------------
        // 4. Petakan seluruh COA dengan data OpeningBalance jika ada
        // ---------------------------------------------------------------------
        $openingBalanceData = $allCoas->map(function ($coa) use (
            $existingOpeningBalances,
            $defaultSubPeriodExpired,
            $defaultSubPeriodClosed
        ) {
            /** @var OpeningBalance|null $item */
            $item = $existingOpeningBalances->get($coa->id);

            if ($item) {
                $hasTransaction = TransactionLine::query()
                    ->where('chart_of_account_id', $coa->id)
                    ->whereHas('transaction', function ($q) use ($item) {
                        $q->where('period_id', $item->period_id)
                            ->where('sub_period_id', $item->sub_period_id);
                    })
                    ->exists();

                $hasAllocation = BudgetAllocation::query()
                    ->where('period_id', $item->period_id)
                    ->where('sub_period_id', $item->sub_period_id)
                    ->where(function ($q) use ($coa) {
                        $q->where('from_chart_of_account_id', $coa->id)
                            ->orWhere('to_chart_of_account_id', $coa->id);
                    })
                    ->exists();

                $subPeriodExpired = $item->subPeriod?->end_date
                    ? Carbon::now()->gt(Carbon::parse($item->subPeriod->end_date))
                    : $defaultSubPeriodExpired;
                $subPeriodClosed = $item->subPeriod->is_closed ?? $defaultSubPeriodClosed;

                $canEdit = ! $hasTransaction
                    && ! $hasAllocation
                    && ! $subPeriodExpired
                    && ! $subPeriodClosed;

                return [
                    'id' => $item->id,
                    'chart_of_account_id' => $coa->id,
                    'account_name' => $coa->name,
                    'account_code' => $coa->code,
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

                    'can_edit' => $canEdit,
                    'can_delete' => $canEdit,
                ];
            }

            // COA yang belum memiliki saldo awal
            return [
                'id' => null,
                'chart_of_account_id' => $coa->id,
                'account_name' => $coa->name,
                'account_code' => $coa->code,
                'sub_period' => null,
                'debit' => 0,
                'credit' => 0,
                'has_transaction' => false,
                'has_allocation' => false,
                'sub_period_closed' => $defaultSubPeriodClosed,
                'sub_period_expired' => $defaultSubPeriodExpired,
                'can_edit' => false,
                'can_delete' => false,
            ];
        });

        return [
            'periods' => $periods,
            'subPeriods' => $subPeriods,
            'openingBalances' => $openingBalanceData,
            'periodId' => $periodId,
            'subPeriodId' => $subPeriodId,
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

        // Ambil semua COA, urutkan berdasarkan kode
        $coaLists = ChartOfAccount::query()
            ->select('id', 'code', 'name', 'normal_balance')
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
