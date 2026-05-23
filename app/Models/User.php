<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;

use App\Enums\NormalBalanceEnum;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasUuids, HasFactory, HasRoles, Notifiable, SoftDeletes;

    protected $table = 'users';
    protected $keyType = 'string';   // ⬅️ WAJIB
    public $incrementing = false;    // ⬅️ WAJIB


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


    public function user_accounts(): HasMany
    {
        return $this->hasMany(UserAccount::class, 'user_id');
    }

    public function coas()
    {
        return $this->belongsToMany(ChartOfAccount::class, 'user_accounts', 'user_id', 'coa_id');
    }

    public function debitCoas()
    {
        return $this->belongsToMany(
            ChartOfAccount::class,
            'user_accounts',
            'user_id',
            'coa_id'
        )->where('chart_of_accounts.normal_balance', NormalBalanceEnum::DEBIT->value);
    }

    public function creditCoas()
    {
        return $this->belongsToMany(
            ChartOfAccount::class,
            'user_accounts',
            'user_id',
            'coa_id'
        )->where('chart_of_accounts.normal_balance', NormalBalanceEnum::CREDIT->value);
    }

    public function transactions(): HasMany
    {
        return $this->hasMany(Transaction::class, 'created_by');
    }

    public function periods(): HasMany
    {
        return $this->hasMany(Period::class, 'created_by');
    }

    public function account_balances(): HasMany
    {
        return $this->hasMany(OpeningBalance::class, 'created_by');
    }
}
