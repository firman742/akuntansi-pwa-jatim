<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

/**
 * Class Period
 * @package App\Models
 *
 * @property string $id
 * @property string $name
 * @property string|null $description
 * @property Carbon $start_date
 * @property Carbon $end_date
 *
 * @property-read OpeningBalance[]|null $opening_balances
 * @property-read Transaction[]|null $transactions
 * @property-read Journal[]|null $journals
 * @property-read SubPeriod[]|null $subPeriods
 * @property-read CoaBalance[]|null $coaBalances
 * @property-read BudgetAllocation[]|null $budgetAllocations
 * @property-read CoaRequest[]|null $coaRequests
 * @property-read AccountTopup[]|null $accountTopups
 */
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
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
    ];

    protected $appends = [
        'is_active',
    ];

    
    /**
     * Get the is_active attribute.
     * @return Attribute
     */
    protected function isActive(): Attribute
    {
        return Attribute::make(
            get: function () {
                if (!$this->start_date || !$this->end_date) {
                    return false;
                }
    
                return now()->between($this->start_date, $this->end_date);
            },
        );
    }

    /**
     * Scope a query to only include active periods.
     * @param Builder $query
     * @return Builder
     */
    public function scopeActive(Builder $query): Builder
    {
        return $query->where('start_date', '<=', now())
            ->where('end_date', '>=', now());
    }

    /**
     * Check if there is any active period.
     * @return bool
     */
    public static function hasActivePeriod(): bool
    {
        return self::active()->exists();
    }

    /**
     * Get the opening balances for the period.
     * @return HasMany
     */
    public function opening_balances(): HasMany
    {
        return $this->hasMany(OpeningBalance::class, 'period_id');
    }

    /**
     * Get the closing balances for the period.
     * @return HasMany
     */
    public function transactions(): HasMany
    {
        return $this->hasMany(Transaction::class, 'period_id');
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
     * Get the journals for the period.
     * @return HasMany
     */
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
     * Get the chart of account balances for the period.
     * @return HasMany
     */
    public function coaBalances(): HasMany
    {
        return $this->hasMany(CoaBalance::class, 'period_id');
    }

    /**
     * Get the budget allocations for the period.
     * @return HasMany
     */
    public function budgetAllocations(): HasMany
    {
        return $this->hasMany(BudgetAllocation::class, 'period_id');
    }

    /**
     * Get the coa requests for the period.
     * @return HasMany
     */
    public function coaRequests(): HasMany
    {
        return $this->hasMany(CoaRequest::class, 'period_id');
    }

    /**
     * Get the account topups for the period.
     * @return HasMany
     */
    public function accountTopups(): HasMany
    {
        return $this->hasMany(AccountTopup::class, 'period_id');
    }

    /**
     * Check if period can be edited.
     * @return bool
     */
    public function canBeEdited(): bool
    {
        return !$this->hasTransactions();
    }
}
