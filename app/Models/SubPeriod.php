<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

/**
 * Class SubPeriod
 * @package App\Models
 *
 * @property string $id
 * @property string $period_id
 * @property string $name
 * @property string|null $description
 * @property Carbon $start_date
 * @property Carbon $end_date
 * @property bool $is_active
 *
 * @property-read Period $period
 * @property-read Transaction[]|null $transactions
 * @property-read Journal[]|null $journals
 * @property-read CoaRequest[]|null $coaRequests
 */
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
     * @param Builder $query
     * @return Builder
     */
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    /**
     * Get all transactions associated with the sub-period.
     * @return HasMany
     */
    public function transactions()
    {
        return $this->hasMany(Transaction::class, 'sub_period_id');
    }

    /**
    * Get all journals associated with the sub-period.
    * @return HasMany
    */
    public function journals()
    {
        return $this->hasMany(Journal::class, 'sub_period_id');
    }

    /**
     * Get all coa requests associated with the sub-period.
     * @return HasMany
     */
    public function coaRequests(): HasMany
    {
        return $this->hasMany(CoaRequest::class, 'sub_period_id');
    }

    /**
     * Get all opening balances associated with the sub-period.
     * @return HasMany
     */
    public function openingBalances(): HasMany
    {
        return $this->hasMany(OpeningBalance::class, 'sub_period_id');
    }

    /**
     * Get all account topups associated with the sub-period.
     * @return HasMany
     */
    public function accountTopups(): HasMany
    {
        return $this->hasMany(AccountTopup::class, 'sub_period_id');
    }
}
