<?php

use App\Enums\TransactionType;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('transactions', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('transaction_number')->unique();
            $table->date('transaction_date');
            $table->enum('transaction_type', TransactionType::values())->default(TransactionType::INCOME->value);
            $table->text('description')->nullable();
            $table->enum('status', ['DRAFT', 'SUBMITTED', 'POSTED', 'REVERSED'])->default('DRAFT');
            $table->decimal('gross_amount', 18, 2);
            $table->decimal('net_amount', 18, 2);
            $table->string('referencree_number')->nullable();
            $table->string('receipt_path')->nullable(); // For file path
            $table->uuid('created_by')->nullable();
            $table->uuid('period_id');
            $table->uuid('sub_period_id')->nullable();
            $table->date('posted_at')->nullable();

            $table->foreign('period_id')
                ->references('id')
                ->on('periods')
                ->restrictOnDelete();
            $table->foreign('sub_period_id')
                ->references('id')
                ->on('sub_periods')
                ->restrictOnDelete();
            $table->foreign('created_by')
                ->references('id')->on('users')
                ->onDelete('set null');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transactions');
    }
};
