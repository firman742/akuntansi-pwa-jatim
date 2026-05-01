@props([
    'users' => collect(),
])

<div x-data="{
    tableRowData: @js($users),
    itemsPerPage: 10,
    currentPage: 1,
    editUrl: '{{ route('bendahara.master.account-users.edit', ':id') }}',

    getInitial(name) {
        if (!name) return '';

        const names = name.trim().split(' ');
        let initials = names[0].charAt(0);

        if (names.length > 1) {
            initials += names[names.length - 1].charAt(0);
        }

        return initials.toUpperCase();
    },

    get totalPages() {
        return Math.ceil(this.tableRowData.length / this.itemsPerPage);
    },

    get totalData() {
        return this.tableRowData.length;
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
}">

    <div class="overflow-hidden border border-gray-200 bg-white pt-4 dark:border-white/[0.05] dark:bg-white/[0.03]">

        {{-- Table --}}
        <div class="max-w-full overflow-x-auto">
            <table class="w-full">

                {{-- Header --}}
                <thead
                    class="px-6 py-3.5 border-t border-y border-gray-100 bg-gray-50
                           dark:border-white/[0.05] dark:bg-gray-900">
                    <tr>
                        <th class="px-6 py-3 text-start text-theme-xs font-medium text-gray-500 dark:text-gray-400">
                            No
                        </th>

                        <th class="px-6 py-3 text-start text-theme-xs font-medium text-gray-500 dark:text-gray-400">
                            Foto
                        </th>

                        <th class="px-6 py-3 text-start text-theme-xs font-medium text-gray-500 dark:text-gray-400">
                            Informasi Pengguna
                        </th>

                        <th class="px-6 py-3 text-start text-theme-xs font-medium text-gray-500 dark:text-gray-400">
                            Akun COA
                        </th>

                        <th class="px-6 py-3 text-start text-theme-xs font-medium text-gray-500 dark:text-gray-400">
                            Action
                        </th>
                    </tr>
                </thead>

                {{-- Body --}}
                <tbody>
                    {{-- Empty State --}}
                    <template x-if="paginatedData.length === 0">
                        <tr>
                            <td colspan="5" class="px-6 py-8 text-center text-gray-500 dark:text-gray-400">
                                Belum ada data pengguna yang tersedia.
                            </td>
                        </tr>
                    </template>

                    {{-- Data Rows --}}
                    <template x-if="paginatedData.length > 0">
                        <template x-for="(row, index) in paginatedData" :key="row.id">
                            <tr
                                class="border-b border-gray-100 transition hover:bg-gray-50
                                       dark:border-white/[0.05] dark:hover:bg-white/[0.02]">

                                {{-- Number --}}
                                <td class="px-3 py-4 sm:px-6 text-sm text-gray-600 dark:text-gray-400">
                                    <span class="font-medium text-gray-700 dark:text-gray-300"
                                        x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)">
                                    </span>
                                </td>

                                {{-- Avatar --}}
                                <td class="px-3 py-4 sm:px-6">
                                    <div
                                        class="flex h-10 w-10 items-center justify-center rounded-full
                                               bg-blue-500 text-sm font-semibold text-white">
                                        <span x-text="getInitial(row.name)"></span>
                                    </div>
                                </td>

                                {{-- User Info --}}
                                <td class="px-3 py-4 sm:px-6">
                                    <div class="flex flex-col">
                                        <span class="font-medium text-gray-800 dark:text-white" x-text="row.name">
                                        </span>

                                        <span class="text-sm text-gray-500 dark:text-gray-400" x-text="row.email">
                                        </span>
                                    </div>
                                </td>

                                {{-- COA Count --}}
                                <td class="px-3 py-4 sm:px-6">
                                    <span
                                        class="inline-flex items-center rounded-full
                                               bg-green-50 px-3 py-1 text-xs font-medium text-green-700
                                               dark:bg-green-500/15 dark:text-green-500">

                                        <span x-text="row.coas_count ?? 0"></span>
                                        <span class="ml-1">Akun</span>
                                    </span>
                                </td>

                                {{-- Action --}}
                                <td class="px-3 py-4 sm:px-6">
                                    <a :href="editUrl.replace(':id', row.id)"
                                        class="inline-flex items-center rounded-lg
                                               border border-brand-300 px-3 py-2 text-sm font-medium bg-blue-600
                                               text-white transition hover:bg-blue-100
                                               dark:border-brand-700 dark:text-brand-400 dark:hover:bg-brand-500/10">
                                        Hubungkan COA

                                        <svg class="ml-2 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                            xmlns="http://www.w3.org/2000/svg">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z">
                                            </path>
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                        </svg>
                                    </a>
                                </td>
                            </tr>
                        </template>
                    </template>
                </tbody>
            </table>
        </div>
    </div>

    {{-- Pagination --}}
    <div class="px-6 py-4 border-t border-gray-200 dark:border-white/[0.05]">
        <div class="flex items-center justify-between">

            {{-- Previous --}}
            <button @click="prevPage" :disabled="currentPage === 1"
                :class="currentPage === 1 ? 'opacity-50 cursor-not-allowed' : ''"
                class="flex items-center gap-2 rounded-lg border border-gray-300 bg-white
                       px-3 py-3 text-theme-sm font-medium text-gray-700 shadow-theme-xs
                       hover:bg-gray-50 hover:text-gray-800
                       dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400">

                <span class="hidden sm:inline">Previous</span>
            </button>

            {{-- Pages --}}
            <ul class="hidden items-center gap-0.5 sm:flex">
                <template x-for="page in displayedPages" :key="page">
                    <li>
                        <button @click="goToPage(page)"
                            :class="currentPage === page ?
                                'bg-blue-500 text-white' :
                                'text-gray-700 hover:bg-blue-500/[0.08] hover:text-blue-500 dark:text-gray-400'"
                            class="flex h-10 w-10 items-center justify-center rounded-lg text-theme-sm font-medium"
                            x-text="page">
                        </button>
                    </li>
                </template>
            </ul>

            {{-- Next --}}
            <button @click="nextPage" :disabled="currentPage === totalPages"
                :class="currentPage === totalPages ? 'opacity-50 cursor-not-allowed' : ''"
                class="flex items-center gap-2 rounded-lg border border-gray-300 bg-white
                       px-3 py-3 text-theme-sm font-medium text-gray-700 shadow-theme-xs
                       hover:bg-gray-50 hover:text-gray-800
                       dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400">

                <span class="hidden sm:inline">Next</span>
            </button>
        </div>
    </div>
</div>
