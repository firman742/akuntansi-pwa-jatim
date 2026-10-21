@props([
    'openingBalances' => collect(),
    'periods' => collect(),
    'periodId' => null,
    'subPeriods' => collect(),
    'subPeriodId' => null,
    'selectedSubPeriodName' => null,
])

<div x-data="{
    tableRowData: @js($openingBalances),

    editUrl: '{{ route('bendahara.opening-balances.edit', ':id') }}',
    destroyUrl: '{{ route('bendahara.opening-balances.destroy', ':id') }}',

    showEditModal: false,
    editRowData: {},
    openEditModal(row) {
        this.showEditModal = true;
        this.editRowData = { ...row };
    },
    closeEditModal() {
        this.showEditModal = false;
        this.editRowData = {};
    },

    get totalDebit() {
        return this.tableRowData.reduce((sum, row) => sum + (parseFloat(row.debit) || 0), 0);
    },

    get totalCredit() {
        return this.tableRowData.reduce((sum, row) => sum + (parseFloat(row.credit) || 0), 0);
    },

    formatCurrency(amount) {
        if (amount === null || amount === undefined || amount === '') return '';
        const num = parseFloat(amount);
        if (num === 0) return 'Rp-';
        return 'Rp' + new Intl.NumberFormat('id-ID', { minimumFractionDigits: 0 }).format(num);
    },

    canEdit(row) {
        return !row.has_transaction && !row.has_allocation && !row.sub_period_closed && !row.sub_period_expired;
    },

    canDelete(row) {
        return !row.has_transaction && !row.has_allocation && !row.sub_period_closed && !row.sub_period_expired;
    },

    getLockReason(row) {
        if (row.has_transaction) return 'Tidak dapat diubah karena sudah ada transaksi.';
        if (row.has_allocation) return 'Tidak dapat diubah karena sudah ada alokasi.';
        if (row.sub_period_closed) return 'Tidak dapat diubah karena periode sudah ditutup.';
        if (row.sub_period_expired) return 'Tidak dapat diubah karena sub periode sudah kadaluarsa.';
        return '';
    }
}">

    <!-- Judul Format Laporan Akuntansi -->
    <div class="mb-4 text-center">
        <h2 class="text-base font-bold tracking-wider text-gray-800 uppercase dark:text-gray-100 mt-4">
            SALDO AWAL
        </h2>
        <p class="text-sm font-semibold tracking-wide text-gray-600 uppercase dark:text-gray-300">
            PER {{ $selectedSubPeriodName ?? 'SELURUH PERIODE' }}
        </p>
    </div>

    <div class="overflow-hidden border border-gray-200 bg-white shadow-sm dark:border-white/[0.05] dark:bg-white/[0.03] rounded-lg">
        <div class="max-w-full overflow-x-auto">
            <table class="w-full text-sm text-left border-collapse">
                <!-- Header Tabel Standar Akuntansi -->
                <thead class="border-b border-t border-gray-300 bg-gray-100 text-gray-700 uppercase font-semibold text-xs dark:border-gray-700 dark:bg-gray-800 dark:text-gray-300">
                    <tr>
                        <th scope="col" class="w-12 px-4 py-3 text-center border-r border-gray-200 dark:border-gray-700">No</th>
                        <th scope="col" class="px-6 py-3 border-r border-gray-200 dark:border-gray-700">Nama Perkiraan</th>
                        <th scope="col" class="w-28 px-4 py-3 text-center border-r border-gray-200 dark:border-gray-700">Ref</th>
                        <th scope="col" class="w-44 px-6 py-3 text-right border-r border-gray-200 dark:border-gray-700">Debit</th>
                        <th scope="col" class="w-44 px-6 py-3 text-right border-r border-gray-200 dark:border-gray-700">Kredit</th>
                        <th scope="col" class="w-20 px-4 py-3 text-center">Aksi</th>
                    </tr>
                </thead>

                <!-- Body Tabel -->
                <tbody class="divide-y divide-gray-200 dark:divide-gray-800 font-mono text-xs sm:text-sm">
                    <template x-if="tableRowData.length > 0">
                        <template x-for="(row, index) in tableRowData" :key="row.id">
                            <tr :class="index % 2 === 0 ? 'bg-white dark:bg-transparent' : 'bg-gray-50/50 dark:bg-white/[0.02]'"
                                class="transition hover:bg-gray-100/80 dark:hover:bg-white/[0.05]">

                                <!-- No -->
                                <td class="px-4 py-2.5 text-center text-gray-500 border-r border-gray-200 dark:border-gray-800"
                                    x-text="index + 1"></td>

                                <!-- Nama Perkiraan -->
                                <td class="px-6 py-2.5 text-gray-800 dark:text-gray-200 border-r border-gray-200 dark:border-gray-800 font-sans font-medium"
                                    x-text="row.account_name"></td>

                                <!-- Ref / Kode COA -->
                                <td class="px-4 py-2.5 text-center text-gray-600 dark:text-gray-400 border-r border-gray-200 dark:border-gray-800"
                                    x-text="row.account_code"></td>

                                <!-- Debit -->
                                <td class="px-6 py-2.5 text-right font-medium text-gray-900 dark:text-gray-100 border-r border-gray-200 dark:border-gray-800"
                                    x-text="row.debit > 0 ? formatCurrency(row.debit) : (row.credit > 0 ? '' : 'Rp-')"></td>

                                <!-- Kredit -->
                                <td class="px-6 py-2.5 text-right font-medium text-gray-900 dark:text-gray-100 border-r border-gray-200 dark:border-gray-800"
                                    x-text="row.credit > 0 ? formatCurrency(row.credit) : (row.debit > 0 ? '' : 'Rp-')"></td>

                                <!-- Action -->
                                <td class="px-4 py-2 text-center">
                                    <div class="flex items-center justify-center gap-1.5">
                                        <!-- Edit/Koreksi Button -->
                                        <button type="button" @click="canEdit(row) && openEditModal(row)"
                                            :disabled="!canEdit(row)"
                                            :title="canEdit(row) ? 'Koreksi Saldo' : getLockReason(row)"
                                            class="p-1 rounded transition"
                                            :class="canEdit(row) ? 'text-amber-600 hover:bg-amber-50 dark:text-amber-400 dark:hover:bg-amber-500/10' : 'cursor-not-allowed text-gray-300 dark:text-gray-700'">
                                            <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                            </svg>
                                        </button>

                                        <!-- Delete Button -->
                                        <form :action="destroyUrl.replace(':id', row.id)" method="POST"
                                            x-on:submit="if (!canDelete(row)) $event.preventDefault();">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" :disabled="!canDelete(row)"
                                                :title="canDelete(row) ? 'Hapus Saldo Awal' : getLockReason(row)"
                                                class="p-1 rounded transition"
                                                :class="canDelete(row) ? 'text-red-600 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-500/10' : 'cursor-not-allowed text-gray-300 dark:text-gray-700'"
                                                onclick="return confirm('Yakin hapus saldo awal ini?')">
                                                <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                                </svg>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </template>
                    </template>

                    <!-- Empty State -->
                    <template x-if="tableRowData.length === 0">
                        <tr>
                            <td colspan="6" class="px-6 py-10 text-center font-sans">
                                <p class="text-sm font-medium text-gray-500 dark:text-gray-400">Belum ada data saldo awal untuk periode ini.</p>
                            </td>
                        </tr>
                    </template>
                </tbody>

                <!-- Footer Total Laporan Akuntansi -->
                <tfoot class="border-t-2 border-b-2 border-gray-400 bg-gray-100 font-mono text-xs sm:text-sm font-bold text-gray-900 dark:border-gray-600 dark:bg-gray-800 dark:text-white">
                    <tr>
                        <td colspan="3" class="px-6 py-3 text-center uppercase tracking-wider border-r border-gray-300 dark:border-gray-700 font-sans">
                            TOTAL
                        </td>
                        <td class="px-6 py-3 text-right border-r border-gray-300 dark:border-gray-700"
                            x-text="formatCurrency(totalDebit)"></td>
                        <td class="px-6 py-3 text-right border-r border-gray-300 dark:border-gray-700"
                            x-text="formatCurrency(totalCredit)"></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <!-- Koreksi Modal -->
        <div x-show="showEditModal" x-transition.opacity class="fixed inset-0 z-50 overflow-y-auto bg-black/60 p-4" x-cloak>
            <div class="flex min-h-full items-center justify-center">
                <div @click.away="closeEditModal()" class="w-full max-w-lg overflow-hidden rounded-2xl bg-white border border-gray-100 shadow-2xl dark:bg-gray-900 dark:border-gray-800">
                    <div class="border-b border-gray-200 px-6 py-5 dark:border-gray-800">
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">Koreksi Saldo Awal</h3>
                        <p class="text-sm text-gray-500 dark:text-gray-400">Lakukan koreksi saldo awal akun pada sub periode terkait.</p>
                    </div>

                    <div class="space-y-5 p-6">
                        <div class="rounded-xl border border-amber-200 bg-amber-50 p-4 dark:border-amber-500/20 dark:bg-amber-500/10">
                            <p class="text-sm text-amber-700 dark:text-amber-300">
                                Koreksi akan memperbarui nilai dasar transaksi. Pastikan nominal dan alasan terverifikasi.
                            </p>
                        </div>

                        <dl class="divide-y divide-gray-200 dark:divide-gray-800 text-sm">
                            <div class="flex justify-between py-2">
                                <dt class="text-gray-500">Sub Periode</dt>
                                <dd class="font-semibold text-gray-900 dark:text-white" x-text="editRowData.sub_period"></dd>
                            </div>
                            <div class="flex justify-between py-2">
                                <dt class="text-gray-500">Akun</dt>
                                <dd class="font-semibold text-gray-900 dark:text-white" x-text="editRowData.account_code + ' - ' + editRowData.account_name"></dd>
                            </div>
                        </dl>

                        <div class="space-y-4">
                            <x-form.input id="amount_display" type="number" name="amount" form="correction-amount"
                                label="Nominal Saldo Baru" placeholder="Masukkan nominal saldo yang benar" required />

                            <x-form.text-area name="correction_reason" label="Alasan Koreksi" form="correction-amount"
                                placeholder="Jelaskan alasan penyesuaian saldo awal ini." rows="3" required />
                        </div>
                    </div>

                    <div class="flex justify-end gap-3 border-t border-gray-200 px-6 py-4 dark:border-gray-800">
                        <button type="button" @click="closeEditModal()" class="rounded-lg border border-gray-300 px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 dark:border-gray-700 dark:text-gray-300 dark:hover:bg-gray-800">
                            Batal
                        </button>
                        <form method="POST" id="correction-amount" :action="`/bendahara/opening-balances/${editRowData.id}`">
                            @csrf
                            @method('PUT')
                            <button type="submit" class="rounded-lg bg-amber-600 px-5 py-2 text-sm font-semibold text-white hover:bg-amber-700">
                                Simpan Koreksi
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
