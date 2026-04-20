<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tax extends Model
{
    use HasUuids, HasFactory;

    protected $table = 'taxes';

    protected $fillable = [
        'name',
        'rate',
        'type',
        'account_payable_id',
        'account_expense_id',
        'account_prepaid_id',
    ];

    /**
     * Get the account payable associated with the tax.
     */
    public function accountPayable()
    {
        return $this->belongsTo(ChartOfAccount::class, 'account_payable_id');
    }

    /**
     * Get the account expense associated with the tax.
     */
    public function accountExpense()
    {
        return $this->belongsTo(ChartOfAccount::class, 'account_expense_id');
    }

    /**
     * Get the prepaid account associated with the tax.
     */
    public function accountPrepaid()
    {
        return $this->belongsTo(ChartOfAccount::class, 'account_prepaid_id');
    }
}
