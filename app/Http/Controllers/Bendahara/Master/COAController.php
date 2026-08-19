<?php

namespace App\Http\Controllers\Bendahara\Master;

use App\Enums\NormalBalanceEnum;
use App\Http\Controllers\Controller;
use App\Http\Requests\Bendahara\Coas\StoreCOARequest;
use App\Http\Requests\Bendahara\Coas\UpdateCOARequest;
use App\Models\AccountType;
use App\Models\ChartOfAccount;
use App\Services\Bendahara\CoaService;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class COAController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): View
    {
        $chartOfAccounts = ChartOfAccount::with([
            'accountType',
            'creator',
            'parent',
            'children' => function ($query) {
                $query->orderBy('code');
            },
            'children.children' => function ($query) {
                $query->orderBy('code');
            }
        ])
            ->orderBy('code')
            ->get();

        $groupedByType = $chartOfAccounts->groupBy(fn($coa) => $coa->accountType?->name ?? 'Uncategorized')
            ->map(fn($group) => $group->sortBy('code'));

        // Statistik Informasi Seluruh COA Sistem
        $stats = [
            'total_coa' => $chartOfAccounts->count(),
            'active_coa' => $chartOfAccounts->where('is_active', true)->count(),
            'inactive_coa' => $chartOfAccounts->where('is_active', false)->count(),
            'total_types' => $groupedByType->count(),
        ];

        return view('pages.menus.bendahara.master.coa.index', compact('groupedByType', 'stats'));
    }

    /**
     * Get children COA for a given parent ID (JSON FOR API)
     */
    public function getChildren(string $id): JsonResponse
    {
        $children = ChartOfAccount::with('accountType')
            ->where('parent_id', $id)
            ->orderBy('code')
            ->get();

        return response()->json($children);
    }

    /**
     * Show the form for creating a new child resource.
     */
    public function createChild(): View
    {
        $accountTypes = AccountType::orderBy('name', 'ASC')->get();

        $parents = ChartOfAccount::with('accountType')
            ->orderBy('code')
            ->get();

        $normalBalances = NormalBalanceEnum::values();

        return view('pages.menus.bendahara.master.coa.create', compact(
            'accountTypes',
            'parents',
            'normalBalances'
        ));
    }

    /**
     * Show the form for creating a new parent resource.
     */
    public function createParent(): View
    {
        $accountTypes = AccountType::orderBy('name', 'ASC')->get();
        $normalBalances = NormalBalanceEnum::values();

        return view('pages.menus.bendahara.master.coa.create-parent', compact(
            'accountTypes',
            'normalBalances'
        ));
    }

    /**
     * Generate kode COA otomatis untuk frontend (JSON)
     */
    public function generateCodeApi(CoaService $service, Request $request): JsonResponse
    {
        $parentId = $request->query('parent_id');

        return response()->json(
            $service->generateCodeForAPI($parentId)
        );
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(CoaService $service, StoreCOARequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()
                ->route('bendahara.master.coas.index')
                ->with('success', 'Akun COA berhasil dibuat.');
        } catch (Exception $e) {
            return back()
                ->withInput()
                ->with('error', 'Gagal membuat Akun COA: ' . $e->getMessage());
        }
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id): View
    {
        $coa = ChartOfAccount::findOrFail($id);
        $accountTypes = AccountType::orderBy('name', 'ASC')->get();

        $parents = ChartOfAccount::where('id', '!=', $id, 'and')
            ->orderBy('code', 'ASC')
            ->get();

        $normalBalances = NormalBalanceEnum::cases();
        $isLocked = true;

        return view('pages.menus.bendahara.master.coa.edit', compact(
            'coa',
            'accountTypes',
            'parents',
            'normalBalances',
            'isLocked'
        ));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(string $id, CoaService $service, UpdateCOARequest $request): RedirectResponse
    {
        try {
            $service->update($id, $request->validated());

            return redirect()
                ->route('bendahara.master.coas.index')
                ->with('success', 'Akun COA berhasil diperbarui.');
        } catch (Exception $e) {
            return back()
                ->withInput()
                ->with('error', 'Gagal memperbarui Akun COA: ' . $e->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id, CoaService $service): RedirectResponse
    {
        try {
            $service->delete($id);

            return redirect()
                ->route('bendahara.master.coas.index')
                ->with('success', 'Akun COA berhasil dihapus.');
        } catch (Exception $e) {
            return back()
                ->with('error', 'Gagal menghapus Akun COA: ' . $e->getMessage());
        }
    }
}