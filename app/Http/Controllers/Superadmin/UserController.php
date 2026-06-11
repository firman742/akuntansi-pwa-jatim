<?php

namespace App\Http\Controllers\Superadmin;

use App\Enums\RoleEnum;
use App\Http\Controllers\Controller;
use App\Http\Requests\Superadmin\Users\StoreUserRequest;
use App\Http\Requests\Superadmin\Users\UpdateUserRequest;
use App\Models\User;
use App\Services\Superadmin\UserService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;
use Spatie\Permission\Models\Role;

class UserController extends Controller
{
    /**
     *
     * @return View
     */
    public function index(): View
    {
        $users = User::with('roles')->get();
        return view('pages.menus.superadmin.users.index', compact('users'));
    }

    /**
     *
     * @param string $id
     * @return View
     */
    public function show(string $id): View
    {
        $user = User::with('roles')->findOrFail($id);
        return view('pages.menus.superadmin.users.show', compact('user'));
    }

    /**
     *
     * @return View
     */
    public function create(): View
    {
        $roles = Role::where('name', '!=', RoleEnum::SUPER_ADMIN->value)->pluck('name');

        return view('pages.menus.superadmin.users.create', compact('roles'));
    }

    /**
     *
     * @param UserService $service
     * @param StoreUserRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function store(UserService $service, StoreUserRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()
                ->route('superadmin.users.index')
                ->with('success', 'User berhasil ditambahkan');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat menyimpan user: ' . $e->getMessage());
        }
    }

    /**
     *
     * @param string $id
     * @return View
     */
    public function edit(string $id): View
    {
        $user = User::with('roles')->findOrFail($id);
        $roles = Role::where('name', '!=', RoleEnum::SUPER_ADMIN->value)->pluck('name');
        $userRole = $user->roles->pluck('name')->first();

        return view('pages.menus.superadmin.users.edit', compact('user', 'roles', 'userRole'));
    }

    /**
     *
     * @param string $id
     * @param UserService $service
     * @param UpdateUserRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function update(string $id, UserService $service, UpdateUserRequest $request): RedirectResponse
    {
        try {
            $service->update($id, $request->validated());

            return redirect()
                ->route('superadmin.users.index')
                ->with('success', 'User berhasil diperbarui');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat memperbarui user: ' . $e->getMessage());
        }
    }

    /**
     *
     * @param string $id
     * @param UserService $service
     * @return RedirectResponse
     * @throws Exception
     */
    public function destroy(string $id, UserService $service): RedirectResponse
    {
        try {
            $service->delete($id);

            return redirect()
                ->route('superadmin.users.index')
                ->with('success', 'User berhasil dihapus');
        } catch (Exception $e) {
            return redirect()
                ->back()
                ->with('error', 'Terjadi kesalahan saat menghapus user: ' . $e->getMessage());
        }
    }
}
