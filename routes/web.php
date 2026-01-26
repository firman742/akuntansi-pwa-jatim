<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthController;

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
Route::middleware(['auth', 'role:SUPER ADMIN'])->group(function () {

    // System Commands (only in local environment)
    Route::post('/optimize-clear', [\App\Http\Controllers\Superadmin\SystemCommandController::class, 'optimizeClear']);
    Route::post('/migrate-fresh-seed', [\App\Http\Controllers\Superadmin\SystemCommandController::class, 'migrateFreshSeed']);
    Route::post('/npm-dev', [\App\Http\Controllers\Superadmin\SystemCommandController::class, 'npmDev']);
    Route::post('/npm-build', [\App\Http\Controllers\Superadmin\SystemCommandController::class, 'npmBuild']);
    
    // Dashboard
    Route::get('/dashboard', fn() => app(\App\Http\Controllers\Superadmin\DashboardController::class)->index())
        ->name('dashboard');

    // User Management
    Route::resource('users', App\Http\Controllers\Superadmin\UserController::class);
    // role management
    Route::resource('roles', App\Http\Controllers\Superadmin\RoleController::class);
    // permission management
    Route::resource('permissions', App\Http\Controllers\Superadmin\PermissionController::class)->only(['index', 'create', 'store']);

});

/*
|--------------------------------------------------------------------------
| Accounting Module - Bendahara
|--------------------------------------------------------------------------
*/
Route::middleware(['auth', 'role:BENDAHARA'])->prefix('bendahara')->group(function () {

    Route::get('/dashboard', [App\Http\Controllers\Bendahara\DashboardController::class, 'index'])->name('bendahara.dashboard');

    // Period Routes
    Route::get('/periode', [App\Http\Controllers\Bendahara\PeriodController::class, 'index'])->name('bendahara.periode.index');
    Route::get('/periode/create', [App\Http\Controllers\Bendahara\PeriodController::class, 'create'])->name('bendahara.periode.create');
    Route::post('/periode', [App\Http\Controllers\Bendahara\PeriodController::class, 'store'])->name('bendahara.periode.store');
    Route::get('/periode/{id}/edit', [App\Http\Controllers\Bendahara\PeriodController::class, 'edit'])->name('bendahara.periode.edit');
    Route::put('/periode/{id}', [App\Http\Controllers\Bendahara\PeriodController::class, 'update'])->name('bendahara.periode.update');
    Route::patch('/periode/{id}/close', [App\Http\Controllers\Bendahara\PeriodController::class, 'close'])->name('bendahara.periode.close');
    Route::delete('/periode/{id}', [App\Http\Controllers\Bendahara\PeriodController::class, 'destroy'])->name('bendahara.periode.destroy');

    // Master Data - Account Type Routes
    Route::get('/master/account-type', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'index'])->name('bendahara.master.account-type.index');
    Route::get('/master/account-type/create', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'create'])->name('bendahara.master.account-type.create');
    Route::post('/master/account-type', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'store'])->name('bendahara.master.account-type.store');
    Route::get('/master/account-type/{id}/edit', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'edit'])->name('bendahara.master.account-type.edit');
    Route::put('/master/account-type/{id}', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'update'])->name('bendahara.master.account-type.update');
    Route::delete('/master/account-type/{id}', [App\Http\Controllers\Bendahara\Master\AccountTypeController::class, 'destroy'])->name('bendahara.master.account-type.destroy');

     // Master Data - COA Routes
    Route::get('/master/coa', [App\Http\Controllers\Bendahara\Master\COAController::class, 'index'])->name('bendahara.master.coa.index');
    Route::get('/master/coa/create', [App\Http\Controllers\Bendahara\Master\COAController::class, 'create'])->name('bendahara.master.coa.create');
    Route::get('/master/coa/generate-code', [App\Http\Controllers\Bendahara\Master\COAController::class, 'generateCodeApi'])->name('bendahara.master.coa.generate-code');
    Route::post('/master/coa', [App\Http\Controllers\Bendahara\Master\COAController::class, 'store'])->name('bendahara.master.coa.store');
    Route::get('/master/coa/{id}/edit', [App\Http\Controllers\Bendahara\Master\COAController::class, 'edit'])->name('bendahara.master.coa.edit');
    Route::put('/master/coa/{id}', [App\Http\Controllers\Bendahara\Master\COAController::class, 'update'])->name('bendahara.master.coa.update');
    Route::delete('/master/coa/{id}', [App\Http\Controllers\Bendahara\Master\COAController::class, 'destroy'])->name('bendahara.master.coa.destroy');

    // Master Data - User Account Routes
    Route::get('/master/account-user', [App\Http\Controllers\Bendahara\Master\UserAccountController::class, 'index'])->name('bendahara.master.account-user.index');
    Route::get('/master/account-user/{id}/edit', [App\Http\Controllers\Bendahara\Master\UserAccountController::class, 'edit'])->name('bendahara.master.account-user.edit');
    Route::post('/master/account-user/{id}', [App\Http\Controllers\Bendahara\Master\UserAccountController::class, 'sync'])->name('bendahara.master.account-user.sync');

    // Opening Balance Routes
    Route::get('/saldo-awal', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'index'])->name('bendahara.opening-balances.index');
    Route::get('/saldo-awal/create', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'create'])->name('bendahara.opening-balances.create');
    Route::post('/saldo-awal', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'store'])->name('bendahara.opening-balances.store');
    Route::get('/saldo-awal/{id}/edit', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'edit'])->name('bendahara.opening-balances.edit');
    Route::put('/saldo-awal/{id}', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'update'])->name('bendahara.opening-balances.update');
    Route::delete('/saldo-awal/{id}', [App\Http\Controllers\Bendahara\OpeningBalanceController::class, 'destroy'])->name('bendahara.opening-balances.destroy');


    // journal routes
    Route::get('/jurnal-umum', [App\Http\Controllers\Bendahara\JournalController::class, 'index'])->name('bendahara.journals.index');
    Route::get('/jurnal-umum/{id}', [App\Http\Controllers\Bendahara\JournalController::class, 'show'])->name('bendahara.journals.show');

});

