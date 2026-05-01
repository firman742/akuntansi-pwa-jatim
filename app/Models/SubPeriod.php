<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubPeriod extends Model
{
    use HasUuids, HasFactory;

    protected $table = 'sub_periods';

    protected $fillable = [
        'period_id',
        'name',
        'description',
        'start_date',
        'end_date',
        'is_active',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
        'is_active' => 'boolean',
    ];

    /**
     * Get the parent period of the sub-period.
     */
    public function period()
    {
        return $this->belongsTo(Period::class, 'period_id');
    }

    /**
     * Scope a query to only include active sub-periods.
     *
     * @param \Illuminate\Database\Eloquent\Builder $query
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    /**
     * Get all transactions associated with the sub-period.
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function transactions()
    {
        return $this->hasMany(Transaction::class, 'sub_period_id');
    }

    /**
    * Get all journals associated with the sub-period.
    * @return \Illuminate\Database\Eloquent\Relations\HasMany
    */
    public function journals()
    {
        return $this->hasMany(Journal::class, 'sub_period_id');
    }
}
