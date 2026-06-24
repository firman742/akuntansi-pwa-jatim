<?php

namespace App\Services;

use App\Models\Journal;
use App\Models\OpeningBalance;
use App\Models\SubPeriod;
use App\Services\Common\ActivityLoggerService;
use Exception;

class BaseService
{
    protected ActivityLoggerService $logger;

    public function __construct(ActivityLoggerService $logger)
    {
        $this->logger = $logger;
    }


    /**
     * Validasi untuk memastikan sub periode masih bisa dimutasi (create/update/delete opening balance).
     * Cek apakah periode sudah ditutup, apakah sudah ada transaksi di sub periode ini, dan apakah sudah ada transaksi di periode setelahnya.
     *
     * @param SubPeriod $subPeriod
     * @param string|null $accountId (opsional, hanya untuk update)
     * @throws Exception
     */
    public static function validateSubPeriodMutation(SubPeriod $subPeriod, string $accountId): void
    {
        if ($subPeriod->period->is_closed) {
            throw new Exception('Periode sudah ditutup.');
        }

        // Cek apakah sudah ada transaksi di sub periode ini untuk akun yang sama
        $journalExisting = Journal::where('sub_period_id', $subPeriod->id)
            ->whereHas(
                'details',
                fn($q) => $q->where('chart_of_account_id', $accountId)
            )
            ->exists();

        if ($journalExisting) {
            throw new Exception(
                'Sudah ada transaksi pada sub periode ini.'
            );
        }

        if (OpeningBalance::where([
            'chart_of_account_id' => $accountId,
            'sub_period_id' => $subPeriod->id
        ])->exists()) {
            throw new Exception('Saldo Awal Sudah Dibuat.');
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
