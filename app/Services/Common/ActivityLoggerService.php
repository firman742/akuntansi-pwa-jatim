<?php

namespace App\Services\Common;

use App\Models\ActivityLog;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class ActivityLoggerService
{
    public function log(
        string $action,
        string $module,
        ?Model $subject = null,
        ?string $description = null,
        array $old = [],
        array $new = [],
        array $additionalData = [],
        ?Request $request = null
    ): ActivityLog {
        $request = $request ?? request();

        return ActivityLog::create([
            'user_id' => Auth::id(),
            'action' => $action,
            'module' => $module,
            'subject_type' => $subject ? get_class($subject) : null,
            'subject_id' => $subject?->getKey(),
            'old_values' => $old,
            'new_values' => $new,
            'description' => $description,
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent(),
            'additional_data' => $additionalData,
        ]);
    }
}