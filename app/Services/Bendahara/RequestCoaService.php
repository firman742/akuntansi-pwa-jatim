<?php

namespace App\Services\Bendahara;

use App\Enums\RequestStatus;
use App\Models\ChartOfAccount;
use App\Models\CoaRequest;
use App\Services\BaseService;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class RequestCoaService extends BaseService
{
    /**
     * Approve a pending COA request and create a new Chart of Account.
     *
     * @param string $id
     * @return ChartOfAccount
     * @throws Exception
     */
    public function approveRequest(string $id, array $request): ChartOfAccount
    {

        DB::beginTransaction();
        $requestCoa = CoaRequest::findOrFail($id);

        if ($requestCoa->status !== RequestStatus::PENDING->value) {
            throw new Exception('Only pending requests can be approved.');
        }

        // Buat COA baru berdasarkan data dari request
        $coa = ChartOfAccount::create([
            'code' => $requestCoa->proposed_code,
            'name' => $requestCoa->proposed_name,
            'account_type_id' => $requestCoa->account_type_id,
            'parent_id' => $requestCoa->parent_coa_id,
            'normal_balance' => $requestCoa->normal_balance,
            'description' => $requestCoa->description,
        ]);

        // Update status request menjadi APPROVED
        $requestCoa->update([
            'status' => RequestStatus::APPROVED->value,
            'approver_id' => Auth::user()->id,
            'approved_at' => Carbon::now(),
            'approval_notes' => $request['approval_notes'] ?? null,
        ]);

        // Log aktivitas approval
        $this->logger->log(
            action: 'APPROVAL',
            module: 'COA_REQUEST',
            subject: $requestCoa,
            description: "Approved COA request ID: {$requestCoa->id}, created COA ID: {$coa->id}",
            additionalData: [
                'request_id' => $requestCoa->id,
                'coa_id' => $coa->id,
            ]
        );

        DB::commit();

        return $coa;
    }


    /**
     * Reject a pending COA request.
     *
     * @param string $id
     * @return CoaRequest
     * @throws Exception
     */
    public function rejectRequest(string $id, array $request): CoaRequest
    {
        DB::beginTransaction();
        $requestCoa = CoaRequest::findOrFail($id);

        if ($requestCoa->status !== RequestStatus::PENDING->value) {
            throw new Exception('Only pending requests can be rejected.');
        }

        $requestCoa->update([
            'status' => RequestStatus::REJECTED->value,
            'approver_id' => Auth::user()->id,
            'rejected_at' => Carbon::now(),
            'rejection_reason' => $request['rejection_reason'] ?? null,
        ]);


        // Log aktivitas rejection
        $this->logger->log(
            action: 'REJECTION',
            module: 'COA_REQUEST',
            subject: $requestCoa,
            description: "Rejected COA request ID: {$requestCoa->id}",
            additionalData: [
                'request_id' => $requestCoa->id,
            ]
        );

        DB::commit();

        return $requestCoa;
    }
}
