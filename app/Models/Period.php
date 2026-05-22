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
        'start_date',
        'end_date',
        'is_closed',
        'closed_at',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
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
            ->where('is_closed', false);
    }

    /**
     * Check if period has transactions.
     * @return bool
     */
    public function hasTransactions(): bool
    {
        return $this->transactions()->exists();
    }

    /**
     * Check if period can be edited.
     * @return bool
     */
    public function canBeEdited(): bool
    {
        return !$this->hasTransactions();
    }

    /**
     * Check if period can be closed.
     * @return bool
     */
    public function canBeClosed(): bool
    {
        return !$this->hasTransactions()
            && now()->greaterThan($this->end_date);
    }
}
