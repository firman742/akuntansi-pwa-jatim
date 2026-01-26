@props(['transactions' => collect()])

<div
    x-data="{
        rows: @js($transactions),
        currentPage: 1,
        perPage: 10,
        selected: null,

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
            }[status] ?? 'bg-gray-100 text-gray-700';
        },

        transactionTypeLabel(type) {
            return {
                'INCOME': 'Penerimaan',
                'EXPENSE': 'Pengeluaran',
            }[type] ?? '-';
        },

        transactionTypeClass(type) {
            return {
                'INCOME': 'bg-blue-100 text-blue-700',
                'EXPENSE': 'bg-red-100 text-red-700',
            }[type] ?? 'bg-gray-100 text-gray-700';
        }
    }"
    class="relative"
>
    <div class="overflow-hidden rounded-2xl border bg-white dark:bg-white/[0.03]">
        <table class="w-full">
            <thead class="bg-gray-50 dark:bg-gray-900 border-b">
                <tr class="text-left text-sm text-gray-500">
                    <th class="px-6 py-4">No</th>
                    <th class="px-6 py-4">Kode</th>
                    <th class="px-6 py-4">Tanggal</th>
                    <th class="px-6 py-4">Deskripsi</th>
                    <th class="px-6 py-4">Tipe</th>
                    <th class="px-6 py-4">Total</th>
                    <th class="px-6 py-4">Pembuat</th>
                    <th class="px-6 py-4">Status</th>
                    <th class="px-6 py-4 text-center">Aksi</th>
                </tr>
            </thead>

            <tbody>
                <template x-for="(row, i) in paginated" :key="row.id">
                    <tr class="border-b hover:bg-gray-50 dark:hover:bg-white/5">
                        <td class="px-6 py-4"
                            x-text="i + 1 + ((currentPage - 1) * perPage)">
                        </td>

                        <td class="px-6 py-4 font-medium"
                            x-text="row.transaction_number">
                        </td>

                        <td class="px-6 py-4"
                            x-text="formatDate(row.transaction_date)">
                        </td>

                        <td class="px-6 py-4"
                            x-text="row.description">
                        </td>

                        {{-- TIPE TRANSAKSI --}}
                        <td class="px-6 py-4">
                            <span
                                class="px-3 py-1 rounded-full text-xs font-medium"
                                :class="transactionTypeClass(row.transaction_type)"
                                x-text="transactionTypeLabel(row.transaction_type)">
                            </span>
                        </td>

                        <td class="px-6 py-4 font-semibold"
                            x-text="currency(row.total_amount)">
                        </td>

                        <td class="px-6 py-4"
                            x-text="row.creator?.name">
                        </td>

                        <td class="px-6 py-4">
                            <span
                                class="px-3 py-1 rounded-full text-xs font-medium"
                                :class="statusClass(row.status)"
                                x-text="row.status">
                            </span>
                        </td>

                        <td class="px-6 py-4 text-center">
                            <button
                                @click="openDetail(row)"
                                class="text-blue-600 hover:underline text-sm font-medium">
                                Detail
                            </button>
                        </td>
                    </tr>
                </template>
            </tbody>
        </table>
    </div>
</div>
