<?php

namespace App\Services\Bendahara;

use App\Enums\NormalBalanceEnum;
use App\Models\ChartOfAccount;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\OpeningBalance;
use App\Models\Period;
use App\Models\SubPeriod;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class OpeningBalanceService
{
    /**
     * Get data for the index page, including periods, sub-periods, and opening balances.
     *
     * @param  string|null  $periodId
     * @param  string|null  $subPeriodId
     * @return array
     */
    public function getIndexData(?string $periodId, ?string $subPeriodId): array
    {
        $periods = Period::where('is_closed', false)->get();

        $subPeriods = collect();

        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date')
                ->get();
        }

        $openingBalances = OpeningBalance::with([
            'chartOfAccount:id,name,code',
            'subPeriod:id,name,period_id,start_date',
            'subPeriod.period:id,is_closed'
        ])
            ->get()
            ->map(function ($item) {

                $hasTransaction = Journal::where(
                    'sub_period_id',
                    $item->sub_period_id
                )->exists();

                $hasFutureTransaction = Journal::whereHas(
                    'subPeriod',
                    fn($q) =>
                    $q->where(
                        'start_date',
                        '>',
                        $item->subPeriod->start_date
                    )
                )->exists();

                $periodClosed = $item->subPeriod?->period?->is_closed ?? false;

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
                    'has_future_transaction' => $hasFutureTransaction,
                    'period_closed' => $periodClosed,

                    'can_edit' => ! $hasTransaction
                        && ! $hasFutureTransaction
                        && ! $periodClosed,

                    'can_delete' => ! $hasTransaction
                        && ! $hasFutureTransaction
                        && ! $periodClosed,
                ];
            });

        return [
            'periods' => $periods,
            'subPeriods' => $subPeriods,
            'openingBalances' => $openingBalances,
        ];
    }

    /**
     * Get data for the create form, including active periods, sub-periods, and COA lists.
     *
     * @return array
     */
    public function getCreateData(): array
    {
        $periods = Period::where('is_closed', false)->get();
        $subPeriods = optional($periods->first())->subPeriods()->orderBy('start_date')->get();

        // just get coa debit
        $coaLists = ChartOfAccount::where('normal_balance', NormalBalanceEnum::DEBIT->value)->orderBy('code')->get();


        return compact('periods', 'coaLists', 'subPeriods');
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
            ]);

            // ================= 2. CREATE COA BALANCE (STATE SNAPSHOT) =================
            CoaBalance::create([
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

            return $openingBalance;
        });
    }

    /**
     * Update an existing opening balance.
     *
     * @param  string  $id
     * @param  array  $data
     * @return OpeningBalance
     * @throws Exception
     */
    public function update(string $id, array $data): OpeningBalance
    {
        return DB::transaction(function () use ($data, $id) {
            $openingBalance = OpeningBalance::findOrFail($id);
            $subPeriod = SubPeriod::with('period')->findOrFail($data['sub_period_id']);
            $accountId = $data['chart_of_account_id'];

            // ================= VALIDATIONS (tetap sama) =================
            $this->validateSubPeriodMutation($subPeriod, $accountId);

            $totalAmount = (float) $data['amount'] + (float) ($data['additional_amount'] ?? 0);

            if ($totalAmount <= 0) {
                throw new Exception('Total saldo harus lebih dari 0.');
            }

            // ================= UPDATE OPENING BALANCE =================
            $openingBalance->update([
                'chart_of_account_id' => $accountId,
                'period_id'           => $subPeriod->period_id,
                'sub_period_id'       => $subPeriod->id,
                'balance_type'        => $data['balance_type'],
                'amount'              => $totalAmount,
                'created_by'          => Auth::id(),
            ]);

            // ================= UPDATE COA BALANCE (STATE SNAPSHOT) =================
            CoaBalance::updateOrCreate(
                [
                    'chart_of_account_id' => $accountId,
                    'period_id'           => $subPeriod->period_id,
                    'sub_period_id'       => $subPeriod->id,
                ],
                [
                    // snapshot awal
                    'opening_balance'     => $totalAmount,
                    'debit_total'         => 0,
                    'credit_total'        => 0,
                    'current_balance'     => $totalAmount,
                    'last_transaction_at' => Carbon::now(),
                ]
            );

            return $openingBalance;
        });
    }


    public function delete(string $id): void
    {
        DB::transaction(function () use ($id) {
            $openingBalance = OpeningBalance::findOrFail($id);
            $subPeriod = SubPeriod::with('period')->findOrFail($openingBalance->sub_period_id);

            // Validasi tetap sama, pastikan sub periode masih bisa dimutasi
            $this->validateSubPeriodMutation($subPeriod, $openingBalance->chart_of_account_id);

            // Hapus opening balance
            $openingBalance->delete();

            // Hapus juga coa balance terkait
            CoaBalance::where([
                'chart_of_account_id' => $openingBalance->chart_of_account_id,
                'period_id'           => $openingBalance->period_id,
                'sub_period_id'       => $openingBalance->sub_period_id,
            ])->delete();
        });
    }

    // ================== PRIVATE METHODS ==================
    /**
     * Validasi untuk memastikan sub periode masih bisa dimutasi (create/update/delete opening balance).
     * Cek apakah periode sudah ditutup, apakah sudah ada transaksi di sub periode ini, dan apakah sudah ada transaksi di periode setelahnya.
     *
     * @param SubPeriod $subPeriod
     * @param string|null $accountId (opsional, hanya untuk update)
     * @throws Exception
     */
    private function validateSubPeriodMutation(SubPeriod $subPeriod, string $accountId): void
    {
        if ($subPeriod->period->is_closed) {
            throw new Exception('Periode sudah ditutup.');
        }

        if (
            Journal::where('sub_period_id', $subPeriod->id)
            ->exists()
        ) {
            throw new Exception(
                'Sudah ada transaksi pada sub periode ini.'
            );
        }

        if (OpeningBalance::where([
            'chart_of_account_id' => $accountId,
            'sub_period_id' => $subPeriod->id
        ])->exists()) {
            throw new Exception('Opening balance sudah ada.');
        }

        $futureJournalExists = Journal::whereHas(
            'subPeriod',
            fn($q) =>
            $q->where(
                'start_date',
                '>',
                $subPeriod->start_date
            )
        )->exists();

        if ($futureJournalExists) {
            throw new Exception(
                'Sudah ada transaksi pada periode setelahnya.'
            );
        }
    }
}
