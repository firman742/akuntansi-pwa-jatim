<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

/**
 * Class AccountType
 * @package App\Models
 *
 * @property string $id
 * @property string $name
 * @property string|null $description
 * @property bool $is_active
 *
 * @property ChartOfAccount[]|null $chartOfAccounts
 * @property CoaRequest[]|null $coaRequests
 */
class AccountType extends Model
{
    /** @use HasFactory<\Database\Factories\AccountTypeFactory> */
    use HasUuids, HasFactory;

    protected $table = 'account_types';

    protected $fillable = [
        'name',
        'description',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    /**
     * Get the chart of accounts for the account type.
     * @return HasMany
     */
    public function chartOfAccounts(): HasMany
    {
        return $this->hasMany(ChartOfAccount::class, 'account_type_id');
    }

    /**
     * Get the coa requests for the account type.
     * @return HasMany
     */
    public function coaRequests(): HasMany
    {
        return $this->hasMany(CoaRequest::class, 'account_type_id');
    }
}
