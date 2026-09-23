<?php

namespace App\Models;

use App\Enums\TransactionStatus;
use App\Enums\TransactionType;
use App\Models\Journal;
use App\Models\Period;
use App\Models\SubPeriod;
use App\Models\TransactionLine;
use App\Models\User;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
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
        'gross_amount',
        'net_amount',
        'referencree_number',
        'receipt_path',
        'period_id',
        'sub_period_id',
        'created_by',
    ];

    // ⬅️ TAMBAHKAN INI AGAR ATRIBUT URL IKUT TERSEDIA DI ALPINE.JS
    protected $appends = [
        'receipt_url',
    ];

    protected $casts = [
        'transaction_date' => 'date',
        'total_amount' => 'decimal:2',
        'transaction_type' => TransactionType::class,
        'status' => TransactionStatus::class,
        'receipt_path' => 'string',
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

    protected function receiptUrl(): Attribute
    {
        return Attribute::make(
            get: function () {
                if (!$this->receipt_path) {
                    return null;
                }

                $url = Storage::disk('google_receipt_transaction')->url($this->receipt_path);

                $fileId = null;

                if (preg_match('/[?&]id=([a-zA-Z0-9_-]+)/', $url, $matches)) {
                    $fileId = $matches[1];
                } elseif (preg_match('/\/file\/d\/([a-zA-Z0-9_-]+)/', $url, $matches)) {
                    $fileId = $matches[1];
                }

                if ($fileId) {
                    return "https://drive.google.com/file/d/{$fileId}/view";
                }

                $url = str_replace('export=download', 'export=view', $url);
                $url = str_replace('/view', '/preview', $url);

                return $url;
            }
        );
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

    public function transactionLines()
    {
        return $this->hasMany(TransactionLine::class, 'transaction_id');
    }

    public function journal()
    {
        return $this->hasOne(Journal::class, 'transaction_id');
    }
}
