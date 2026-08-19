@props([
    'transactions' => collect(),
])

<div x-data="{
    tableRowData: @js($transactions),
    itemsPerPage: 10,
    currentPage: 1,
    incomeShowUrl: '{{ route('user.transactions.incomes.show', ':id') }}',
    expenseShowUrl: '{{ route('user.transactions.expenses.show', ':id') }}',

    get totalPages() {
        return Math.ceil(this.tableRowData.length / this.itemsPerPage) || 1;
    },

    get paginatedData() {
        const start = (this.currentPage - 1) * this.itemsPerPage;
        return this.tableRowData.slice(start, start + this.itemsPerPage);
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
        if (page >= 1 && page <= this.totalPages) {
            this.currentPage = page;
        }
    },

    formatDate(dateStr) {
        if (!dateStr) return '-';
        return new Date(dateStr).toLocaleDateString('id-ID', {
            day: '2-digit',
            month: 'short',
            year: 'numeric'
        });
    },

    currency(amount) {
        return new Intl.NumberFormat('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0
        }).format(amount || 0);
    },

    getCoaName(row) {
        if (row.transaction_lines && row.transaction_lines.length > 0) {
            const coa = row.transaction_lines[0].chart_of_account;
            if (coa) {
                const countExtra = row.transaction_lines.length - 1;
                return coa.code + ' - ' + coa.name + (countExtra > 0 ? ` (+${countExtra})` : '');
            }
        }
        return '-';
    },

    typeBadgeClass(type) {
        return {
            'INCOME': 'bg-emerald-50 text-emerald-700 border-emerald-200 dark:bg-emerald-500/10 dark:text-emerald-400 dark:border-emerald-500/20',
            'EXPENSE': 'bg-red-50 text-red-700 border-red-200 dark:bg-red-500/10 dark:text-red-400 dark:border-red-500/20',
            'TRANSFER': 'bg-amber-50 text-amber-700 border-amber-200 dark:bg-amber-500/10 dark:text-amber-400 dark:border-amber-500/20',
        } [type] ?? 'bg-gray-50 text-gray-700 border-gray-200';
    },

    typeLabel(type) {
        return {
            'INCOME': 'Pemasukan',
            'EXPENSE': 'Pengeluaran',
            'TRANSFER': 'Transfer',
        } [type] ?? type;
    },

    statusBadgeClass(status) {
        return {
            'DRAFT': 'bg-amber-50 text-amber-700 border-amber-200 dark:bg-amber-500/10 dark:text-amber-400',
            'POSTED': 'bg-emerald-50 text-emerald-700 border-emerald-200 dark:bg-emerald-500/10 dark:text-emerald-400',
            'REVERSED': 'bg-rose-50 text-rose-700 border-rose-200 dark:bg-rose-500/10 dark:text-rose-400',
        } [status] ?? 'bg-gray-50 text-gray-700 border-gray-200';
    },

    statusLabel(status) {
        return {
            'DRAFT': 'Draft',
            'POSTED': 'Diposting',
            'REVERSED': 'Dibatalkan',
        } [status] ?? status;
    },

    getDetailUrl(row) {
        if (row.transaction_type === 'INCOME') {
            return this.incomeShowUrl.replace(':id', row.id);
        }
        return this.expenseShowUrl.replace(':id', row.id);
    }
}">

    {{-- TABLE --}}
    <div
        class="overflow-hidden border border-gray-200 bg-white dark:border-gray-800 dark:bg-gray-900 rounded-xl shadow-xs">
        <div class="max-w-full overflow-x-auto">
            <table class="w-full text-left text-sm text-gray-600 dark:text-gray-400">
                <thead
                    class="border-b border-gray-200 bg-gray-50/80 dark:border-gray-800 dark:bg-gray-800/50 text-xs uppercase font-semibold text-gray-500 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-6 py-4">No</th>
                        <th scope="col" class="px-6 py-4">No. & Tanggal</th>
                        <th scope="col" class="px-6 py-4">Jenis Transaksi</th>
                        <th scope="col" class="px-6 py-4">Akun (COA)</th>
                        <th scope="col" class="px-6 py-4">Deskripsi / Catatan</th>
                        <th scope="col" class="px-6 py-4 text-right">Nominal</th>
                        <th scope="col" class="px-6 py-4 text-center">Status</th>
                        <th scope="col" class="px-6 py-4 text-center">Aksi</th>
                    </tr>
                </thead>

                <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                    <template x-if="paginatedData.length > 0">
                        <template x-for="(row, index) in paginatedData" :key="row.id">
                            <tr class="transition hover:bg-gray-50/60 dark:hover:bg-gray-800/40">
                                {{-- NO --}}
                                <td class="px-6 py-4 font-medium text-gray-500 dark:text-gray-400">
                                    <span x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)"></span>
                                </td>

                                {{-- NO & TANGGAL TRANSAKSI --}}
                                <td class="px-6 py-4">
                                    <div class="flex flex-col">
                                        <span class="font-semibold text-gray-900 dark:text-white"
                                            x-text="row.transaction_number || 'TRX'"></span>
                                        <span class="text-xs text-gray-500 dark:text-gray-400"
                                            x-text="formatDate(row.transaction_date)"></span>
                                    </div>
                                </td>

                                {{-- JENIS TRANSAKSI --}}
                                <td class="px-6 py-4">
                                    <span
                                        class="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold"
                                        :class="typeBadgeClass(row.transaction_type)"
                                        x-text="typeLabel(row.transaction_type)">
                                    </span>
                                </td>

                                {{-- AKUN (COA) --}}
                                <td class="px-6 py-4">
                                    <span
                                        class="inline-flex items-center rounded-md bg-gray-100 dark:bg-gray-800 px-2.5 py-1 text-xs font-medium text-gray-700 dark:text-gray-300"
                                        x-text="getCoaName(row)"></span>
                                </td>

                                {{-- DESKRIPSI --}}
                                <td class="px-6 py-4 max-w-xs truncate">
                                    <span class="text-gray-700 dark:text-gray-300"
                                        x-text="row.description || '-'"></span>
                                </td>

                                {{-- NOMINAL --}}
                                <td class="px-6 py-4 text-right font-bold"
                                    :class="{
                                        'text-emerald-600 dark:text-emerald-400': row.transaction_type === 'INCOME',
                                        'text-rose-600 dark:text-rose-400': row.transaction_type === 'EXPENSE',
                                        'text-gray-900 dark:text-white': row.transaction_type === 'TRANSFER'
                                    }">
                                    <span
                                        x-text="(row.transaction_type === 'INCOME' ? '+ ' : (row.transaction_type === 'EXPENSE' ? '- ' : '')) + currency(row.net_amount)"></span>
                                </td>

                                {{-- STATUS --}}
                                <td class="px-6 py-4 text-center">
                                    <span
                                        class="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-medium"
                                        :class="statusBadgeClass(row.status)" x-text="statusLabel(row.status)">
                                    </span>
                                </td>

                                {{-- AKSI --}}
                                <td class="px-6 py-4 text-center">
                                    <div class="flex items-center justify-center">
                                        <a :href="getDetailUrl(row)" title="Lihat Detail Transaksi"
                                            class="inline-flex h-8 w-8 items-center justify-center rounded-lg border border-gray-200 bg-white text-gray-600 shadow-2xs transition hover:bg-gray-50 hover:text-blue-600 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700 dark:hover:text-blue-400">
                                            <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                            </svg>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </template>
                    </template>

                    {{-- JIKA DATA KOSONG --}}
                    <template x-if="paginatedData.length === 0">
                        <x-common.empty-table-state 
                            title="Tidak ada riwayat transaksi ditemukan"
                            description="Coba sesuaikan kata kunci pencarian atau rentang tanggal filter Anda."
                        />
                    </template>
                </tbody>
            </table>
        </div>

        {{-- PAGINATION FOOTER --}}
        <x-common.pagination itemLabel="transaksi" />
    </div>
</div>
