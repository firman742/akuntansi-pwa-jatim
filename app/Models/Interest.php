<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Interest extends Model
{
    use HasUuids, HasFactory;

    protected $table = 'interests';

    protected $fillable = [
        'name',
        'rate',
        'type',
        'account_interest_id',
        'account_expense_id',
    ];


    /**
     * Get the interest account associated with the interest.
     */
    public function accountInterest()
    {
        return $this->belongsTo(ChartOfAccount::class, 'account_interest_id');
    }

    /**
     * Get the account expense associated with the interest.
     */
    public function accountExpense()
    {
        return $this->belongsTo(ChartOfAccount::class, 'account_expense_id');
    }
}
