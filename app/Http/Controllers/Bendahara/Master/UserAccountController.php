<?php

namespace App\Http\Controllers\Bendahara\Master;

use App\Models\User;
use App\Models\UserAccount;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\ChartOfAccount;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;

class UserAccountController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $users = User::role('ACCOUNTING USER')
            ->withCount('coas')
            ->orderBy('name')
            ->get();

        return view('pages.menus.bendahara.master.user_accounts.index', compact('users'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $user = User::with('coas')->findOrFail($id);

        $coas = ChartOfAccount::where('is_active', true)
            ->orderBy('code')
            ->get();

        // COA yang sudah di-assign
        $assignedCoaIds = $user->coas->pluck('id')->toArray();

        return view('pages.menus.bendahara.master.user_accounts.edit', compact('user', 'coas', 'assignedCoaIds'));
    }

    public function sync(Request $request, string $id)
    {
        $request->validate([
            'coa_ids' => ['nullable', 'array'],
            'coa_ids.*' => ['exists:chart_of_accounts,id'],
        ]);

        $user = User::findOrFail($id);

        DB::transaction(function () use ($user, $request) {
            // Hapus relasi lama
            UserAccount::where('user_id', $user->id)->delete();

            // Insert baru
            if ($request->filled('coa_ids')) {
                $data = collect($request->coa_ids)->map(fn($coaId) => [
                    'id' => Str::uuid(),
                    'user_id' => $user->id,
                    'coa_id' => $coaId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ])->toArray();

                UserAccount::insert($data);
            }
        });

        return redirect()
            ->route('bendahara.master.account-user.index')
            ->with('success', 'Akun COA berhasil diperbarui.');
    }
}
