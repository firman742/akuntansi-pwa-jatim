<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * Class JournalDetail
 * @package App\Models
 *
 * @property string $id
 * @property string $journal_id
 * @property string $chart_of_account_id
 * @property float $debit
 * @property float $credit
 * @property string|null $description
 *
 * @property Journal $journal
 * @property ChartOfAccount $chartOfAccount
 */
class JournalDetail extends Model
{
    use HasUuids, HasFactory;

    protected $table = 'journal_details';
    protected $fillable = [
        'journal_id',
        'chart_of_account_id',
        'debit',
        'credit',
        'description',
    ];

    public function journal()
    {
        return $this->belongsTo(Journal::class);
    }

    public function chartOfAccount()
    {
        return $this->belongsTo(ChartOfAccount::class, 'chart_of_account_id');
    }
}
