<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Collection;

/**
 * Class Journal
 * @package App\Models
 *
 * @property string $id
 * @property string $journal_number
 * @property Carbon $journal_date
 * @property string|null $description
 * @property float $total_debit
 * @property float $total_credit
 * @property string|null $posted_by
 * @property Carbon|null $posted_at
 * @property string|null $period_id
 * @property string|null $sub_period_id
 * @property string|null $transaction_id
 *
 * @property Period|null $period
 * @property SubPeriod|null $subPeriod
 * @property Transaction|null $transaction
 * @property User|null $postedBy
 * @property Collection|JournalDetail[] $details
 */
class Journal extends Model
{
    use HasUuids, HasFactory;

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
        'sub_period_id',
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

    public function subPeriod()
    {
        return $this->belongsTo(SubPeriod::class);
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
