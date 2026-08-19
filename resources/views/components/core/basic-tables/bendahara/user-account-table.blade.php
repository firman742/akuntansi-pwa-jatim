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
    <div
        class="overflow-hidden border border-gray-200/80 bg-white shadow-xs dark:border-gray-800 dark:bg-gray-900 transition-all">
        <div class="max-w-full overflow-x-auto">
            <table class="w-full text-left text-sm">
                {{-- HEADER --}}
                <thead class="border-b border-gray-200/80 bg-gray-50/80 dark:border-gray-800 dark:bg-gray-800/50">
                    <tr>
                        <th scope="col"
                            class="w-14 px-6 py-4 text-center text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            No
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Foto
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Informasi Pengguna
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Akun COA Debit
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Akun COA Kredit
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Action
                        </th>
                    </tr>
                </thead>

                {{-- BODY --}}
                <tbody class="divide-y divide-gray-100 dark:divide-gray-800/60">
                    {{-- DATA AVAILABLE --}}
                    <template x-if="paginatedData.length > 0">
                        <template x-for="(row, index) in paginatedData" :key="row.id">
                            <tr class="group transition-colors hover:bg-gray-50/80 dark:hover:bg-gray-800/40">
                                {{-- NO --}}
                                <td class="px-6 py-4 text-center font-mono text-xs text-gray-500 dark:text-gray-400"
                                    x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)">
                                </td>

                                {{-- Avatar --}}
                                <td class="px-6 py-4 max-w-xs">
                                    <div
                                        class="flex h-10 w-10 items-center justify-center rounded-full
                                               bg-blue-500 text-sm font-semibold text-white">
                                        <span x-text="getInitial(row.name)"></span>
                                    </div>
                                </td>

                                {{-- User Info --}}
                                <td class="px-6 py-4 max-w-xs">
                                    <div class="flex flex-col">
                                        <span class="font-medium text-gray-800 dark:text-white" x-text="row.name">
                                        </span>

                                        <span class="text-sm text-gray-500 dark:text-gray-400" x-text="row.email">
                                        </span>
                                    </div>
                                </td>

                                {{-- COA debet Count --}}
                                <td class="px-6 py-4 max-w-xs">
                                    <span
                                        class="inline-flex items-center rounded-full px-3 py-1 text-xs bg-blue-50 text-blue-700 border border-blue-500 dark:bg-blue-500/15 dark:text-blue-500 dark:border-blue-500">

                                        <span x-text="row.debit_coas_count ?? 0"></span>
                                        <span class="ml-1">Akun</span>
                                    </span>
                                </td>

                                {{-- COA credit Count --}}
                                <td class="px-6 py-4 max-w-xs">
                                    <span
                                        class="inline-flex items-center rounded-full px-3 py-1 text-xs bg-green-50 text-green-700 border border-green-500 dark:bg-green-500/15 dark:text-green-500 dark:border-green-500">

                                        <span x-text="row.credit_coas_count ?? 0"></span>
                                        <span class="ml-1">Akun</span>
                                    </span>
                                </td>

                                {{-- Action --}}
                                <td class="px-6 py-4 max-w-xs">
                                    <a :href="editUrl.replace(':id', row.id)"
                                        class="inline-flex items-center rounded-lg
                                               border border-brand-300 px-3 py-2 text-sm font-medium bg-blue-500
                                               text-white transition hover:bg-blue-400
                                               dark:border-brand-700 dark:text-white-90 dark:hover:bg-brand-500/10">
                                        Hubungkan COA

                                        <svg class="ml-2 h-4 w-4" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
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

                     {{-- DATA KOSONG --}}
                    <template x-if="paginatedData.length === 0">
                        <x-common.empty-table-state 
                            title="Tidak ada data pengguna ditemukan"
                            description="Coba sesuaikan kata kunci pencarian atau rentang tanggal filter Anda."
                        />
                    </template>
                </tbody>
            </table>
        </div>
    </div>

    {{-- PAGINATION FOOTER --}}
        <x-common.pagination itemLabel="pengguna" />
</div>
