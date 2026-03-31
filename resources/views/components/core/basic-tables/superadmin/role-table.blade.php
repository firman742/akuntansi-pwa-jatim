@props([
    'roles' => collect(),
])

<div x-data="{
    tableRowData: @js($roles),
    itemsPerPage: 10,
    currentPage: 1,
    selectedRows: [],
    selectAll: false,
    showUrl: '{{ route('superadmin.roles.show', ':id') }}',

    get totalPages() {
        return Math.ceil(this.tableRowData.length / this.itemsPerPage);
    },

    get paginatedData() {
        const start = (this.currentPage - 1) * this.itemsPerPage;
        return this.tableRowData.slice(start, start + this.itemsPerPage);
    },

    getInitial(name) {
        if (!name) return '-';
        return name.split(' ')
            .map(word => word.charAt(0))
            .join('')
            .substring(0, 2)
            .toUpperCase();
    },

    getRoleName(roles) {
        if (!roles || roles.length === 0) return '-';
        return roles.map(r => r.name).join(', ');
    }
}">

    <div
        class="overflow-hidden border border-gray-200 bg-white dark:border-white/[0.05] dark:bg-white/[0.03]">
        <!-- Table -->
        <div class="max-w-full overflow-x-auto">
            <table class="w-full">
                <thead
                    class="px-6 py-3.5 border-t border-gray-100 border-y bg-gray-50 dark:border-white/[0.05] dark:bg-gray-900">
                    <tr>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            <div class="flex items-center gap-3">
                                <span class="font-medium text-gray-500 text-theme-xs dark:text-gray-400">No</span>
                            </div>
                        </th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Nama</th>
                       
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Action</th>
                    </tr>
                </thead>
                <tbody>
                    <template x-for="(row, index) in paginatedData" :key="row.id">
                        <tr class="border-b border-gray-100 dark:border-white/[0.05]">

                            <!-- No Urut -->
                            <td class="px-3 py-2 text-xs sm:px-6 sm:py-4 sm:text-sm text-gray-600 dark:text-gray-400">
                                <div class="flex items-center gap-3">
                                    <span class="font-medium text-gray-700 text-theme-sm dark:text-gray-400"
                                        x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)"></span>
                                </div>
                            </td>

                            <!-- Nama -->
                            <td class="px-3 py-2 text-xs sm:px-6 sm:py-4 sm:text-sm text-gray-600 dark:text-gray-400">
                                <span class="font-medium text-gray-700 dark:text-gray-400" x-text="row.name"></span>
                            </td>

                            <!-- Action -->
                            <td class="px-3 py-2 text-xs sm:px-6 sm:py-4 sm:text-sm text-gray-600 dark:text-gray-400">
                                <div class="flex items-center gap-3">
                                    <!-- View -->
                                    <a :href="showUrl.replace(':id', row.id)"
                                        class="inline-flex items-center justify-center">
                                        <svg class="size-5 text-gray-700 hover:text-blue-500 dark:text-gray-400 dark:hover:text-blue-500"
                                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                        </svg>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </template>
                </tbody>

            </table>
        </div>
    </div>
</div>
