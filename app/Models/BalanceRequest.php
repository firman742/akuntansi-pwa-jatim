<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * @property string $id
 * @property string $requester_id
 * @property string|null $approver_id
 * @property string $user_account_id
 * @property string $source_coa_id
 * @property string $period_id
 * @property string $sub_period_id
 * @property float $amount
 * @property string $status
 * @property string|null $purpose
 * @property string|null $note
 * @property Carbon|null $approved_at
 * @property string|null $approval_notes
 * @property Carbon|null $rejected_at
 * @property string|null $rejection_reason
 *
 * @property User $requester
 * @property User|null $approver
 * @property UserAccount $userAccount
 * @property CoaBalance $sourceCoa
 * @property Period $period
 * @property SubPeriod $subPeriod
 */
class BalanceRequest extends Model
{
    use HasUuids, SoftDeletes;

    protected $table = 'balance_requests';

    protected $fillable = [
        'requester_id',
        'approver_id',
        'user_account_id',
        'source_coa_id',
        'period_id',
        'sub_period_id',
        'amount',
        'status',
        'purpose',
        'note',
        'approved_at',
        'approval_notes',
        'rejected_at',
        'rejection_reason',
    ];

    protected $casts = [
        'amount' => 'float',
        'approved_at' => 'datetime',
        'rejected_at' => 'datetime',
    ];

    /**
     *
     * @return BelongsTo
     */
    public function requester(): BelongsTo
    {
        return $this->belongsTo(User::class, 'requester_id');
    }

    /**
     *
     * @return BelongsTo
     */
    public function approver(): BelongsTo
    {
        return $this->belongsTo(User::class, 'approver_id');
    }

    /**
     *
     * @return BelongsTo
     */
    public function userAccount(): BelongsTo
    {
        return $this->belongsTo(UserAccount::class, 'user_account_id');
    }

    /**
     *
     * @return BelongsTo
     */
    public function sourceCoa(): BelongsTo
    {
        return $this->belongsTo(CoaBalance::class, 'source_coa_id');
    }

    /**
     *
     * @return BelongsTo
     */
    public function period(): BelongsTo
    {
        return $this->belongsTo(Period::class, 'period_id');
    }

    /**
     *
     * @return BelongsTo
     */
    public function subPeriod(): BelongsTo
    {
        return $this->belongsTo(SubPeriod::class, 'sub_period_id');
    }
}
