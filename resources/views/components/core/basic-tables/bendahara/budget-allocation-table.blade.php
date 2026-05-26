@props([
    'budgetAllocations' => collect(),
    'periods' => collect(),
    'periodId' => null,
    'subPeriods' => collect(),
    'subPeriodId' => null,
])

<div x-data="{
    tableRowData: @js($budgetAllocations),
    itemsPerPage: 10,
    currentPage: 1,
    {{-- editUrl: '{{ route('bendahara.opening-balances.edit', ':id') }}', --}}
    {{-- destroyUrl: '{{ route('bendahara.opening-balances.destroy', ':id') }}', --}}

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
    selectedRows: [],
    selectAll: false,
    handleSelectAll() {
        this.selectAll = !this.selectAll;
        if (this.selectAll) {
            this.selectedRows = this.tableRowData.map(row => row.id);
        } else {
            this.selectedRows = [];
        }
    },
    handleRowSelect(id) {
        if (this.selectedRows.includes(id)) {
            this.selectedRows = this.selectedRows.filter(rowId => rowId !== id);
        } else {
            this.selectedRows.push(id);
        }
    },
    getStatusClass(status) {
        return status == 1 ?
            'bg-green-50 text-green-700 dark:bg-green-500/15 dark:text-green-500' :
            'bg-red-50 text-red-700 dark:bg-red-500/15 dark:text-red-500';
    },
    getStatusLabel(status) {
        return status == 1 ? 'Ditutup' : 'Tidak Ditutup';
    },
    formatCurrency(amount) {
        return new Intl.NumberFormat('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0
        }).format(amount);
    },

    deleteRow(id) {
        if (confirm('Are you sure you want to delete this order?')) {
            this.tableRowData = this.tableRowData.filter(row => row.id !== id);
            this.selectedRows = this.selectedRows.filter(rowId => rowId !== id);

            if (this.currentPage > this.totalPages) {
                this.currentPage = this.totalPages || 1;
            }
        }
    }
}">
    <div class="overflow-hidden border border-gray-200 bg-white shadow-sm">
        <div class="max-w-full overflow-x-auto">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4 p-3">

                <div class="p-4 rounded-xl bg-blue-50">
                    <div class="text-xs text-gray-500">Total Distribusi</div>
                    <div class="text-xl font-bold text-blue-700"
                        x-text="formatCurrency(tableRowData.reduce((a,b)=>a + Number(b.amount),0))">
                    </div>
                </div>

                <div class="p-4 rounded-xl bg-green-50">
                    <div class="text-xs text-gray-500">Jumlah Transaksi</div>
                    <div class="text-xl font-bold text-green-700" x-text="tableRowData.length">
                    </div>
                </div>

                <div class="p-4 rounded-xl bg-yellow-50">
                    <div class="text-xs text-gray-500">Rata-rata Distribusi</div>
                    <div class="text-xl font-bold text-yellow-700"
                        x-text="formatCurrency(
                            tableRowData.length 
                            ? tableRowData.reduce((a,b)=>a + Number(b.amount),0) / tableRowData.length 
                            : 0
                        )">
                    </div>
                </div>

            </div>
            <table class="w-full border-collapse">
                <thead
                    class="px-6 py-3.5 border-t border-gray-100 border-y bg-gray-200 dark:border-white/[0.05] dark:bg-gray-900">
                    <tr>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-center">
                            No
                        </th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-center">
                            Sub Periode</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-center">
                            Akun Asal</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-center">
                            Akun Tujuan</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-center">
                            Tipe</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-center">
                            Jumlah</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-center">
                            Deskripsi</th>
                        {{-- <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-center">
                            Action</th> --}}
                    </tr>
                </thead>
                <tbody class="text-center">
                    <template x-if="paginatedData.length > 0">
                        <template x-for="(row, index) in paginatedData" :key="row.id">

                            <tr class="border-b hover:bg-gray-50 transition">

                                <!-- NO -->
                                <td class="px-4 py-3 text-center text-gray-500"
                                    x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)">
                                </td>

                                <!-- SUB PERIOD -->
                                <td class="px-4 py-3 text-gray-600" x-text="row.sub_period"></td>

                                <!-- FROM -->
                                <td class="px-4 py-3">
                                    <div class="font-medium text-gray-800" x-text="row.from_account"></div>
                                    <div class="text-xs text-gray-400" x-text="row.from_code"></div>
                                </td>

                                <!-- TO -->
                                <td class="px-4 py-3">
                                    <div class="font-medium text-gray-800" x-text="row.to_account"></div>
                                    <div class="text-xs text-gray-400" x-text="row.to_code"></div>
                                </td>

                                <!-- TYPE -->
                                <td class="px-4 py-3 text-center">
                                    <span class="px-2 py-1 text-xs rounded-full"
                                        :class="row.type === 'IN' ?
                                            'bg-green-100 text-green-700' :
                                            'bg-red-100 text-red-700'"
                                        x-text="row.type">
                                    </span>
                                </td>

                                <!-- AMOUNT -->
                                <td class="px-4 py-3 text-right font-semibold text-gray-800"
                                    x-text="formatCurrency(row.amount)">
                                </td>

                                <!-- DESCRIPTION -->
                                <td class="px-4 py-3 text-gray-500 italic" x-text="row.description ?? '-'"></td>

                            </tr>

                        </template>

                    </template>
                    <!-- Jika data kosong -->
                    <template x-if="paginatedData.length === 0">
                        <tr>
                            <td colspan="8" class="px-6 py-10 text-center">
                                <div class="flex flex-col items-center justify-center gap-2">
                                    <svg class="w-12 h-12 text-gray-300" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                            d="M9 12h6m-6 4h6M7 4h10a2 2 0 012 2v12a2 2 0 01-2 2H7a2 2 0 01-2-2V6a2 2 0 012-2z" />
                                    </svg>

                                    <p class="text-sm font-medium text-gray-500">
                                        Belum ada data distribusi saldo
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
