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
        Schema::create('coa_balances', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('chart_of_account_id');
            $table->uuid('period_id');
            $table->uuid('sub_period_id');
            $table->decimal('opening_balance', 20, 2);
            $table->decimal('debit_total', 20, 2);
            $table->decimal('credit_total', 20, 2);
            $table->decimal('current_balance', 20, 2);
            $table->timestamp('last_transaction_at')->nullable();
            $table->softDeletes();
            $table->timestamps();

            $table->foreign('chart_of_account_id')->references('id')->on('chart_of_accounts')->onDelete('cascade');
            $table->foreign('period_id')->references('id')->on('periods')->onDelete('cascade');
            $table->foreign('sub_period_id')->references('id')->on('sub_periods')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('coa_balances');
    }
};
