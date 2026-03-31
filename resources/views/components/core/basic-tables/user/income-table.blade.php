@props([
    'incomes' => collect(),
])

<div x-data="{
    tableRowData: @js($incomes),
    itemsPerPage: 10,
    currentPage: 1,
    showUrl: '{{ route('user.transactions.incomes.show', ':id') }}',
    {{-- destroyUrl: '{{ route('user.incomes.destroy', ':id') }}', --}}

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

    formatCurrency(amount) {
        return new Intl.NumberFormat('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0
        }).format(amount);
    },

    statusBadge(status) {
        switch (status) {
            case 'POSTED':
                return 'bg-green-100 text-green-700 dark:bg-green-500/15 dark:text-green-400';
            case 'SUBMITTED':
                return 'bg-yellow-100 text-yellow-700 dark:bg-yellow-500/15 dark:text-yellow-400';
            case 'REVERSED':
                return 'bg-red-100 text-red-700 dark:bg-red-500/15 dark:text-red-400';
            default:
                return 'bg-gray-100 text-gray-700 dark:bg-gray-500/15 dark:text-gray-400';
        }
    },
    statusLabel(status) {
        switch (status) {
            case 'POSTED':
                return 'Posted';
            case 'SUBMITTED':
                return 'Diajukan';
            case 'REVERSED':
                return 'Dibatalkan';
            default:
                return 'Draft';
        }
    },
    formatDate(date) {
        if (!date) return '-';
        const d = new Date(date);
        return d.toLocaleDateString('id-ID', {
            day: '2-digit',
            month: 'long',
            year: 'numeric',
        });
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
    <div
        class="overflow-hidden rounded-2xl border border-gray-200 bg-white dark:border-white/[0.05] dark:bg-white/[0.03]">
        <!-- Table -->
        <div class="max-w-full overflow-x-auto">
            <table class="w-full border-collapse">
                <thead>
                    <tr
                        class="bg-gray-50 text-[11px] font-bold uppercase tracking-wider text-gray-600 border-b border-gray-200">
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            <div class="flex items-center gap-3">
                                <span class="font-medium text-gray-500 text-theme-xs dark:text-gray-400">No</span>
                            </div>
                        </th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            tanggal transaksi</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            deskripsi</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            total</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            pembuat</th>
                        {{-- <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Status</th> --}}
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Action</th>
                    </tr>
                </thead>
                <tbody>
                    <template x-for="(row, index) in paginatedData" :key="row.id">
                        <tr class="border-b border-gray-100 dark:border-white/[0.05]">

                            <!-- No Urut -->
                            <td class="px-4 sm:px-6 py-3.5">
                                <div class="flex items-center gap-3">
                                    <span class="font-medium text-gray-700 text-theme-sm dark:text-gray-400"
                                        x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)"></span>
                                </div>
                            </td>

                            <!-- Tanggal Transaksi -->
                            <td class="px-4 sm:px-6 py-3.5" x-text="formatDate(row.transaction_date)"></td>

                            <!-- Deskripsi -->
                            <td class="px-4 sm:px-6 py-3.5" x-text="row.description"></td>

                            <!-- total -->
                            <td class="px-4 sm:px-6 py-3.5" x-text="formatCurrency(row.total_amount)"></td>

                            <!-- pembuat -->
                            <td class="px-4 sm:px-6 py-3.5" x-text="row.creator.name"></td>

                            <!-- status -->
                            {{-- <td class="px-4 sm:px-6 py-3.5">
                                <span class="inline-flex items-center rounded-full px-2.5 py-1 text-xs font-medium"
                                    :class="statusBadge(row.status)" x-text="statusLabel(row.status)">
                                </span>
                            </td> --}}

                            <!-- Action -->
                            <td class="px-4 sm:px-3 py-2.5">
                                <div class="flex items-center gap-2">
                                    <div class="flex items-center gap-2">

                                        <!-- Show -->
                                        <a :href="showUrl.replace(':id', row.id)"
                                            class="flex h-8 w-8 items-center justify-center rounded-md
                                                    text-green-600 hover:bg-green-50
                                                    dark:text-green-400 dark:hover:bg-green-500/10"
                                            title="Edit Periode">
                                            <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                                xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                fill="none" viewBox="0 0 24 24">
                                                <path stroke="currentColor" stroke-width="2"
                                                    d="M21 12c0 1.2-4.03 6-9 6s-9-4.8-9-6c0-1.2 4.03-6 9-6s9 4.8 9 6Z" />
                                                <path stroke="currentColor" stroke-width="2"
                                                    d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                            </svg>
                                        </a>

                                    </div>

                                    <!-- Delete SELALU tampil -->
                                    {{-- <form :action="destroyUrl.replace(':id', row.id)" method="POST"
                                        onsubmit="return confirm('Yakin hapus periode ini?')">
                                        @csrf
                                        @method('DELETE')

                                        <button type="submit"
                                            class="flex h-8 w-8 items-center justify-center rounded-md
                                                   text-red-600 hover:bg-red-50
                                                   dark:text-red-400 dark:hover:bg-red-500/10"
                                            title="Hapus Periode">
                                            <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0 1 16.138 21H7.862
                                                       a2 2 0 0 1-1.995-1.858L5 7m5 4v6m4-6v6
                                                       m1-10V4a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v3M4 7h16" />
                                            </svg>
                                        </button>
                                    </form> --}}
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
                                'text-gray-700 hover:bg-blue-500/[0.08] hover:text-blue-500 dark:text-gray-400 dark:hover:text-blue-500'"
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

<script>
    const periodFilter = document.getElementById('filter_period');
    const subPeriodFilter = document.getElementById('filter_sub_period');

    periodFilter.addEventListener('change', async function() {

        let periodId = this.value;

        subPeriodFilter.innerHTML = '<option>Loading...</option>';

        if (!periodId) {
            subPeriodFilter.innerHTML = '<option value="">Semua</option>';
            return;
        }

        const res = await fetch(`/user/periode/${periodId}/sub-periods`);
        const data = await res.json();

        subPeriodFilter.innerHTML = '<option value="">Semua</option>';

        data.forEach(sub => {
            subPeriodFilter.innerHTML += `
                <option value="${sub.id}">${sub.name}</option>
            `;
        });
    });
</script>
