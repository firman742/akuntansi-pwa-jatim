<?php

namespace App\Services\Bendahara;

use App\Enums\NormalBalanceEnum;
use App\Models\AccountTopup;
use App\Models\ChartOfAccount;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Services\BaseService;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class TopUpBalanceService extends BaseService
{
    /**
     * @param array $data
     * @return AccountTopup
     * @throws Exception
     */
    public function store(array $data): AccountTopup
    {
        return DB::transaction(function () use ($data) {

            /**
             * =====================================================
             * VALIDATION
             * =====================================================
             */
            $coa = ChartOfAccount::query()
                ->findOrFail($data['chart_of_account_id']);

            $period = Period::query()
                ->findOrFail($data['period_id']);

            $subPeriod = SubPeriod::query()
                ->findOrFail($data['sub_period_id']);

            if (!$coa->is_active) {
                throw new Exception('Akun COA tidak aktif.');
            }

            if ($period->is_closed) {
                throw new Exception('Periode tidak aktif.');
            }

            if ($subPeriod->period_id !== $period->id) {
                throw new Exception(
                    'Sub periode tidak sesuai dengan periode yang dipilih.'
                );
            }

            if ($data['amount'] <= 0) {
                throw new Exception(
                    'Nominal topup harus lebih besar dari nol.'
                );
            }

            /**
             * =====================================================
             * CREATE ACCOUNT TOPUP
             * =====================================================
             */
            $accountTopup = AccountTopup::query()->create([
                'chart_of_account_id' => $coa->id,
                'period_id'           => $period->id,
                'sub_period_id'       => $subPeriod->id,
                'created_by'          => Auth::id(),
                'amount'              => $data['amount'],
                'reason'              => $data['reason'] ?? null,
            ]);

            /**
             * =====================================================
             * UPDATE COA BALANCE
             * =====================================================
             */
            $coaBalance = CoaBalance::query()->firstOrCreate(
                [
                    'chart_of_account_id' => $coa->id,
                    'period_id' => $period->id,
                ],
                [
                    'debit_total' => 0,
                    'credit_total' => 0,
                    'current_balance' => 0,
                ]
            );

            $amount = (float) $data['amount'];

            if ($coa->normal_balance === 'DEBIT') {

                $coaBalance->update([
                    'debit_total' => $coaBalance->debit_total + $amount,
                    'current_balance' => $coaBalance->current_balance + $amount,
                ]);
            } elseif ($coa->normal_balance === 'CREDIT') {

                $coaBalance->update([
                    'credit_total' => $coaBalance->credit_total + $amount,
                    'current_balance' => $coaBalance->current_balance + $amount,
                ]);
            }

            /**
             * =====================================================
             * CREATE JOURNAL ENTRY & JOURNAL DETAILS
             * =====================================================
             */
            $journal = Journal::create([
                'journal_number' => sprintf(
                    'TOPUP-%s-%s',
                    $period->id,
                    now()->format('YmdHis')
                ),
                'journal_date' => now(),
                'description' => 'Topup akun ' . $coa->name,
                'total_debit' => $amount,
                'total_credit' => $amount,
                'posted_by' => Auth::id(),
                'posted_at' => now(),
                'period_id' => $period->id,
                'sub_period_id' => $subPeriod->id,
                'transaction_id' => null,
            ]);

            return $accountTopup;
        });
    }


    /**
     * Delete an account topup and update the corresponding CoaBalance
     *
     * @param string $id
     * @return void
     * @throws \Exception
     */
    public function destroy(string $id): void
    {
        $accountTopup = AccountTopup::findOrFail($id);

        DB::transaction(function () use ($accountTopup) {

            $coaBalance = CoaBalance::where([
                'chart_of_account_id' => $accountTopup->chart_of_account_id,
                'period_id' => $accountTopup->period_id,
                'sub_period_id' => $accountTopup->sub_period_id,
            ])->first();

            if (!$coaBalance) {
                throw new \Exception('Coa balance not found.');
            }

            if ($accountTopup->chartOfAccount->normal_balance === NormalBalanceEnum::DEBIT->value) {
                $coaBalance->decrement('debit_total', $accountTopup->amount);
            } else {
                $coaBalance->decrement('credit_total', $accountTopup->amount);
            }

            $coaBalance->decrement('current_balance', $accountTopup->amount);

            $accountTopup->delete();
        });
    }
}
