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
            abort(401, 'Unauthorized');
        }

        if (! method_exists($user, 'getRoleNames')) {
            abort(500, 'Role system not configured on User model');
        }

        $userRole = $user->getRoleNames()->first();

        if (! $userRole) {
            abort(403, 'User has no role');
        }

        if (! in_array($userRole, $roles, true)) {
            abort(403, 'You do not have access to this module');
        }

        return $next($request);
    }
}
