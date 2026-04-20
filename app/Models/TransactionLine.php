<?php

namespace App\Models;

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransactionLine extends Model
{
    use HasUuids, HasFactory;
    
    protected $table = 'transaction_lines';

    protected $fillable = [
        'transaction_id',
        'chart_of_account_id',
        'position',
        'amount',
        'meta_type',
        'description',
        'line_type',
    ];

    protected $casts = [
        'position' => NormalBalanceEnum::class,
        'amount' => 'decimal:2',
        'meta_type' => MetaTypeTransactionEnum::class,
    ];

    public function transaction()
    {
        return $this->belongsTo(Transaction::class, 'transaction_id');
    }

    public function chartOfAccount()
    {
        return $this->belongsTo(ChartOfAccount::class, 'chart_of_account_id');
    }
}
