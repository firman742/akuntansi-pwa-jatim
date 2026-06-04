<?php

use App\Enums\NormalBalanceEnum;
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
        Schema::create('coa_requests', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('requester_id');
            $table->uuid('approver_id')->nullable();
            $table->uuid('parent_coa_id')->nullable();
            $table->uuid('account_type_id');
            $table->uuid('sub_period_id')->nullable();
            $table->string('proposed_name');
            $table->string('proposed_code')->unique();
            $table->enum('normal_balance', NormalBalanceEnum::values());
            $table->enum('status', RequestStatus::values())->default(RequestStatus::PENDING->value);
            $table->text('description')->nullable();
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
            $table->foreign('parent_coa_id')
                ->references('id')->on('chart_of_accounts')
                ->onDelete('set null');
            $table->foreign('account_type_id')
                ->references('id')->on('account_types')
                ->onDelete('cascade');
            $table->foreign('sub_period_id')
                ->references('id')->on('sub_periods')
                ->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('coa_requests');
    }
};
