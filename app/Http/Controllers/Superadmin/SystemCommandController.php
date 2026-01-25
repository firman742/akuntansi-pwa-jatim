<?php

namespace App\Http\Controllers\Superadmin;

use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Symfony\Component\Process\Process;
use Illuminate\Support\Facades\Artisan;

class SystemCommandController extends Controller
{
    private function guard()
    {
        if (!app()->environment('production')) {
            abort(403, 'Only allowed in local environment');
        }
    }

    public function optimizeClear(): JsonResponse
    {
        $this->guard();
        Artisan::call('optimize:clear');

        return response()->json(['message' => 'Optimize clear executed']);
    }

    public function migrateFreshSeed(): JsonResponse
    {
        $this->guard();
        Artisan::call('migrate:fresh', ['--seed' => true]);

        return response()->json(['message' => 'Database refreshed & seeded']);
    }

    public function npmDev(): JsonResponse
    {
        $this->guard();

        Process::fromShellCommandline('npm run dev')->start();

        return response()->json(['message' => 'npm run dev started']);
    }

    public function npmBuild(): JsonResponse
    {
        $this->guard();

        $process = Process::fromShellCommandline('npm run build');
        $process->run();

        return response()->json(['message' => 'npm run build finished']);
    }
}
