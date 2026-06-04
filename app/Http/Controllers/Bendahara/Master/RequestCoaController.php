<?php

namespace App\Http\Controllers\Bendahara\Master;

use App\Enums\RequestStatus;
use App\Http\Controllers\Controller;
use App\Models\CoaRequest;
use App\Services\Bendahara\RequestCoaService;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class RequestCoaController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @return View
     */
    public function index(): View
    {
        $requests = CoaRequest::query()
            ->with([
                'accountType',
                'parentCoa',
                'subPeriod',
                'approver:id,name',
                'requester:id,name'
            ])
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function ($item) {

                $item->status_label = RequestStatus::from($item->status)->label();
        
                return $item;
            });

        return view('pages.menus.bendahara.master.request_coas.index', compact('requests'));
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
            ->with([
                'accountType',
                'parentCoa',
                'subPeriod',
                'approver:id,name',
                'requester:id,name'
            ])
            ->findOrFail($id);

        return view('pages.menus.bendahara.master.request_coas.show', compact('coaRequest'));
    }


    /**
     * Approve a COA request and convert it to a regular COA
     *
     * @param string $id
     * @param Request $request
     * @param RequestCoaService $service
     * 
     * @return RedirectResponse
     */
    public function approve(string $id, Request $request, RequestCoaService $service): RedirectResponse
    {
        $request->validate([
            'approval_notes' => ['required', 'string', 'max:1000'],
        ]);

        try {
            $service->approveRequest($id, $request->all());

            return redirect()->route('bendahara.master.requests.coas.index')
                ->with('success', 'COA request approved successfully.');
        } catch (Exception $e) {
            return redirect()->route('bendahara.master.requests.coas.index')
                ->with('error', 'Failed to approve COA request: ' . $e->getMessage());
        }
    }

    /**
     * Reject a COA request.
     *
     * @param string $id
     * @param Request $request
     * @param RequestCoaService $service
     * 
     * @return RedirectResponse
     */
    public function reject(string $id, Request $request, RequestCoaService $service): RedirectResponse
    {
        $request->validate([
            'rejection_reason' => ['required', 'string', 'max:1000'],
        ]);

        try {
            $service->rejectRequest($id, $request->all());

            return redirect()->route('bendahara.master.requests.coas.index')
                ->with('success', 'COA request rejected successfully.');
        } catch (Exception $e) {
            return redirect()->route('bendahara.master.requests.coas.index')
                ->with('error', 'Failed to reject COA request: ' . $e->getMessage());
        }
    }
}
