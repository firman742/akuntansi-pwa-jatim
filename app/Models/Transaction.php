<?php

namespace App\Models;

use App\Enums\TransactionType;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;

class Transaction extends Model implements HasMedia
{
    use HasUuids, HasFactory, InteractsWithMedia;

    protected $table = 'transactions';
    protected $fillable = [
        'transaction_number',
        'transaction_date',
        'description',
        'transaction_type',
        'status',
        'total_amount',
        'receipt_path',
        'period_id',
        'created_by',
    ];

    protected $casts = [
        'transaction_date' => 'date',
        'total_amount' => 'decimal:2',
        'transaction_type' => TransactionType::class, // ⬅️ KUNCI
        'receipt_path' => 'string', // For file path
    ];

    public function registerMediaCollections(): void
    {
        $this->addMediaCollection('receipts')
            ->singleFile()
            ->acceptsMimeTypes(['image/jpeg', 'image/png', 'image/webp'])
            ->useDisk('public');
    }

    public function receiptDirectory(): string
    {
        $type = strtolower($this->transaction_type->value);

        return "{$this->period_id}/{$type}/{$this->created_by}";
    }

    public function getReceiptUrlAttribute(): ?string
    {
        return $this->receipt_path
            ? asset('storage/' . $this->receipt_path)
            : null;
    }


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

    public function journal()
    {
        return $this->hasOne(Journal::class, 'transaction_id');
    }
}
