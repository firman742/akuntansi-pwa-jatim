<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

/**
 * Class ClosingBalance
 * 
 * @property string $id
 * @property string|null $period_id
 * @property string $sub_period_id
 * @property string $chart_of_account_id
 * @property string|null $created_by
 * @property string $balance_type
 * @property float $amount
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 */
class ClosingBalance extends Model
{
    use HasUuids, HasFactory;

    protected $table = 'closing_balances';

    protected $fillable = [
        'period_id',
        'sub_period_id',
        'chart_of_account_id',
        'created_by',
        'balance_type',
        'amount',
    ];


    /**
     * Get the period that owns the closing balance.
     * 
     * @return BelongsTo
     */
    public function period(): BelongsTo
    {
        return $this->belongsTo(Period::class, 'period_id');
    }

    /**
     * Get the sub period that owns the closing balance.
     * 
     * @return BelongsTo
     */
    public function subPeriod(): BelongsTo
    {
        return $this->belongsTo(SubPeriod::class, 'sub_period_id');
    }

    /**
     * Get the chart of account that owns the closing balance.
     * 
     * @return BelongsTo
     */
    public function chartOfAccount(): BelongsTo
    {
        return $this->belongsTo(ChartOfAccount::class, 'chart_of_account_id');
    }

    /**
     * Get the user that created the closing balance.
     * 
     * @return BelongsTo
     */
    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }
    
}
