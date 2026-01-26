@props([
    'openingBalances' => collect(),
    'periods' => collect(),
    'periodId' => null,
])

<div x-data="{
    tableRowData: @js($openingBalances),
    itemsPerPage: 10,
    currentPage: 1,
    editUrl: '{{ route('bendahara.opening-balances.edit', ':id') }}',
    destroyUrl: '{{ route('bendahara.opening-balances.destroy', ':id') }}',

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
    <div
        class="overflow-hidden rounded-2xl border border-gray-200 bg-white pt-4 dark:border-white/[0.05] dark:bg-white/[0.03]">
        <form method="GET" class="px-6 mb-4">
            <div class="flex items-center gap-3">
                <select name="period_id"
                    class="h-10 rounded-lg border border-gray-300 bg-white px-3 text-sm
                           dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400"
                    onchange="this.form.submit()">
                    @foreach ($periods as $period)
                        <option value="{{ $period->id }}" {{ $periodId == $period->id ? 'selected' : '' }}>
                            {{ $period->name }}
                        </option>
                    @endforeach
                </select>
            </div>
        </form>

        <!-- Header -->
        <div class="flex flex-col gap-4 px-6 mb-4 sm:flex-row sm:items-center sm:justify-between">
            <div>
                <h3 class="text-lg font-semibold text-gray-800 dark:text-white/90">
                    Daftar Saldo Awal
                </h3>
            </div>
            <div class="flex items-center gap-3">
                {{-- import --}}
                <a href="">
                    <x-ui.button variant="outline" size="sm">
                        <x-slot:startIcon>
                            <svg class="h-4 w-4 stroke-current fill-white dark:fill-gray-800" viewBox="0 0 20 20"
                                fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                    d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m6.75 12-3-3m0 0-3 3m3-3v6m-1.5-15H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z" />
                            </svg>
                        </x-slot:startIcon>


                        Import
                    </x-ui.button>
                </a>

                {{-- tambah --}}
                <a href="{{ route('bendahara.opening-balances.create') }}">
                    <x-ui.button variant="outline" size="sm">
                        <x-slot:startIcon>
                            <svg class="h-4 w-4 stroke-current fill-white dark:fill-gray-800" viewBox="0 0 20 20"
                                fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M10 4.16699V15.8337" stroke="" stroke-width="1.5" stroke-linecap="round"
                                    stroke-linejoin="round" />
                                <path d="M4.16699 10H15.8337" stroke="" stroke-width="1.5" stroke-linecap="round"
                                    stroke-linejoin="round" />
                            </svg>
                        </x-slot:startIcon>
                        Tambah
                    </x-ui.button>
                </a>
            </div>
        </div>

        <!-- Table -->
        <div class="max-w-full overflow-x-auto">
            <table class="w-full">
                <thead
                    class="px-6 py-3.5 border-t border-gray-100 border-y bg-gray-50 dark:border-white/[0.05] dark:bg-gray-900">
                    <tr>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            <div class="flex items-center gap-3">
                                {{-- <div @click="handleSelectAll()"
                                    class="flex h-5 w-5 cursor-pointer items-center justify-center rounded-md border-[1.25px]"
                                    :class="selectAll ? 'border-blue-500 dark:border-blue-500 bg-blue-500' :
                                        'bg-white dark:bg-white/0 border-gray-300 dark:border-gray-700'">
                                    <svg :class="selectAll ? 'block' : 'hidden'" width="14" height="14"
                                        viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M11.6668 3.5L5.25016 9.91667L2.3335 7" stroke="white"
                                            stroke-width="1.94437" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                </div> --}}
                                <span class="font-medium text-gray-500 text-theme-xs dark:text-gray-400">No</span>
                            </div>
                        </th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Akun</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Kode</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Debit</th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Kredit</th>
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
                                    {{-- <div @click="handleRowSelect(row.id)"
                                        class="flex h-5 w-5 cursor-pointer items-center justify-center rounded-md border-[1.25px]"
                                        :class="selectedRows.includes(row.id) ?
                                            'border-blue-500 bg-blue-500' :
                                            'border-gray-300 bg-white dark:bg-white/0 dark:border-gray-700'">

                                        <svg x-show="selectedRows.includes(row.id)" width="14" height="14"
                                            viewBox="0 0 14 14">
                                            <path d="M11.6668 3.5L5.25016 9.91667L2.3335 7" stroke="white"
                                                stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round" />
                                        </svg>
                                    </div> --}}

                                    <span class="font-medium text-gray-700 text-theme-sm dark:text-gray-400"
                                        x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)"></span>
                                </div>
                            </td>

                            <!-- Nama -->
                            <td class="px-4 sm:px-6 py-3.5">
                                <span class="font-medium text-gray-700 dark:text-gray-400"
                                    x-text="row.account_name"></span>
                            </td>

                            <!-- Kode -->
                            <td class="px-4 sm:px-6 py-3.5" x-text="row.account_code"></td>

                            <!-- Debit -->
                            <td class="px-4 sm:px-6 py-3.5"
                                x-text="row.debit > 0 ? formatCurrency(row.debit) : '-'"></td>

                            <!-- Kredit -->
                            <td class="px-4 sm:px-6 py-3.5"
                                x-text="row.credit > 0 ? formatCurrency(row.credit) : '-'"></td>

                            <!-- Action -->
                            <td class="px-4 sm:px-3 py-2.5">
                                <div class="flex items-center gap-2">

                                    <!-- Close & Edit hanya jika BELUM ditutup -->
                                    <template x-if="!row.is_closed">
                                        <div class="flex items-center gap-2">

                                            <!-- Edit -->
                                            <a :href="editUrl.replace(':id', row.id)"
                                                class="flex h-8 w-8 items-center justify-center rounded-md
                                                       text-green-600 hover:bg-green-50
                                                       dark:text-green-400 dark:hover:bg-green-500/10"
                                                title="Edit Periode">
                                                <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M10.779 17.779 4.36 19.918 6.5 13.5m4.279 4.279
                                                           8.364-8.643a3.027 3.027 0 0 0-2.14-5.165
                                                           3.03 3.03 0 0 0-2.14.886L6.5 13.5" />
                                                </svg>
                                            </a>

                                        </div>
                                    </template>

                                    <!-- Delete SELALU tampil -->
                                    <form :action="destroyUrl.replace(':id', row.id)" method="POST"
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
                                    </form>

                                    <!-- Badge jika sudah ditutup -->
                                    <template x-if="row.is_closed">
                                        <span
                                            class="ml-2 inline-flex items-center rounded-full px-2.5 py-1
                                                   text-xs font-medium
                                                   bg-gray-100 text-gray-600
                                                   dark:bg-gray-500/15 dark:text-gray-400">
                                            Ditutup
                                        </span>
                                    </template>

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
