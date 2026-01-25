<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use App\Enums\PermissionEnum;
use App\Enums\RoleEnum;
use Spatie\Permission\PermissionRegistrar;

class RolePermissionSeeder extends Seeder
{
    public function run(): void
    {
        app(PermissionRegistrar::class)->forgetCachedPermissions();

        // 1. Create permissions dynamically
        foreach (PermissionEnum::cases() as $permissionEnum) {
            Permission::firstOrCreate([
                'name' => $permissionEnum->value,
                'guard_name' => 'web',
                'group' => $permissionEnum->group(),
                'description' => $permissionEnum->description(),
                'is_default' => $permissionEnum->isDefault(),
            ]);
        }

        // 2. Create roles + assign permissions
        foreach (RoleEnum::cases() as $roleEnum) {
            $role = Role::firstOrCreate([
                'name' => $roleEnum->value,
                'guard_name' => 'web',
            ]);

            $permissionNames = collect($roleEnum->permissions())
                ->map(fn ($p) => $p->value)
                ->toArray();

            $role->syncPermissions($permissionNames);
        }
    }
}
