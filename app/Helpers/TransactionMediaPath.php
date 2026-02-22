<?php

namespace App\Helpers;

use App\Models\Transaction;

class TransactionMediaPath
{
    /**
     * Generate base directory path for transaction receipt
     */
    public static function generate(Transaction $transaction): string
    {
        $type = strtolower($transaction->transaction_type->value);

        return sprintf(
            '%s/%s/%s',
            $transaction->period_id,
            $type,
            $transaction->created_by
        );
    }
}
