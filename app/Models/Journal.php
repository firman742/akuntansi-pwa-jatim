<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class Journal extends Model
{
    use HasUuids;

    protected $table = 'journals';
    protected $fillable = [
        'journal_number',
        'journal_date',
        'description',
        'total_debit',
        'total_credit',
        'posted_by',
        'posted_at',
        'period_id',
        'transaction_id',
    ];

    protected $casts = [
        'journal_date' => 'date',
        'posted_at'    => 'datetime',
    ];
    public function period()
    {
        return $this->belongsTo(Period::class);
    }

    public function transaction()
    {
        return $this->belongsTo(Transaction::class);
    }

    public function postedBy()
    {
        return $this->belongsTo(User::class, 'posted_by');
    }

    public function details()
    {
        return $this->hasMany(JournalDetail::class);
    }
}
