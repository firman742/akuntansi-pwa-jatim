@extends('layouts.app')

@section('title', 'Neraca Saldo Awal - Buat Multi Periode')

@section('content')
    <x-common.page-breadcrumb pageTitle="Neraca Saldo Awal - Buat Multi Periode" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan" :dismissible="false">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    <x-common.component-card title="Buat Saldo Awal Multi Periode ">
        {{-- ============================= --}}
        {{-- DESKRIPSI --}}
        {{-- ============================= --}}
        <div class="mb-6 rounded-lg border border-gray-200 bg-gray-50 p-4 text-sm text-gray-600 dark:border-gray-700 dark:bg-white/5 dark:text-gray-300">

            <p class="font-medium mb-1">
                Informasi
            </p>

            <p>
                Fitur ini digunakan untuk membuat saldo awal yang sama pada beberapa fiscal year / Periode sekaligus.
                Sistem akan secara otomatis menyimpan saldo awal pada sub periode pertama dari setiap fiscal year yang dipilih.
            </p>

            <p class="mt-2 text-xs text-gray-500">
                Contoh: Jika dipilih tahun 2024, 2025, dan 2026 maka saldo awal akan dibuat pada bulan pertama masing-masing tahun tersebut.
            </p>

        </div>

        <form method="POST" action="{{ route('bendahara.opening-balances.store-bulk') }}">
            @csrf



            {{-- ============================= --}}
            {{-- PILIH PERIOD --}}
            {{-- ============================= --}}

            <div class="mb-8">

                <label class="block text-sm font-medium mb-3">
                    Pilih Fiscal Year / Periode
                </label>

                <div class="grid grid-cols-2 md:grid-cols-4 gap-3">

                    @foreach ($periods as $period)
                        <label
                            class="flex items-center gap-3 border rounded-lg p-3 cursor-pointer hover:bg-gray-50 dark:hover:bg-white/5">

                            <input type="checkbox" name="period_ids[]" value="{{ $period->id }}" class="period-checkbox">

                            <span class="text-sm font-medium">
                                {{ $period->name }}
                            </span>

                        </label>
                    @endforeach

                </div>

                <p class="text-xs text-gray-500 mt-2">
                    Saldo awal yang sama akan dibuat untuk semua fiscal year / Periode yang dipilih.
                </p>

            </div>



            {{-- ============================= --}}
            {{-- CORE INPUT --}}
            {{-- ============================= --}}

            <div class="border-t pt-6">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">


                    <div>

                        <label class="block text-sm font-medium mb-2">
                            Akun (COA)
                        </label>

                        <select name="chart_of_account_id"
                            class="h-11 w-full rounded-lg border border-gray-300 px-4 text-sm dark:border-gray-700 dark:bg-dark-900 dark:text-white">

                            <option value="">-- Pilih Akun --</option>

                            @foreach ($coaLists as $coa)
                                <option value="{{ $coa->id }}">
                                    {{ $coa->code }} — {{ $coa->name }}
                                </option>
                            @endforeach

                        </select>

                    </div>



                    <div>

                        <label class="block text-sm font-medium mb-2">
                            Tipe Saldo
                        </label>

                        <select name="balance_type"
                            class="h-11 w-full rounded-lg border border-gray-300 px-4 text-sm dark:border-gray-700 dark:bg-dark-900 dark:text-white">

                            <option value="">-- Pilih Tipe --</option>

                            <option value="DEBIT">Debit</option>
                            <option value="CREDIT">Kredit</option>

                        </select>

                    </div>

                </div>



                <div class="mt-6">

                    <label class="block text-sm font-medium mb-2">
                        Nominal Saldo Awal
                    </label>

                    <input type="text" id="amount_display"
                        class="h-11 w-full rounded-lg border border-gray-300 px-4 text-sm dark:border-gray-700 dark:bg-dark-900 dark:text-white"
                        placeholder="Masukkan nominal saldo awal">

                    <input type="hidden" name="amount" id="amount">

                </div>

            </div>



            <div class="mt-8 flex justify-end gap-3">

                <a href="{{ route('bendahara.opening-balances.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Simpan Saldo Awal
                </x-ui.button>

            </div>

        </form>

    </x-common.component-card>



    <script>
        const inputDisplay = document.getElementById('amount_display');
        const inputHidden = document.getElementById('amount');

        function formatRupiah(value) {

            let numberString = value.replace(/[^,\d]/g, '').toString();
            let split = numberString.split(',');
            let sisa = split[0].length % 3;
            let rupiah = split[0].substr(0, sisa);
            let ribuan = split[0].substr(sisa).match(/\d{3}/gi);

            if (ribuan) {

                let separator = sisa ? '.' : '';
                rupiah += separator + ribuan.join('.');

            }

            return 'Rp ' + rupiah;

        }

        inputDisplay.addEventListener('input', function(e) {

            let rawValue = e.target.value.replace(/[^0-9]/g, '');

            inputHidden.value = rawValue;

            if (rawValue) {
                e.target.value = formatRupiah(rawValue);
            } else {
                e.target.value = '';
            }

        });
    </script>
@endsection
