<?php

use App\Http\Middleware\RoleMiddleware;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Validation\ValidationException;
use Symfony\Component\HttpKernel\Exception\HttpExceptionInterface;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__ . '/../routes/web.php',
        commands: __DIR__ . '/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {

        /*
        |--------------------------------------------------------------------------
        | Route Middleware Aliases
        |--------------------------------------------------------------------------
        | Digunakan via: Route::middleware('role:SUPER_ADMIN')
        */
        $middleware->alias([
            'role' => RoleMiddleware::class,
        ]);

        /*
        |--------------------------------------------------------------------------
        | Middleware Groups (opsional)
        |--------------------------------------------------------------------------
        */
        $middleware->group('web', [
            \Illuminate\Session\Middleware\StartSession::class,
            \Illuminate\View\Middleware\ShareErrorsFromSession::class,
            // \App\Http\Middleware\VerifyCsrfToken::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->render(function (
            Throwable $e,
            $request
        ) {

            if ($e instanceof ValidationException) {
                return null;
            }
        
            if (! $e instanceof HttpExceptionInterface) {
                return null;
            }

            
            $status = method_exists($e, 'getStatusCode')
                ? $e->getStatusCode()
                : 500;

            if (view()->exists("errors.$status")) {
                return response()->view(
                    "errors.$status",
                    [
                        'status' => $status,
                        'title' => "Error {$status}",
                        'message' => $e->getMessage(),
                    ],
                    $status
                );
            }

            return response()->view(
                'errors.default',
                [
                    'status' => $status,
                    'title' => "Error {$status}",
                    'message' => $e->getMessage(),
                ],
                $status
            );
        });
    })
    ->create();
