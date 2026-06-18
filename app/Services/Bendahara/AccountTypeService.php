<?php

namespace App\Services\Bendahara;

use App\Enums\ActivityLogAction;
use App\Models\AccountType;
use App\Models\ChartOfAccount;
use App\Services\BaseService;
use Exception;

class AccountTypeService extends BaseService
{
    /**
     * Create a new Account type.
     *
     * @param  array  $data
     * @return AccountType
     * @throws Exception
     */
    public function store(array $data): AccountType
    {
        $accountType = AccountType::create($data);

        // activity log
        $this->logger->log(
            action: ActivityLogAction::CREATED->value,
            module: "ACCOUNT_TYPE",
            subject: $accountType,
            description: "Tipe akun {$accountType->name} berhasil dibuat.",
            old: [],
            new: $accountType->toArray(),
            additionalData: []
        );

        return $accountType;
    }


    /**
     * Update an existing account type.
     *
     * @param  string  $id
     * @param  array  $data
     * @return AccountType
     * @throws Exception
     */
    public function update(string $id, array $data): AccountType
    {
        $accountType = AccountType::findOrFail($id);
        $accountTypeOld = $accountType->replicate();

        $accountType->update($data);

        // activity log
        $this->logger->log(
            action: ActivityLogAction::UPDATED->value,
            module: "ACCOUNT_TYPE",
            subject: $accountType,
            description: "Tipe akun {$accountType->name} berhasil diperbarui.",
            old: $accountTypeOld->toArray(),
            new: $accountType->toArray(),
            additionalData: []
        );

        return $accountType;
    }

    /**
     * Delete the specified account type.
     * TODO: Add check to prevent deletion if Account Type is in use on COA.
     *
     * @param  string  $id
     * @return void
     * @throws Exception
     */
    public function delete(string $id): void
    {
        $accountType = AccountType::findOrFail($id);

        $inUse = ChartOfAccount::where('account_type_id', $accountType->id)->exists();

        if ($inUse) {
            throw new Exception('Tipe akun tidak dapat dihapus karena masih digunakan pada COA.');
        }

        // activity log
        $this->logger->log(
            action: ActivityLogAction::DELETED->value,
            module: "ACCOUNT_TYPE",
            subject: $accountType,
            description: "Tipe akun {$accountType->name} berhasil dihapus.",
            old: $accountType->toArray(),
            new: [],
            additionalData: []
        );

        $accountType->delete();
    }
}
