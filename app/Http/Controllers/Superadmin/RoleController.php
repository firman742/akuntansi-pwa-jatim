<?php

namespace App\Http\Controllers\Superadmin;

use App\Models\User;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Permission;

class RoleController extends Controller
{
    public function index()
    {
        $roles = Role::with('permissions')->get();
        return view('pages.menus.superadmin.roles.index', compact('roles'));
    }

    public function show(string $id)
    {
        $role = Role::with('permissions')->findOrFail($id);
        $permissions = Permission::orderBy('group')->orderByDesc('is_default')->get();
        return view('pages.menus.superadmin.roles.show', compact('role', 'permissions'));
    }
   
    public function update(Request $request, string $id)
    {
        $role = Role::findOrFail($id);
        $permissions = $request->input('permissions', []);

        $role->syncPermissions($permissions);

        return redirect()->route('superadmin.roles.index')->with('success', 'Role updated successfully');
    }

}
