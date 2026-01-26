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
        Schema::create('journals', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('journal_number')->unique();
            $table->date('journal_date');
            $table->text('description')->nullable();
            $table->decimal('total_debit', 15, 2);
            $table->decimal('total_credit', 15, 2);
            $table->uuid('posted_by')->nullable();
            $table->dateTime('posted_at')->nullable();
            $table->uuid('period_id');
            $table->uuid('transaction_id')->nullable();

            $table->foreign('posted_by')->references('id')->on('users')->onDelete('set null');
            $table->foreign('period_id')->references('id')->on('periods')->onDelete('cascade');
            $table->foreign('transaction_id')->references('id')->on('transactions')->onDelete('set null');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('journals');
    }
};
