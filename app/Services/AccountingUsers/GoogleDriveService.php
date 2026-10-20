<?php

namespace App\Services\AccountingUsers;

use Google\Client as GoogleClient;
use Illuminate\Support\Facades\Log;

class GoogleDriveService
{
    protected GoogleClient $client;

    public function __construct()
    {
        $this->client = new GoogleClient();
        $this->client->setClientId(config('filesystems.disks.google_receipt_transaction.clientId'));
        $this->client->setClientSecret(config('filesystems.disks.google_receipt_transaction.clientSecret'));
        $this->client->refreshToken(config('filesystems.disks.google_receipt_transaction.refreshToken'));

        Log::info('Test Google Drive Service');
    }


    public function getAccessToken()
    {
        // $token = $this->client->getAccessToken();

        // dd($token);
        $token = $this->client->fetchAccessTokenWithRefreshToken(config('filesystems.disks.google_receipt_transaction.refreshToken'));

        // dd($token);
        return $token['access_token'] ?? null;
    }
}
