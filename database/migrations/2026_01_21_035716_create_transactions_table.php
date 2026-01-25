<?php

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
            $table->enum('transaction_type', ['INCOME', 'EXPENSE', 'TRANSFER']);
            $table->text('description')->nullable();
            $table->enum('status', ['DRAFT', 'SUBMITTED', 'POSTED', 'REVERSED'])->default('DRAFT');
            $table->decimal('total_amount', 15, 2)->default(0);
            $table->uuid('created_by')->nullable();
            $table->uuid('period_id');

            $table->foreign('period_id')
                ->references('id')
                ->on('periods')
                ->onDelete('cascade');
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
