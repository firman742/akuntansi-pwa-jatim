<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Enums\RoleEnum;

class UserSeeder extends Seeder
{
    protected array $users = [
        [
            'name'  => 'Super Admin',
            'email' => 'superadmin@example.com',
            'no_telp' => '081234567890',
            'address' => 'Jl. Merdeka No. 1, Jakarta',
            'roles' => [RoleEnum::SUPER_ADMIN],
            'is_superadmin' => true,
        ],

        // ACCOUNTING
        [
            'name'  => 'Bendahara',
            'email' => 'bendahara@example.com',
            'no_telp' => '081298765432',
            'address' => 'Jl. Sudirman No. 10, Bandung',
            'roles' => [RoleEnum::BENDAHARA],
        ],
        [
            'name'  => 'Pengguna ATC',
            'email' => 'user-atc@example.com',
            'no_telp' => '081212345678',
            'address' => 'Jl. Thamrin No. 5, Surabaya',
            'roles' => [RoleEnum::USER],
        ],
        [
            'name'  => 'Pengguna KLL',
            'email' => 'user-kll@example.com',
            'no_telp' => '081276543210',
            'address' => 'Jl. Gatot Subroto No. 20, Medan',
            'roles' => [RoleEnum::USER],
        ],
    ];

    public function run(): void
    {
        foreach ($this->users as $data) {
            $user = User::firstOrCreate(
                ['email' => $data['email']],
                [
                    'name'     => $data['name'],
                    'password' => Hash::make('password'), // default dev password
                    'is_superadmin' => $data['is_superadmin'] ?? false,
                ]
            );

            $roles = collect($data['roles'])
                ->map(fn (RoleEnum $role) => $role->value)
                ->toArray();

            $user->syncRoles($roles);
        }
    }
}
