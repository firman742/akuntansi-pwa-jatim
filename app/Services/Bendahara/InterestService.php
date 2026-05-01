<?php

namespace App\Services\Bendahara;

use App\Enums\MetaTypeTransactionEnum;
use App\Models\Interest;
use App\Models\TransactionLine;
use Exception;

class InterestService
{
    /**
     * Create a new Account type.
     *
     * @param  array  $data
     * @return Interest
     * @throws Exception
     */
    public function store(array $data): Interest
    {
        // Normalisasi rate berdasarkan tipe pajak
        $data = $this->normalizeRate($data);

        return Interest::create($data);
    }


    /**
     * Update an existing account type.
     *
     * @param  string  $id
     * @param  array  $data
     * @return Interest
     * @throws Exception
     */
    public function update(string $id, array $data): Interest
    {
        $interest = Interest::findOrFail($id);

        // Validasi: tidak boleh diubah jika sudah dipakai transaksi
        if ($this->isUsedInTransaction($interest)) {
            throw new Exception('Tidak dapat mengubah pajak karena sudah digunakan dalam transaksi.');
        }

        // Normalisasi rate berdasarkan tipe pajak
        $data = $this->normalizeRate($data);

        $interest->update($data);

        return $interest;
    }

    /**
     * Delete the specified Interest.
     *
     * @param  string  $id
     * @return void
     * @throws Exception
     */
    public function delete(string $id): void
    {
        $interest = Interest::findOrFail($id);

        // Validasi: tidak boleh dihapus jika sudah dipakai transaksi
        if ($this->isUsedInTransaction($interest)) {
            throw new Exception('Tidak dapat menghapus pajak karena sudah digunakan dalam transaksi.');
        }

        $interest->delete();
    }

    /**
     * Normalize Interest rate value.
     *
     * FIXED   -> otomatis 0
     * DECIMAL -> hapus trailing zero (11.00 => 11, 10.50 => 10.5)
     *
     * @param array $data
     * @return array
     */
    private function normalizeRate(array $data): array
    {
        if ($data['type'] === 'FIXED') {
            $data['rate'] = 0;
        } else {
            $data['rate'] = $data['rate'] ?? 0;
        }

        return $data;
    }

    /**
     * Check whether interest has been used in transaction.
     *
     * @param Interest $interest
     * @return bool
     */
    private function isUsedInTransaction(Interest $interest): bool
    {
        return TransactionLine::query()
            ->where('meta_type', MetaTypeTransactionEnum::INTEREST->value)
            ->where(function ($query) use ($interest) {
                $query->where('chart_of_account_id', $interest->account_interest_id);

                if ($interest->account_expense_id) {
                    $query->orWhere(
                        'chart_of_account_id',
                        $interest->account_expense_id
                    );
                }
            })
            ->exists();
    }
}
