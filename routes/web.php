<?php

use App\Http\Controllers\Auth\AuthController;
use App\Models\CoaBalance;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Authentication
|--------------------------------------------------------------------------
*/

Route::middleware('guest')->group(function () {
    Route::get('/login', [AuthController::class, 'loginForm'])->name('login');
    Route::post('/login', [AuthController::class, 'login'])->name('login.post');
    Route::get('/register', [AuthController::class, 'registerForm'])->name('register');
    Route::post('/register', [AuthController::class, 'register'])->name('register.post');
});

Route::post('/logout', [AuthController::class, 'logout'])
    ->middleware('auth')
    ->name('logout');

/*
|--------------------------------------------------------------------------
| REDIRECT BASED ON ROLE
|--------------------------------------------------------------------------
*/
Route::get('/', function () {
    // Jika belum login → ke halaman login
    if (!Auth::check()) {
        return redirect()->route('login');
    }

    // Jika sudah login → redirect sesuai role
    $role = Auth::user()->getRoleNames()->first();
    $map  = config('role-redirect');

    return redirect()->route($map[$role] ?? 'login');
})->name('home');


/*
|--------------------------------------------------------------------------
| Super Admin (Global)
|--------------------------------------------------------------------------
*/
Route::middleware(['auth', 'role:SUPER ADMIN'])->prefix('superadmin')->name('superadmin.')->group(function () {
    // System Commands
    Route::post('/optimize-clear', [\App\Http\Controllers\Superadmin\SystemCommandController::class, 'optimizeClear']);
    Route::post('/migrate-fresh-seed', [\App\Http\Controllers\Superadmin\SystemCommandController::class, 'migrateFreshSeed']);
    Route::post('/npm-dev', [\App\Http\Controllers\Superadmin\SystemCommandController::class, 'npmDev']);
    Route::post('/npm-build', [\App\Http\Controllers\Superadmin\SystemCommandController::class, 'npmBuild']);

    Route::post('/install-medialibrary', [\App\Http\Controllers\Superadmin\SystemCommandController::class, 'installMediaLibrary']);

    // Dashboard
    Route::get('/dashboard', fn() => app(\App\Http\Controllers\Superadmin\DashboardController::class)->index())
        ->name('dashboard');

    // Resource
    Route::resource('users', App\Http\Controllers\Superadmin\UserController::class);
    Route::resource('roles', App\Http\Controllers\Superadmin\RoleController::class);
    Route::resource('permissions', App\Http\Controllers\Superadmin\PermissionController::class)
        ->only(['index', 'create', 'store']);


    // Activity Logs
    Route::get('/activity-logs', [App\Http\Controllers\Superadmin\ActivityLogController::class, 'index'])
        ->name('activity-logs.index');
    Route::get('/activity-logs/{id}', [App\Http\Controllers\Superadmin\ActivityLogController::class, 'show'])
        ->name('activity-logs.show');

    // Configurations
    Route::prefix('configurations')->name('configurations.')->group(function () {
        Route::get('/edit', [App\Http\Controllers\Superadmin\ConfigurationController::class, 'edit'])->name('edit');
        Route::post('/', [App\Http\Controllers\Superadmin\ConfigurationController::class, 'update'])->name('update');
    });
});

