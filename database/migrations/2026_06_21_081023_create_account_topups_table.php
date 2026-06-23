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
        Schema::create('account_topups', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('chart_of_account_id');
            $table->uuid('period_id');
            $table->uuid('sub_period_id');
            $table->uuid('created_by');
            $table->float('amount');
            $table->string('reason')->nullable();
            $table->timestamps();

            $table->foreign('chart_of_account_id')->references('id')->on('chart_of_accounts')->onDelete('cascade');
            $table->foreign('period_id')->references('id')->on('periods')->onDelete('cascade');
            $table->foreign('sub_period_id')->references('id')->on('sub_periods')->onDelete('cascade');
            $table->foreign('created_by')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('account_topups');
    }
};
