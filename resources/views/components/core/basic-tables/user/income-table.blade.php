@props([
    'transactions' => collect(),
])

<div x-data="{
    tableRowData: @js($transactions),
    itemsPerPage: 10,
    currentPage: 1,
    showUrl: '{{ route('user.transactions.incomes.show', ':id') }}',
    editUrl: '{{ route('user.transactions.incomes.edit', ':id') }}',
    deleteUrl: '{{ route('user.transactions.incomes.destroy', ':id') }}',

    get totalPages() {
        return Math.ceil(this.tableRowData.length / this.itemsPerPage) || 1;
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

    formatDate(dateStr) {
        if (!dateStr) return '-';
        return new Date(dateStr).toLocaleDateString('id-ID', {
            day: '2-digit',
            month: 'short',
            year: 'numeric'
        });
    },

    currency(amount) {
        return new Intl.NumberFormat('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0
        }).format(amount || 0);
    },

    getCoas(row) {
        if (!row.transaction_lines || row.transaction_lines.length === 0) {
            return [];
        }

        return row.transaction_lines
            .map(line => line.chart_of_account)
            .filter(coa => coa);
    },

    typeBadgeClass(type) {
        return {
            'INCOME': 'bg-emerald-50 text-emerald-700 border-emerald-200 dark:bg-emerald-500/10 dark:text-emerald-400 dark:border-emerald-500/20',
            'EXPENSE': 'bg-red-50 text-red-700 border-red-200 dark:bg-red-500/10 dark:text-red-400 dark:border-red-500/20',
            'TRANSFER': 'bg-amber-50 text-amber-700 border-amber-200 dark:bg-amber-500/10 dark:text-amber-400 dark:border-amber-500/20',
        } [type] ?? 'bg-gray-50 text-gray-700 border-gray-200';
    },

    typeLabel(type) {
        return {
            'INCOME': 'Pemasukan',
            'EXPENSE': 'Pengeluaran',
            'TRANSFER': 'Transfer',
        } [type] ?? type;
    },

    statusBadgeClass(status) {
        return {
            'DRAFT': 'bg-amber-50 text-amber-700 border-amber-200 dark:bg-amber-500/10 dark:text-amber-400',
            'POSTED': 'bg-emerald-50 text-emerald-700 border-emerald-200 dark:bg-emerald-500/10 dark:text-emerald-400',
            'REVERSED': 'bg-rose-50 text-rose-700 border-rose-200 dark:bg-rose-500/10 dark:text-rose-400',
        } [status] ?? 'bg-gray-50 text-gray-700 border-gray-200';
    },

    statusLabel(status) {
        return {
            'DRAFT': 'Draft',
            'POSTED': 'Diposting',
            'REVERSED': 'Dibatalkan',
        } [status] ?? status;
    },

    getDetailUrl(row) {
        return this.showUrl.replace(':id', row.id);
    }
}">

    {{-- TABLE --}}
    <div
        class="overflow-hidden border border-gray-200 bg-white dark:border-gray-800 dark:bg-gray-900 rounded-xl shadow-xs">
        <div class="max-w-full overflow-x-auto">
            <table class="w-full text-left text-sm text-gray-600 dark:text-gray-400">
                <thead
                    class="border-b border-gray-200 bg-gray-50/80 dark:border-gray-800 dark:bg-gray-800/50 text-xs uppercase font-semibold text-gray-500 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-6 py-4">No</th>
                        <th scope="col" class="px-6 py-4">No. & Tanggal</th>
                        <th scope="col" class="px-6 py-4">Jenis Transaksi</th>
                        <th scope="col" class="px-6 py-4">Akun (COA)</th>
                        <th scope="col" class="px-6 py-4">Deskripsi / Catatan</th>
                        <th scope="col" class="px-6 py-4 text-right">Nominal</th>
                        <th scope="col" class="px-6 py-4 text-center">Lampiran Bukti</th>
                        <th scope="col" class="px-6 py-4 text-center">Status</th>
                        <th scope="col" class="px-6 py-4 text-center">Aksi</th>
                    </tr>
                </thead>

                <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                    <template x-if="paginatedData.length > 0">
                        <template x-for="(row, index) in paginatedData" :key="row.id">
                            <tr class="transition hover:bg-gray-50/60 dark:hover:bg-gray-800/40">
                                {{-- NO --}}
                                <td class="px-6 py-4 font-medium text-gray-500 dark:text-gray-400">
                                    <span x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)"></span>
                                </td>

                                {{-- NO & TANGGAL TRANSAKSI --}}
                                <td class="px-6 py-4">
                                    <div class="flex flex-col">
                                        <a :href="getDetailUrl(row)" title="Lihat Detail Transaksi"
                                            class="font-semibold text-gray-900 dark:text-white hover:underline hover:text-blue-600 dark:hover:text-blue-400"
                                            x-text="row.transaction_number || 'TRX'"></a>
                                        <span class="text-xs text-gray-500 dark:text-gray-400"
                                            x-text="formatDate(row.transaction_date)"></span>
                                    </div>
                                </td>

                                {{-- JENIS TRANSAKSI --}}
                                <td class="px-6 py-4">
                                    <span
                                        class="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold"
                                        :class="typeBadgeClass(row.transaction_type)"
                                        x-text="typeLabel(row.transaction_type)">
                                    </span>
                                </td>

                                {{-- AKUN (COA) --}}
                                <td class="px-6 py-4">
                                    <div class="flex flex-col gap-1.5">
                                        <template x-if="getCoas(row).length > 0">
                                            <template x-for="coa in getCoas(row)" :key="coa.id">
                                                <div
                                                    class="inline-flex w-fit items-center rounded-md bg-gray-100 px-2.5 py-1 text-xs font-medium text-gray-700 dark:bg-gray-800 dark:text-gray-300">
                                                    <span x-text="`${coa.code} - ${coa.name}`"></span>
                                                </div>
                                            </template>
                                        </template>

                                        <template x-if="getCoas(row).length === 0">
                                            <span class="text-xs text-gray-400">-</span>
                                        </template>
                                    </div>
                                </td>

                                {{-- DESKRIPSI --}}
                                <td class="px-6 py-4 max-w-xs truncate">
                                    <span class="text-gray-700 dark:text-gray-300"
                                        x-text="row.description || '-'"></span>
                                </td>

                                {{-- NOMINAL --}}
                                <td class="px-6 py-4 text-right font-bold"
                                    :class="{
                                        'text-emerald-600 dark:text-emerald-400': row.transaction_type === 'INCOME',
                                        'text-rose-600 dark:text-rose-400': row.transaction_type === 'EXPENSE',
                                        'text-gray-900 dark:text-white': row.transaction_type === 'TRANSFER'
                                    }">
                                    <span
                                        x-text="(row.transaction_type === 'INCOME' ? '+ ' : (row.transaction_type === 'EXPENSE' ? '- ' : '')) + currency(row.net_amount)"></span>
                                </td>

                                {{-- LAMPIRAN / BUKTI TRANSAKSI (REFINED UI) --}}
                                <td class="px-6 py-4 text-center">
                                    <template x-if="row.receipt_path && row.receipt_url">
                                        <div class="inline-flex items-center justify-center">
                                            <a :href="row.receipt_url" target="_blank"
                                                class="group inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-semibold transition bg-emerald-50 text-emerald-700 border border-emerald-200 hover:bg-emerald-100 dark:bg-emerald-500/10 dark:text-emerald-400 dark:border-emerald-500/20 dark:hover:bg-emerald-500/20 shadow-2xs"
                                                title="Klik untuk membuka bukti transaksi">

                                                {{-- Ikon PDF --}}
                                                <template x-if="row.receipt_path.toLowerCase().endsWith('.pdf')">
                                                    <svg class="w-4 h-4 text-rose-500 shrink-0" fill="none"
                                                        viewBox="0 0 24 24" stroke="currentColor">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
                                                    </svg>
                                                </template>

                                                {{-- Ikon Gambar (PNG/JPG/JPEG/dll) --}}
                                                <template x-if="!row.receipt_path.toLowerCase().endsWith('.pdf')">
                                                    <svg class="w-4 h-4 text-emerald-600 dark:text-emerald-400 shrink-0"
                                                        fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                        <path stroke-linecap="round" stroke-linejoin="round"
                                                            stroke-width="2"
                                                            d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                    </svg>
                                                </template>

                                                <span>Terlampir</span>

                                                <svg class="w-3.5 h-3.5 opacity-60 group-hover:translate-x-0.5 transition-transform"
                                                    fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                                                </svg>
                                            </a>
                                        </div>
                                    </template>

                                    <template x-if="!row.receipt_path">
                                        <span
                                            class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-lg text-xs font-medium bg-gray-100 text-gray-400 dark:bg-gray-800 dark:text-gray-500">
                                            <svg class="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                                    d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
                                            </svg>
                                            Kosong
                                        </span>
                                    </template>
                                </td>

                                {{-- STATUS --}}
                                <td class="px-6 py-4 text-center">
                                    <span
                                        class="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-medium"
                                        :class="statusBadgeClass(row.status)" x-text="statusLabel(row.status)">
                                    </span>
                                </td>

                                {{-- AKSI --}}
                                <td class="px-6 py-4 text-center">
                                    <x-common.table-actions detailUrl="getDetailUrl(row)"
                                        detailTooltip="Lihat Detail Transaksi" editUrl="editUrl.replace(':id', row.id)"
                                        canEdit="!row.sub_period || !row.sub_period.is_closed"
                                        editLockReason="row.sub_period && row.sub_period.is_closed ? 'Sub periode sudah ditutup' : 'Edit Transaksi'"
                                        destroyUrl="deleteUrl.replace(':id', row.id)"
                                        canDelete="!row.sub_period || !row.sub_period.is_closed"
                                        deleteLockReason="row.sub_period && row.sub_period.is_closed ? 'Sub periode sudah ditutup' : 'Hapus Transaksi'"
                                        deleteConfirm="Apakah Anda yakin ingin menghapus transaksi ini? Saldo dan jurnal akan disesuaikan kembali." />
                                </td>
                            </tr>
                        </template>
                    </template>

                    {{-- JIKA DATA KOSONG --}}
                    <template x-if="paginatedData.length === 0">
                        <x-common.empty-table-state title="Tidak ada riwayat transaksi ditemukan"
                            description="Coba sesuaikan kata kunci pencarian atau rentang tanggal filter Anda." />
                    </template>
                </tbody>
            </table>
        </div>

        {{-- PAGINATION FOOTER --}}
        <x-common.pagination itemLabel="transaksi" />
    </div>
</div>
