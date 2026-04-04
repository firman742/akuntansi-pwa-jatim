<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Http\Controllers\Controller;
use App\Models\SubPeriod;

class PeriodController extends Controller
{
    public function getSubPeriods($id)
    {
        return SubPeriod::where('period_id', $id)
            ->active()
            ->select('id', 'name')
            ->orderBy('start_date')
            ->get();
    }
}