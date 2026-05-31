@props(['transactions' => collect()])

<div x-data="{
    rows: @js($transactions),
    currentPage: 1,
    perPage: 10,
    selected: null,
    showUrl: '{{ route('bendahara.reports.transactions.show', ':id') }}',

    get totalPages() {
        return Math.ceil(this.rows.length / this.perPage);
    },

    get paginated() {
        const start = (this.currentPage - 1) * this.perPage;
        return this.rows.slice(start, start + this.perPage);
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
            'POSTED': 'bg-green-100 text-green-700',
            'SUBMITTED': 'bg-yellow-100 text-yellow-700',
            'REVERSED': 'bg-red-100 text-red-700',
        } [status] ?? 'bg-gray-100 text-gray-700';
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
            'INCOME': 'bg-blue-100 text-blue-700 border border-blue-200',
            'EXPENSE': 'bg-red-100 text-red-700 border border-red-200',
            'TRANSFER': 'bg-yellow-100 text-yellow-700 border border-yellow-200',
        } [type] ?? 'bg-gray-100 text-gray-700';
    }
}" class="relative">

    {{-- TABLE --}}
    <div class="overflow-hidden rounded-2xl border bg-white dark:bg-white/[0.03]">
        <table class="w-full">
            <thead class="bg-gray-50 dark:bg-gray-900 border-b">
                <tr class="text-left text-sm text-gray-500">
                    <th class="px-6 py-4">No</th>
                    <th class="px-6 py-4">Tanggal</th>
                    <th class="px-6 py-4">Deskripsi</th>
                    <th class="px-6 py-4">Tipe</th>
                    <th class="px-6 py-4">Total</th>
                    <th class="px-6 py-4">Pembuat</th>
                    {{-- <th class="px-6 py-4">Status</th> --}}
                    <th class="px-6 py-4 text-center">Aksi</th>
                </tr>
            </thead>

            <tbody>
                <template x-for="(row, i) in paginated" :key="row.id">
                    <tr class="border-b hover:bg-gray-50 dark:hover:bg-white/5"
                        :class="{
                            'bg-blue-50/40': row.transaction_type === 'INCOME',
                            'bg-red-50/40': row.transaction_type === 'EXPENSE'
                        }">
                        {{-- NO --}}
                        <td class="px-6 py-4" x-text="i + 1 + ((currentPage - 1) * perPage)">
                        </td>

                        {{-- TANGGAL --}}
                        <td class="px-6 py-4" x-text="formatDate(row.transaction_date)">
                        </td>

                        {{-- DESKRIPSI --}}
                        <td class="px-6 py-4" x-text="row.description">
                        </td>

                        {{-- TIPE --}}
                        <td class="px-6 py-4">
                            <span class="px-3 py-1 rounded-full text-xs font-medium"
                                :class="transactionTypeClass(row.transaction_type)"
                                x-text="transactionTypeLabel(row.transaction_type)">
                            </span>
                        </td>

                        {{-- TOTAL --}}
                        <td class="px-6 py-4 font-semibold"
                            :class="{
                                'text-blue-700': row.transaction_type === 'INCOME',
                                'text-red-700': row.transaction_type === 'EXPENSE'
                            }"
                            x-text="currency(row.net_amount)">
                        </td>

                        {{-- CREATOR --}}
                        <td class="px-6 py-4" x-text="row.creator?.name ?? '-'">
                        </td>

                        {{-- STATUS --}}
                        {{-- <td class="px-6 py-4">
                            <span
                                class="px-3 py-1 rounded-full text-xs font-medium"
                                :class="statusClass(row.status)"
                                x-text="row.status">
                            </span>
                        </td> --}}

                        {{-- AKSI --}}
                        <td class="px-6 py-4 text-center">
                            <a :href="showUrl.replace(':id', row.id)"
                                class="text-blue-500 hover:underline text-sm font-medium">
                                <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                    xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                    viewBox="0 0 24 24">
                                    <path stroke="currentColor" stroke-width="2"
                                        d="M21 12c0 1.2-4.03 6-9 6s-9-4.8-9-6c0-1.2 4.03-6 9-6s9 4.8 9 6Z" />
                                    <path stroke="currentColor" stroke-width="2"
                                        d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                </svg>
                            </a>
                        </td>
                    </tr>
                </template>

                {{-- EMPTY STATE --}}
                <template x-if="rows.length === 0">
                    <tr>
                        <td colspan="9" class="text-center py-6 text-gray-400">
                            Tidak ada data transaksi
                        </td>
                    </tr>
                </template>
            </tbody>
        </table>
    </div>

    {{-- PAGINATION --}}
    <div class="flex justify-between items-center mt-4 text-sm text-gray-600">
        <div>
            Halaman <span x-text="currentPage"></span> dari <span x-text="totalPages"></span>
        </div>

        <div class="flex gap-2">
            <button @click="currentPage--" :disabled="currentPage === 1"
                class="px-3 py-1 border rounded disabled:opacity-50">
                Prev
            </button>

            <button @click="currentPage++" :disabled="currentPage === totalPages"
                class="px-3 py-1 border rounded disabled:opacity-50">
                Next
            </button>
        </div>
    </div>

</div>
