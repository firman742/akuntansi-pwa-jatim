<?php

namespace App\Http\Controllers\Superadmin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;

class UserController extends Controller
{
    public function index()
    {
        $users = User::with('roles')->get();
        return view('pages.menus.superadmin.users.index', compact('users'));
    }

    public function show(string $id)
    {
        $user = User::with('roles')->findOrFail($id);
        return view('pages.menus.superadmin.users.show', compact('user'));
    }

    public function create()
    {
        $roles = Role::pluck('name');
        return view('pages.menus.superadmin.users.create', compact('roles'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'      => 'required|string|max:255',
            'no_telp'   => 'nullable|string|max:20',
            'email'     => 'required|email|unique:users,email',
            'address'   => 'nullable|string',
            'role'      => 'required|exists:roles,name',
            'password'  => 'required|string|min:8|confirmed',
        ]);

        $user = User::create([
            'name'     => $validated['name'],
            'no_telp'  => $validated['no_telp'] ?? null,
            'email'    => $validated['email'],
            'address'  => $validated['address'] ?? null,
            'password' => Hash::make($validated['password']),
        ]);

        $user->assignRole($validated['role']);

        return redirect()
            ->route('users.index')
            ->with('success', 'User berhasil ditambahkan');
    }

    public function edit(string $id)
    {
        $user = User::with('roles')->findOrFail($id);
        $roles = Role::pluck('name');
        $userRole = $user->roles->pluck('name')->first();

        return view('pages.menus.superadmin.users.edit', compact('user', 'roles', 'userRole'));
    }

    public function update(Request $request, string $id)
    {
        $user = User::findOrFail($id);

        $validated = $request->validate([
            'name'      => 'required|string|max:255',
            'no_telp'   => 'nullable|string|max:20',
            'email'     => 'required|email|unique:users,email,' . $user->id,
            'address'   => 'nullable|string',
            'role'      => 'required|exists:roles,name',
        ]);

        $user->update([
            'name'    => $validated['name'],
            'no_telp' => $validated['no_telp'] ?? null,
            'email'   => $validated['email'],
            'address' => $validated['address'] ?? null,
        ]);

        $user->syncRoles([$validated['role']]);

        return redirect()
            ->route('users.index')
            ->with('success', 'User berhasil diperbarui');
    }

    public function destroy(string $id)
    {
        $user = User::findOrFail($id);

        // optional: lepas role & permission
        $user->syncRoles([]);
        $user->permissions()->detach();

        // soft delete
        $user->delete();

        return redirect()
            ->route('users.index')
            ->with('success', 'User berhasil dihapus');
    }
}
