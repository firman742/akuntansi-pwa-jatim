<?php

namespace App\Services\Superadmin;

use App\Models\User;
use App\Services\BaseService;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserService extends BaseService
{
    /**
     * Create a new user.
     *
     * @param  array  $data
     * @return User
     */
    public function store(array $data): User
    {
        DB::beginTransaction();
        $user = User::create([
            'name'     => $data['name'],
            'no_telp'  => $data['no_telp'] ?? null,
            'email'    => $data['email'],
            'address'  => $data['address'] ?? null,
            'password' => Hash::make($data['password']),
        ]);

        if (isset($data['role'])) {
            $user->assignRole($data['role']);
        }

        // Activity log bisa ditambahkan di controller, karena service ini bisa dipakai di banyak tempat, jadi lognya bisa berbeda2 tergantung konteksnya
        $this->logger->log(
            action: 'create',
            module: 'user',
            subject: $user,
            description: "User {$user->name} created with role(s): " . implode(', ', (array) $data['role'] ?? []),
            new: $user->toArray()
        );
        DB::commit();
        return $user;
    }

    /**
     * Update an existing user.
     *
     * @param  string  $id
     * @param  array  $data
     * @return User
     * @throws Exception
     */
    public function update(string $id, array $data): User
    {
        DB::beginTransaction();
        $user = User::findOrFail($id);

        $user->update([
            'name'     => $data['name'],
            'no_telp'  => $data['no_telp'] ?? null,
            'email'    => $data['email'],
            'address'  => $data['address'] ?? null,
        ]);

        if (isset($data['role'])) {
            $user->syncRoles($data['role']);
        }

        $this->logger->log(
            action: 'update',
            module: 'user',
            subject: $user,
            description: "User {$user->name} updated with role(s): " . implode(', ', (array) $data['role'] ?? []),
            old: $user->getOriginal(),
            new: $user->toArray()
        );

        DB::commit();


        return $user;
    }

    /**
     * Delete the specified user.
     *
     * @param  string  $id
     * @return mixed
     * @throws Exception
     */
    public function delete(string $id): mixed
    {
        return DB::transaction(function () use ($id) {
            $user = User::findOrFail($id);

            // optional: detach roles & permissions
            $user->syncRoles([]);
            $user->permissions()->detach();

            if ($user->hasRelatedEntities()) {
                throw new Exception("Tidak dapat menghapus user {$user->name} karena memiliki entitas terkait: " . implode(', ', array_keys($user->getRelatedEntities())));
            }

            $user->delete();

            $this->logger->log(
                action: 'delete',
                module: 'user',
                subject: $user,
                description: "User {$user->name} deleted",
                old: $user->getOriginal()
            );
        });
    }
}
