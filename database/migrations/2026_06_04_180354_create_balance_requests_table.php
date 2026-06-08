<?php

use App\Enums\RequestStatus;
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
        Schema::create('balance_requests', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('requester_id');
            $table->uuid('approver_id')->nullable();
            $table->uuid('user_account_id');
            $table->uuid('source_coa_id')->nullable();
            $table->uuid('period_id');
            $table->uuid('sub_period_id');
            $table->decimal('amount', 15, 2);
            $table->enum('status', RequestStatus::values())->default(RequestStatus::PENDING->value);
            $table->string('purpose')->nullable();
            $table->text('note')->nullable();
            $table->timestamp('approved_at')->nullable();
            $table->text('approval_notes')->nullable();
            $table->timestamp('rejected_at')->nullable();
            $table->text('rejection_reason')->nullable();

            $table->softDeletes();
            $table->timestamps();

            $table->foreign('requester_id')
                ->references('id')->on('users')
                ->onDelete('cascade');
            $table->foreign('approver_id')
                ->references('id')->on('users')
                ->onDelete('set null');
            $table->foreign('user_account_id')
                ->references('id')->on('user_accounts')
                ->onDelete('cascade');
            $table->foreign('source_coa_id')
                ->references('id')->on('coa_balances')
                ->onDelete('cascade');
            $table->foreign('period_id')
                ->references('id')->on('periods')
                ->onDelete('cascade');
            $table->foreign('sub_period_id')
                ->references('id')->on('sub_periods')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('balance_requests');
    }
};
