<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Period extends Model
{
    /** @use HasFactory<\Database\Factories\PeriodFactory> */
    use HasUuids, HasFactory;

    protected $table = 'periods';
    
    protected $fillable = [
        'name',
        'description',
        'is_closed',
        'closed_at',
    ];

    protected $casts = [
        'is_closed' => 'boolean',
        'closed_at' => 'datetime',
    ];

    /**
     * Get the user who closed the period.
     * @return BelongsTo
     * 
     */
    public function closedByUser(): BelongsTo
    {
        return $this->belongsTo(User::class, 'closed_by');
    }

    public function opening_balances(): HasMany
    {
        return $this->hasMany(OpeningBalance::class, 'period_id');
    }

    public function transactions(): HasMany
    {
        return $this->hasMany(Transaction::class, 'period_id');
    }

    public function journals(): HasMany
    {
        return $this->hasMany(Journal::class, 'period_id');
    }

    /**
     * Get the sub-periods for the period.
     * @return HasMany
     */
    public function subPeriods(): HasMany
    {
        return $this->hasMany(SubPeriod::class, 'period_id');
    }

     /**
     * Scope a query to only include active periods.
     *
     * @param \Illuminate\Database\Eloquent\Builder $query
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeActive(Builder $query): Builder
    {
        return $query
            ->where('is_closed', false)
            ->whereDate('start_date', '<=', now())
            ->whereDate('end_date', '>=', now());
    }
}
