<?php

namespace Database\Seeders;

use App\Enums\NormalBalanceEnum;
use App\Enums\RoleEnum;
use App\Models\AccountType;
use App\Models\CoaRequest;
use App\Models\SubPeriod;
use App\Models\User;
use Illuminate\Database\Seeder;

class CoaRequestSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $requesters = User::role(RoleEnum::USER->value)->get();

        if ($requesters->isEmpty()) {
            return;
        }

        $accountTypes = AccountType::all();

        $subPeriods = SubPeriod::all();

        for ($i = 1; $i <= 10; $i++) {

            $accountType = $accountTypes->random();

            CoaRequest::create([
                'requester_id' => $requesters->random()->id,

                'approver_id' => null,

                'parent_coa_id' => null,

                'account_type_id' => $accountType->id,

                'sub_period_id' => $subPeriods->random()?->id,

                'proposed_name' => fake()->unique()->words(
                    3,
                    true
                ),

                'proposed_code' => 'REQ-' . str_pad(
                    (string) $i,
                    4,
                    '0',
                    STR_PAD_LEFT
                ),

                'normal_balance' => fake()->randomElement([
                    NormalBalanceEnum::DEBIT->value,
                    NormalBalanceEnum::CREDIT->value,
                ]),

                'status' => 'PENDING',

                'description' => fake()->sentence(),

                'approved_at' => null,
                'approval_notes' => null,

                'rejected_at' => null,
                'rejection_reason' => null,
            ]);
        }
    }
}
