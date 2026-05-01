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
        Schema::create('interests', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('name');
            $table->decimal('rate', 8, 2); // misal: 5.00 untuk 5%
            $table->enum('type', ['PERCENTAGE', 'FIXED'])->default('PERCENTAGE');

             // 🔥 relasi ke COA (bukan string lagi)
             $table->uuid('account_interest_id')->nullable(); // akun bunga
             $table->uuid('account_expense_id')->nullable(); // akun beban bunga

             $table->foreign('account_interest_id')
                 ->references('id')
                 ->on('chart_of_accounts')
                 ->onDelete('set null');
             $table->foreign('account_expense_id')
                 ->references('id')
                 ->on('chart_of_accounts')
                 ->onDelete('set null');
                 
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('interests');
    }
};
