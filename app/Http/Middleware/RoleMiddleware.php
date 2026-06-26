<?php

namespace App\Http\Middleware;

use App\Enums\RoleEnum;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RoleMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  Request  $request
     * @param  Closure  $next
     * @param  string[] ...$roles
     */
    public function handle(Request $request, Closure $next, ...$roles): Response
    {
        $user = $request->user();

        if (! $user) {
            abort(401, 'Anda harus login untuk mengakses halaman ini');
        }

        if (! method_exists($user, 'getRoleNames')) {
            abort(500, 'Pengguna tidak memiliki metode getRoleNames. Pastikan model User menggunakan trait HasRoles dari Spatie.');
        }

        $userRoles = $user->getRoleNames()->toArray();

        if (empty($userRoles)) {
            abort(403, 'Pengguna tidak memiliki peran yang valid');
        }

        if (empty(array_intersect($userRoles, $roles))) {
            abort(403, 'Anda tidak memiliki akses ke halaman ini');
        }

        return $next($request);
    }
}
