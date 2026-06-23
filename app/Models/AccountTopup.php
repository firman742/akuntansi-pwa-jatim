<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

/**
 * Class AccountTopup
 * @package App\Models
 *
 * @property string $id
 * @property string $chart_of_account_id
 * @property string $period_id
 * @property string $sub_period_id
 * @property string $created_by
 * @property float $amount
 * @property string|null $reason
 *
 * @property ChartOfAccount $chartOfAccount
 * @property Period $period
 * @property SubPeriod $subPeriod
 * @property User $creator
 * 
 */
class AccountTopup extends Model
{
    use HasUuids, HasFactory;

    protected $table = 'account_topups';

    protected $fillable = [
        'chart_of_account_id',
        'period_id',
        'sub_period_id',
        'created_by',
        'amount',
        'reason',
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
