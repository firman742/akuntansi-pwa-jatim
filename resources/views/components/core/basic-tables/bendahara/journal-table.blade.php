@props(['journals', 'periods', 'periodId'])

<div x-data="{
    rows: @js($journals),
    itemsPerPage: 10,
    currentPage: 1,

    get paginated() {
        const start = (this.currentPage - 1) * this.itemsPerPage;
        return this.rows.slice(start, start + this.itemsPerPage);
    },

    formatDate(date) {
        return new Date(date).toLocaleDateString('id-ID', {
            day: '2-digit',
            month: 'long',
            year: 'numeric'
        });
    },

    formatCurrency(amount) {
        return new Intl.NumberFormat('id-ID', {
            style: 'currency',
            currency: 'IDR',
            minimumFractionDigits: 0
        }).format(amount);
    }
}"
    class="overflow-hidden rounded-2xl border border-gray-200 bg-white pt-4 dark:border-white/[0.05] dark:bg-white/[0.03]">

    {{-- Filter Periode --}}
    <form method="GET" class="px-6 mb-4">
        <div class="flex items-center gap-3">
            <select name="period_id"
                class="h-10 rounded-lg border border-gray-300 bg-white px-3 text-sm
            dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400"
                onchange="this.form.submit()">
                @foreach ($periods as $period)
                    <option value="{{ $period->id }}" {{ $periodId == $period->id ? 'selected' : '' }}>
                        {{ $period->name }}
                    </option>
                @endforeach
            </select>
        </div>
    </form>

    <!-- Header -->
    <div class="flex flex-col gap-4 px-6 mb-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
            <h3 class="text-lg font-semibold text-gray-800 dark:text-white/90">
                Daftar Jurnal Umum
            </h3>
        </div>
        <div class="flex items-center gap-3">
            

            {{-- Export --}}
            <a href="">
                <x-ui.button variant="outline" size="sm">
                    <x-slot:startIcon>
                        <svg class="h-4 w-4 stroke-current fill-white dark:fill-gray-800" viewBox="0 0 20 20"
                            fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m6.75 12-3-3m0 0-3 3m3-3v6m-1.5-15H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z" />
                        </svg>
                    </x-slot:startIcon>


                    Export
                </x-ui.button>
            </a>

            {{-- tambah --}}
            <a href="{{ route('bendahara.opening-balances.create') }}">
                <x-ui.button variant="outline" size="sm">
                    <x-slot:startIcon>
                        <svg class="h-4 w-4 stroke-current fill-white dark:fill-gray-800" viewBox="0 0 24 24"
                            fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M1.5 12C1.5 12 5.5 4.5 12 4.5C18.5 4.5 22.5 12 22.5 12C22.5 12 18.5 19.5 12 19.5C5.5 19.5 1.5 12 1.5 12Z" 
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M12 15.75C13.6569 15.75 15 14.4069 15 12.75C15 11.0931 13.6569 9.75 12 9.75C10.3431 9.75 9 11.0931 9 12.75C9 14.4069 10.3431 15.75 12 15.75Z" 
                                stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </x-slot:startIcon>
                    Lihat Seluruhnya
                </x-ui.button>
            </a>
        </div>
    </div>


    {{-- Table --}}
    <div class="max-w-full overflow-x-auto">
        <table class="w-full">
            <thead
                class="px-6 py-3.5 border-t border-gray-100 border-y bg-gray-50 dark:border-white/[0.05] dark:bg-gray-900">
                <tr>
                    <th class="px-6 py-3 text-left text-xs">Tanggal</th>
                    <th class="px-6 py-3 text-left text-xs">No Jurnal</th>
                    <th class="px-6 py-3 text-left text-xs">Deskripsi</th>
                    <th class="px-6 py-3 text-right text-xs">Debit</th>
                    <th class="px-6 py-3 text-right text-xs">Kredit</th>
                    <th class="px-6 py-3 text-left text-xs">Aksi</th>
                </tr>
            </thead>

            <tbody>
                <template x-for="row in paginated" :key="row.id">
                    <tr class="border-t">
                        <td class="px-6 py-3" x-text="formatDate(row.journal_date)"></td>
                        <td class="px-6 py-3 font-medium" x-text="row.journal_number"></td>
                        <td class="px-6 py-3" x-text="row.description ?? '-'"></td>
                        <td class="px-6 py-3 text-right" x-text="formatCurrency(row.total_debit)"></td>
                        <td class="px-6 py-3 text-right" x-text="formatCurrency(row.total_credit)"></td>
                        <td class="px-6 py-3">
                            <a :href="row.detail_url" class="text-primary-600 hover:underline text-sm font-bold underline">
                                Detail
                            </a>
                        </td>
                    </tr>
                </template>
            </tbody>
        </table>
    </div>

    
</div>
</div>
