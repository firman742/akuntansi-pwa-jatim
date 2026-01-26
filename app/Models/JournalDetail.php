<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;

class JournalDetail extends Model
{
    use HasUuids;

    protected $table = 'journal_details';
    protected $fillable = [
        'journal_id',
        'coa_id',
        'debit',
        'credit',
        'description',
    ];

    public function journal()
    {
        return $this->belongsTo(Journal::class);
    }

    public function coa()
    {
        return $this->belongsTo(ChartOfAccount::class);
    }
}
