<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphTo;

/**
 * App\Models\ActivityLog
 *
 * @property string $id
 * @property string|null $user_id
 * @property string $action
 * @property string $module
 * @property string|null $description
 * @property string|null $subject_type
 * @property string|null $subject_id
 * @property array|null $old_values
 * @property array|null $new_values
 * @property string|null $ip_address
 * @property string|null $user_agent
 * @property array|null $additional_data
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * @property-read User|null $user
 * @property-read Model|null $subject
 * @method static Builder|ActivityLog newModelQuery()
 * @method static Builder|ActivityLog newQuery()
 * @method static Builder|ActivityLog query()
 * @method static Builder|ActivityLog whereAction($value)
 * @method static Builder|ActivityLog whereAdditionalData($value)
 * @method static Builder|ActivityLog whereCreatedAt($value)
 * @method static Builder|ActivityLog whereDescription($value)
 * @method static Builder|ActivityLog whereId($value)
 * @method static Builder|ActivityLog whereIpAddress($value)
 * @method static Builder|ActivityLog whereModelId($value)
 * @method static Builder|ActivityLog whereModelType($value)
 * @method static Builder|ActivityLog whereModule($value)
 * @method static Builder|ActivityLog whereNewValues($value)
 * @method static Builder|ActivityLog whereOldValues($value)
 * @method static Builder|ActivityLog whereUserAgent($value)
 * @method static Builder|ActivityLog whereUserId($value)
 */
class ActivityLog extends Model
{
    use HasUuids;

    protected $table = 'activity_logs';

    protected $fillable = [
        'user_id',
        'action',
        'module',
        'description',
        'subject_type',
        'subject_id',
        'old_values',
        'new_values',
        'ip_address',
        'user_agent',
        'additional_data',
    ];

    protected $casts = [
        'old_values' => 'array',
        'new_values' => 'array',
        'additional_data' => 'array',
    ];


    /**
     * Get the user that performed the action.
     * 
     * @return BelongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    /**
     * Get the model that was affected by the action.
     * 
     * @return MorphTo
     */
    public function subject(): MorphTo
    {
        return $this->morphTo(null, 'subject_type', 'subject_id');
    }
}
