<?php

namespace App\Enums;

enum TransactionStatus: string
{
    case DRAFT = 'DRAFT';
    case POSTED = 'POSTED';
    case REVERSED = 'REVERSED';

    /**
     * Label untuk UI
     */
    public function label(): string
    {
        return match ($this) {
            self::DRAFT => 'Draft',
            self::POSTED => 'Diposting',
            self::REVERSED => 'Dibatalkan',
        };
    }

    /**
     * Class CSS Badge untuk UI
     */
    public function badgeClass(): string
    {
        return match ($this) {
            self::DRAFT => 'bg-amber-50 text-amber-700 border-amber-200 dark:bg-amber-500/10 dark:text-amber-400 dark:border-amber-500/20',
            self::POSTED => 'bg-emerald-50 text-emerald-700 border-emerald-200 dark:bg-emerald-500/10 dark:text-emerald-400 dark:border-emerald-500/20',
            self::REVERSED => 'bg-rose-50 text-rose-700 border-rose-200 dark:bg-rose-500/10 dark:text-rose-400 dark:border-rose-500/20',
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
