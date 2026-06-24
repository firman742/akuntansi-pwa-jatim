<?php

namespace App\Services\Superadmin;

use App\Helpers\SettingHelper;
use App\Models\Configuration;
use App\Services\BaseService;
use Illuminate\Support\Facades\DB;

class ConfigurationService extends BaseService
{
    /**
     * Update the application configuration.
     *
     * @param  array  $data
     * @return void
     */
    public function update(array $data): void
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

        if (!empty($data['app_logo'])) {

            SettingHelper::updateMedia(
                'APP_LOGO',
                'configuration_app_logo',
                $data['app_logo']
            );
            
            $this->updateConfig(
                'APP_LOGO',
                SettingHelper::logo()
            );
        }

        if (isset($data['app_background_login'])) {

            SettingHelper::updateMedia(
                'APP_BACKGROUND_LOGIN',
                'configuration_app_background_login',
                $data['app_background_login']
            );

            $this->updateConfig(
                'APP_BACKGROUND_LOGIN',
                SettingHelper::loginBackground()
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
