<?php

namespace App\Services\Bendahara;

use App\Enums\MetaTypeTransactionEnum;
use App\Models\Tax;
use App\Models\TransactionLine;
use Exception;

class TaxService
{
    /**
     * Create a new Account type.
     *
     * @param  array  $data
     * @return Tax
     * @throws Exception
     */
    public function store(array $data): Tax
    {
        // Normalisasi rate berdasarkan tipe pajak
        $data = $this->normalizeRate($data);

        return Tax::create($data);
    }


    /**
     * Update an existing account type.
     *
     * @param  string  $id
     * @param  array  $data
     * @return Tax
     * @throws Exception
     */
    public function update(string $id, array $data): Tax
    {
        $tax = Tax::findOrFail($id);

        // Validasi: tidak boleh diubah jika sudah dipakai transaksi
        if ($this->isUsedInTransaction($tax)) {
            throw new Exception('Tidak dapat mengubah pajak karena sudah digunakan dalam transaksi.');
        }

        // Normalisasi rate berdasarkan tipe pajak
        $data = $this->normalizeRate($data);

        $tax->update($data);

        return $tax;
    }

    /**
     * Delete the specified tax.
     *
     * @param  string  $id
     * @return void
     * @throws Exception
     */
    public function delete(string $id): void
    {
        $tax = Tax::findOrFail($id);

        // Validasi: tidak boleh dihapus jika sudah dipakai transaksi
        if ($this->isUsedInTransaction($tax)) {
            throw new Exception('Tidak dapat menghapus pajak karena sudah digunakan dalam transaksi.');
        }

        $tax->delete();
    }

    /**
     * Normalize tax rate value.
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
     * Check whether tax has been used in transaction.
     *
     * @param Tax $tax
     * @return bool
     */
    private function isUsedInTransaction(Tax $tax): bool
    {
        return TransactionLine::query()
            ->where('meta_type', MetaTypeTransactionEnum::TAX->value)
            ->where(function ($query) use ($tax) {
                if ($tax->account_prepaid_id) {
                    $query->orWhere(
                        'chart_of_account_id',
                        $tax->account_prepaid_id
                    );
                }

                if ($tax->account_payable_id) {
                    $query->orWhere(
                        'chart_of_account_id',
                        $tax->account_payable_id
                    );
                }

                if ($tax->account_expense_id) {
                    $query->orWhere(
                        'chart_of_account_id',
                        $tax->account_expense_id
                    );
                }
            })
            ->exists();
    }
}
