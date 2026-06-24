<?php

namespace App\Http\Controllers\Superadmin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Superadmin\Roles\UpdateRoleRequest;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RoleController extends Controller
{
    /**
     *
     * @return View
     */
    public function index(): View
    {
        $roles = Role::with('permissions')->get();
        return view('pages.menus.superadmin.roles.index', compact('roles'));
    }

    /**
     *
     * @param string $id
     * @return View
     */
    public function show(string $id): View
    {
        $role = Role::with('permissions')->findOrFail($id);
        $permissions = Permission::orderBy('group')->orderByDesc('is_default')->get();
        return view('pages.menus.superadmin.roles.show', compact('role', 'permissions'));
    }

    /**
     *
     * @return View
     */
    public function create(): View
    {
        $permissions = Permission::orderBy('group')->orderByDesc('is_default')->get();
        return view('pages.menus.superadmin.roles.create', compact('permissions'));
    }

    /**
     *
     * @param Request $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function store(Request $request): RedirectResponse
    {
        try {
            $request->validate([
                'name' => 'required|unique:roles,name',
                'permissions' => 'array',
            ]);

            $role = Role::create(['name' => strtoupper($request->input('name'))]);
            $permissions = $request->input('permissions', []);
            $role->syncPermissions($permissions);

            return redirect()
                ->route('superadmin.roles.index')
                ->with('success', 'Peran berhasil dibuat');
        } catch (Exception $e) {
            return back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat membuat peran: ' . $e->getMessage());
        }
    }

    /**
     *
     * @param Request $request
     * @param string $id
     * @return RedirectResponse
     */
    public function update(UpdateRoleRequest $request, string $id): RedirectResponse
    {
        try {
            $validated = $request->validated();

            $role = Role::findOrFail($id);
            $role->name = strtoupper($validated['name']);
            $role->save();

            $permissions = $validated['permissions'] ?? [];
            $role->syncPermissions($permissions);

            return redirect()
                ->route('superadmin.roles.index')
                ->with('success', 'Peran berhasil diperbarui');
        } catch (Exception $e) {
            return back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat memperbarui peran: ' . $e->getMessage());
        }
    }
}
