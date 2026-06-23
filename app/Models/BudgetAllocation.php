<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * Class BudgetAllocation
 * @package App\Models
 *
 * @property string $id
 * @property string $from_chart_of_account_id
 * @property string $to_chart_of_account_id
 * @property string $period_id
 * @property string $sub_period_id
 * @property string|null $created_by
 * @property float $amount
 * @property string|null $allocation_type
 * @property string|null $description
 *
 * @property ChartOfAccount $fromChartOfAccount
 * @property ChartOfAccount $toChartOfAccount
 * @property Period $period
 * @property SubPeriod $subPeriod
 * @property User|null $creator
 */
class BudgetAllocation extends Model
{
    use HasUuids, SoftDeletes, HasFactory;

    protected $table = 'budget_allocations';

    protected $fillable = [
        'from_chart_of_account_id',
        'to_chart_of_account_id',
        'period_id',
        'sub_period_id',
        'created_by',
        'amount',
        'allocation_type',
        'description',
    ];


    /** 
     * @return BelongsTo
     */
    public function fromChartOfAccount(): BelongsTo
    {
        return $this->belongsTo(ChartOfAccount::class, 'from_chart_of_account_id');
    }

    /**
     * @return BelongsTo
     */
    public function toChartOfAccount(): BelongsTo
    {
        return $this->belongsTo(ChartOfAccount::class, 'to_chart_of_account_id');
    }

    /**
     * @return BelongsTo
     */
    public function period(): BelongsTo
    {
        return $this->belongsTo(Period::class, 'period_id');
    }

    /**
     * @return BelongsTo
     */
    public function subPeriod(): BelongsTo
    {
        return $this->belongsTo(SubPeriod::class, 'sub_period_id');
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}
