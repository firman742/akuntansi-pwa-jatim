<?php

namespace App\Services\AccountingUsers;

use App\Enums\RequestStatus;
use App\Models\BalanceRequest;
use App\Models\SubPeriod;
use App\Services\BaseService;
use Exception;
use Illuminate\Support\Facades\Auth;

class RequestBalanceService extends BaseService
{
    /**
     * Create a new Account type.
     *
     * @param  array  $data
     * @return BalanceRequest
     * @throws Exception
     */
    public function store(array $data): BalanceRequest
    {
        $subPeriod = SubPeriod::query()
            ->findOrFail($data['sub_period_id']);

        $requestBalance = BalanceRequest::create([
            'requester_id' => Auth::id(),
            'user_account_id' => $data['user_account_id'],
            'period_id' => $subPeriod->period_id,
            'sub_period_id' => $subPeriod->id,
            'amount' => $data['amount'],
            'purpose' => $data['purpose'],
            'note' => $data['note'],
            'status' => RequestStatus::PENDING->value,
        ]);

        /**
         * =====================================================
         * AUDIT LOG - USER BALANCE UPDATED
         * =====================================================
         */
        $this->logger->log(
            action: 'CREATE',
            module: 'BALANCE_REQUEST',
            subject: $requestBalance,
            description: "Request balance dengan jumlah '" . $requestBalance->amount . "' untuk periode '" . $subPeriod->name . "' telah dibuat oleh user " . Auth::user()->name . ".",
            old: [],
            new: $requestBalance->toArray(),
            additionalData: [
                'requester_id' => $requestBalance->requester_id,
                'user_account_id' => $requestBalance->user_account_id,
                'period_id' => $requestBalance->period_id,
                'sub_period_id' => $requestBalance->sub_period_id,
                'amount' => $requestBalance->amount,
                'purpose' => $requestBalance->purpose,
                'note' => $requestBalance->note,
                'status' => $requestBalance->status,
            ]
        );
        return $requestBalance;
    }
}
