<?php

namespace App\Enums;

enum ActivityLogAction: string
{
    case CREATED = 'created';
    case UPDATED = 'updated';
    case DELETED = 'deleted';
    case CLOSED = 'closed';
    case VIEWED = 'viewed';
    case RESTORED = 'restored';
    case FORCE_DELETED = 'force_deleted';
    case APPROVED = 'approved';
    case REJECT = 'reject';
    case ERROR = 'error';
    case SYNC = 'sync';

    /**
     * Label untuk UI
     */
    public function label(): string
    {
        return match ($this) {
            self::CREATED => 'Dibuat',
            self::UPDATED => 'Diperbarui',
            self::DELETED => 'Dihapus',
            self::CLOSED => 'Ditutup',
            self::VIEWED => 'Dilihat',
            self::RESTORED => 'Dipulihkan',
            self::FORCE_DELETED => 'Dihapus Permanen',
            self::APPROVED => 'Disetujui',
            self::REJECT => 'Ditolak',
            self::ERROR => 'error',
            self::SYNC => 'Sinkronisasi',
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