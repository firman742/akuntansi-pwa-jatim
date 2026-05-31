<?php

namespace App\Services;

use App\Services\Common\ActivityLoggerService;

class BaseService
{
    protected ActivityLoggerService $logger;

    public function __construct(ActivityLoggerService $logger)
    {
        $this->logger = $logger;
    }
}