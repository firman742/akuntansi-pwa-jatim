<?php

namespace App\Models;

use App\Enums\TransactionType;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Transaction extends Model
{
    use HasUuids, HasFactory;

    protected $table = 'transactions';
    protected $fillable = [
        'transaction_number',
        'transaction_date',
        'description',
        'transaction_type',
        'status',
        'total_amount',
        'period_id',
        'created_by',
    ];

    protected $casts = [
        'transaction_date' => 'date',
        'total_amount' => 'decimal:2',
        'transaction_type' => TransactionType::class, // ⬅️ KUNCI
    ];

    public function period()
    {
        return $this->belongsTo(Period::class, 'period_id');
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function transactionLines()
    {
        return $this->hasMany(TransactionLine::class, 'transaction_id');
    }
}
