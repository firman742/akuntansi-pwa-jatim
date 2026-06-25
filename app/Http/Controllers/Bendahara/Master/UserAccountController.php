<?php

namespace App\Http\Controllers\Bendahara\Master;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\UserAccounts\SyncUserAccountRequest;
use App\Models\ChartOfAccount;
use App\Models\User;
use App\Services\Bendahara\UserAccountService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Throwable;

class UserAccountController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @param Request $request
     * @return View
     */
    public function index(Request $request): View
    {
        $search = $request->query('search');

        $users = User::role('ACCOUNTING USER')
            ->withCount([
                'debitCoas',
                'creditCoas'
            ])
            ->when($search, function ($query, $search) {
                $query->where('name', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%");
            })
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

            return redirect()
                ->route('bendahara.master.account-users.index')
                ->with('success', 'Penanggung Jawab Akun COA berhasil disinkronkan.');

        } catch (Throwable $e) {
            return back()
                ->withInput()
                ->with('error', 'Gagal menyinkronkan penanggung jawab akun: ' . $e->getMessage());
        }
    }
}
