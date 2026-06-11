<?php

namespace App\Http\Controllers\Superadmin;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class PermissionController extends Controller
{
    public function create()
    {
        $permissions = Permission::orderBy('group')->orderByDesc('is_default')->get();
        return view('pages.menus.superadmin.roles.create', compact('permissions'));
    }

    public function store(Request $request)
    {
        try {
            $validated = $request->validate([
                'name'        => 'required|string|unique:roles,name',
                'permissions' => 'array',
                'permissions.*' => 'exists:permissions,id',
            ]);
    
            $role = Role::create(['name' => $validated['name']]);
    
            if (!empty($validated['permissions'])) {
                $role->syncPermissions($validated['permissions']);
            }
    
            return redirect()
                ->route('roles.index')
                ->with('success', 'Role berhasil ditambahkan');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat menyimpan role: ' . $e->getMessage());
        }
    }

}
