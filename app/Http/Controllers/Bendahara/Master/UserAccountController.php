<?php

namespace App\Http\Controllers\Bendahara\Master;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\UserAccounts\SyncUserAccountRequest;
use App\Models\ChartOfAccount;
use App\Models\User;
use App\Services\Bendahara\UserAccountService;
use Illuminate\Http\RedirectResponse;
use Illuminate\View\View;
use Throwable;

class UserAccountController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @return View
     */
    public function index(): View
    {
        $users = User::role('ACCOUNTING USER')
            ->withCount([
                'debitCoas',
                'creditCoas'
            ])
            ->orderBy('name')
            ->get();

        return view('pages.menus.bendahara.master.user_accounts.index', compact('users'));
    }

    /**
     * Show the form for editing the specified resource.
     * 
     * @param string $id
     * @return View
     */
    public function edit(string $id): View
    {
        $user = User::with([
            'coas',
            'debitCoas',
            'creditCoas'
        ])->findOrFail($id);

        $coas = ChartOfAccount::where('is_active', true)
            ->orderBy('code')
            ->get();

        // COA yang sudah di-assign
        $assignedCoaIds = $user->coas->pluck('id')->toArray();
        $assignedDebitCoaIds = $user->debitCoas->pluck('id')->toArray();
        $assignedCreditCoaIds = $user->creditCoas->pluck('id')->toArray();

        return view('pages.menus.bendahara.master.user_accounts.edit', compact('user', 'coas', 'assignedCoaIds', 'assignedDebitCoaIds', 'assignedCreditCoaIds'));
    }


    /**
     * Sync the specified resource in storage.
     * 
     * @param string $id
     * @param UserAccountService $service
     * @param SyncUserAccountRequest $request
     * @return RedirectResponse
     * @throws Throwable
     */
    public function sync(string $id, UserAccountService $service, SyncUserAccountRequest $request): RedirectResponse
    {
        try {
            $service->sync($id, $request->validated());

            return redirect()->route('bendahara.master.account-users.index')
                ->with('success', 'Akun pengguna berhasil disinkronkan.');

        } catch (Throwable $e) {
            return redirect()->back()
                ->withInput()
                ->with('error', 'Gagal menyinkronkan akun pengguna: ' . $e->getMessage());
        }
    }
}
