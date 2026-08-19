<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Http\Controllers\Controller;
use App\Models\ChartOfAccount;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class COAController extends Controller
{
    /**
     * Display a listing of the resource for logged in user.
     */
    public function index(): View
    {
        $user = Auth::user();

        $coas = ChartOfAccount::query()
            ->whereHas('userAccounts', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->with([
                'accountType',
                'creator',
                'parent',
                'children' => function ($query) {
                    $query->orderBy('code');
                },
                'children.children' => function ($query) {
                    $query->orderBy('code');
                },
            ])
            ->orderBy('code')
            ->get();

        // Grouping berdasarkan Tipe Akun
        $groupedByType = $coas->groupBy(fn ($coa) => $coa->accountType?->name ?? 'Uncategorized');

        // Statistik Informasi COA Pengguna
        $stats = [
            'total_coa' => $coas->count(),
            'active_coa' => $coas->where('is_active', true)->count(),
            'inactive_coa' => $coas->where('is_active', false)->count(),
            'total_types' => $groupedByType->count(),
        ];

        return view('pages.menus.user.coas.index', compact('coas', 'groupedByType', 'stats'));
    }
}
