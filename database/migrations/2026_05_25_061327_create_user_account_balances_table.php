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
        Schema::create('user_account_balances', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('user_account_id');
            $table->uuid('coa_balance_id');
            $table->uuid('period_id'); // Periode terkait
            $table->uuid('sub_period_id'); // Sub periode terkait
            $table->uuid('allocated_by');
            $table->decimal('allocated_balance', 15, 2)->default(0); // Saldo yang dialokasikan untuk periode berjalan
            $table->decimal('used_balance', 15, 2)->default(0); // Saldo yang sudah digunakan selama periode berjalan
            $table->decimal('remaining_balance', 15, 2)->default(0); // Saldo yang tersisa untuk periode berjalan
            $table->timestamp('allocated_at')->nullable(); // Waktu alokasi saldo untuk periode berjalan

            $table->foreign('user_account_id')
                ->references('id')
                ->on('user_accounts')
                ->onDelete('cascade');
            $table->foreign('coa_balance_id')
                ->references('id')
                ->on('coa_balances')
                ->onDelete('cascade');
            $table->foreign('period_id')
                ->references('id')
                ->on('periods')
                ->onDelete('cascade');
            $table->foreign('sub_period_id')
                ->references('id')
                ->on('sub_periods')
                ->onDelete('cascade');
            $table->foreign('allocated_by')
                ->references('id')
                ->on('users')
                ->onDelete('cascade');
            $table->softDeletes();
            
            $table->unique(['user_account_id', 'coa_balance_id', 'sub_period_id'], 'unique_user_account_balance');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_account_balances');
    }
};
