<?php

namespace App\Services\Bendahara;

use App\Enums\ActivityLogAction;
use App\Models\ChartOfAccount;
use App\Services\BaseService;
use Exception;
use Illuminate\Support\Facades\Auth;

class CoaService extends BaseService
{
    /**
     * Create a new Account type.
     *
     * @param  array  $data
     * @return ChartOfAccount
     * @throws Exception
     */
    public function store(array $data): ChartOfAccount
    {
        // Gunakan generateCode untuk otomatis kode, level, dan order
        $result = $this->generateCode($data['parent_id'] ?? null);

        $coa = ChartOfAccount::create([
            'code' => $result['code'],
            'name' => $data['name'],
            'account_type_id' => $data['account_type_id'],
            'parent_id' => $data['parent_id'] ?? null,
            'level' => $result['level'],
            'order' => $result['order'],
            'normal_balance' => $data['normal_balance'],
            'description' => $data['description'] ?? null,
            'is_active' => $data['is_active'] ?? true,
            'created_by' => Auth::id(),
        ]);

        // activity log
        $this->logger->log(
            action: ActivityLogAction::CREATED->value,
            module: "CHART_OF_ACCOUNT",
            subject: $coa,
            description: "COA {$coa->name} berhasil dibuat.",
            old: [],
            new: $coa->toArray(),
            additionalData: [
                'parent_id' => $data['parent_id'] ?? null,
                'account_type_id' => $data['account_type_id'],
                'normal_balance' => $data['normal_balance'],
                'is_active' => $data['is_active'] ?? true,
            ]
        );

        return $coa;
    }


    /**
     * Update existing Chart Of Account.
     *
     * @param string $id
     * @param array $data
     * @return ChartOfAccount
     * @throws Exception
     */
    public function update(string $id, array $data): ChartOfAccount
    {
        $coa = ChartOfAccount::findOrFail($id);
        $oldCOA = $coa->toArray();

        // cek apakah coa sudah dipakai
        $isUsed = $coa->transactionLines()->exists() || $coa->journalDetails()->exists() || $coa->userAccounts()->exists();

        // jika sudah dipakai, tipe akun & normal balance tidak boleh berubah
        if ($isUsed) {
            if (
                $coa->account_type_id !== $data['account_type_id'] ||
                $coa->normal_balance !== $data['normal_balance']
            ) {
                throw new Exception(
                    'COA sudah digunakan dalam transaksi, jurnal, atau sudah dihubungkan ke pengguna. Tipe akun dan normal balance tidak dapat diubah.'
                );
            }
        }

        // jika parent berubah, regenerate struktur code
        if (($coa->parent_id ?? null) !== ($data['parent_id'] ?? null)) {
            $result = $this->generateCode($data['parent_id'] ?? null);

            $coa->update([
                'code' => $result['code'],
                'level' => $result['level'],
                'order' => $result['order'],
                'parent_id' => $data['parent_id'] ?? null,
            ]);
        }

        $coa->update([
            'name' => $data['name'],
            'account_type_id' => $data['account_type_id'],
            'normal_balance' => $data['normal_balance'],
            'description' => $data['description'] ?? null,
            'is_active' => $data['is_active'] ?? false,
            'updated_by' => Auth::id(),
        ]);

        // activity log
        $this->logger->log(
            action: ActivityLogAction::UPDATED->value,
            module: "CHART_OF_ACCOUNT",
            subject: $coa,
            description: "COA {$coa->name} berhasil diperbarui.",
            old: $oldCOA,
            new: $coa->toArray(),
            additionalData: [
                'parent_id' => $data['parent_id'] ?? null,
                'account_type_id' => $data['account_type_id'],
                'normal_balance' => $data['normal_balance'],
                'is_active' => $data['is_active'] ?? false,
            ]
        );

        return $coa->fresh();
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
        $coa = ChartOfAccount::findOrFail($id);

        $usedInTransactions = $coa->transactionLines()->exists();
        $usedInJournals = $coa->journalDetails()->exists();
        $usedByUsers = $coa->userAccounts()->exists(); // ✅ NEW VALIDATION


        if ($usedInTransactions || $usedInJournals || $usedByUsers) {
            throw new Exception(
                'COA tidak dapat dihapus karena sudah digunakan dalam transaksi, jurnal, atau sudah dihubungkan ke pengguna.'
            );
        }

        // activity log
        $this->logger->log(
            action: ActivityLogAction::DELETED->value,
            module: "CHART_OF_ACCOUNT",
            subject: $coa,
            description: "COA {$coa->name} berhasil dihapus.",
            old: $coa->toArray(),
            new: [],
            additionalData: []
        );
        
        $coa->delete();
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
