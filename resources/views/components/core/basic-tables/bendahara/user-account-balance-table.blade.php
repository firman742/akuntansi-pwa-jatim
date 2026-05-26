@props([
    'userAccountBalances' => collect(),
])

<div x-data="{
    tableRowData: @js($userAccountBalances),
    itemsPerPage: 10,
    currentPage: 1,

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
        this.currentPage = page;
    },

    formatCurrency(amount) {
        return new Intl.NumberFormat('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0
        }).format(amount || 0);
    },

    getUsagePercentage(allocated, used) {
        if (!allocated || allocated <= 0) return 0;

        return Math.min(
            Math.round((used / allocated) * 100),
            100
        );
    }
}">
    {{-- SUMMARY CARD --}}
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4 p-3">

        {{-- TOTAL ALOKASI --}}
        <div class="rounded-2xl border border-blue-100 bg-gradient-to-br from-blue-50 to-white p-5">
            <div class="text-sm text-gray-500 mb-1">
                Total Saldo Dibagikan
            </div>

            <div class="text-2xl font-bold text-blue-700"
                x-text="formatCurrency(
                    tableRowData.reduce((sum, row) => sum + Number(row.allocated_balance), 0)
                )">
            </div>
        </div>

        {{-- TOTAL TERPAKAI --}}
        <div class="rounded-2xl border border-amber-100 bg-gradient-to-br from-amber-50 to-white p-5">
            <div class="text-sm text-gray-500 mb-1">
                Total Saldo Terpakai
            </div>

            <div class="text-2xl font-bold text-amber-700"
                x-text="formatCurrency(
                    tableRowData.reduce((sum, row) => sum + Number(row.used_balance), 0)
                )">
            </div>
        </div>

        {{-- TOTAL SISA --}}
        <div class="rounded-2xl border border-green-100 bg-gradient-to-br from-green-50 to-white p-5">
            <div class="text-sm text-gray-500 mb-1">
                Total Saldo Tersisa
            </div>

            <div class="text-2xl font-bold text-green-700"
                x-text="formatCurrency(
                    tableRowData.reduce((sum, row) => sum + Number(row.remaining_balance), 0)
                )">
            </div>
        </div>

    </div>

    {{-- TABLE --}}
    <div class="overflow-hidden border border-gray-200 bg-white shadow-sm">

        <div class="overflow-x-auto">
            <table class="min-w-full">

                {{-- HEADER --}}
                <thead class="bg-gray-100 border-b border-gray-200">
                    <tr>

                        <th class="px-5 py-4 text-xs font-semibold uppercase tracking-wide text-gray-500 text-center">
                            No
                        </th>

                        <th class="px-5 py-4 text-xs font-semibold uppercase tracking-wide text-gray-500 text-center">
                            Sub Periode
                        </th>

                        <th class="px-5 py-4 text-xs font-semibold uppercase tracking-wide text-gray-500 text-left">
                            Pengguna
                        </th>

                        <th class="px-5 py-4 text-xs font-semibold uppercase tracking-wide text-gray-500 text-left">
                            Akun COA
                        </th>

                        <th class="px-5 py-4 text-xs font-semibold uppercase tracking-wide text-gray-500 text-right">
                            Dialokasikan
                        </th>

                        <th class="px-5 py-4 text-xs font-semibold uppercase tracking-wide text-gray-500 text-right">
                            Terpakai
                        </th>

                        <th class="px-5 py-4 text-xs font-semibold uppercase tracking-wide text-gray-500 text-right">
                            Sisa
                        </th>

                        <th class="px-5 py-4 text-xs font-semibold uppercase tracking-wide text-gray-500 text-center">
                            Progress
                        </th>

                        <th class="px-5 py-4 text-xs font-semibold uppercase tracking-wide text-gray-500 text-center">
                            Dialokasikan
                        </th>

                    </tr>
                </thead>

                {{-- BODY --}}
                <tbody class="divide-y divide-gray-100">

                    <template x-if="paginatedData.length > 0">

                        <template x-for="(row, index) in paginatedData" :key="row.id">

                            <tr class="hover:bg-gray-50 transition">

                                {{-- NO --}}
                                <td class="px-5 py-4 text-center text-sm text-gray-500"
                                    x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)">
                                </td>

                                {{-- SUB PERIOD --}}
                                <td class="px-5 py-4 text-center">

                                    <span
                                        class="inline-flex rounded-full bg-blue-50 px-3 py-1 text-xs font-medium text-blue-700"
                                        x-text="row.sub_period || '-'">
                                    </span>

                                </td>

                                {{-- USER --}}
                                <td class="px-5 py-4">
                                    <div class="font-semibold text-gray-800" x-text="row.user_account_name">
                                    </div>

                                    <div class="text-xs text-gray-400">
                                        User Account
                                    </div>
                                </td>

                                {{-- COA --}}
                                <td class="px-5 py-4">

                                    <div class="font-medium text-gray-800" x-text="row.account_name">
                                    </div>

                                    <div class="inline-flex items-center mt-1 rounded-lg bg-gray-100 px-2 py-1 text-xs text-gray-600"
                                        x-text="row.account_code">
                                    </div>

                                </td>

                                {{-- ALLOCATED --}}
                                <td class="px-5 py-4 text-right">

                                    <div class="font-bold text-blue-700" x-text="formatCurrency(row.allocated_balance)">
                                    </div>

                                </td>

                                {{-- USED --}}
                                <td class="px-5 py-4 text-right">

                                    <div class="font-semibold text-amber-600" x-text="formatCurrency(row.used_balance)">
                                    </div>

                                </td>

                                {{-- REMAINING --}}
                                <td class="px-5 py-4 text-right">

                                    <div class="font-bold text-green-700"
                                        x-text="formatCurrency(row.remaining_balance)">
                                    </div>

                                </td>

                                {{-- PROGRESS --}}
                                <td class="px-5 py-4">

                                    <div class="w-full">

                                        <div class="mb-1 flex items-center justify-between text-xs">
                                            <span class="text-gray-500">
                                                Pemakaian
                                            </span>

                                            <span class="font-semibold text-gray-700"
                                                x-text="getUsagePercentage(row.allocated_balance, row.used_balance) + '%'">
                                            </span>
                                        </div>

                                        <div class="h-2 overflow-hidden rounded-full bg-gray-100">

                                            <div class="h-full rounded-full bg-blue-500 transition-all duration-500"
                                                :style="`width: ${getUsagePercentage(row.allocated_balance, row.used_balance)}%`">
                                            </div>

                                        </div>

                                    </div>

                                </td>

                                {{-- ALLOCATED AT --}}
                                <td class="px-5 py-4 text-center">

                                    <div class="text-sm text-gray-700" x-text="row.allocated_at || '-'">
                                    </div>

                                </td>

                            </tr>

                        </template>

                    </template>

                    {{-- EMPTY --}}
                    <template x-if="paginatedData.length === 0">

                        <tr>
                            <td colspan="9" class="px-6 py-14">

                                <div class="flex flex-col items-center justify-center">

                                    <div
                                        class="mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-gray-100">

                                        <svg class="h-8 w-8 text-gray-400" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                                d="M9 12h6m-6 4h6M7 4h10a2 2 0 012 2v12a2 2 0 01-2 2H7a2 2 0 01-2-2V6a2 2 0 012-2z" />
                                        </svg>

                                    </div>

                                    <h3 class="text-sm font-semibold text-gray-700">
                                        Belum Ada Pembagian Saldo
                                    </h3>

                                    <p class="mt-1 text-xs text-gray-400">
                                        Data pembagian saldo ke pengguna akan tampil di sini
                                    </p>

                                </div>

                            </td>
                        </tr>

                    </template>

                </tbody>

            </table>
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
</div>
