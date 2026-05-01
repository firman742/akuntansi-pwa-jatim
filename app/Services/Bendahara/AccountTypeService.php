<?php

namespace App\Services\Bendahara;

use App\Models\AccountType;
use App\Models\ChartOfAccount;
use Exception;

class AccountTypeService
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
        return AccountType::create($data);
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

        $accountType->update($data);

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

        $accountType->delete();
    }
}
