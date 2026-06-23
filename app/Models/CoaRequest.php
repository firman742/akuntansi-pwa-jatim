<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * @property string $id
 * @property string $requester_id
 * @property string|null $approver_id
 * @property string|null $parent_coa_id
 * @property string $account_type_id
 * @property string|null $sub_period_id
 * @property string $proposed_name
 * @property string $proposed_code
 * @property string $normal_balance
 * @property string $status
 * @property string|null $description
 * @property Carbon|null $approved_at
 * @property string|null $approval_notes
 * @property Carbon|null $rejected_at
 * @property string|null $rejection_reason
 *
 * @property-read User $requester
 * @property-read User|null $approver
 * @property-read ChartOfAccount|null $parentCoa
 * @property-read AccountType $accountType
 * @property-read SubPeriod|null $subPeriod
 */
class CoaRequest extends Model
{
    use HasUuids, SoftDeletes, HasFactory;

    protected $table = 'coa_requests';

    protected $fillable = [
        'requester_id',
        'approver_id',
        'parent_coa_id',
        'account_type_id',
        'sub_period_id',
        'proposed_name',
        'proposed_code',
        'normal_balance',
        'status',
        'description',
        'approved_at',
        'approval_notes',
        'rejected_at',
        'rejection_reason'
    ];

    protected $casts = [
        'status' => 'string',
        'normal_balance' => 'string',
        'approved_at' => 'datetime',
        'rejected_at' => 'datetime',
    ];

    /**
     * @return BelongsTo
     */
    public function requester(): BelongsTo
    {
        return $this->belongsTo(User::class, 'requester_id');
    }

    /**
     * @return BelongsTo
     */
    public function approver(): BelongsTo
    {
        return $this->belongsTo(User::class, 'approver_id');
    }

    /**
     * @return BelongsTo
     */
    public function parentCoa(): BelongsTo
    {
        return $this->belongsTo(ChartOfAccount::class, 'parent_coa_id');
    }

    /**
     * @return BelongsTo
     */
    public function accountType(): BelongsTo
    {
        return $this->belongsTo(AccountType::class, 'account_type_id');
    }

    /**
     * @return BelongsTo
     */
    public function subPeriod(): BelongsTo
    {
        return $this->belongsTo(SubPeriod::class, 'sub_period_id');
    }
}
