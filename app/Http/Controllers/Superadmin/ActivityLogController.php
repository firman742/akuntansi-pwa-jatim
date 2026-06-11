<?php

namespace App\Http\Controllers\Superadmin;

use App\Http\Controllers\Controller;
use App\Models\ActivityLog;
use Illuminate\View\View;

class ActivityLogController extends Controller
{
    /**
     * @return View
     */
    public function index(): View
    {
        $activityLogs = ActivityLog::with('user')
            ->latest()->get();

        return view('pages.menus.superadmin.activity_logs.index', compact('activityLogs'));
    }

    /**
     * @param string $id
     * @return View
     */
    public function show(string $id): View
    {
        $activityLog = ActivityLog::findOrFail($id);
        return view('pages.menus.superadmin.activity_logs.show', compact('activityLog'));
    }
}
