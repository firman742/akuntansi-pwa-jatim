@props([
    'accountTypes' => collect(),
])

<div x-data="{
    tableRowData: @js($accountTypes),
    itemsPerPage: 10,
    currentPage: 1,
    selectedRows: [],
    selectAll: false,
    editUrl: '{{ route('bendahara.master.account-types.edit', ':id') }}',
    destroyUrl: '{{ route('bendahara.master.account-types.destroy', ':id') }}',

    get totalPages() {
        return Math.ceil(this.tableRowData.length / this.itemsPerPage);
    },

    get paginatedData() {
        const start = (this.currentPage - 1) * this.itemsPerPage;
        return this.tableRowData.slice(start, start + this.itemsPerPage);
    },
    get displayedPages() {
        const total = this.totalPages;
        const current = this.currentPage;
        const delta = 2; // jumlah page kiri & kanan

        const pages = [];
        let start = Math.max(1, current - delta);
        let end = Math.min(total, current + delta);

        // pastikan selalu 5 angka kalau memungkinkan
        if (current <= delta + 1) {
            end = Math.min(total, 1 + delta * 2);
        }

        if (current + delta >= total) {
            start = Math.max(1, total - delta * 2);
        }

        for (let i = start; i <= end; i++) {
            pages.push(i);
        }

        return pages;
    },
    prevPage() {
        if (this.currentPage > 1) this.currentPage--;
    },

    nextPage() {
        if (this.currentPage < this.totalPages) this.currentPage++;
    },

    goToPage(page) {
        if (page !== '...' && page >= 1 && page <= this.totalPages) {
            this.currentPage = page;
        }
    },

    getStatusClass(status) {
        return status == 1 ?
            'bg-green-50 text-green-700 border border-green-500 dark:bg-green-500/15 dark:text-green-500 dark:border-green-500' :
            'bg-red-50 text-red-700 border border-red-500 dark:bg-red-500/15 dark:text-red-500 dark:border-red-500';
    },
    getStatusLabel(status) {
        return status == 1 ? 'Aktif' : 'Tidak Aktif';
    },
    canDelete(row) {
        return row.chart_of_accounts_count === 0;
    },
    getLockReason(row) {
        if (row.chart_of_accounts_count > 0) {
            return 'Tidak dapat dihapus dikarenakan telah memiliki data COA';
        }

        return null;
    },

}">

    <div
        class="overflow-hidden border border-gray-200/80 bg-white shadow-xs dark:border-gray-800 dark:bg-gray-900 transition-all">
        <!-- Table -->
        <div class="max-w-full overflow-x-auto">
            <table class="w-full text-left text-sm">
                <thead class="border-b border-gray-200/80 bg-gray-50/80 dark:border-gray-800 dark:bg-gray-800/50">
                    <tr>
                        <th scope="col"
                            class="w-14 px-6 py-4 text-center text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            No
                        </th>
                        <th scope="col"
                            class="w-14 px-6 py-4 text-center text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Nama</th>
                        <th scope="col"
                            class="w-14 px-6 py-4 text-center text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Deskripsi</th>
                        <th scope="col"
                            class="w-14 px-6 py-4 text-center text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Status</th>
                        <th scope="col"
                            class="w-14 px-6 py-4 text-center text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Aksi</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-800/60">
                    <template x-if="paginatedData.length > 0">
                        <template x-for="(row, index) in paginatedData" :key="row.id">
                            <tr class="group transition-colors hover:bg-gray-50/80 dark:hover:bg-gray-800/40">
                                {{-- NO --}}
                                <td class="px-6 py-4 text-center font-mono text-xs text-gray-500 dark:text-gray-400"
                                    x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)">
                                </td>

                                <!-- Nama -->
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <p class="truncate text-xs text-gray-600 dark:text-gray-300"
                                        :title="row.name || '-'" x-text="row.name || '-'">
                                    </p>
                                </td>

                                <!-- Deskripsi -->
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <p class="truncate text-xs text-gray-600 dark:text-gray-300"
                                        :title="row.description || '-'" x-text="row.description || '-'">
                                    </p>
                                </td>

                                <!-- Status -->
                                <td class="px-6 py-4 whitespace-nowrap text-center">
                                    <span :class="getStatusClass(row.status)"
                                        class="inline-flex items-center rounded-full px-2.5 py-0.5 text-[10px] font-medium capitalize">
                                        <span x-text="getStatusLabel(row.status)"></span>
                                    </span>
                                </td>

                                <!-- Action -->
                                <td class="px-6 py-4 text-center whitespace-nowrap">
                                    <x-common.table-actions :editUrl="'editUrl.replace(\':id\', row.id)'" canEdit="true" :destroyUrl="'destroyUrl.replace(\':id\', row.id)'"
                                        canDelete="canDelete(row)" deleteLockReason="getLockReason(row)" />
                                </td>
                            </tr>
                        </template>
                    </template>
                    {{-- DATA KOSONG --}}
                    <template x-if="paginatedData.length === 0">
                        <x-common.empty-table-state title="Tidak ada data periode ditemukan"
                            description="Coba sesuaikan kata kunci pencarian atau rentang tanggal filter Anda." />
                    </template>
                </tbody>

            </table>
        </div>
    </div>

    {{-- PAGINATION FOOTER --}}
    <x-common.pagination itemLabel="tipe akun" />
</div>
