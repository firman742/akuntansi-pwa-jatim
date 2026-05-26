<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Http\Controllers\Controller;
use App\Models\ChartOfAccount;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class COAController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return View
     */
    public function index(): View
    {
        $user = Auth::user();

        $coas = ChartOfAccount::query()
            ->whereHas('userAccounts', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->with('parent')
            ->orderBy('code')
            ->get();

        return view('pages.menus.user.coas.index', compact('coas'));
    }
}