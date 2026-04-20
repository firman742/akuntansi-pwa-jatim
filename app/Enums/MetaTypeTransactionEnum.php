<?php

namespace App\Enums;

enum MetaTypeTransactionEnum: string
{
    case MAIN  = 'MAIN';
    case TAX = 'TAX';
    case INTEREST = 'INTEREST';

    /**
     * Label untuk UI
     */
    public function label(): string
    {
        return match ($this) {
            self::MAIN  => 'Utama',
            self::TAX => 'Pajak',
            self::INTEREST => 'Bunga',
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
