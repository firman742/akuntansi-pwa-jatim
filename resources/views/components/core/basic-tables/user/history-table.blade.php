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
                        <tr>
                            <td colspan="8" class="px-6 py-12 text-center">
                                <div class="flex flex-col items-center justify-center">
                                    <div class="rounded-full bg-gray-100 dark:bg-gray-800 p-3 mb-3">
                                        <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                                d="M9 12h6m-6 4h6M7 4h10a2 2 0 012 2v12a2 2 0 01-2 2H7a2 2 0 01-2-2V6a2 2 0 012-2z" />
                                        </svg>
                                    </div>
                                    <p class="text-sm font-semibold text-gray-900 dark:text-white">Tidak ada riwayat
                                        transaksi ditemukan</p>
                                    <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">Coba sesuaikan kata kunci
                                        pencarian atau rentang tanggal filter Anda.</p>
                                </div>
                            </td>
                        </tr>
                    </template>
                </tbody>
            </table>
        </div>

        <!-- PAGINATION BAR -->
        <div class="px-6 py-4 border-t border-gray-200 dark:border-white/[0.05]">
            <div class="flex items-center justify-between flex-wrap gap-3">
                <p class="text-xs text-gray-500 dark:text-gray-400">
                    Menampilkan <span class="font-medium text-gray-900 dark:text-white"
                        x-text="paginatedData.length ? ((currentPage - 1) * itemsPerPage) + 1 : 0"></span>
                    sampai <span class="font-medium text-gray-900 dark:text-white"
                        x-text="Math.min(currentPage * itemsPerPage, tableRowData.length)"></span>
                    dari <span class="font-medium text-gray-900 dark:text-white" x-text="tableRowData.length"></span>
                    transaksi
                </p>
                <div class="flex items-center justify-between gap-3">
                    <button @click="prevPage" :disabled="currentPage === 1"
                        :class="currentPage === 1 ? 'opacity-50 cursor-not-allowed' : ''"
                        class="flex items-center gap-2 rounded-lg border border-gray-300 bg-white px-3 py-3 text-theme-sm font-medium text-gray-700 shadow-theme-xs hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200 sm:px-3.5">
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                            xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                d="M2.58301 9.99868C2.58272 10.1909 2.65588 10.3833 2.80249 10.53L7.79915 15.5301C8.09194 15.8231 8.56682 15.8233 8.85981 15.5305C9.15281 15.2377 9.15297 14.7629 8.86018 14.4699L5.14009 10.7472L16.6675 10.7472C17.0817 10.7472 17.4175 10.4114 17.4175 9.99715C17.4175 9.58294 17.0817 9.24715 16.6675 9.24715L5.14554 9.24715L8.86017 5.53016C9.15297 5.23717 9.15282 4.7623 8.85983 4.4695C8.56684 4.1767 8.09197 4.17685 7.79917 4.46984L2.84167 9.43049C2.68321 9.568 2.58301 9.77087 2.58301 9.99715C2.58301 9.99766 2.58301 9.99817 2.58301 9.99868Z"
                                fill="currentColor" />
                        </svg>
                        <span class="hidden sm:inline">Previous</span>
                    </button>

                    <span class="block text-sm font-medium text-gray-700 dark:text-gray-400 sm:hidden">
                        Page <span x-text="currentPage"></span> of <span x-text="totalPages"></span>
                    </span>

                    <ul class="hidden items-center gap-0.5 sm:flex">
                        <template x-for="page in displayedPages" :key="page">
                            <li>
                                <button x-show="page !== '...'" @click="goToPage(page)"
                                    :class="currentPage === page ? 'bg-blue-500 text-white' :
                                        'text-gray-700 hover:bg-green-500/[0.08] hover:text-blue-500 dark:text-gray-400 dark:hover:text-blue-500'"
                                    class="flex h-10 w-10 items-center justify-center rounded-lg text-theme-sm font-medium"
                                    x-text="page"></button>
                                <span x-show="page === '...'"
                                    class="flex h-10 w-10 items-center justify-center text-gray-500">...</span>
                            </li>
                        </template>
                    </ul>

                    <button @click="nextPage" :disabled="currentPage === totalPages"
                        :class="currentPage === totalPages ? 'opacity-50 cursor-not-allowed' : ''"
                        class="flex items-center gap-2 rounded-lg border border-gray-300 bg-white px-3 py-3 text-theme-sm font-medium text-gray-700 shadow-theme-xs hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200 sm:px-3.5">
                        <span class="hidden sm:inline">Next</span>
                        <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                            xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                d="M17.4175 9.9986C17.4178 10.1909 17.3446 10.3832 17.198 10.53L12.2013 15.5301C11.9085 15.8231 11.4337 15.8233 11.1407 15.5305C10.8477 15.2377 10.8475 14.7629 11.1403 14.4699L14.8604 10.7472L3.33301 10.7472C2.91879 10.7472 2.58301 10.4114 2.58301 9.99715C2.58301 9.58294 2.91879 9.24715 3.33301 9.24715L14.8549 9.24715L11.1403 5.53016C10.8475 5.23717 10.8477 4.7623 11.1407 4.4695C11.4336 4.1767 11.9085 4.17685 12.2013 4.46984L17.1588 9.43049C17.3173 9.568 17.4175 9.77087 17.4175 9.99715C17.4175 9.99763 17.4175 9.99812 17.4175 9.9986Z"
                                fill="currentColor" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
