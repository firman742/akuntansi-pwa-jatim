@props([
    'taxes' => collect(),
])

<div x-data="{
    tableRowData: @js($taxes),
    itemsPerPage: 10,
    currentPage: 1,
    selectedRows: [],
    selectAll: false,
    editUrl: '{{ route('bendahara.master.taxes.edit', ':id') }}',
    destroyUrl: '{{ route('bendahara.master.taxes.destroy', ':id') }}',

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
        if (page !== '...' && page >= 1 && page <= this.totalPages) {
            this.currentPage = page;
        }
    },

}">
    <div class="overflow-hidden border border-gray-200 bg-white dark:border-white/[0.05] dark:bg-white/[0.03]">
        <!-- Table -->
        <div class="max-w-full overflow-x-auto">
            <table class="w-full">
                <thead
                    class="px-6 py-3.5 border-t border-gray-100 border-y bg-gray-50 dark:border-white/[0.05] dark:bg-gray-900">
                    <tr>
                        <th class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs text-start">
                            No
                        </th>
                        <th class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs text-start">
                            Nama Pajak
                        </th>
                        <th class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs text-start">
                            Rate (%)
                        </th>
                        <th class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs text-start">
                            Tipe
                        </th>
                        <th class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs text-start">
                            Pajak Dibayar Dimuka
                        </th>
                        <th class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs text-start">
                            Hutang Pajak
                        </th>
                        <th class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs text-start">
                            Beban Pajak
                        </th>
                        <th class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs text-start">
                            Action
                        </th>
                    </tr>
                </thead>

                <tbody>
                    <template x-for="(row, index) in paginatedData" :key="row.id">
                        <tr class="border-b border-gray-100 dark:border-white/[0.05]">

                            <!-- No -->
                            <td class="px-3 py-2 text-xs sm:px-6 sm:py-4 sm:text-sm text-gray-600 dark:text-gray-400">
                                <span class="font-medium text-gray-700 text-theme-sm dark:text-gray-400"
                                    x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)"></span>
                            </td>

                            <!-- Nama -->
                            <td class="px-3 py-2 text-xs sm:px-6 sm:py-4 sm:text-sm text-gray-600 dark:text-gray-400">
                                <span class="font-medium text-gray-700 dark:text-gray-400"
                                    x-text="row.name"></span>
                            </td>

                            <!-- Rate -->
                            <td class="px-3 py-2 text-xs sm:px-6 sm:py-4 sm:text-sm text-gray-600 dark:text-gray-400">
                                <span x-text="row.rate + '%'"></span>
                            </td>

                            <!-- Type -->
                            <td class="px-3 py-2 text-xs sm:px-6 sm:py-4 sm:text-sm text-gray-600 dark:text-gray-400">
                                <span x-text="row.type ?? '-'"></span>
                            </td>

                            <!-- Prepaid -->
                            <td class="px-3 py-2 text-xs sm:px-6 sm:py-4 sm:text-sm text-gray-600 dark:text-gray-400">
                                <span x-text="row.account_prepaid ? row.account_prepaid.code : ''"></span> - <span x-text="row.account_prepaid ? row.account_prepaid.name : ''"></span>
                            </td>

                            <!-- Payable -->
                            <td class="px-3 py-2 text-xs sm:px-6 sm:py-4 sm:text-sm text-gray-600 dark:text-gray-400">
                                <span x-text="row.account_payable ? row.account_payable.code : ''"></span> - <span x-text="row.account_payable ? row.account_payable.name : ''"></span>
                            </td>

                            <!-- Expense -->
                            <td class="px-3 py-2 text-xs sm:px-6 sm:py-4 sm:text-sm text-gray-600 dark:text-gray-400">
                                <span x-text="row.account_expense ? row.account_expense.code : ''"></span> - <span x-text="row.account_expense ? row.account_expense.name : ''"></span>
                            </td>

                            <!-- Action -->
                            <td class="px-3 py-2 text-xs sm:px-6 sm:py-4 sm:text-sm text-gray-600 dark:text-gray-400">
                                <div class="flex items-center gap-3">

                                    <!-- Edit -->
                                    <a :href="editUrl.replace(':id', row.id)"
                                        class="inline-flex items-center justify-center">
                                        <svg class="size-5 text-gray-700 hover:text-green-500 dark:text-gray-400 dark:hover:text-green-500"
                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M10.779 17.779 4.36 19.918 6.5 13.5m4.279 4.279 8.364-8.643a3.027 3.027 0 0 0-2.14-5.165
                                                     3.03 3.03 0 0 0-2.14.886L6.5 13.5m4.279 4.279L6.499 13.5" />
                                        </svg>
                                    </a>

                                    <!-- Delete -->
                                    <form :action="destroyUrl.replace(':id', row.id)" method="POST"
                                        onsubmit="return confirm('Yakin hapus pajak ini?')" class="inline-flex">
                                        @csrf
                                        @method('DELETE')

                                        <button type="submit" class="inline-flex items-center justify-center">
                                            <svg class="size-5 text-gray-700 hover:text-red-500 dark:text-gray-400 dark:hover:text-red-500"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6
                                                         m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                            </svg>
                                        </button>
                                    </form>

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
                Previous
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
                    </li>
                </template>
            </ul>

            <button @click="nextPage" :disabled="currentPage === totalPages"
                :class="currentPage === totalPages ? 'opacity-50 cursor-not-allowed' : ''"
                class="flex items-center gap-2 rounded-lg border border-gray-300 bg-white px-3 py-3 text-theme-sm font-medium text-gray-700 shadow-theme-xs hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-white/[0.03] dark:hover:text-gray-200 sm:px-3.5">
                Next
            </button>
        </div>
    </div>
</div>