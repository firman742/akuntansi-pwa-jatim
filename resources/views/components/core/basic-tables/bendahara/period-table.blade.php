@props([
    'periods' => collect(),
])

<div x-data="{
    tableRowData: @js($periods),
    itemsPerPage: 10,
    currentPage: 1,
    editUrl: '{{ route('bendahara.periods.edit', ':id') }}',

    get totalPages() {
        return Math.ceil(this.tableRowData.length / this.itemsPerPage) || 1;
    },

    get paginatedData() {
        const start = (this.currentPage - 1) * this.itemsPerPage;
        return this.tableRowData.slice(start, start + this.itemsPerPage);
    },

    get startIndex() {
        if (this.tableRowData.length === 0) return 0;
        return (this.currentPage - 1) * this.itemsPerPage + 1;
    },

    get endIndex() {
        return Math.min(this.currentPage * this.itemsPerPage, this.tableRowData.length);
    },

    get displayedPages() {
        const total = this.totalPages;
        const current = this.currentPage;
        const delta = 2;

        const pages = [];
        let start = Math.max(1, current - delta);
        let end = Math.min(total, current + delta);

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

    formatDate(date) {
        if (!date) return '-';
        return new Date(date).toLocaleDateString('id-ID', {
            day: 'numeric',
            month: 'short',
            year: 'numeric'
        });
    },

    isExpired(row) {
        if (!row.end_date) return false;
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const endDate = new Date(row.end_date);
        endDate.setHours(0, 0, 0, 0);
        return endDate < today;
    },

    getStatusBadge(row) {
        if (row.is_closed) {
            return {
                label: 'Ditutup',
                class: 'bg-gray-100 text-gray-700 border-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:border-gray-700',
                dot: 'bg-gray-400'
            };
        }
        if (row.is_active) {
            return {
                label: 'Aktif',
                class: 'bg-emerald-50 text-emerald-700 border-emerald-200 dark:bg-emerald-950/40 dark:text-emerald-400 dark:border-emerald-800/60',
                dot: 'bg-emerald-500 animate-pulse'
            };
        }
        if (this.isExpired(row)) {
            return {
                label: 'Selesai / Kadaluarsa',
                class: 'bg-amber-50 text-amber-700 border-amber-200 dark:bg-amber-950/40 dark:text-amber-400 dark:border-amber-800/60',
                dot: 'bg-amber-500'
            };
        }
        return {
            label: 'Belum Aktif',
            class: 'bg-slate-50 text-slate-600 border-slate-200 dark:bg-slate-800/40 dark:text-slate-400 dark:border-slate-700',
            dot: 'bg-slate-400'
        };
    },

    getEditLockReason(row) {
        if (row.is_closed) {
            return 'Periode sudah ditutup';
        }
        if (row.transactions_count > 0) {
            return 'Periode sudah memiliki transaksi';
        }
        if (row.sub_period_transactions_count > 0) {
            return 'Terdapat transaksi pada sub periode';
        }
        if (this.isExpired(row)) {
            return 'Periode telah mengakhiri siklusnya';
        }
        return null;
    },

    canEdit(row) {
        return !this.getEditLockReason(row);
    }
}">
    {{-- TABLE CONTAINER --}}
    <div
        class="overflow-hidden border border-gray-200/80 bg-white shadow-xs dark:border-gray-800 dark:bg-gray-900 transition-all">
        <div class="max-w-full overflow-x-auto">
            <table class="w-full text-left text-sm">
                {{-- HEADER --}}
                <thead class="border-b border-gray-200/80 bg-gray-50/80 dark:border-gray-800 dark:bg-gray-800/50">
                    <tr>
                        <th scope="col"
                            class="w-14 px-6 py-4 text-center text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            No
                        </th>
                        <th scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Nama Periode
                        </th>
                        <th scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Deskripsi
                        </th>
                        <th scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Rentang Waktu
                        </th>
                        <th scope="col"
                            class="px-6 py-4 text-center text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Status
                        </th>
                        <th scope="col"
                            class="px-6 py-4 text-center text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Aksi Pengelolaan
                        </th>
                    </tr>
                </thead>

                {{-- BODY --}}
                <tbody class="divide-y divide-gray-100 dark:divide-gray-800/60">
                    {{-- DATA AVAILABLE --}}
                    <template x-if="paginatedData.length > 0">
                        <template x-for="(row, index) in paginatedData" :key="row.id">
                            <tr class="group transition-colors hover:bg-gray-50/80 dark:hover:bg-gray-800/40">
                                {{-- NO --}}
                                <td class="px-6 py-4 text-center font-mono text-xs text-gray-500 dark:text-gray-400"
                                    x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)">
                                </td>

                                {{-- NAMA PERIODE --}}
                                <td class="px-6 py-4">
                                    <div class="flex flex-col gap-0.5">
                                        <span class="font-semibold text-gray-900 dark:text-white"
                                            x-text="row.name"></span>
                                        <div class="flex items-center gap-2 text-xs text-gray-500 dark:text-gray-400">
                                            <span
                                                x-text="(row.sub_periods ? row.sub_periods.length : 0) + ' Sub-Periode'"></span>
                                            <span>•</span>
                                            <span
                                                x-text="((row.transactions_count || 0) + (row.sub_period_transactions_count || 0)) + ' Transaksi'"></span>
                                        </div>
                                    </div>
                                </td>

                                {{-- DESKRIPSI --}}
                                <td class="px-6 py-4 max-w-xs">
                                    <p class="truncate text-xs text-gray-600 dark:text-gray-300"
                                        :title="row.description || '-'" x-text="row.description || '-'">
                                    </p>
                                </td>

                                {{-- RENTANG WAKTU --}}
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div
                                        class="inline-flex items-center gap-1.5 rounded-xl border border-gray-200/80 bg-gray-50 px-3 py-1.5 text-xs font-mono text-gray-700 dark:border-gray-800 dark:bg-gray-800/60 dark:text-gray-300">
                                        <svg class="h-3.5 w-3.5 text-gray-400 shrink-0" fill="none"
                                            viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                        </svg>
                                        <span x-text="formatDate(row.start_date)"></span>
                                        <span class="text-gray-400">—</span>
                                        <span x-text="formatDate(row.end_date)"></span>
                                    </div>
                                </td>

                                {{-- STATUS BADGE --}}
                                <td class="px-6 py-4 text-center whitespace-nowrap">
                                    @php $badge = 'getStatusBadge(row)'; @endphp
                                    <span
                                        class="inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 text-xs font-medium transition-all"
                                        :class="{{ $badge }}.class">
                                        <span class="h-1.5 w-1.5 rounded-full" :class="{{ $badge }}.dot"></span>
                                        <span x-text="{{ $badge }}.label"></span>
                                    </span>
                                </td>

                                <td class="px-6 py-4 text-center whitespace-nowrap">
                                    <x-common.table-actions
                                        :editUrl="'editUrl.replace(\':id\', row.id)'"
                                        canEdit="canEdit(row)"
                                        editLockReason="getEditLockReason(row)"

                                        :destroyUrl="'destroyUrl.replace(\':id\', row.id)'"
                                        canDelete="canEdit(row)"
                                        deleteLockReason="getEditLockReason(row)"
                                    />
                                </td>
                            </tr>
                        </template>
                    </template>

                    {{-- DATA KOSONG --}}
                    <template x-if="paginatedData.length === 0">
                        <x-common.empty-table-state 
                            title="Tidak ada data periode ditemukan"
                            description="Coba sesuaikan kata kunci pencarian atau rentang tanggal filter Anda."
                        />
                    </template>
                </tbody>
            </table>
        </div>

        {{-- PAGINATION FOOTER --}}
        <x-common.pagination itemLabel="periode" />
    </div>
</div>
