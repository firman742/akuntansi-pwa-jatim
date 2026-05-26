<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * Class CoaBalance
 * @package App\Models
 *
 * @property string $id
 * @property string $chart_of_account_id
 * @property string $period_id
 * @property string $sub_period_id
 * @property float $opening_balance
 * @property float $debit_total
 * @property float $credit_total
 * @property float $current_balance
 * @property Carbon|null $last_transaction_at
 *
 * @property ChartOfAccount $chartOfAccount
 * @property Period $period
 * @property SubPeriod $subPeriod
 */
class CoaBalance extends Model
{
    use HasUuids, SoftDeletes;

    protected $table = 'coa_balances';

    protected $fillable = [
        'chart_of_account_id',
        'period_id',
        'sub_period_id',
        'opening_balance',
        'debit_total',
        'credit_total',
        'current_balance',
        'last_transaction_at',
    ];

    protected $casts = [
        'opening_balance' => 'float',
        'debit_total' => 'float',
        'credit_total' => 'float',
        'current_balance' => 'float',
        'last_transaction_at' => 'datetime',
    ];

    /**
     * Relationships
     * @return BelongsTo
     */
    public function chartOfAccount(): BelongsTo
    {
        return $this->belongsTo(ChartOfAccount::class, 'chart_of_account_id');
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
}
