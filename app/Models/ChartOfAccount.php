<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ChartOfAccount extends Model
{
    /** @use HasFactory<\Database\Factories\ChartOfAccountFactory> */
    use HasUuids, HasFactory;

    protected $table = 'chart_of_accounts';
    protected $fillable = [
        'code',
        'name',
        'parent_id',
        'level',
        'order',
        'account_type_id',
        'description',
        'normal_balance',
        'is_active',
        'created_by',
    ];
    
    protected $casts = [
        'is_active' => 'boolean',
    ];

    /**
     * Get the account type that owns the chart of account.
     * @return BelongsTo
     */
    public function accountType(): BelongsTo
    {
        return $this->belongsTo(AccountType::class, 'account_type_id');
    }

    public function userAccounts(): HasMany
    {
        return $this->hasMany(UserAccount::class, 'coa_id');
    }

    public function users()
    {
        return $this->belongsToMany(ChartOfAccount::class, 'user_accounts', 'coa_id', 'user_id');
    }

    /**
     * Get the user who created the chart of account.
     * @return BelongsTo
     */
    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function parent(): BelongsTo
    {
        return $this->belongsTo(ChartOfAccount::class, 'parent_id');
    }

    public function children(): HasMany
    {
        return $this->hasMany(ChartOfAccount::class, 'parent_id');
    }

    public function opening_balances(): HasMany
    {
        return $this->hasMany(OpeningBalance::class, 'chart_of_account_id');
    }

    public function journal_details() : HasMany
    {
        return $this->hasMany(JournalDetail::class, 'coa_id');
        
    }

}
