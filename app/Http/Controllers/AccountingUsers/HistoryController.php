<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Models\Journal;
use App\Models\AccountType;
use App\Models\Transaction;
use Illuminate\Http\Request;
use App\Models\JournalDetail;
use App\Enums\TransactionType;
use App\Models\ChartOfAccount;
use App\Models\TransactionLine;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\Period;
use Illuminate\Support\Facades\Auth;

class HistoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $transactions = Transaction::with([
            'creator:id,name',
            'transactionLines.chartOfAccount:id,code,name'
        ])
            ->orderBy('created_at', 'desc')
            ->get();

        $transaction = Transaction::first();

        return view('pages.menus.user.histories.index', compact('transactions'));
    }
}
