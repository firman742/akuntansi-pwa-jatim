<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * Class UserAccountBalance
 * @package App\Models
 *
 * @property string $id
 * @property string $user_account_id
 * @property string $coa_balance_id
 * @property string $sub_period_id
 * @property string $allocated_by
 * @property float $allocated_balance
 * @property float $income_balance
 * @property float $used_balance
 * @property float $remaining_balance
 * @property Carbon|null $allocated_at
 *
 * @property UserAccount $userAccount
 * @property CoaBalance $coaBalance
 * @property SubPeriod $subPeriod
 * @property User $allocatedBy
 */
class UserAccountBalance extends Model
{
    use HasUuids, SoftDeletes, HasFactory;

    protected $table = "user_account_balances";

    protected $fillable = [
        "user_account_id",
        "coa_balance_id",
        "period_id",
        "sub_period_id",
        "allocated_by",
        "allocated_balance",
        "income_balance",
        "used_balance",
        "remaining_balance",
        "allocated_at",
    ];

    /*
    * @return BelongsTo
    */
    public function userAccount(): BelongsTo
    {
        return $this->belongsTo(UserAccount::class, 'user_account_id');
    }

    /*
    * @return BelongsTo
    */
    public function coaBalance(): BelongsTo
    {
        return $this->belongsTo(CoaBalance::class, 'coa_balance_id');
    }

    /*
    * @return BelongsTo
    */
    public function period(): BelongsTo
    {
        return $this->belongsTo(Period::class, 'period_id');
    }

    /*
    * @return BelongsTo
    */
    public function subPeriod(): BelongsTo
    {
        return $this->belongsTo(SubPeriod::class, 'sub_period_id');
    }

    /*
    * @return BelongsTo
    */
    public function allocatedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'allocated_by');
    }
}
