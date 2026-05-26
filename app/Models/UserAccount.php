<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

/**
 * Class UserAccount
 * @package App\Models
 *
 * @property string $id
 * @property string $user_id
 * @property string $coa_id
 *
 * @property User $user
 * @property ChartOfAccount $coa
 * @property UserAccountBalance[]|HasMany $balances
 */
class UserAccount extends Model
{
    use HasUuids;
    protected $table = 'user_accounts';
    protected $fillable = [
        'user_id',
        'coa_id',
    ];

    /**
     * Undocumented function
     *
     * @return BelongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }


    /*
     * Undocumented function
     *
     * @return BelongsTo
     */
    public function coa(): BelongsTo
    {
        return $this->belongsTo(ChartOfAccount::class, 'coa_id');
    }

    /*
     * Undocumented function
     *
     * @return HasMany
     */
    public function balances(): HasMany
    {
        return $this->hasMany(UserAccountBalance::class, 'user_account_id');
    }
}
