<?php

namespace App\Http\Controllers\Bendahara;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Journal;
use App\Models\Transaction;

class DashboardController extends Controller
{
    public function index()
    {
        $recentTransactions = Transaction::latest()
            ->take(5)
            ->get();

        $recentJournals = Journal::latest()
            ->take(5)
            ->get();

        $transferType = \App\Enums\TransactionType::TRANSFER->value;

        return view('pages.menus.bendahara.dashboard', compact('recentTransactions', 'recentJournals', 'transferType'));
    }
}
