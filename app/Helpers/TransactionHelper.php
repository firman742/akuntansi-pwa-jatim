<?php

namespace App\Helpers;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use App\Models\ChartOfAccount;

class TransactionHelper
{
    public static function formatTrxDesc(string $type, string $context): string
    {
        return "{$type} - {$context}";
    }

    public static function formatLineDesc(string $role, string $from, string $to): string
    {
        return "{$role} - {$from} → {$to}";
    }

    /**
     * Mengembalikan deskripsi input pengguna langsung.
     * Jika kosong, fallback ke Nama Akun / Deskripsi Parent.
     */
    public static function generateLineDescription(string|ChartOfAccount $coa, ?string $reference = null ): string
    {
        // 1. Jika ada deskripsi yang diinputkan pengguna, gunakan langsung
        $cleanRef = trim((string) $reference);
        if ($cleanRef !== '' && $cleanRef !== '-') {
            return $cleanRef;
        }

        // 2. Fallback: Ambil nama akun jika input dikosongkan
        $account = is_string($coa)
            ? ChartOfAccount::find($coa, ['name'])
            : $coa;

        return $account ? $account->name : 'Transaksi';
    }
}
