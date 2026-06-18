<?php

namespace App\Services\Bendahara;

use App\Enums\ActivityLogAction;
use App\Models\User;
use App\Models\UserAccount;
use App\Services\BaseService;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class UserAccountService extends BaseService
{
    /**
     * Sync the specified resource in storage.
     * 
     * @param string $id
     * @param array $data
     * @return User
     */
    public function sync(string $id, array $data): User
    {
        $user = User::findOrFail($id);

        $oldCoaIds = $user->coas()
            ->pluck('chart_of_accounts.id')
            ->toArray();

        $newCoaIds = $data['coa_ids'] ?? [];

        DB::transaction(function () use ($user, $data, $oldCoaIds, $newCoaIds) {
            // hapus relasi lama
            UserAccount::where('user_id', $user->id)->delete();

            // insert relasi baru
            if (!empty($data['coa_ids'])) {
                $rows = collect($data['coa_ids'])
                    ->map(fn ($coaId) => [
                        'id' => (string) Str::uuid(),
                        'user_id' => $user->id,
                        'coa_id' => $coaId,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ])
                    ->toArray();

                UserAccount::insert($rows);
            }

            // activity log
            $this->logger->log(
                action: ActivityLogAction::SYNC->value,
                module: 'USER_ACCOUNT',
                subject: $user,
                description: "Sinkronisasi akun untuk pengguna {$user->name}",
                old: [
                    'coa_ids' => $oldCoaIds,
                ],
                new: [
                    'coa_ids' => $newCoaIds,
                ],
                additionalData: [
                    'user_id' => $user->id,
                    'added' => array_values(array_diff($newCoaIds, $oldCoaIds)),
                    'removed' => array_values(array_diff($oldCoaIds, $newCoaIds)),
                ]
            );
        });

        return $user->fresh('coas');
    }
}
