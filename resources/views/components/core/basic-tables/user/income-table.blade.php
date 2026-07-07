@props([
    'transactions' => collect(),
])

<div x-data="{
    tableRowData: @js($transactions),
    itemsPerPage: 10,
    currentPage: 1,
    selectedRows: [],
    selectAll: false,
    showUrl: '{{ route('user.transactions.incomes.show', ':id') }}',

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
    openDetail(row) {
        this.selected = row;
    },
    closeDetail() {
        this.selected = null;
    },
    formatDate(date) {
        return new Date(date).toLocaleDateString('id-ID', {
            day: '2-digit',
            month: 'long',
            year: 'numeric'
        });
    },
    currency(amount) {
        return new Intl.NumberFormat('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0
        }).format(amount);
    },

    statusClass(status) {
        return {
            'DRAFT': 'bg-gray-50 text-gray-700 border border-gray-500 dark:bg-gray-500/15 dark:text-gray-500 dark:border-gray-500',
            'SUBMITTED': 'bg-green-50 text-green-700 border border-green-500 dark:bg-green-500/15 dark:text-green-500 dark:border-green-500',
            'POSTED': 'bg-yellow-50 text-yellow-700 border border-yellow-500 dark:bg-yellow-500/15 dark:text-yellow-500 dark:border-yellow-500',
            'REVERSED': 'bg-red-50 text-red-700 border border-red-500 dark:bg-red-500/15 dark:text-red-500 dark:border-red-500',
        } [status] ?? 'bg-gray-50 text-gray-700 border border-gray-500 dark:bg-gray-500/15 dark:text-gray-500 dark:border-gray-500';
    },

    statusLabel(status) {
        return {
            'DRAFT': 'DRAFT',
            'POSTED': 'DIPOSTING',
            'REVERSED': 'DIBATALKAN',
        } [status] ?? '-';
    },

    transactionTypeLabel(type) {
        return {
            'INCOME': 'Penerimaan',
            'EXPENSE': 'Pengeluaran',
            'TRANSFER': 'Transfer',
        } [type] ?? '-';
    },

    transactionTypeClass(type) {
        return {
            'INCOME': 'bg-blue-50 text-blue-700 border border-blue-500 dark:bg-blue-500/15 dark:text-blue-500 dark:border-blue-500',
            'EXPENSE': 'bg-red-50 text-red-700 border border-red-500 dark:bg-red-500/15 dark:text-red-500 dark:border-red-500',
            'TRANSFER': 'bg-yellow-50 text-yellow-700 border border-yellow-500 dark:bg-yellow-500/15 dark:text-yellow-500 dark:border-yellow-500',
        } [type] ?? 'bg-gray-50 text-gray-700 border border-gray-500 dark:bg-gray-500/15 dark:text-gray-500 dark:border-gray-500';
    }
}">

    {{-- TABLE --}}
    <div class="overflow-hidden border border-gray-200 bg-white dark:border-white/[0.05] dark:bg-white/[0.03] shadow-sm">
        <div class="max-w-full overflow-x-auto">
            <table class="w-full">
                <thead
                    class="px-6 py-3.5 border-t border-gray-100 border-y bg-gray-200 dark:border-white/[0.05] dark:bg-gray-900">
                    <tr>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            No</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Tanggal</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Deskripsi</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Tipe</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Total</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Pembuat</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Status</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-center">
                            Aksi</th>
                    </tr>
                </thead>

                <tbody>
                    <template x-if="paginatedData.length > 0">
                        <template x-for="(row, index) in paginatedData" :key="row.id">
                            <tr :class="index % 2 === 0 ? 'bg-gray-50 dark:bg-white/[0.02]' : 'bg-white dark:bg-white/[0.03]'"
                                class="border-b border-gray-100 transition hover:bg-gray-100 dark:border-white/[0.05]">
                                {{-- No --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="font-medium text-gray-700 dark:text-gray-400"
                                        x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)"></span>
                                </td>

                                {{-- TANGGAL --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="font-medium text-gray-700 dark:text-gray-400"
                                        x-text="formatDate(row.transaction_date)"></span>
                                </td>

                                {{-- DESKRIPSI --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="font-medium text-gray-700 dark:text-gray-400"
                                        x-text="row.description"></span>
                                </td>

                                {{-- TIPE --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span
                                        class="inline-flex w-[120px] justify-center rounded-full px-2 py-0.5 text-theme-xs font-medium"
                                        :class="transactionTypeClass(row.transaction_type)"
                                        x-text="transactionTypeLabel(row.transaction_type)">
                                    </span>
                                </td>

                                {{-- TOTAL --}}
                                <td class="px-4 sm:px-6 py-3.5 font-semibold">
                                    <span class="font-medium text-gray-700 dark:text-gray-400"
                                        :class="{
                                            'text-blue-700': row.transaction_type === 'INCOME',
                                            'text-red-700': row.transaction_type === 'EXPENSE'
                                        }"
                                        x-text="currency(row.net_amount)">
                                    </span>
                                </td>

                                {{-- CREATOR --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="font-medium text-gray-700 dark:text-gray-400"
                                        x-text="row.creator?.name ?? '-'"></span>
                                </td>

                                {{-- STATUS --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="px-3 py-1 rounded-full text-xs font-medium"
                                        :class="statusClass(row.status)" x-text="statusLabel(row.status)">
                                    </span>
                                </td>

                                {{-- AKSI --}}

                                <td class="px-4 sm:px-6 py-3.5">
                                    <div class="flex items-center gap-3">
                                        {{-- Show --}}
                                        <a :href="showUrl.replace(':id', row.id)" title="Lihat Detail"
                                            class="flex h-8 w-8 items-center justify-center rounded-md text-blue-500 transition hover:bg-blue-50 dark:text-blue-400 dark:hover:bg-blue-500/10"
                                            title="Lihat Detail">
                                            <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5
                                                c4.477 0 8.268 2.943 9.542 7
                                                -1.274 4.057-5.065 7-9.542 7
                                                -4.477 0-8.268-2.943-9.542-7z" />
                                            </svg>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </template>
                    </template>

                    {{-- Jika data kosong --}}
                    <template x-if="paginatedData.length === 0">
                        <tr>
                            <td colspan="10" class="px-6 py-10 text-center">
                                <div class="flex flex-col items-center justify-center gap-2">
                                    <svg class="w-12 h-12 text-gray-300" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                            d="M9 12h6m-6 4h6M7 4h10a2 2 0 012 2v12a2 2 0 01-2 2H7a2 2 0 01-2-2V6a2 2 0 012-2z" />
                                    </svg>

                                    <p class="text-sm font-medium text-gray-500">
                                        Belum ada data transaksi yang tersedia
                                    </p>

                                    <p class="text-xs text-gray-400">
                                        Data yang tersedia akan tampil di tabel ini
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </template>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Pagination -->
    <div class="px-6 py-4 border-t border-gray-200 dark:border-white/[0.05]">
        <div class="flex items-center justify-between">
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
