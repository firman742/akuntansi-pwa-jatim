<?php

namespace App\Services\Bendahara;

use App\Models\User;
use App\Models\UserAccount;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class UserAccountService
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

        DB::transaction(function () use ($user, $data) {
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
        });

        return $user->fresh('coas');
    }
}
