@props([
    'sub_periods' => collect(),
    'periods' => collect(),
])

<div x-data="{
    tableRowData: @js($sub_periods),
    itemsPerPage: 10,
    currentPage: 1,

    destroyUrl: '{{ route('bendahara.sub-periode.destroy', ':id') }}',

    get totalPages() {
        return Math.ceil(this.tableRowData.length / this.itemsPerPage);
    },

    get paginatedData() {
        const start = (this.currentPage - 1) * this.itemsPerPage;
        return this.tableRowData.slice(start, start + this.itemsPerPage);
    },

    prevPage() {
        if (this.currentPage > 1) this.currentPage--;
    },

    nextPage() {
        if (this.currentPage < this.totalPages) this.currentPage++;
    },

    getStatusClass(status) {
        return status ?
            'bg-green-50 text-green-700 dark:bg-green-500/15 dark:text-green-500' :
            'bg-gray-100 text-gray-600 dark:bg-gray-500/15 dark:text-gray-400';
    },

    getStatusLabel(status) {
        return status ? 'Aktif' : 'Non Aktif';
    }
}">

    <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">

        <!-- TABLE -->
        <div class="max-w-full overflow-x-auto">
            <table class="w-full">

                <thead>
                    <tr
                        class="bg-gray-50 text-[11px] font-bold uppercase tracking-wider text-gray-600 border-b border-gray-200">
                        <th class="px-6 py-4 text-center border-r border-gray-100">No</th>
                        <th class="px-6 py-4 text-center border-r border-gray-100">Periode</th>
                        <th class="px-6 py-4 text-center border-r border-gray-100">Nama</th>
                        <th class="px-6 py-4 text-center border-r border-gray-100">Deskripsi</th>
                        <th class="px-6 py-4 text-center border-r border-gray-100">Tanggal Mulai</th>
                        <th class="px-6 py-4 text-center border-r border-gray-100">Tanggal Selesai</th>
                        <th class="px-6 py-4 text-center border-r border-gray-100">Status</th>
                        <th class="px-6 py-4 text-center border-r border-gray-100">Action</th>

                    </tr>

                </thead>

                <tbody>

                    <template x-for="(row, index) in paginatedData" :key="row.id">

                        <tr class="border-b border-gray-100 dark:border-white/[0.05]">

                            <td class="px-4 sm:px-6 py-3.5" x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)">
                            </td>

                            <td class="px-4 sm:px-6 py-3.5" x-text="row.period?.name"></td>

                            <td class="px-4 sm:px-6 py-3.5" x-text="row.name"></td>

                            <td class="px-4 sm:px-6 py-3.5" x-text="row.description"></td>

                            <td class="px-4 sm:px-6 py-3.5" x-text="new Date(row.start_date).toLocaleDateString()">
                            </td>

                            <td class="px-4 sm:px-6 py-3.5" x-text="new Date(row.end_date).toLocaleDateString()">
                            </td>

                            <td class="px-4 sm:px-6 py-3.5">

                                <span class="inline-block rounded-full px-2 py-0.5 text-xs font-medium"
                                    :class="getStatusClass(row.is_active)" x-text="getStatusLabel(row.is_active)">
                                </span>

                            </td>

                            <!-- Action -->
                            <td class="px-4 sm:px-3 py-2.5">
                                <div class="flex items-center gap-2">

                                    <!-- Close & Edit hanya jika BELUM ditutup -->
                                    <template x-if="!row.is_closed">
                                        <div class="flex items-center gap-2">

                                            <!-- Close -->
                                            {{-- <form :action="closeUrl.replace(':id', row.id)" method="POST"
                                                onsubmit="return confirm('Apakah anda yakin MENUTUP periode ini?')">
                                                @csrf
                                                @method('PATCH')

                                                <button type="submit"
                                                    class="flex h-8 w-8 items-center justify-center rounded-md
                                                        text-yellow-600 hover:bg-yellow-50
                                                        dark:text-yellow-400 dark:hover:bg-yellow-500/10"
                                                    title="Tutup Periode">
                                                    <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                                                        stroke="currentColor">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="m15 9-6 6m0-6 6 6m6-3a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                                                    </svg>
                                                </button>
                                            </form> --}}

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
                                        onsubmit="return confirm('Yakin hapus sub periode ini?')">
                                        @csrf
                                        @method('DELETE')

                                        <button type="submit"
                                            class="flex h-8 w-8 items-center justify-center rounded-md
                                                text-red-600 hover:bg-red-50
                                                dark:text-red-400 dark:hover:bg-red-500/10"
                                            title="Hapus Sub Periode">
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

        <!-- PAGINATION -->

        <div class="px-6 py-4 border-t border-gray-200 dark:border-white/[0.05]">

            <div class="flex items-center justify-between">

                <button @click="prevPage" :disabled="currentPage === 1" class="px-3 py-2 border rounded">

                    Previous

                </button>

                <span>

                    Page <span x-text="currentPage"></span>
                    of
                    <span x-text="totalPages"></span>

                </span>

                <button @click="nextPage" :disabled="currentPage === totalPages" class="px-3 py-2 border rounded">

                    Next

                </button>

            </div>

        </div>

    </div>

</div>
