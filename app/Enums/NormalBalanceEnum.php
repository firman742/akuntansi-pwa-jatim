<?php

namespace App\Enums;

enum NormalBalanceEnum: string
{
    case DEBIT  = 'DEBIT';
    case CREDIT = 'CREDIT';

    /**
     * Label untuk UI
     */
    public function label(): string
    {
        return match ($this) {
            self::DEBIT  => 'DEBIT',
            self::CREDIT => 'CREDIT',
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
