<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;

/**
 * @property string $id
 * @property string $type
 * @property string $key
 * @property string|null $value
 * @property string|null $description
 * @property bool $is_active
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 */
class Configuration extends Model implements HasMedia
{
    use HasUuids, InteractsWithMedia, HasFactory;

    protected $table = 'configurations';

    protected $fillable = [
        'type',
        'key',
        'value',
        'description',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];


    public function registerMediaCollections(): void
    {
        $this->addMediaCollection('configuration')
            ->singleFile();
    }
}
