<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * Class ChartOfAccount
 * @package App\Models
 *
 * @property string $id
 * @property string $code
 * @property string $name
 * @property string|null $parent_id
 * @property int $level
 * @property int $order
 * @property string|null $account_type_id
 * @property string|null $description
 * @property string|null $normal_balance
 * @property bool $is_active
 * @property string|null $created_by
 *
 * @property AccountType|null $accountType
 * @property UserAccount[]|null $userAccounts
 * @property User[]|null $users
 * @property User|null $creator
 * @property ChartOfAccount|null $parent
 * @property ChartOfAccount[]|null $children
 * @property OpeningBalance[]|null $opening_balances
 * @property JournalDetail[]|null $journalDetails
 * @property TransactionLine[]|null $transactionLines
 * @property CoaBalance[]|null $coaBalances
 * @property BudgetAllocation[]|null $budgetAllocationsFrom
 * @property BudgetAllocation[]|null $budgetAllocationsTo
 */
class ChartOfAccount extends Model
{
    /** @use HasFactory<\Database\Factories\ChartOfAccountFactory> */
    use HasUuids, HasFactory, SoftDeletes;

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
        return $this->belongsToMany(
            User::class,
            'user_accounts',
            'coa_id',
            'user_id'
        );
    }

    /**
     * Get the user who created the chart of account.
     * @return BelongsTo
     */
    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    /**
     * Get the parent chart of account.
     * @return BelongsTo
     */
    public function parent(): BelongsTo
    {
        return $this->belongsTo(ChartOfAccount::class, 'parent_id');
    }

    /**
     * Get the child chart of accounts.
     * @return HasMany
     */
    public function children(): HasMany
    {
        return $this->hasMany(ChartOfAccount::class, 'parent_id');
    }

    /**
     * Get the opening balances for the chart of account.
     * @return HasMany
     */
    public function opening_balances(): HasMany
    {
        return $this->hasMany(OpeningBalance::class, 'chart_of_account_id');
    }

    /**
     * Get the closing balances for the chart of account.
     * @return HasMany
     */
    public function journalDetails(): HasMany
    {
        return $this->hasMany(JournalDetail::class, 'chart_of_account_id');
    }

    /**
     * Get the transaction lines for the chart of account.
     * @return HasMany
     */
    public function transactionLines(): HasMany
    {
        return $this->hasMany(TransactionLine::class, 'chart_of_account_id');
    }

    /**
     * Get the coa balances for the chart of account.
     * @return HasMany
     */
    public function coaBalances(): HasMany
    {
        return $this->hasMany(CoaBalance::class, 'chart_of_account_id');
    }

    /**
     * Get the budget allocations where this chart of account is the source.
     * @return HasMany
     */
    public function budgetAllocationsFrom(): HasMany
    {
        return $this->hasMany(BudgetAllocation::class, 'from_chart_of_account_id');
    }

    /**
     * Get the budget allocations where this chart of account is the destination.
     * @return HasMany
     */
    public function budgetAllocationsTo(): HasMany
    {
        return $this->hasMany(BudgetAllocation::class, 'to_chart_of_account_id');
    }

    /**
     * Get the coa requests associated with this chart of account.
     * @return HasMany
     */
    public function coaRequests(): HasMany
    {
        return $this->hasMany(CoaRequest::class, 'parent_coa_id');
    }

    /**
     * Get the account topups associated with this chart of account.
     * @return HasMany
     */
    public function accountTopups(): HasMany
    {
        return $this->hasMany(AccountTopup::class, 'chart_of_account_id');
    }

    public function childrenRecursive(): HasMany
    {
        return $this->children()->with('childrenRecursive');
    }
}
