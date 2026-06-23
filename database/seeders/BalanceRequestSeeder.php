<?php

namespace Database\Seeders;

use App\Enums\RoleEnum;
use App\Models\BalanceRequest;
use App\Models\CoaBalance;
use App\Models\User;
use Illuminate\Database\Seeder;

class BalanceRequestSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $users = User::role(RoleEnum::USER->value)
            ->with('userAccounts')
            ->get();

        if ($users->isEmpty()) {
            return;
        }

        for ($i = 1; $i <= 10; $i++) {

            $user = $users
                ->filter(fn($u) => $u->userAccounts->isNotEmpty())
                ->random();

            $userAccount = $user->userAccounts->random();

            $coaBalance = CoaBalance::query()
                ->where('chart_of_account_id', $userAccount->coa_id)
                ->inRandomOrder()
                ->first();

            if (!$coaBalance) {
                continue;
            }

            BalanceRequest::create([
                'requester_id' => $user->id,

                'approver_id' => null,

                'user_account_id' => $userAccount->id,

                'source_coa_id' => $coaBalance->id,

                'period_id' => $coaBalance->period_id,

                'sub_period_id' => $coaBalance->sub_period_id,

                'amount' => fake()->numberBetween(
                    100_000,
                    5_000_000
                ),

                'status' => 'PENDING',

                'purpose' => fake()->randomElement([
                    'Biaya operasional',
                    'Kegiatan lapangan',
                    'Pembelian perlengkapan',
                    'Transportasi',
                    'Konsumsi rapat',
                    'Program kerja divisi',
                ]),

                'note' => fake()->sentence(),

                'approved_at' => null,
                'approval_notes' => null,

                'rejected_at' => null,
                'rejection_reason' => null,
            ]);
        }
    }
}
