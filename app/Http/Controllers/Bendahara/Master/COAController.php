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
     * 
     * @return View
     */
    public function index(): View
    {
        $chartOfAccounts = ChartOfAccount::with([
            'accountType',
            'creator',
            'parent',
            'children.children'
        ])
            ->orderBy('code')
            ->get();

        $groupedByType = $chartOfAccounts->groupBy(fn($coa) => $coa->accountType?->name ?? 'Uncategorized');

        return view('pages.menus.bendahara.master.coa.index', [
            'groupedByType' => $groupedByType
        ]);
    }


    /**
     * Get children COA for a given parent ID (JSON FOR API)
     * 
     * @param string $id
     * @return JsonResponse
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
     * Show the form for creating a new resource.
     * 
     * @return View
     */
    public function createChild(): View
    {
        $accountTypes = AccountType::orderBy('name')->get();

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

    public function createParent(): View
    {
        $accountTypes = AccountType::orderBy('name')->get();

        $normalBalances = NormalBalanceEnum::values();

        return view('pages.menus.bendahara.master.coa.create-parent', compact(
            'accountTypes',
            'normalBalances'
        ));
    }

    /**
     * Generate kode COA otomatis untuk frontend (JSON)
     * 
     * @param CoaService $service
     * @param Request $request
     * @return JsonResponse
     */
    public function generateCodeApi(CoaService $service, Request $request): JsonResponse
    {
        $parentId = $request->query('parent_id'); // ambil dari query header ?parent_id=

        return response()->json(
            $service->generateCodeForAPI($parentId)
        );
    }

    /**
     * Store a newly created resource in storage.
     * 
     * @param CoaService $service
     * @param StoreCOARequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function store(CoaService $service, StoreCOARequest $request): RedirectResponse
    {
        try {
            $service->store($request->validated());

            return redirect()->route('bendahara.master.coas.index')
                ->with('success', 'Chart of Account berhasil dibuat.');
        } catch (Exception $e) {
            return redirect()->back()
                ->withInput()
                ->with('error', 'Gagal membuat Chart of Account: ' . $e->getMessage());
        }
    }

    /**
     * Show the form for editing the specified resource.
     * 
     * @param string $id
     * @return View
     */
    public function edit(string $id): View
    {
        $coa = ChartOfAccount::findOrFail($id);

        $accountTypes = AccountType::orderBy('name')->get();

        $parents = ChartOfAccount::where('id', '!=', $id)
            ->orderBy('code')
            ->get();

        $normalBalances = NormalBalanceEnum::cases();

        $isLocked = true;

        return view('pages.menus.bendahara.master.coa.edit',
            compact(
                'coa',
                'accountTypes',
                'parents',
                'normalBalances',
                'isLocked'
            )
        );
    }

    /**
     * Update the specified resource in storage.
     * 
     * @param string $id
     * @param CoaService $service
     * @param UpdateCOARequest $request
     * @return RedirectResponse
     * @throws Exception
     */
    public function update(string $id, CoaService $service, UpdateCOARequest $request): RedirectResponse
    {
        try {
            $service->update($id, $request->validated());

            return redirect()->route('bendahara.master.coas.index')
                ->with('success', 'Chart of Account berhasil diperbarui.');
        } catch (Exception $e) {
            return redirect()->back()
                ->withInput()
                ->with('error', 'Gagal memperbarui Chart of Account: ' . $e->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     * 
     * @param string $id
     * @param CoaService $service
     * @return RedirectResponse
     * @throws Exception
     */
    public function destroy(string $id, CoaService $service): RedirectResponse
    {
        try {
            $service->delete($id);

            return redirect()->route('bendahara.master.coas.index')
                ->with('success', 'Chart of Account berhasil dihapus.');
        } catch (Exception $e) {
            return redirect()->back()
                ->with('error', 'Gagal menghapus Chart of Account: ' . $e->getMessage());
        }
    }
}