/*
|--------------------------------------------------------------------------
| Accounting Module - User
|--------------------------------------------------------------------------
*/
Route::middleware(['auth', 'role:ACCOUNTING USER'])->prefix('user')->group(function () {

    Route::get('/dashboard', [App\Http\Controllers\Accountingusers\DashboardController::class, 'index'])->name('user.dashboard');

    // Income Routes
    Route::get('/transaksi/penerimaan', [App\Http\Controllers\Accountingusers\IncomeController::class, 'index'])->name('user.incomes.index');
    Route::get('transaksi/penerimaan/create', [App\Http\Controllers\Accountingusers\IncomeController::class, 'create'])->name('user.incomes.create');
    Route::post('transaksi/penerimaan', [App\Http\Controllers\Accountingusers\IncomeController::class, 'store'])->name('user.incomes.store');
    Route::get('transaksi/penerimaan/{id}', [App\Http\Controllers\Accountingusers\IncomeController::class, 'show'])->name('user.incomes.show');
    

    // Expense Routes
    Route::get('/transaksi/pengeluaran', [App\Http\Controllers\Accountingusers\ExpenseController::class, 'index'])->name('user.expenses.index');
    Route::get('transaksi/pengeluaran/create', [App\Http\Controllers\Accountingusers\ExpenseController::class, 'create'])->name('user.expenses.create');
    Route::post('transaksi/pengeluaran', [App\Http\Controllers\Accountingusers\ExpenseController::class, 'store'])->name('user.expenses.store');
    Route::get('transaksi/pengeluaran/{id}', [App\Http\Controllers\Accountingusers\ExpenseController::class, 'show'])->name('user.expenses.show');

    // History Routes
    Route::get('/transaksi/history', [App\Http\Controllers\Accountingusers\HistoryController::class, 'index'])->name('user.histories.index');
});
