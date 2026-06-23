<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClosingBalance extends Model
{
    use HasUuids, HasFactory;

    protected $table = 'closing_balances';

    protected $fillable = [
        'period_id',
        'chart_of_account_id',
        'created_by',
        'balance_type',
        'amount',
    ];


    public function period()
    {
        return $this->belongsTo(Period::class, 'period_id');
    }

    public function chartOfAccount()
    {
        return $this->belongsTo(ChartOfAccount::class, 'chart_of_account_id');
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }
    
}
