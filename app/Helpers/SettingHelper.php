<?php

namespace App\Helpers;

use App\Models\Configuration;

class SettingHelper
{
    protected static ?array $settings = null;

    protected static function load(): void
    {
        if (self::$settings === null) {
            self::$settings = Configuration::query()
                ->pluck('value', 'key')
                ->toArray();
        }
    }

    public static function get(
        string $key,
        mixed $default = null
    ): mixed {
        self::load();

        return self::$settings[$key] ?? $default;
    }

    public static function appName(): string
    {
        return self::get(
            'APP_NAME',
            config('app.name')
        );
    }

    public static function appDescription(): ?string
    {
        return self::get('APP_DESCRIPTION');
    }

    public static function appTagline(): ?string
    {
        return self::get('APP_TAGLINE');
    }

    public static function logo(): ?string
    {
        $configuration = Configuration::query()
            ->where('key', 'APP_LOGO')
            ->first();

        return $configuration?->getFirstMediaUrl('configuration');
    }

    public static function loginBackground(): ?string
    {
        $configuration = Configuration::query()
            ->where('key', 'APP_BACKGROUND_LOGIN')
            ->first();

        return $configuration?->getFirstMediaUrl('configuration');
    }
}