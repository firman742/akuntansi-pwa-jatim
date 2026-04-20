<?php

use App\Enums\MetaTypeTransactionEnum;
use App\Enums\NormalBalanceEnum;
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
            $table->enum('position', NormalBalanceEnum::values())->default(NormalBalanceEnum::DEBIT->value);
            $table->decimal('amount', 18, 2);
            $table->enum('meta_type', MetaTypeTransactionEnum::values())->default(MetaTypeTransactionEnum::MAIN->value);
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
