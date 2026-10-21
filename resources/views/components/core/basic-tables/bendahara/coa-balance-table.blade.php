@props([
    'coaBalances' => collect(),
    'selectedSubPeriodName' => null,
])

<div x-data="{
    tableRowData: @js($coaBalances),
    showUrl: '{{ route('bendahara.coa-balances.show', ':id') }}',

    get totalOpening() {
        return this.tableRowData.reduce((sum, row) => sum + (parseFloat(row.opening_balance) || 0), 0);
    },

    get totalDebit() {
        return this.tableRowData.reduce((sum, row) => sum + (parseFloat(row.debit_total) || 0), 0);
    },

    get totalCredit() {
        return this.tableRowData.reduce((sum, row) => sum + (parseFloat(row.credit_total) || 0), 0);
    },

    get totalCurrent() {
        return this.tableRowData.reduce((sum, row) => sum + (parseFloat(row.current_balance) || 0), 0);
    },

    formatCurrency(amount) {
        if (amount === null || amount === undefined || amount === '') return '';
        const num = parseFloat(amount);
        if (num === 0) return '';
        return 'Rp' + new Intl.NumberFormat('id-ID', { minimumFractionDigits: 0 }).format(num);
    }
}">

    <!-- Judul Format Laporan Akuntansi -->
    <div class="mb-4 mt-4 text-center">
        <h2 class="text-base font-bold tracking-wider text-gray-800 uppercase dark:text-gray-100">
            MUTASI SALDO AKUN
        </h2>
        <p class="text-sm font-semibold tracking-wide text-gray-600 uppercase dark:text-gray-300">
            PER {{ $selectedSubPeriodName ?? 'SELURUH PERIODE' }}
        </p>
    </div>

    <div
        class="overflow-hidden border border-gray-200 bg-white shadow-sm dark:border-white/[0.05] dark:bg-white/[0.03] rounded-lg">
        <div class="max-w-full overflow-x-auto">
            <table class="w-full text-sm text-left border-collapse">
                <!-- Header Tabel Standar Akuntansi -->
                <thead
                    class="border-b border-t border-gray-300 bg-gray-100 text-gray-700 uppercase font-semibold text-xs dark:border-gray-700 dark:bg-gray-800 dark:text-gray-300">
                    <tr>
                        <th scope="col"
                            class="w-12 px-4 py-3 text-center border-r border-gray-200 dark:border-gray-700">No</th>
                        <th scope="col" class="px-6 py-3 border-r border-gray-200 dark:border-gray-700">Nama
                            Perkiraan</th>
                        <th scope="col"
                            class="w-28 px-4 py-3 text-center border-r border-gray-200 dark:border-gray-700">Ref</th>
                        <th scope="col"
                            class="w-40 px-6 py-3 text-right border-r border-gray-200 dark:border-gray-700">Saldo Awal
                        </th>
                        <th scope="col"
                            class="w-40 px-6 py-3 text-right border-r border-gray-200 dark:border-gray-700">Debit</th>
                        <th scope="col"
                            class="w-40 px-6 py-3 text-right border-r border-gray-200 dark:border-gray-700">Kredit</th>
                        <th scope="col"
                            class="w-44 px-6 py-3 text-right border-r border-gray-200 dark:border-gray-700">Sisa Saldo
                        </th>
                        <th scope="col" class="w-20 px-4 py-3 text-center">Aksi</th>
                    </tr>
                </thead>

                <!-- Body Tabel -->
                <tbody class="divide-y divide-gray-200 dark:divide-gray-800 font-mono text-xs sm:text-sm">
                    <template x-if="tableRowData.length > 0">
                        <template x-for="(row, index) in tableRowData" :key="row.chart_of_account_id">
                            <tr :class="index % 2 === 0 ? 'bg-white dark:bg-transparent' : 'bg-gray-50/50 dark:bg-white/[0.02]'"
                                class="transition hover:bg-gray-100/80 dark:hover:bg-white/[0.05]">

                                <!-- No -->
                                <td class="px-4 py-2.5 text-center text-gray-500 border-r border-gray-200 dark:border-gray-800 font-sans"
                                    x-text="index + 1"></td>

                                <!-- Nama Perkiraan -->
                                <td class="px-6 py-2.5 text-gray-800 dark:text-gray-200 border-r border-gray-200 dark:border-gray-800 font-sans font-medium"
                                    x-text="row.chart_of_account?.name ?? '-'"></td>

                                <!-- Ref / Kode COA -->
                                <td class="px-4 py-2.5 text-center text-gray-600 dark:text-gray-400 border-r border-gray-200 dark:border-gray-800"
                                    x-text="row.chart_of_account?.code ?? '-'"></td>

                                <!-- Saldo Awal -->
                                <td class="px-6 py-2.5 text-right font-medium text-gray-900 dark:text-gray-100 border-r border-gray-200 dark:border-gray-800"
                                    x-text="formatCurrency(row.opening_balance)"></td>

                                <!-- Debit -->
                                <td class="px-6 py-2.5 text-right font-medium text-emerald-600 dark:text-emerald-400 border-r border-gray-200 dark:border-gray-800"
                                    x-text="formatCurrency(row.debit_total)"></td>

                                <!-- Kredit -->
                                <td class="px-6 py-2.5 text-right font-medium text-rose-600 dark:text-rose-400 border-r border-gray-200 dark:border-gray-800"
                                    x-text="formatCurrency(row.credit_total)"></td>

                                <!-- Sisa Saldo -->
                                <td class="px-6 py-2.5 text-right font-semibold text-gray-900 dark:text-gray-100 border-r border-gray-200 dark:border-gray-800"
                                    x-text="formatCurrency(row.current_balance)"></td>

                                <!-- Action -->
                                <td class="px-4 py-2 text-center">
                                    <div class="flex items-center justify-center">
                                        <!-- Tombol Detail Aktif jika ada record CoaBalance -->
                                        <template x-if="row.id">
                                            <a :href="showUrl.replace(':id', row.id)"
                                                class="flex h-8 w-8 items-center justify-center rounded-md text-blue-600 hover:bg-blue-50 dark:text-blue-400 dark:hover:bg-blue-500/10 transition"
                                                title="Lihat Detail">
                                                <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                                </svg>
                                            </a>
                                        </template>

                                        <!-- Tombol Disabled jika belum ada data CoaBalance -->
                                        <template x-if="!row.id">
                                            <span
                                                class="flex h-8 w-8 items-center justify-center rounded-md text-gray-300 dark:text-gray-600 cursor-not-allowed"
                                                title="Belum ada transaksi / saldo pada sub periode ini">
                                                <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2"
                                                        d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                                </svg>
                                            </span>
                                        </template>
                                    </div>
                                </td>
                            </tr>
                        </template>
                    </template>

                    <!-- Empty State -->
                    <template x-if="tableRowData.length === 0">
                        <tr>
                            <td colspan="8" class="px-6 py-10 text-center font-sans">
                                <p class="text-sm font-medium text-gray-500 dark:text-gray-400">Tidak ada akun COA yang
                                    ditemukan.</p>
                            </td>
                        </tr>
                    </template>
                </tbody>

                <!-- Footer Total Laporan Akuntansi -->
                <tfoot
                    class="border-t-2 border-b-2 border-gray-400 bg-gray-100 font-mono text-xs sm:text-sm font-bold text-gray-900 dark:border-gray-600 dark:bg-gray-800 dark:text-white">
                    <tr>
                        <td colspan="3"
                            class="px-6 py-3 text-center uppercase tracking-wider border-r border-gray-300 dark:border-gray-700 font-sans">
                            TOTAL
                        </td>
                        <td class="px-6 py-3 text-right border-r border-gray-300 dark:border-gray-700"
                            x-text="formatCurrency(totalOpening)"></td>
                        <td class="px-6 py-3 text-right border-r border-gray-300 dark:border-gray-700"
                            x-text="formatCurrency(totalDebit)"></td>
                        <td class="px-6 py-3 text-right border-r border-gray-300 dark:border-gray-700"
                            x-text="formatCurrency(totalCredit)"></td>
                        <td class="px-6 py-3 text-right border-r border-gray-300 dark:border-gray-700"
                            x-text="formatCurrency(totalCurrent)"></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>
