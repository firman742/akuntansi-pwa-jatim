<?php

namespace Database\Seeders;

use App\Enums\RoleEnum;
use App\Models\ChartOfAccount;
use App\Models\User;
use App\Models\UserAccount;
use Illuminate\Database\Seeder;
use Illuminate\Support\Collection;

class UserAccountSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $users = User::role(RoleEnum::USER->value)->get();

        if ($users->isEmpty()) {
            return;
        }

        /**
         * Ambil hanya akun detail (leaf account)
         */
        $leafAccounts = ChartOfAccount::query()
            ->whereDoesntHave('children')
            ->get();

        $debitAccounts = $leafAccounts
            ->where('normal_balance', 'DEBIT')
            ->values();

        $creditAccounts = $leafAccounts
            ->where('normal_balance', 'CREDIT')
            ->values();

        foreach ($users as $user) {

            /**
             * Minimal 20 debit
             * Tambahan random 0-10
             */
            $debitTake = min(
                $debitAccounts->count(),
                20 + rand(0, 10)
            );

            /**
             * Minimal 25 credit
             * Tambahan random 0-10
             */
            $creditTake = min(
                $creditAccounts->count(),
                25 + rand(0, 10)
            );

            $selectedAccounts = collect()
                ->merge(
                    $debitAccounts
                        ->shuffle()
                        ->take($debitTake)
                )
                ->merge(
                    $creditAccounts
                        ->shuffle()
                        ->take($creditTake)
                )
                ->unique('id');

            foreach ($selectedAccounts as $coa) {

                // Assign akun yang dipilih
                UserAccount::firstOrCreate([
                    'user_id' => $user->id,
                    'coa_id'  => $coa->id,
                ]);

                // Assign seluruh parent
                foreach ($this->getParentAccounts($coa) as $parent) {

                    UserAccount::firstOrCreate([
                        'user_id' => $user->id,
                        'coa_id'  => $parent->id,
                    ]);
                }
            }
        }
    }

    /**
     * Ambil seluruh parent dari sebuah COA.
     * 
     * @return Collection<ChartOfAccount>
     */
    private function getParentAccounts(ChartOfAccount $coa): Collection
    {
        $parents = collect();
        $current = $coa->parent;

        while ($current) {
            $parents->push($current);

            $current = $current->parent;
        }

        return $parents;
    }
}
