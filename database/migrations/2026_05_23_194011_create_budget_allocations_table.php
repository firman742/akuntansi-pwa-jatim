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
        Schema::create('budget_allocations', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('from_chart_of_account_id');
            $table->uuid('to_chart_of_account_id');
            $table->uuid('period_id');
            $table->uuid('sub_period_id');
            $table->uuid('created_by')->nullable();
            $table->decimal('amount', 15, 2);
            $table->enum('allocation_type', ['manual', 'auto'])->default('auto');
            $table->string('description')->nullable();
            $table->softDeletes();
            $table->timestamps();

            $table->foreign('from_chart_of_account_id')
                ->references('id')
                ->on('chart_of_accounts')
                ->onDelete('cascade');
            $table->foreign('to_chart_of_account_id')
                ->references('id')
                ->on('chart_of_accounts')
                ->onDelete('cascade');
            $table->foreign('period_id')
                ->references('id')
                ->on('periods')
                ->onDelete('cascade');
            $table->foreign('sub_period_id')
                ->references('id')
                ->on('sub_periods')
                ->onDelete('cascade');
            $table->foreign('created_by')
                ->references('id')
                ->on('users')
                ->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('budget_allocations');
    }
};