/*
|--------------------------------------------------------------------------
| Accounting Module - Bendahara
|--------------------------------------------------------------------------
*/
Route::middleware(['auth', 'role:BENDAHARA'])->prefix('bendahara')->name('bendahara.')->group(function () {

    Route::get('/dashboard', [App\Http\Controllers\Bendahara\DashboardController::class, 'index'])
        ->name('dashboard');

    /*
    |--------------------------------------------------------------------------
    | PERIOD
    |--------------------------------------------------------------------------
    */
    Route::prefix('periods')->name('periods.')->group(function () {
        Route::get('/', [App\Http\Controllers\Bendahara\PeriodController::class, 'index'])->name('index');
        Route::get('/create', [App\Http\Controllers\Bendahara\PeriodController::class, 'create'])->name('create');
        Route::post('/', [App\Http\Controllers\Bendahara\PeriodController::class, 'store'])->name('store');
        Route::get('/{id}/edit', [App\Http\Controllers\Bendahara\PeriodController::class, 'edit'])->name('edit');
        Route::put('/{id}', [App\Http\Controllers\Bendahara\PeriodController::class, 'update'])->name('update');
        Route::delete('/{id}', [App\Http\Controllers\Bendahara\PeriodController::class, 'destroy'])->name('destroy');

        Route::patch('/{id}/close', [App\Http\Controllers\Bendahara\PeriodController::class, 'close'])
            ->name('close');

        Route::get('/{id}/sub-periods', [App\Http\Controllers\Bendahara\PeriodController::class, 'getSubPeriods'])
            ->name('sub-periods');
    });

    /*
    |--------------------------------------------------------------------------
    | SUB PERIOD
    |--------------------------------------------------------------------------
    */
    Route::prefix('sub-periods')->name('sub-periods.')->group(function () {
        Route::get('/', [App\Http\Controllers\Bendahara\SubPeriodController::class, 'index'])->name('index');
        Route::get('/create', [App\Http\Controllers\Bendahara\SubPeriodController::class, 'create'])->name('create');
        Route::post('/', [App\Http\Controllers\Bendahara\SubPeriodController::class, 'store'])->name('store');
        Route::get('/{id}/edit', [App\Http\Controllers\Bendahara\SubPeriodController::class, 'edit'])->name('edit');
        Route::put('/{id}', [App\Http\Controllers\Bendahara\SubPeriodController::class, 'update'])->name('update');
        Route::delete('/{id}', [App\Http\Controllers\Bendahara\SubPeriodController::class, 'destroy'])->name('destroy');
    });

    /*
    |--------------------------------------------------------------------------
    | MASTER DATA
    |--------------------------------------------------------------------------
    */
    Route::prefix('master')->name('master.')->group(function () {

        // Account Type
        Route::prefix('account-types')->name('account-types.')->group(function () {
            Route::get('/', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'index'])->name('index');
            Route::get('/create', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'create'])->name('create');
            Route::post('/', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'store'])->name('store');
            Route::get('/{id}/edit', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'edit'])->name('edit');
            Route::put('/{id}', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'update'])->name('update');
            Route::delete('/{id}', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'destroy'])->name('destroy');
        });

        // COA
        Route::prefix('coas')->name('coas.')->group(function () {
            Route::get('/', [App\Http\Controllers\Bendahara\Master\COAController::class, 'index'])->name('index');
            Route::get('/create-child', [App\Http\Controllers\Bendahara\Master\COAController::class, 'createChild'])->name('create-child');
            Route::get('/create-parent', [App\Http\Controllers\Bendahara\Master\COAController::class, 'createParent'])->name('create-parent');
            Route::get('/generate-code', [App\Http\Controllers\Bendahara\Master\COAController::class, 'generateCodeApi'])->name('generate-code');
            Route::post('/', [App\Http\Controllers\Bendahara\Master\COAController::class, 'store'])->name('store');
            Route::get('/{id}/children', [App\Http\Controllers\Bendahara\Master\COAController::class, 'getChildren'])->name('children');
            Route::get('/{id}/edit', [App\Http\Controllers\Bendahara\Master\COAController::class, 'edit'])->name('edit');
            Route::put('/{id}', [App\Http\Controllers\Bendahara\Master\COAController::class, 'update'])->name('update');
            Route::delete('/{id}', [App\Http\Controllers\Bendahara\Master\COAController::class, 'destroy'])->name('destroy');
        });

        // User Account
        Route::prefix('account-users')->name('account-users.')->group(function () {
            Route::get('/', [App\Http\Controllers\Bendahara\Master\UserAccountController::class, 'index'])->name('index');
            Route::get('/{id}/edit', [App\Http\Controllers\Bendahara\Master\UserAccountController::class, 'edit'])->name('edit');
            Route::post('/{id}', [App\Http\Controllers\Bendahara\Master\UserAccountController::class, 'sync'])->name('sync');
        });

        // request COA
        Route::prefix('requests')->name('requests.')->group(function () {
            Route::get('/coas', [App\Http\Controllers\Bendahara\Master\RequestCoaController::class, 'index'])->name('coas.index');
            Route::get('/coas/{id}', [App\Http\Controllers\Bendahara\Master\RequestCoaController::class, 'show'])->name('coas.show');
            Route::post('/coas/{id}/approve', [App\Http\Controllers\Bendahara\Master\RequestCoaController::class, 'approve'])->name('coas.approve');
            Route::post('/coas/{id}/reject', [App\Http\Controllers\Bendahara\Master\RequestCoaController::class, 'reject'])->name('coas.reject');
        });
    });

    /*
    |--------------------------------------------------------------------------
    | API FOR DYNAMIC FORM
    |--------------------------------------------------------------------------
    */
    Route::get('/coa-balances/{coa}', function ($coa) {
        $sub = request('sub_period_id');


        $balance = CoaBalance::where('chart_of_account_id', $coa)
            ->where('sub_period_id', $sub->id)
            ->first();

        return response()->json([
            'current_balance' => $balance->current_balance ?? 0
        ]);
    });

    Route::get('/coa-available-fund/{coa}', function ($coa) {

        $periodId = request('period_id');
        $subPeriodId = request('sub_period_id');

        /**
         * 1. PRIORITY: COA BALANCE
         */
        $balance = \App\Models\CoaBalance::where('chart_of_account_id', $coa)
            ->where('period_id', $periodId)
            ->where('sub_period_id', $subPeriodId)
            ->first();

        if ($balance && $balance->current_balance !== null) {
            return response()->json([
                'available' => (float) $balance->current_balance,
                'source' => 'coa_balance'
            ]);
        }

        /**
         * 2. FALLBACK: OPENING BALANCE
         * (kalau sistem kamu pakai opening_balance sebagai baseline)
         */
        $opening = \App\Models\OpeningBalance::where('chart_of_account_id', $coa)
            ->where('period_id', $periodId)
            ->where('sub_period_id', $subPeriodId)
            ->first();

        if ($opening) {
            return response()->json([
                'available' => (float) $opening->amount,
                'source' => 'opening_balance'
            ]);
        }

        /**
         * 3. DEFAULT
         */
        return response()->json([
            'available' => 0,
            'source' => null
        ]);
    });
    /*
    |--------------------------------------------------------------------------
    | OPENING BALANCE
    |--------------------------------------------------------------------------
    */
    Route::prefix('opening-balances')->name('opening-balances.')->group(function () {
        Route::get('/', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'index'])->name('index');
        Route::get('/get-last-closing', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'getLastClosingBalance'])->name('get-last-balance');
        Route::get('/create', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'create'])->name('create');
        Route::post('/', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'store'])->name('store');

        Route::get('/bulk/create', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'createBulk'])->name('create-bulk');
        Route::post('/bulk', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'storeBulk'])->name('store-bulk');

        Route::get('/{id}/edit', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'edit'])->name('edit');
        Route::put('/{id}', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'update'])->name('update');
        Route::delete('/{id}', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'destroy'])->name('destroy');
    });

    /*
    |--------------------------------------------------------------------------
    | BUDGET ALLOCATION
    |--------------------------------------------------------------------------
    */
    Route::prefix('budget-allocations')->name('budget-allocations.')->group(function () {
        Route::get('/', [App\Http\Controllers\Bendahara\BudgetAllocationController::class, 'index'])->name('index');
        Route::get('/create', [App\Http\Controllers\Bendahara\BudgetAllocationController::class, 'create'])->name('create');
        Route::post('/', [App\Http\Controllers\Bendahara\BudgetAllocationController::class, 'store'])->name('store');
        Route::get('/{id}/edit', [App\Http\Controllers\Bendahara\BudgetAllocationController::class, 'edit'])->name('edit');
        Route::put('/{id}', [App\Http\Controllers\Bendahara\BudgetAllocationController::class, 'update'])->name('update');
        Route::delete('/{id}', [App\Http\Controllers\Bendahara\BudgetAllocationController::class, 'destroy'])->name('destroy');
    });

    /*
    |--------------------------------------------------------------------------
    | USER ACCOUNT BALANCE
    |--------------------------------------------------------------------------
    */
    Route::prefix('user-account-balances')->name('user-account-balances.')->group(function () {
        Route::get('/', [App\Http\Controllers\Bendahara\UserAccountBalanceController::class, 'index'])->name('index');
        Route::get('/create', [App\Http\Controllers\Bendahara\UserAccountBalanceController::class, 'create'])->name('create');
        Route::post('/', [App\Http\Controllers\Bendahara\UserAccountBalanceController::class, 'store'])->name('store');
        Route::get('/coas/{coa}/users', [App\Http\Controllers\Bendahara\UserAccountBalanceController::class, 'getUserAccountsByCoa'])->name('users-by-coa');
    });

    /*
    |--------------------------------------------------------------------------
    | REQUEST BALANCE
    |--------------------------------------------------------------------------
    */
    Route::prefix('requests')->name('requests.')->group(function () {
        Route::get('/balances', [App\Http\Controllers\Bendahara\BalanceRequestController::class, 'index'])->name('balances.index');
        Route::get('/balances/create', [App\Http\Controllers\Bendahara\BalanceRequestController::class, 'create'])->name('balances.create');
        Route::post('/balances', [App\Http\Controllers\Bendahara\BalanceRequestController::class, 'store'])->name('balances.store');
        Route::get('/balances/{id}', [App\Http\Controllers\Bendahara\BalanceRequestController::class, 'show'])->name('balances.show');
        Route::post('/balances/{id}/approve', [App\Http\Controllers\Bendahara\BalanceRequestController::class, 'approve'])->name('balances.approve');
        Route::post('/balances/{id}/reject', [App\Http\Controllers\Bendahara\BalanceRequestController::class, 'reject'])->name('balances.reject');
    });

    /*
    |--------------------------------------------------------------------------
    | REPORTS
    |--------------------------------------------------------------------------
    */
    Route::prefix('reports')->name('reports.')->group(function () {
        Route::get('/journal', [App\Http\Controllers\Bendahara\JournalController::class, 'index'])->name('journal.index');
        Route::get('/journal/{id}', [App\Http\Controllers\Bendahara\JournalController::class, 'show'])->name('journal.show');
        Route::get('/journal/export/{type}', [App\Http\Controllers\Bendahara\JournalController::class, 'export'])->name('journal.export');

        Route::get('/ledger', [App\Http\Controllers\Bendahara\LedgerController::class, 'index'])->name('ledger.index');
        Route::get('/ledger/export', [App\Http\Controllers\Bendahara\LedgerController::class, 'export'])->name('ledger.export');

        Route::get('/activity', [App\Http\Controllers\Bendahara\ActivityReportController::class, 'index'])->name('activity.index');

        Route::get('/trial-balance', [App\Http\Controllers\Bendahara\TrialBalanceController::class, 'index'])->name('trial-balance.index');

        Route::get('/transactions', [App\Http\Controllers\Bendahara\TransactionController::class, 'index'])->name('transactions.index');
        Route::get('/transactions/{id}', [App\Http\Controllers\Bendahara\TransactionController::class, 'show'])->name('transactions.show');
    });
});

