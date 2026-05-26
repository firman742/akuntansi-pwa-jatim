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

        $openingBalances = OpeningBalance::with(['chartOfAccount', 'subPeriod'])
            ->leftJoin('sub_periods', 'opening_balances.sub_period_id', '=', 'sub_periods.id')

            ->when($periodId, function ($q) use ($periodId) {
                $q->where('opening_balances.period_id', $periodId);
            })

            ->when($subPeriodId, function ($q) use ($subPeriodId) {
                $q->where('opening_balances.sub_period_id', $subPeriodId);
            })

            ->orderBy('sub_periods.start_date')
            ->orderBy('opening_balances.created_at', 'desc')

            ->select('opening_balances.*')
            ->get()
            ->map(function ($item) {
                return [
                    'id' => $item->id,
                    'account_name' => $item->chartOfAccount->name,
                    'account_code' => $item->chartOfAccount->code,
                    'sub_period' => optional($item->subPeriod)->name,
                    'debit' => $item->balance_type === NormalBalanceEnum::DEBIT->value ? $item->amount : 0,
                    'credit' => $item->balance_type === NormalBalanceEnum::CREDIT->value ? $item->amount : 0,
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
            if ($subPeriod->period->is_closed) {
                throw new Exception('Tidak dapat reset saldo karena periode sudah ditutup.');
            }

            if (Journal::where('sub_period_id', $subPeriod->id)->exists()) {
                throw new Exception('Tidak dapat reset saldo karena sudah ada transaksi pada sub periode ini.');
            }

            if (OpeningBalance::where([
                'chart_of_account_id' => $accountId,
                'sub_period_id' => $subPeriod->id
            ])->exists()) {
                throw new Exception('Opening balance sudah ada.');
            }

            $futureJournalExists = Journal::whereHas('subPeriod', function ($q) use ($subPeriod) {
                $q->where('start_date', '>', $subPeriod->start_date);
            })->exists();

            if ($futureJournalExists) {
                throw new Exception('Sudah ada transaksi pada periode setelahnya.');
            }

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
}
