<?php

namespace App\Services\AccountingUsers;

use App\Enums\RequestStatus;
use App\Models\ChartOfAccount;
use App\Models\CoaRequest;
use App\Services\BaseService;
use Exception;
use Illuminate\Support\Facades\Auth;

class RequestCoaService extends BaseService
{
    /**
     * Create a new Account type.
     *
     * @param  array  $data
     * @return CoaRequest
     * @throws Exception
     */
    public function store(array $data): CoaRequest
    {
        // Gunakan generateCode untuk otomatis kode, level, dan order
        $result = $this->generateCode($data['parent_id'] ?? null);
        $generated = $this->generateCode(
            $data['parent_coa_id'] ?? null
        );

        $coa = CoaRequest::create([
            'requester_id'     => Auth::id(),
            'parent_coa_id'    => $data['parent_coa_id'] ?? null,
            'account_type_id'  => $data['account_type_id'],
            'proposed_name'    => $data['proposed_name'],
            'proposed_code'    => $generated['code'],
            'normal_balance'   => $data['normal_balance'],
            'description'      => $data['description'] ?? null,

            'status'           => RequestStatus::PENDING->value,
        ]);

        /**
         * =====================================================
         * AUDIT LOG - USER BALANCE UPDATED
         * =====================================================
         */
        $this->logger->log(
            action: 'CREATE',
            module: 'COA_REQUEST',
            subject: $coa,
            description: "Request COA dengan nama '" . $coa->proposed_name . "' dan kode '" . $coa->proposed_code . "' telah dibuat oleh user " . Auth::user()->name . ".",
            old: [],
            new: $coa->toArray(),
            additionalData: [
                'requester_id' => $coa->requester_id,
                'account_type_id' => $coa->account_type_id,
                'parent_coa_id' => $coa->parent_coa_id,
                'normal_balance' => $coa->normal_balance,
                'status' => $coa->status,
            ]
        );
        return $coa;
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