/*
|--------------------------------------------------------------------------
| Accounting Module - User
|--------------------------------------------------------------------------
*/
Route::middleware(['auth', 'role:ACCOUNTING USER'])->prefix('user')->name('user.')->group(function () {

    Route::get('/dashboard', [App\Http\Controllers\AccountingUsers\DashboardController::class, 'index'])
        ->name('dashboard');


    /*
    |--------------------------------------------------------------------------
    | COA
    |--------------------------------------------------------------------------
    */
    Route::prefix('coas')->name('coas.')->group(function () {
        Route::get('/', [App\Http\Controllers\AccountingUsers\COAController::class, 'index'])->name('index');
        Route::get('/{id}/children', [App\Http\Controllers\AccountingUsers\COAController::class, 'getChildren'])->name('children');
    });

    /*
    |--------------------------------------------------------------------------
    | USER ACCOUNT BALANCE
    |--------------------------------------------------------------------------
    */
    Route::prefix('user-account-balances')->name('user-account-balances.')->group(function () {
        Route::get('/', [App\Http\Controllers\AccountingUsers\UserAccountBalanceController::class, 'index'])->name('index');
        Route::get('/{id}', [App\Http\Controllers\AccountingUsers\UserAccountBalanceController::class, 'show'])->name('show');
    });

    /*
    |--------------------------------------------------------------------------
    | PERIOD HELPER
    |--------------------------------------------------------------------------
    */
    Route::prefix('periode')->name('periods.')->group(function () {
        Route::get('/{id}/sub-periods', [App\Http\Controllers\AccountingUsers\PeriodController::class, 'getSubPeriods'])
            ->name('sub-periods');
    });

    /*
    |--------------------------------------------------------------------------
    | TRANSACTIONS
    |--------------------------------------------------------------------------
    */
    Route::prefix('transactions')->name('transactions.')->group(function () {
        // transaction
        Route::get('/cash-balance', [App\Http\Controllers\AccountingUsers\IncomeController::class, 'getCashBalance'])->name('cash-balance');
        Route::get('/create', [App\Http\Controllers\AccountingUsers\TransactionController::class, 'create'])->name('create');
        Route::post('/', [App\Http\Controllers\AccountingUsers\TransactionController::class, 'store'])->name('store');

        // // Income
        // Route::prefix('incomes')->name('incomes.')->group(function () {
        //     Route::get('/', [App\Http\Controllers\AccountingUsers\IncomeController::class, 'index'])->name('index');
        //     Route::get('/cash-balance', [App\Http\Controllers\AccountingUsers\IncomeController::class, 'getCashBalance'])->name('cash-balance');
        //     Route::get('/create', [App\Http\Controllers\AccountingUsers\IncomeController::class, 'create'])->name('create');
        //     Route::post('/', [App\Http\Controllers\AccountingUsers\IncomeController::class, 'store'])->name('store');
        //     Route::get('/{id}', [App\Http\Controllers\AccountingUsers\IncomeController::class, 'show'])->name('show');
        // });

        // // Expense
        // Route::prefix('expenses')->name('expenses.')->group(function () {
        //     Route::get('/', [App\Http\Controllers\AccountingUsers\ExpenseController::class, 'index'])->name('index');
        //     Route::get('/cash-balance', [App\Http\Controllers\AccountingUsers\ExpenseController::class, 'getCashBalance'])->name('cash-balance');
        //     Route::get('/create', [App\Http\Controllers\AccountingUsers\ExpenseController::class, 'create'])->name('create');
        //     Route::post('/', [App\Http\Controllers\AccountingUsers\ExpenseController::class, 'store'])->name('store');
        //     Route::get('/{id}', [App\Http\Controllers\AccountingUsers\ExpenseController::class, 'show'])->name('show');
        // });

        // History
        Route::prefix('histories')->name('histories.')->group(function () {
            Route::get('/', [App\Http\Controllers\AccountingUsers\HistoryController::class, 'index'])->name('index');
            Route::get('/{id}', [App\Http\Controllers\AccountingUsers\HistoryController::class, 'show'])->name('show');
        });
    });

    /*
    |--------------------------------------------------------------------------
    | COA REQUEST
    |--------------------------------------------------------------------------
    */
    Route::prefix('requests')->name('requests.')->group(function () {
        // COA Request
        Route::prefix('coas')->name('coas.')->group(function () {
            Route::get('/', [App\Http\Controllers\AccountingUsers\CoaRequestController::class, 'index'])->name('index');
            Route::get('/create', [App\Http\Controllers\AccountingUsers\CoaRequestController::class, 'create'])->name('create');
            Route::post('/', [App\Http\Controllers\AccountingUsers\CoaRequestController::class, 'store'])->name('store');
            Route::get('/generate-code', [App\Http\Controllers\AccountingUsers\CoaRequestController::class, 'generateCodeApi'])->name('generate-code');
            Route::get('/{id}', [App\Http\Controllers\AccountingUsers\CoaRequestController::class, 'show'])->name('show');
        });

        // Balance Request
        Route::prefix('balances')->name('balances.')->group(function () {
            Route::get('/', [App\Http\Controllers\AccountingUsers\BalanceRequestController::class, 'index'])->name('index');
            Route::get('/create', [App\Http\Controllers\AccountingUsers\BalanceRequestController::class, 'create'])->name('create');
            Route::post('/', [App\Http\Controllers\AccountingUsers\BalanceRequestController::class, 'store'])->name('store');
            Route::get('/{id}', [App\Http\Controllers\AccountingUsers\BalanceRequestController::class, 'show'])->name('show');
        });
    });
});
