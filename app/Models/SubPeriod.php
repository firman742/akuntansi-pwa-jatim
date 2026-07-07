<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
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
 * @property bool $is_closed
 * @property Carbon|null $closed_at
 * @property string|null $closed_by
 *
 * @property-read Period $period
 * @property-read User|null $closed_by_user
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
        'is_closed',
        'closed_at',
        'closed_by',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
        'is_closed' => 'boolean',
        'closed_at' => 'datetime',
    ];

    /**
     * Get the parent period of the sub-period.
     * @return BelongsTo
     */
    public function period(): BelongsTo
    {
        return $this->belongsTo(Period::class, 'period_id');
    }

    /**
     * Get the user who closed the sub-period.
     * @return BelongsTo
     */
    public function closed_by(): BelongsTo
    {
        return $this->belongsTo(User::class, 'closed_by');
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
     * Get all closing balances associated with the sub-period.
     * @return HasMany
     */
    public function closingBalances(): HasMany
    {
        return $this->hasMany(ClosingBalance::class, 'sub_period_id');
    }

    /**
     * Get all closing balances associated with the sub-period.
     * @return HasMany
     */
    public function coaBalances(): HasMany
    {
        return $this->hasMany(CoaBalance::class, 'sub_period_id');
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
