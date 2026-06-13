<?php

namespace App\Http\Controllers\AccountingUsers;

use App\Enums\NormalBalanceEnum;
use App\Enums\RequestStatus;
use App\Http\Controllers\Controller;
use App\Http\Requests\AccountingUsers\StoreReqCoaRequest;
use App\Models\AccountType;
use App\Models\ChartOfAccount;
use App\Models\CoaRequest;
use App\Services\AccountingUsers\RequestCoaService;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\View\View;

class CoaRequestController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return View
     */
    public function index(): View
    {
        $requests = CoaRequest::query()
            ->where('requester_id', Auth::id())
            ->with([
                'accountType',
                'parentCoa',
                'subPeriod',
                'approver:id,name'
            ])
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function ($item) {

                $item->status_label = RequestStatus::from($item->status)->label();
        
                return $item;
            });
            

        return view('pages.menus.user.requestCoas.index', compact('requests'));
    }

    /**
     * Display the specified resource.
     *
     * @param string $id
     * @return View
     */
    public function show(string $id): View
    {
        $coaRequest = CoaRequest::query()
            ->where('id', $id)
            ->where('requester_id', Auth::id())
            ->with([
                'accountType',
                'parentCoa',
                'subPeriod',
                'approver:id,name'
            ])
            ->firstOrFail();

        return view('pages.menus.user.requestCoas.show', compact('coaRequest'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return View
     */
    public function create(): View
    {
        $accountTypes = AccountType::query()->orderBy('name')->get();
        $parents = ChartOfAccount::query()
            ->with('accountType')
            ->where('is_active', true)
            ->orderBy('code')
            ->get();

        $normalBalances = NormalBalanceEnum::values();

        return view('pages.menus.user.requestCoas.create', compact(
            'accountTypes',
            'parents',
            'normalBalances'
        ));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param RequestCoaService $service
     * @param StoreReqCoaRequest $requests
     * @return RedirectResponse
     */
    public function store(RequestCoaService $service, StoreReqCoaRequest $requests): RedirectResponse
    {
        try {
            $service->store($requests->validated());

            return redirect()->route('user.requests.coas.index')
                ->with('success', 'Permintaan COA berhasil dibuat dan menunggu persetujuan.');
        } catch (Exception $e) {
            // Log error jika perlu
            Log::error('Error saat membuat permintaan COA: ' . $e->getMessage());

            return back()
                ->withInput()
                ->with('error', 'Terjadi kesalahan saat membuat permintaan COA. Silahkan coba lagi.');
        }
    }

    /**
     * Generate kode COA otomatis untuk frontend (JSON)
     * 
     * @param RequestCoaService $service
     * @param Request $request
     * @return JsonResponse
     */
    public function generateCodeApi(RequestCoaService $service, Request $request): JsonResponse
    {
        $parentId = $request->query('parent_id'); // ambil dari query header ?parent_id=

        return response()->json(
            $service->generateCodeForAPI($parentId)
        );
    }
}
