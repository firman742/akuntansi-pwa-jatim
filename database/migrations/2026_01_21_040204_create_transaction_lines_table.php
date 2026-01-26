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
        Schema::create('transaction_lines', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('transaction_id');
            $table->uuid('chart_of_account_id');
            $table->decimal('debit_amount', 15, 2)->default(0)->nullable();
            $table->decimal('credit_amount', 15, 2)->default(0)->nullable();
            $table->enum('line_type', ['debit', 'credit']);
            $table->text('description')->nullable();

            $table->foreign('transaction_id')
                ->references('id')
                ->on('transactions')
                ->onDelete('cascade');
            $table->foreign('chart_of_account_id')
                ->references('id')
                ->on('chart_of_accounts')
                ->onDelete('restrict');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transaction_lines');
    }
};
