<?php

namespace App\Services\Bendahara;

use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\UserAccount;
use App\Models\UserAccountBalance;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class UserAccountBalanceService
{
    /**
     * Get data for the index page, including periods, sub-periods, and user account balances.
     *
     * @param  string|null  $periodId
     * @param  string|null  $subPeriodId
     * @param  string|null  $search
     * @return array
     */
    public function getIndexData(?string $periodId, ?string $subPeriodId, ?string $search = null): array
    {
        $periods = Period::where('is_closed', false)->get();
        $subPeriods = collect();

        if ($periodId) {
            $subPeriods = SubPeriod::where('period_id', $periodId)
                ->orderBy('start_date')
                ->get();
        }

        $userAccountBalances = UserAccountBalance::with(['userAccount', 'coaBalance', 'subPeriod'])
            ->leftJoin('sub_periods', 'user_account_balances.sub_period_id', '=', 'sub_periods.id')
            ->when($periodId, function ($q) use ($periodId) {
                $q->where('user_account_balances.period_id', $periodId);
            })
            ->when($subPeriodId, function ($q) use ($subPeriodId) {
                $q->where('user_account_balances.sub_period_id', $subPeriodId);
            })
            ->when($search, function ($q) use ($search) {
                $q->whereHas('userAccount.user', function ($q) use ($search) {
                    $q->where('name', 'like', "%{$search}%");
                })->orWhereHas('coaBalance.chartOfAccount', function ($q) use ($search) {
                    $q->where('name', 'like', "%{$search}%")
                        ->orWhere('code', 'like', "%{$search}%");
                });
            })
            ->orderBy('sub_periods.start_date')
            ->orderBy('user_account_balances.created_at', 'desc')
            ->select('user_account_balances.*')
            ->get()
            ->map(function ($item) {
                return [
                    'id' => $item->id,
                    'user_account_name' => $item->userAccount->user->name,
                    'account_name' => $item->coaBalance->chartOfAccount->name,
                    'account_code' => $item->coaBalance->chartOfAccount->code,
                    'sub_period' => optional($item->subPeriod)->name,
                    'allocated_balance' => $item->allocated_balance,
                    'used_balance' => $item->used_balance,
                    'remaining_balance' => $item->remaining_balance,
                    'allocated_at' => $item->allocated_at,
                ];
            });


        return [
            'periods' => $periods,
            'subPeriods' => $subPeriods,
            'userAccountBalances' => $userAccountBalances,
        ];
    }

    /*
     * Get data for the create page, including available periods, COA balances, and user accounts.
     *
     * @return array
     */
    public function getCreateData(): array
    {
        $periods = Period::with('subPeriods')
            ->where('is_closed', false)
            ->orderByDesc('created_at')
            ->get();

        $coaBalances = CoaBalance::with('chartOfAccount')
            ->whereHas('chartOfAccount', function ($q) {
                $q->whereNotNull('parent_id');
            })->get();
        $userAccounts = UserAccount::orderBy('user_id')->get();

        return [
            'periods' => $periods,
            'coaBalances' => $coaBalances,
            'userAccounts' => $userAccounts,
        ];
    }


    /*
    * Store a new user account balance, update COA balance, and create journal entries.
    *
    * @param array $data
    * @throws Exception
    */
    public function store(array $data): void
    {
        DB::transaction(function () use ($data) {
            $coaBalance = CoaBalance::with('chartOfAccount')->findOrFail($data['coa_balance_id']);

            /* 
            |-------------------------------------------------------------------------- 
            | VALIDASI SALDO 
            |-------------------------------------------------------------------------- 
            */
            if ($coaBalance->current_balance < $data['allocated_balance']) {
                throw new Exception('Saldo akun tidak mencukupi.');
            }


            /* 
            |-------------------------------------------------------------------------- 
            | KURANGI SALDO COA 
            |-------------------------------------------------------------------------- 
            */
            $coaBalance->decrement('current_balance', $data['allocated_balance']);


            /* 
            |-------------------------------------------------------------------------- 
            | CREATE USER ACCOUNT BALANCE 
            |-------------------------------------------------------------------------- 
            */
            $userBalance = UserAccountBalance::create([
                'user_account_id' => $data['user_account_id'],
                'coa_balance_id' => $coaBalance->id,
                'period_id' => $data['period_id'],
                'sub_period_id' => $data['sub_period_id'],
                'allocated_by' => Auth::id(),
                'allocated_balance' => $data['allocated_balance'],
                'used_balance' => 0,
                'remaining_balance' => $data['allocated_balance'],
                'allocated_at' => now(),
            ]);


            /* 
            |-------------------------------------------------------------------------- 
            | CREATE JOURNAL 
            |-------------------------------------------------------------------------- 
            */
            $journal = Journal::create([
                'journal_number' => 'JRN-' . now()->format('YmdHis'),
                'journal_date' => now(),
                'description' => $data['description'] ?? 'Pembagian saldo ke pengguna',
                'total_debit' => $data['allocated_balance'],
                'total_credit' => $data['allocated_balance'],
                'posted_by' => Auth::id(),
                'posted_at' => now(),
                'period_id' => $data['period_id'],
                'sub_period_id' => $data['sub_period_id'],
            ]);


            /* 
            |-------------------------------------------------------------------------- 
            | JOURNAL DETAIL 
            |-------------------------------------------------------------------------- 
            */

            /* 
            | Debit = Beban / Saldo User 
            */
            JournalDetail::create([
                'journal_id' => $journal->id,
                'chart_of_account_id' => $coaBalance->chart_of_account_id,
                'debit' => $data['allocated_balance'],
                'credit' => 0,
                'description' => 'Distribusi saldo ke user',
            ]);
            /* | Credit = Kas / Saldo sumber */
            JournalDetail::create([
                'journal_id' => $journal->id,
                'chart_of_account_id' => $coaBalance->chart_of_account_id,
                'debit' => 0,
                'credit' => $data['allocated_balance'],
                'description' => 'Pengurangan saldo akun',
            ]);
        });
    }
}
