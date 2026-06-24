<?php

namespace App\Http\Controllers\Superadmin;

use App\Http\Controllers\Controller;
use App\Models\ActivityLog;
use Illuminate\Http\Request;
use Illuminate\View\View;

class ActivityLogController extends Controller
{
    /**
     * @return View
     */
    public function index(Request $request): View
    {
        $search = $request->input('search');

        $activityLogs = ActivityLog::with('user')
            ->when($search, function ($query, $search) {
                $query->where('description', 'like', "%{$search}%")
                    ->orWhereHas('user', function ($query) use ($search) {
                        $query->where('name', 'like', "%{$search}%");
                    });
            })->get();
            
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
