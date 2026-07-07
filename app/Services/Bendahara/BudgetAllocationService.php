<?php

namespace App\Services\Bendahara;

use App\Enums\ActivityLogAction;
use App\Enums\NormalBalanceEnum;
use App\Models\BudgetAllocation;
use App\Models\ChartOfAccount;
use App\Models\CoaBalance;
use App\Models\Journal;
use App\Models\JournalDetail;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Services\BaseService;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class BudgetAllocationService extends BaseService
{
    /**
     * Get data for the index page, including periods, sub-periods, and budget Allocation.
     *
     * @param  string|null  $periodId
     * @param  string|null  $subPeriodId
     * @param  string|null  $search
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

        $query = BudgetAllocation::with([
            'fromChartOfAccount',
            'toChartOfAccount',
            'subPeriod',
            'period',
        ]);

        /**
         * FILTER PERIOD
         */
        if ($periodId) {
            $query->where('period_id', $periodId);
        }

        /**
         * FILTER SUB PERIOD
         */
        if ($subPeriodId) {
            $query->where('sub_period_id', $subPeriodId);
        }

        $budgetAllocations = $query
            ->when($search, function ($q) use ($search) {
                $q->where(function ($query) use ($search) {
                    $query->whereHas('fromChartOfAccount', function ($q) use ($search) {
                        $q->where('name', 'like', "%{$search}%")
                            ->orWhere('code', 'like', "%{$search}%");
                    })
                    ->orWhereHas('toChartOfAccount', function ($q) use ($search) {
                        $q->where('name', 'like', "%{$search}%")
                            ->orWhere('code', 'like', "%{$search}%");
                    })
                    ->orWhere('description', 'like', "%{$search}%");
                });
            })
            ->latest()
            ->limit(20)
            ->get()
            ->map(function ($item) {
                return [
                    'id' => $item->id,
                    'period' => $item->period->name ?? '-',
                    'sub_period' => $item->subPeriod->name ?? '-',
                    'from_account' => $item->fromChartOfAccount->name ?? '-',
                    'from_code' => $item->fromChartOfAccount->code ?? '-',
                    'to_account' => $item->toChartOfAccount->name ?? '-',
                    'to_code' => $item->toChartOfAccount->code ?? '-',
                    'amount' => $item->amount,
                    'type' => $item->allocation_type,
                    'description' => $item->description,
                    'created_at' => optional($item->created_at)->format('d M Y H:i'),
                ];
            });

        return [
            'periods' => $periods,
            'subPeriods' => $subPeriods,
            'budgetAllocations' => $budgetAllocations,
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
        $coaDebits = ChartOfAccount::where('normal_balance', NormalBalanceEnum::DEBIT->value)
            ->orderBy('code')
            ->get();
            
        return [
            'periods' => $periods,
            'coaDebits' => $coaDebits,
        ];
    }

    /**
     * Create a new opening balance.
     *
     * @param  array  $data
     * @return BudgetAllocation
     * @throws Exception
     */
    public function store(array $data): BudgetAllocation
    {
        return DB::transaction(function () use ($data) {

            /**
             * 1. VALIDASI PERIODE AKTIF
             */
            $period = Period::find($data['period_id']);

            if (!$period || $period->is_closed) {
                throw new Exception('Periode tidak valid atau sudah ditutup.');
            }

            /**
             * 2. VALIDASI SUB PERIOD HARUS MILIK PERIOD
             */
            if (!empty($data['sub_period_id'])) {
                $subPeriod = SubPeriod::where('id', $data['sub_period_id'])
                    ->where('period_id', $data['period_id'])
                    ->first();

                if (!$subPeriod) {
                    throw new Exception('Sub periode tidak valid atau tidak terkait dengan periode yang dipilih.');
                }
            }

            /**
             * 3. VALIDASI COA EXISTS (double safety)
             */
            $fromCoa = ChartOfAccount::find($data['from_chart_of_account_id']);
            $toCoa = ChartOfAccount::find($data['to_chart_of_account_id']);

            if (!$fromCoa || !$toCoa) {
                throw new Exception('Chart of Account tidak valid.');
            }

            /**
             * 4. VALIDASI SALDO FROM COA (anti minus)
             */
            $fromBalance = CoaBalance::firstOrCreate(
                [
                    'chart_of_account_id' => $data['from_chart_of_account_id'],
                    'period_id' => $data['period_id'],
                    'sub_period_id' => $data['sub_period_id'] ?? null,
                ],
                [
                    'opening_balance' => 0,
                    'debit_total' => 0,
                    'credit_total' => 0,
                    'current_balance' => 0,
                    'last_transaction_at' => Carbon::now(),
                ]
            );

            if ($fromBalance->current_balance < $data['amount']) {
                throw new Exception('Saldo pada akun sumber tidak mencukupi untuk alokasi ini.');
            }

            /**
             * 5. CREATE BUDGET ALLOCATION
             */
            $allocation = BudgetAllocation::create([
                'from_chart_of_account_id' => $data['from_chart_of_account_id'],
                'to_chart_of_account_id' => $data['to_chart_of_account_id'],
                'period_id' => $data['period_id'],
                'sub_period_id' => $data['sub_period_id'] ?? null,
                'amount' => $data['amount'],
                'allocation_type' => $data['allocation_type'],
                'description' => $data['description'] ?? null,
                'created_by' => Auth::id(),
            ]);

            $amount = (float) $data['amount'];

            /**
             * 6. UPDATE FROM COA (keluar dana)
             */
            $fromBalance->credit_total += $amount;
            $fromBalance->current_balance -= $amount;
            $fromBalance->last_transaction_at = Carbon::now();
            $fromBalance->save();

            /**
             * 7. UPDATE TO COA (masuk dana)
             */
            $toBalance = CoaBalance::firstOrCreate(
                [
                    'chart_of_account_id' => $data['to_chart_of_account_id'],
                    'period_id' => $data['period_id'],
                    'sub_period_id' => $data['sub_period_id'] ?? null,
                ],
                [
                    'opening_balance' => 0,
                    'debit_total' => 0,
                    'credit_total' => 0,
                    'current_balance' => 0,
                    'last_transaction_at' => Carbon::now(),
                ]
            );

            $toBalance->debit_total += $amount;
            $toBalance->current_balance += $amount;
            $toBalance->last_transaction_at = Carbon::now();
            $toBalance->save();

            /**
             * 8. CREATE JOURNAL
             */
            $journal = Journal::create([
                'journal_number' => 'JRNL-' . now()->format('YmdHis') . '-' . strtoupper(Str::random(5)),
                'journal_date' => now(),
                'description' => $data['description']
                    ?? 'Distribusi saldo dari '
                    . $fromCoa->name
                    . ' ke '
                    . $toCoa->name,

                'total_debit' => $amount,
                'total_credit' => $amount,

                'posted_by' => Auth::id(),
                'posted_at' => now(),

                'period_id' => $data['period_id'],
                'sub_period_id' => $data['sub_period_id'] ?? null,

                // jika belum ada transaction module bisa null
                'transaction_id' => null,
            ]);

            /**
             * 9. JOURNAL DETAIL - DEBIT
             * akun tujuan menerima saldo
             */
            JournalDetail::create([
                'journal_id' => $journal->id,
                'chart_of_account_id' => $toCoa->id,
                'debit' => $amount,
                'credit' => 0,
                'description' => 'Debit alokasi dana',
            ]);

            /**
             * 10. JOURNAL DETAIL - CREDIT
             * akun sumber mengeluarkan saldo
             */
            JournalDetail::create([
                'journal_id' => $journal->id,
                'chart_of_account_id' => $fromCoa->id,
                'debit' => 0,
                'credit' => $amount,
                'description' => 'Credit alokasi dana',
            ]);

            /**
             * 11. ACTIVITY LOG
             * mencatat aktivitas distribusi saldo untuk audit trail
             */
            $this->logger->log(
                action: ActivityLogAction::CREATED->value,
                module: "BUDGET_ALLOCATION",
                subject: $allocation,
                description: "Distribusi saldo dari akun {$fromCoa->name} ke akun {$toCoa->name} sebesar Rp. {$amount} berhasil dibuat.",
                old: [],
                new: $allocation->toArray(),
                additionalData: [
                    'from_chart_of_account_id' => $fromCoa->id,
                    'to_chart_of_account_id' => $toCoa->id,
                    'period_id' => $data['period_id'],
                    'sub_period_id' => $data['sub_period_id'] ?? null,
                    'amount' => $amount,
                    'allocation_type' => $data['allocation_type'],
                    'description' => $data['description'] ?? null,
                    'journal_id' => $journal->id,
                ]
            );

            return $allocation;
        });
    }
}
