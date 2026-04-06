@extends('layouts.app')

@section('title', 'Neraca Saldo Awal - Buat Multi Periode')

@section('content')
    <x-common.page-breadcrumb pageTitle="Neraca Saldo Awal - Buat Multi Periode" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    <x-common.component-card title="Buat Saldo Awal Multi Periode">
        {{-- INFORMASI MEKANISME BULK --}}
        <div class="mb-6 rounded-lg border border-blue-200 bg-blue-50 p-4 dark:border-blue-900/30 dark:bg-blue-900/10">
            <h4 class="text-sm font-bold text-blue-900 dark:text-blue-300 mb-2 flex items-center gap-2">
                <i class="fas fa-info-circle"></i> Mekanisme Bulk Input
            </h4>
            <p class="text-sm text-blue-800 dark:text-blue-400">
                Sistem akan membuat saldo awal pada <strong>Sub Periode Pertama</strong> di setiap Fiscal Year yang dipilih.
                Nominal yang Anda masukkan di bawah akan <strong>dijumlahkan secara otomatis</strong> dengan saldo sisa
                (Closing Balance) dari periode sebelumnya pada masing-masing tahun tersebut.
            </p>
        </div>

        <form method="POST" action="{{ route('bendahara.opening-balances.store-bulk') }}">
            @csrf

            {{-- PILIH PERIOD --}}
            <div class="mb-8">
                <label class="block text-sm font-medium mb-3 text-gray-700 dark:text-gray-300">
                    Pilih Fiscal Year / Periode Tujuan
                </label>
                <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
                    @foreach ($periods as $period)
                        <label
                            class="group relative flex items-center gap-3 border rounded-lg p-3 cursor-pointer hover:bg-blue-50 dark:hover:bg-white/5 transition-colors">
                            <input type="checkbox" name="period_ids[]" value="{{ $period->id }}"
                                class="w-4 h-4 text-blue-600 rounded">
                            <span class="text-sm font-medium">{{ $period->name }}</span>
                        </label>
                    @endforeach
                </div>
            </div>

            {{-- CORE INPUT --}}
            <div class="border-t pt-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    {{-- COA --}}
                    <div>
                        <label class="block text-sm font-medium mb-2">Akun (COA)</label>
                        <select name="chart_of_account_id" required
                            class="h-11 w-full rounded-lg border border-gray-300 px-4 text-sm dark:bg-dark-900">
                            <option value="">-- Pilih Akun --</option>
                            @foreach ($coaLists as $coa)
                                <option value="{{ $coa->id }}">{{ $coa->code }} — {{ $coa->name }}</option>
                            @endforeach
                        </select>
                    </div>

                    {{-- TIPE SALDO --}}
                    <div>
                        <label class="block text-sm font-medium mb-2">Tipe Saldo</label>
                        <select name="balance_type" required
                            class="h-11 w-full rounded-lg border border-gray-300 px-4 text-sm dark:bg-dark-900">
                            <option value="DEBIT">DEBIT</option>
                            <option value="CREDIT">KREDIT</option>
                        </select>
                    </div>
                </div>

                {{-- NOMINAL TAMBAHAN --}}
                <div class="mt-6">
                    <label class="block text-sm font-medium mb-2 text-green-600 dark:text-green-400">
                        Nominal Saldo Tambahan (Manual)
                    </label>
                    <div class="relative">
                        <input type="text" id="amount_display"
                            class="h-11 w-full rounded-lg border border-green-300 px-4 text-sm focus:ring-2 focus:ring-green-500 dark:bg-dark-900"
                            placeholder="Isi 0 jika hanya ingin menarik saldo sisa tahun lalu">
                        <p class="mt-2 text-xs text-gray-500 italic">
                            * Nominal ini akan ditambahkan ke saldo sisa penutupan masing-masing tahun yang dipilih.
                        </p>
                    </div>
                    <input type="hidden" name="amount" id="amount" value="0">
                </div>
            </div>

            <div class="mt-8 flex justify-end gap-3 border-t pt-6">
                <a href="{{ route('bendahara.opening-balances.index') }}">
                    <x-ui.button type="button" variant="outline" size="sm">Kembali</x-ui.button>
                </a>
                <x-ui.button type="submit" variant="primary" size="sm">
                    Proses Bulk Saldo Awal
                </x-ui.button>
            </div>
        </form>
    </x-common.component-card>

    <script>
        const inputDisplay = document.getElementById('amount_display');
        const inputHidden = document.getElementById('amount');

        function formatRupiah(value) {
            let numberString = value.replace(/[^0-9]/g, '');
            if (!numberString) return '';
            let sisa = numberString.length % 3;
            let rupiah = numberString.substr(0, sisa);
            let ribuan = numberString.substr(sisa).match(/\d{3}/gi);
            if (ribuan) {
                let separator = sisa ? '.' : '';
                rupiah += separator + ribuan.join('.');
            }
            return 'Rp ' + rupiah;
        }

        inputDisplay.addEventListener('input', function(e) {
            let rawValue = e.target.value.replace(/[^0-9]/g, '');
            inputHidden.value = rawValue || 0;
            e.target.value = formatRupiah(rawValue);
        });
    </script>
@endsection
