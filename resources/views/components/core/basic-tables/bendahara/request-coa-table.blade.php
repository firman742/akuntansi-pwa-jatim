@props([
    'requests' => collect(),
])

<div x-data="{
    tableRowData: @js($requests),
    itemsPerPage: 10,
    currentPage: 1,
    showUrl: '{{ route('bendahara.master.requests.coas.show', ':id') }}',

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

    formatCurrency(amount) {
        return new Intl.NumberFormat('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0
        }).format(amount);
    },

    statusBadge(status) {
        return {
            pending: 'bg-yellow-50 text-yellow-700 border border-yellow-500 dark:bg-yellow-500/15 dark:text-yellow-400 dark:border-yellow-500',
            approved: 'bg-green-50 text-green-700 border border-green-500 dark:bg-green-500/15 dark:text-green-400 dark:border-green-500',
            rejected: 'bg-red-50 text-red-700 border border-red-500 dark:bg-red-500/15 dark:text-red-400 dark:border-red-500',
        } [status] ?? 'bg-gray-50 text-gray-700 border border-gray-500 dark:bg-gray-500/15 dark:text-gray-400 dark:border-gray-500';
    },

    normalBalanceBadge(balance) {
        return balance === 'DEBIT' ?
            'bg-blue-50 text-blue-700 border border-blue-500 dark:bg-blue-500/15 dark:text-blue-400 dark:border-blue-500' :
            'bg-green-50 text-green-700 border border-green-500 dark:bg-green-500/15 dark:text-green-400 dark:border-green-500';
    },

    formatDate(date) {
        if (!date) return '-';

        const d = new Date(date);

        return d.toLocaleDateString('id-ID', {
            day: '2-digit',
            month: 'long',
            year: 'numeric',
        });
    },

    deleteRow(id) {
        if (confirm('Are you sure you want to delete this order?')) {
            this.tableRowData = this.tableRowData.filter(row => row.id !== id);
            this.selectedRows = this.selectedRows.filter(rowId => rowId !== id);

            if (this.currentPage > this.totalPages) {
                this.currentPage = this.totalPages || 1;
            }
        }
    }
}">
    {{-- TABLE CONTAINER --}}
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
                            Kode COA
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Nama COA
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Nama Pengaju
                        </th>


                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Tipe Akun
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Parent COA
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Saldo Normal
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Status
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Nama Approver
                        </th>

                        <th
                            scope="col"
                            class="px-6 py-4 text-[11px] font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Tanggal Pengajuan
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

                                {{-- Kode COA --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="font-medium text-gray-700 dark:text-gray-400" x-text="row.proposed_code ?? 'kosong'"></span>
                                </td>

                                {{-- Nama COA --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="font-light text-gray-700 dark:text-gray-400" x-text="row.proposed_name"></span>
                                </td>

                                {{-- Nama Pengaju --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="font-light text-gray-700 dark:text-gray-400" x-text="row.requester.name"></span>
                                </td>

                                {{-- Account Type --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="font-light text-gray-700 dark:text-gray-400" x-text="row.account_type?.name ?? '-'"></span>
                                </td>

                                {{-- Parent COA --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="font-light text-gray-700 dark:text-gray-400" x-text="row.parent_coa?.name ?? '-'"></span>
                                </td>

                                {{-- Normal Balance --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="inline-flex w-[120px] justify-center rounded-full px-2 py-0.5 text-theme-xs font-medium" 
                                        :class="normalBalanceBadge(row.normal_balance)" x-text="row.normal_balance">
                                    </span>
                                </td>

                                {{-- Status --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="inline-flex w-[120px] justify-center rounded-full px-2 py-0.5 text-theme-xs font-medium" 
                                        :class="statusBadge(row.status)" x-text="row.status_label">
                                    </span>
                                </td>

                                {{-- Nama Approver --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="font-light text-gray-700 dark:text-gray-400" x-text="row.approver?.name ?? '-'"></span>
                                </td>

                                {{-- Created At --}}
                                <td class="px-4 sm:px-6 py-3.5">
                                    <span class="font-light text-gray-700 dark:text-gray-400" x-text="formatDate(row.created_at)"></span>
                                </td>

                                <!-- Action -->
                                <td class="px-6 py-4 text-center whitespace-nowrap">
                                    <x-common.table-actions
                                        :detailUrl="'showUrl.replace(\':id\', row.id)'"
                                        canDetail="true"
                                    />
                                </td>
                            </tr>
                        </template>
                    </template>
                    {{-- DATA KOSONG --}}
                    <template x-if="paginatedData.length === 0">
                        <x-common.empty-table-state 
                            title="Tidak ada data pengajuan coa ditemukan"
                            description="Coba sesuaikan kata kunci pencarian atau rentang tanggal filter Anda."
                        />
                    </template>
                </tbody>

            </table>
        </div>
    </div>

    <!-- Pagination -->
    <x-common.pagination itemLabel="pengajuan" />
</div>
</div>

<script>
    const periodFilter = document.getElementById('filter_period');
    const subPeriodFilter = document.getElementById('filter_sub_period');

    periodFilter.addEventListener('change', async function() {

        let periodId = this.value;

        subPeriodFilter.innerHTML = '<option>Loading...</option>';

        if (!periodId) {
            subPeriodFilter.innerHTML = '<option value="">Semua</option>';
            return;
        }

        const res = await fetch(`/user/periode/${periodId}/sub-periods`);
        const data = await res.json();

        subPeriodFilter.innerHTML = '<option value="">Semua</option>';

        data.forEach(sub => {
            subPeriodFilter.innerHTML += `
                <option value="${sub.id}">${sub.name}</option>
            `;
        });
    });
</script>
