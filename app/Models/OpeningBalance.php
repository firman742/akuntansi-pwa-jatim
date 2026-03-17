<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class OpeningBalance extends Model
{
    use HasUuids;
    protected $table = 'opening_balances';
    protected $fillable = [
        'chart_of_account_id',
        'period_id',
        'sub_period_id',
        'created_by',
        'balance_type',
        'amount',
    ];

    public function chartOfAccount()
    {
        return $this->belongsTo(ChartOfAccount::class, 'chart_of_account_id');
    }

    public function period()
    {
        return $this->belongsTo(Period::class, 'period_id');
    }

    public function subPeriod()
    {
        return $this->belongsTo(SubPeriod::class, 'sub_period_id');
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

}
