<?php

namespace App\Http\Controllers\Bendahara\Master;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\AccountTypes\StoreAccountTypeRequest;
use App\Http\Requests\Bendahara\AccountTypes\UpdateAccountTypeRequest;
use App\Models\AccountType;
use App\Services\Bendahara\AccountTypeService;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;

class AccountTypeController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @return View
     */
    public function index(): View
    {
        $accountTypes = AccountType::withCount('chartOfAccounts')->get();

        return view('pages.menus.bendahara.master.account-types.index', compact('accountTypes'));
    }

    /**
     * Show the form for creating a new resource.
     * 
     * @return View
     */
    public function create(): View
    {
        return view('pages.menus.bendahara.master.account-types.create');
    }

    /**
     * Store a newly created resource in storage.
     * 
     * @param AccountTypeService $service
     * @param StoreAccountTypeRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function store(AccountTypeService $service, StoreAccountTypeRequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()->route('bendahara.master.account-types.index')
                ->with('success', 'Tipe akun berhasil ditambahkan.');
        } catch (Exception $e) {
            return back()->withErrors([
                'error' => 'Gagal membuat Tipe akun: ' . $e->getMessage()
            ])->withInput();
        }
    }

    /**
     * Show the form for editing the specified resource.
     * 
     * @param string $id
     * @return View
     */
    public function edit(string $id): View
    {
        $accountType = AccountType::findOrFail($id);

        return view('pages.menus.bendahara.master.account-types.edit', compact('accountType'));
    }

    /**
     * Update the specified resource in storage.
     * 
     * @param string $id
     * @param AccountTypeService $service
     * @param UpdateAccountTypeRequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function update(string $id, AccountTypeService $service, UpdateAccountTypeRequest $request): RedirectResponse
    {
        try {
            $service->update($id, $request->validated());

            return redirect()->route('bendahara.master.account-types.index')
                ->with('success', 'Tipe akun berhasil diperbarui.');

        } catch (Exception $e) {
            return back()->withErrors([
                'error' => 'Gagal memperbarui Tipe akun: ' . $e->getMessage()
            ])->withInput();
        }
    }

    /**
     * Remove the specified resource from storage.
     * 
     * @param string $id
     * @param AccountTypeService $service
     * @return RedirectResponse
     * @throws Exception
     */
    public function destroy(string $id, AccountTypeService $service): RedirectResponse
    {
        try {
            $service->delete($id);

            return redirect()->route('bendahara.master.account-types.index')
                ->with('success', 'Tipe akun berhasil dihapus.');

        } catch (Exception $e) {
            return back()->withErrors([
                'error' => 'Gagal menghapus Tipe akun: ' . $e->getMessage()
            ]);
        }
    }
}
