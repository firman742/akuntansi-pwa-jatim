<?php

namespace App\Helpers;

use App\Models\Transaction;

class TransactionNumberHelper
{
    /**
     * Generate unique transaction number
     *
     * Format:
     * TRX-{COA_CODE}-{PERIOD}-{SEQUENCE}
     * Example:
     * TRX-11100-202601-0001
     */
    public static function generate(
        string $coaCode,
        string $periodCode
    ): string {
        $prefix = "TRX-{$coaCode}-{$periodCode}-";

        $lastNumber = Transaction::query()
            ->where('transaction_number', 'like', $prefix . '%')
            ->orderByDesc('transaction_number')
            ->value('transaction_number');

        $sequence = 1;

        if ($lastNumber) {
            $lastSeq = (int) substr($lastNumber, -4);
            $sequence = $lastSeq + 1;
        }

        return $prefix . str_pad($sequence, 4, '0', STR_PAD_LEFT);
    }
}
