<?php

namespace App\Services\Bendahara;

use App\Enums\ActivityLogAction;
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
        $requestCoa = CoaRequest::query()->where('id', $id)->with(['parentCoa', 'accountType'])->firstOrFail();
        $generatedCode = $this->generateCode($requestCoa->parent_coa_id);
        $requestCoa->proposed_code = $generatedCode['code'];

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
            action: ActivityLogAction::APPROVED->value,
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
            action: ActivityLogAction::REJECT->value,
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


    /**
     * Generate kode COA otomatis untuk API (tanpa field created_by)
     * 
     * @param string|null $parentId
     * @return array ['code' => string, 'level' => int, 'order' => int]
     */
    public function generateCodeForAPI(?string $parentId = null): array
    {
        $result = $this->generateCode($parentId);

        return [
            'code' => $result['code'],
            'level' => $result['level'],
            'order' => $result['order'],
        ];

        return $this->generateCode($parentId);
    }

    /**
     * Generate kode COA otomatis berdasarkan parent_id (rekursif)
     * 
     * @param string|null $parentId
     * @return array ['code' => string, 'level' => int, 'order' => int]
     */
    private function generateCode(?string $parentId = null): array
    {
        if ($parentId) {
            // Parent ada → level > 1
            $parent = ChartOfAccount::findOrFail($parentId);
            $level = $parent->level + 1;

            // Ambil semua child parent
            $children = ChartOfAccount::where('parent_id', $parent->id)
                ->orderBy('code')
                ->get();

            // Tentukan posisi digit sesuai level (level 2 → index 2, dsb)
            $codeStr = str_pad($parent->code, 5, '0', STR_PAD_LEFT);
            $codeArr = str_split($codeStr);
            $position = min($level + 1, 5) - 1; // index 0-based

            if ($children->isEmpty()) {
                // Belum ada child → set digit level ke 1
                $codeArr[$position] = '1';
            } else {
                $lastChild = $children->last();
                $grandChildren = ChartOfAccount::where('parent_id', $lastChild->id)
                    ->orderBy('code')
                    ->get();

                if ($grandChildren->isNotEmpty()) {
                    // Rekursif ke child terakhir
                    return $this->generateCode($lastChild->id);
                }

                // Last child tidak punya anak → increment digit
                $lastCodeArr = str_split(str_pad($lastChild->code, 5, '0', STR_PAD_LEFT));
                $currentDigit = (int)$lastCodeArr[$position];
                $codeArr[$position] = (string)($currentDigit + 1);
            }

            $code = implode('', $codeArr);
            $order = $children->max('order') ? $children->max('order') + 1 : 1;
        } else {
            // Root (parent_id null / level 1)
            $level = 1;

            $children = ChartOfAccount::whereNull('parent_id')
                ->orderBy('code')
                ->get();

            if ($children->isEmpty()) {
                $code = '10000';
                $order = 1;
            } else {
                $lastRoot = $children->last();
                $lastCode = str_pad($lastRoot->code, 5, '0', STR_PAD_LEFT);
                $firstDigit = (int)substr($lastCode, 0, 1) + 1;

                $code = $firstDigit . '0000'; // level 1 root baru
                $order = $lastRoot->order + 1;
            }
        }

        return [
            'code'  => $code,
            'level' => $level,
            'order' => $order,
        ];
    }
}
