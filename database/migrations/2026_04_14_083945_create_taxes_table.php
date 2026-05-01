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
        Schema::create('taxes', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('name');
            $table->decimal('rate', 8, 2)->default(0); // misal 10.00 untuk 10%
            $table->enum('type', ['PERCENTAGE', 'FIXED'])->default('PERCENTAGE');

            // 🔥 relasi ke COA (bukan string lagi)
            $table->uuid('account_payable_id')->nullable(); // utang pajak
            $table->uuid('account_expense_id')->nullable(); // beban pajak
            $table->uuid('account_prepaid_id')->nullable(); // prepaid tax


            $table->foreign('account_payable_id')
                ->references('id')
                ->on('chart_of_accounts')
                ->restrictOnDelete();
            $table->foreign('account_expense_id')
                ->references('id')
                ->on('chart_of_accounts')
                ->restrictOnDelete();
            $table->foreign('account_prepaid_id')
                ->references('id')
                ->on('chart_of_accounts')
                ->restrictOnDelete();

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('taxes');
    }
};
