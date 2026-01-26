<?php

namespace App\Enums;

enum TransactionType: string
{
    case INCOME  = 'INCOME';
    case EXPENSE = 'EXPENSE';

    /**
     * Label untuk UI
     */
    public function label(): string
    {
        return match ($this) {
            self::INCOME  => 'Penerimaan',
            self::EXPENSE => 'Pengeluaran',
        };
    }
    
    public static function values(): array
    {
        return array_map(
            fn (self $case) => $case->value,
            self::cases()
        );
    }
}
