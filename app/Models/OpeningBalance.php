<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

/**
 * Class OpeningBalance
 * @package App\Models
 *
 * @property string $id
 * @property string $chart_of_account_id
 * @property string $period_id
 * @property string $sub_period_id
 * @property string $created_by
 * @property string $balance_type
 * @property float $amount
 * @property bool $is_correction
 * @property string|null $correction_reason
 *
 * @property ChartOfAccount $chartOfAccount
 * @property Period $period
 * @property SubPeriod $subPeriod
 * @property User $creator
 */
class OpeningBalance extends Model
{
    use HasUuids;

    protected $table = 'opening_balances';

    protected $fillable = [
        'chart_of_account_id',
        'period_id',
        'sub_period_id',
        'created_by',
        'balance_type',
        'amount',
        'is_correction',
        'correction_reason',
    ];

    protected $casts = [
        'is_correction' => 'boolean',
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

    /**
     * @return BelongsTo
     */
    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

}
