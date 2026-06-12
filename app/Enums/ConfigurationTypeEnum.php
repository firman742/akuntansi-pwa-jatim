<?php

namespace App\Enums;

enum ConfigurationTypeEnum: string
{
    case STRING = 'string';
    case INTEGER = 'integer';
    case BOOLEAN = 'boolean';
    case ARRAY = 'array';
    case JSON = 'json';
    case IMAGE = 'image';

    /**
     * Label untuk UI
     */
    public function label(): string
    {
        return match ($this) {
            self::STRING => 'String',
            self::INTEGER => 'Integer',
            self::BOOLEAN => 'Boolean',
            self::ARRAY => 'Array',
            self::JSON => 'JSON',
            self::IMAGE => 'Image',
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