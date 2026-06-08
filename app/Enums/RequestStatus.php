<?php

namespace App\Enums;

enum RequestStatus: string
{
    case PENDING = 'pending';
    case APPROVED = 'approved';
    case REJECTED = 'rejected';
    case CANCELLED = 'canceled';

    /**
     * Label untuk UI
     */
    public function label(): string
    {
        return match ($this) {
            self::PENDING => 'Menunggu',
            self::APPROVED => 'Disetujui',
            self::REJECTED => 'Ditolak',
            self::CANCELLED => 'Dibatalkan',
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
