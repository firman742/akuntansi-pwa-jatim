<?php

namespace App\Http\Controllers\AccountingUsers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class DashboardController extends Controller
{
    public function index()
    {
        return view('pages.menus.user.dashboard');
    }
}
