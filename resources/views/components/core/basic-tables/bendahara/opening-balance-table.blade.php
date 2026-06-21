@props([
    'openingBalances' => collect(),
    'periods' => collect(),
    'periodId' => null,
    'subPeriods' => collect(),
    'subPeriodId' => null,
])

<div x-data="{
    tableRowData: @js($openingBalances),
    itemsPerPage: 10,
    currentPage: 1,

    editUrl: '{{ route('bendahara.opening-balances.edit', ':id') }}',
    destroyUrl: '{{ route('bendahara.opening-balances.destroy', ':id') }}',

    showEditModal: false,
    openEditModal(row) {
        this.showEditModal = true;
        this.editRowData = { ...row };
    },
    closeEditModal() {
        this.showEditModal = false;
        this.editRowData = {};
    },

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
    },
    canEdit(row) {
        return !row.has_transaction &&
            !row.has_allocation &&
            !row.period_closed &&
            !row.sub_period_expired;
    },

    canDelete(row) {
        return !row.has_transaction &&
            !row.has_allocation &&
            !row.period_closed &&
            !row.sub_period_expired;
    },
    getLockReason(row) {
        if (row.has_transaction) {
            return 'Tidak dapat mengedit/hapus karena sudah ada transaksi pada sub periode ini.';
        }
        if (row.has_allocation) {
            return 'Tidak dapat mengedit/hapus karena sudah ada alokasi pada sub periode ini.';
        }
        if (row.period_closed) {
            return 'Tidak dapat mengedit/hapus karena periode ini sudah ditutup.';
        }
        if (row.sub_period_expired) {
            return 'Tidak dapat mengedit/hapus karena sub periode ini sudah kadaluarsa.';
        }
        return '';
    },
}">
    <div class="overflow-hidden border border-gray-200 bg-white dark:border-white/[0.05] dark:bg-white/[0.03] shadow-sm">
        <div class="max-w-full overflow-x-auto">
            <table class="w-full">
                <thead
                    class="px-6 py-3.5 border-t border-gray-100 border-y bg-gray-200 dark:border-white/[0.05] dark:bg-gray-900">
                    <tr>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            No
                        </th>
                        <th
                            class="px-6 py-3 font-medium text-gray-500 sm:px-6 text-theme-xs dark:text-gray-400 text-start">
                            Sub Periode</th>
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
                    <template x-if="paginatedData.length > 0">
                        <template x-for="(row, index) in paginatedData" :key="row.id">
                            <tr :class="index % 2 === 0 ? 'bg-gray-50 dark:bg-white/[0.02]' : 'bg-white dark:bg-white/[0.03]'"
                                class="border-b border-gray-100 transition hover:bg-gray-100 dark:border-white/[0.05]">

                                <!-- No Urut -->
                                <td class="px-3 py-4 sm:px-6">
                                    <span class="font-light text-gray-700 dark:text-gray-400"
                                        x-text="(index + 1) + ((currentPage - 1) * itemsPerPage)"></span>
                                </td>

                                <!-- Sub Periode -->
                                <td class="px-3 py-4 sm:px-6">
                                    <span class="font-light text-gray-700 dark:text-gray-400"
                                        x-text="row.sub_period"></span>
                                </td>

                                <!-- Nama -->
                                <td class="px-3 py-4 sm:px-6">
                                    <span class="font-light text-gray-700 dark:text-gray-400"
                                        x-text="row.account_name"></span>
                                </td>

                                <!-- Kode -->
                                <td class="px-3 py-4 sm:px-6">
                                    <span class="font-light text-gray-700 dark:text-gray-400"
                                        x-text="row.account_code"></span>
                                </td>

                                <!-- Debit -->
                                <td class="px-3 py-4 sm:px-6">
                                    <span class="font-light text-gray-700 dark:text-gray-400"
                                        x-text="row.debit > 0 ? formatCurrency(row.debit) : '-'"></span>
                                </td>

                                <!-- Kredit -->
                                <td class="px-3 py-4 sm:px-6">
                                    <span class="font-light text-gray-700 dark:text-gray-400"
                                        x-text="row.credit > 0 ? formatCurrency(row.credit) : '-'"></span>
                                </td>

                                <!-- Action -->
                                <td class="px-4 sm:px-3 py-2.5">
                                    <div class="flex items-center gap-2">

                                        <button type="button" @click="canEdit(row) && openEditModal(row)"
                                            :disabled="!canEdit(row)"
                                            :title="canEdit(row) ? 'Koreksi Saldo' : getLockReason(row)"
                                            class="flex h-8 w-8 items-center justify-center rounded-md transition"
                                            :class="canEdit(row) ?
                                                'text-blue-500 hover:bg-blue-50 dark:text-blue-400 dark:hover:bg-blue-500/10' :
                                                'cursor-not-allowed bg-gray-100 text-gray-400 dark:bg-gray-800 dark:text-gray-600'">
                                            <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                            </svg>
                                        </button>

                                        {{-- Delete --}}
                                        <form :action="destroyUrl.replace(':id', row.id)" method="POST"
                                            x-on:submit="if (!canDelete(row)) $event.preventDefault();">
                                            @csrf
                                            @method('DELETE')

                                            <button type="submit" :disabled="!canDelete(row)"
                                                :title="canDelete(row) ? 'Hapus Saldo Awal' : getLockReason(row)"
                                                class="flex h-8 w-8 items-center justify-center rounded-md transition"
                                                :class="canDelete(row) ?
                                                    'text-red-600 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-500/10' :
                                                    'cursor-not-allowed bg-gray-100 text-gray-400 dark:bg-gray-800 dark:text-gray-600'"
                                                onclick="return confirm('Yakin hapus saldo awal ini?')">
                                                <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862
                                                            a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6
                                                            m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                                </svg>
                                            </button>
                                        </form>
                                    </div>
                                </td>

                            </tr>
                        </template>
                    </template>
                    <!-- Jika data kosong -->
                    <template x-if="paginatedData.length === 0">
                        <tr>
                            <td colspan="9" class="px-6 py-10 text-center">
                                <div class="flex flex-col items-center justify-center gap-2">
                                    <svg class="w-12 h-12 text-gray-300" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                            d="M9 12h6m-6 4h6M7 4h10a2 2 0 012 2v12a2 2 0 01-2 2H7a2 2 0 01-2-2V6a2 2 0 012-2z" />
                                    </svg>

                                    <p class="text-sm font-medium text-gray-500">
                                        Belum ada data saldo awal
                                    </p>

                                    <p class="text-xs text-gray-400">
                                        Data yang tersedia akan tampil di tabel ini
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </template>
                </tbody>

            </table>
        </div>

        <!-- Koreksi Modal -->
        <div x-show="showEditModal" x-transition.opacity class="fixed inset-0 z-99999 overflow-y-auto bg-black/60 p-4">

            <div class="flex items-center justify-center">
                <div @click.away="closeEditModal()"
                    class="w-full max-w-lg sm:max-w-xl lg:max-w-2xl overflow-hidden rounded-2xl bg-white border border-gray-100 shadow-2xl dark:bg-gray-900 dark:border-white">


                    {{-- Header --}}
                    <div class="border-b border-gray-200 px-6 py-5 dark:border-white">

                        <div class="flex items-center gap-3">

                            <div
                                class="flex h-12 w-12 items-center justify-center rounded-full bg-amber-100 text-amber-600 dark:bg-amber-500/20 dark:text-amber-400">

                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor">

                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 9v2m0 4h.01M12 3L2 21h20L12 3z" />
                                </svg>

                            </div>

                            <div class="flex-1">

                                <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                                    Koreksi Saldo Awal
                                </h3>

                                <p class="text-sm text-gray-500 dark:text-gray-400">
                                    Lakukan koreksi terhadap saldo awal akun pada sub periode yang dipilih.
                                </p>

                            </div>

                        </div>

                    </div>

                    {{-- Body --}}
                    <div class="space-y-5 p-6">

                        {{-- Warning --}}
                        <div
                            class="rounded-xl border border-amber-200 bg-amber-50 p-4 dark:border-amber-500/20 dark:bg-amber-500/10">

                            <div class="flex items-start gap-3">
                                <p class="text-sm text-amber-700 dark:text-amber-300">
                                    Koreksi saldo awal akan mengubah nilai saldo yang digunakan sebagai dasar
                                    pencatatan transaksi pada periode terkait. Pastikan nominal dan alasan
                                    koreksi telah diverifikasi sebelum disimpan.
                                </p>

                            </div>
                        </div>

                        {{-- Informasi Akun --}}
                        <div>
                            <h4 class="mb-3 text-sm font-semibold text-gray-900 dark:text-white">
                                Informasi Saldo Saat Ini
                            </h4>

                            <dl class="divide-y divide-gray-200 dark:divide-gray-800">

                                <div class="flex flex-col gap-1 py-3 sm:flex-row sm:justify-between">
                                    <dt class="text-sm text-gray-500">
                                        Sub Periode
                                    </dt>

                                    <dd class="font-semibold text-gray-900 dark:text-white"
                                        x-text="editRowData.sub_period">
                                    </dd>
                                </div>

                                <div class="flex flex-col gap-1 py-3 sm:flex-row sm:justify-between">
                                    <dt class="text-sm text-gray-500">
                                        Akun
                                    </dt>

                                    <dd class="font-semibold text-gray-900 dark:text-white"
                                        x-text="editRowData.account_code + ' - ' + editRowData.account_name">
                                    </dd>
                                </div>


                                <div class="flex flex-col gap-1 py-3 sm:flex-row sm:justify-between">
                                    <dt class="text-sm text-gray-500">
                                        Saldo Saat Ini
                                    </dt>

                                    <dd class="font-semibold text-primary-600 dark:text-primary-400"
                                        x-text="editRowData.debit > 0
                                            ? formatCurrency(editRowData.debit)
                                            : formatCurrency(editRowData.credit)">
                                    </dd>
                                </div>

                            </dl>
                        </div>

                        {{-- Form Koreksi --}}
                        <div class="grid grid-cols-1 gap-5">

                            <x-form.input id="amount_display" type="number" name="amount" form="correction-amount"
                                label="Saldo Hasil Koreksi" placeholder="Masukkan nominal saldo yang benar"
                                required />

                            <x-form.text-area name="correction_reason" label="Alasan Koreksi"
                                form="correction-amount"
                                placeholder="Jelaskan alasan perubahan saldo awal, misalnya karena kesalahan input nominal sebelumnya atau hasil penyesuaian audit."
                                rows="4" required />

                        </div>

                    </div>

                    {{-- Footer --}}
                    <div class="flex justify-end gap-3 border-t border-gray-200 px-6 py-4 dark:border-gray-800">

                        <button type="button" @click="closeEditModal()"
                            class="rounded-lg border border-gray-300 px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 dark:border-gray-700 dark:text-gray-300 dark:hover:bg-gray-800">

                            Batal

                        </button>

                        <form method="POST" id="correction-amount"
                            :action="`/bendahara/opening-balances/${editRowData.id}`">
                            @csrf
                            @method('PUT')
                            <button type="submit"
                                class="rounded-lg bg-green-600 px-5 py-2 text-sm font-semibold text-white hover:bg-green-700">

                                Simpan Koreksi

                            </button>
                        </form>
                    </div>
                </div>
            </div>
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
