<?php

namespace App\Services\Superadmin;

use App\Models\Configuration;
use App\Services\BaseService;
use Illuminate\Support\Facades\DB;

class ConfigurationService extends BaseService
{
    public function update(array $data): Configuration
    {
        DB::beginTransaction();
        $this->updateConfig(
            'APP_NAME',
            $data['app_name']
        );

        $this->updateConfig(
            'APP_DESCRIPTION',
            $data['app_description']
        );

        $this->updateConfig(
            'APP_TAGLINE',
            $data['app_tagline']
        );

        if (isset($data['app_logo'])) {

            $config = Configuration::where('key', 'APP_LOGO')->firstOrFail();

            $config->clearMediaCollection('configuration');
            $config
                ->addMediaFromRequest('app_logo')
                ->toMediaCollection('configuration_app_logo');

            $this->updateConfig(
                'APP_LOGO',
                $config->getFirstMediaUrl('configuration_app_logo')
            );
        }

        if (isset($data['app_background_login'])) {

            $config = Configuration::where('key', 'APP_BACKGROUND_LOGIN')->firstOrFail();
            $config->clearMediaCollection('configuration');
            $config
                ->addMediaFromRequest('app_background_login')
                ->toMediaCollection('configuration_app_background_login');

            $this->updateConfig(
                'APP_BACKGROUND_LOGIN',
                $config->getFirstMediaUrl('configuration_app_background_login')
            );
        }

        // ACTIVITY LOG
        $this->logger->log(
            action: 'update',
            module: 'configuration',
            subject: null,
            description: 'Configuration updated',
            new: $data,
            additionalData: [
                'app_logo' => $data['app_logo'] ?? null,
                'app_background_login' => $data['app_background_login'] ?? null,
            ]
        );
        DB::commit();
        return $config;
    }

    /**
     * Update a configuration value by key.
     *
     * @param  string  $key
     * @param  mixed  $value
     * @return void
     */
    private function updateConfig(string $key, mixed $value): void
    {
        Configuration::where(
            'key',
            $key
        )->update([
            'value' => $value
        ]);
    }
}
