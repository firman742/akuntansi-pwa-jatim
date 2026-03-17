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

    public function installMediaLibrary()
    {
        // if (!app()->environment('local')) {
        //     abort(403, 'Only allowed in local environment');
        // }

        $commands = [
            'composer require "spatie/laravel-medialibrary"',
            'php artisan vendor:publish --provider="Spatie\MediaLibrary\MediaLibraryServiceProvider" --tag="medialibrary-migrations"',
            'php artisan migrate',
            'php artisan vendor:publish --provider="Spatie\MediaLibrary\MediaLibraryServiceProvider" --tag="medialibrary-config"',
        ];

        $output = [];

        foreach ($commands as $cmd) {
            $process = Process::fromShellCommandline($cmd);
            $process->run();

            $output[] = [
                'command' => $cmd,
                'result' => $process->getOutput()
            ];
        }

        return response()->json([
            'message' => 'Media Library installation finished',
            'logs' => $output
        ]);
    }
}
