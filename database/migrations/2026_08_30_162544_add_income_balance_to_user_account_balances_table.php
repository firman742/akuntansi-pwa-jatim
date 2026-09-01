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
        Schema::table('user_account_balances', function (Blueprint $table) {
            $table->decimal('income_balance', 15, 2)
                ->default(0)
                ->after('allocated_balance');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('user_account_balances', function (Blueprint $table) {
            $table->dropColumn('income_balance');
        });
    }
};
