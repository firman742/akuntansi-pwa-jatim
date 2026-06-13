<?php

namespace App\Models;

use App\Enums\NormalBalanceEnum;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;

/**
 * @property string $id
 * @property string $name
 * @property string $no_telp
 * @property string $address
 * @property string $email
 * @property string $password
 * @property bool $is_superadmin
 *
 * @property-read UserAccount[]|null $user_accounts
 * @property-read ChartOfAccount[]|null $coas
 * @property-read ChartOfAccount[]|null $debitCoas
 * @property-read ChartOfAccount[]|null $creditCoas
 * @property-read Transaction[]|null $transactions
 * @property-read Period[]|null $periods
 * @property-read OpeningBalance[]|null $account_balances
 * @property-read CoaRequest[]|null $coa_requests
 * @property-read CoaRequest[]|null $approved_coa_requests
 */
class User extends Authenticatable
{
    use HasUuids, HasFactory, HasRoles, Notifiable;

    protected $table = 'users';
    protected $keyType = 'string';   // ⬅️ WAJIB
    public $incrementing = false;    // ⬅️ WAJIB
    protected string $activityModule = 'User';


    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'no_telp',
        'address',
        'email',
        'password',
        'is_superadmin',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
            'is_superadmin' => 'boolean',
        ];
    }

    /**
     * @return HasMany
     */
    public function user_accounts(): HasMany
    {
        return $this->hasMany(UserAccount::class, 'user_id');
    }

    /**
     * @return BelongsToMany
     */
    public function coas(): BelongsToMany
    {
        return $this->belongsToMany(ChartOfAccount::class, 'user_accounts', 'user_id', 'coa_id');
    }

    /**
     * @return BelongsToMany
     */
    public function debitCoas(): BelongsToMany
    {
        return $this->belongsToMany(
            ChartOfAccount::class,
            'user_accounts',
            'user_id',
            'coa_id'
        )->where('chart_of_accounts.normal_balance', NormalBalanceEnum::DEBIT->value);
    }

    /**
     * @return BelongsToMany
     */
    public function creditCoas(): BelongsToMany
    {
        return $this->belongsToMany(
            ChartOfAccount::class,
            'user_accounts',
            'user_id',
            'coa_id'
        )->where('chart_of_accounts.normal_balance', NormalBalanceEnum::CREDIT->value);
    }

    /**
     * @return HasMany
     */
    public function transactions(): HasMany
    {
        return $this->hasMany(Transaction::class, 'created_by');
    }

    /**
     * @return HasMany
     */
    public function periods(): HasMany
    {
        return $this->hasMany(Period::class, 'created_by');
    }

    /**
     * @return HasMany
     */
    public function account_balances(): HasMany
    {
        return $this->hasMany(OpeningBalance::class, 'created_by');
    }

    /**
     * @return HasMany
     */
    public function coa_requests(): HasMany
    {
        return $this->hasMany(CoaRequest::class, 'requester_id');
    }

    /**
     * @return HasMany
     */
    public function approved_coa_requests(): HasMany
    {
        return $this->hasMany(CoaRequest::class, 'approver_id');
    }
}
