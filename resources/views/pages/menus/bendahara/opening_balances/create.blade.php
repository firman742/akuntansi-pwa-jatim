@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Saldo Awal" />

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


    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    <x-common.component-card title="Tambah Saldo Awal">
        <form method="POST" action="{{ route('bendahara.opening-balances.store') }}">
            @csrf

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                {{-- PERIODE --}}
                <div class="col-span-1">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Periode
                    </label>

                    <select name="period_id"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300
                               focus:ring-brand-500/10 h-11 w-full rounded-lg border
                               @error('period_id') border-error-300
                               @else border-gray-300 @enderror
                               bg-transparent px-4 py-2.5 text-sm
                               dark:border-gray-700 dark:text-white/90"
                        required>
                        <option value="">-- Pilih Periode --</option>
                        @foreach ($periods as $period)
                            <option value="{{ $period->id }}" {{ old('period_id') == $period->id ? 'selected' : '' }}>
                                {{ $period->name }}
                            </option>
                        @endforeach
                    </select>

                    @error('period_id')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- COA --}}
                <div class="col-span-1">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Akun (COA)
                    </label>

                    <select name="chart_of_account_id"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300
                               focus:ring-brand-500/10 h-11 w-full rounded-lg border
                               @error('chart_of_account_id') border-error-300
                               @else border-gray-300 @enderror
                               bg-transparent px-4 py-2.5 text-sm
                               dark:border-gray-700 dark:text-white/90"
                        required>
                        <option value="">-- Pilih Akun --</option>
                        @foreach ($coaLists as $coa)
                            <option value="{{ $coa->id }}"
                                {{ old('chart_of_account_id') == $coa->id ? 'selected' : '' }}>
                                {{ $coa->code }} — {{ $coa->name }}
                            </option>
                        @endforeach
                    </select>

                    @error('chart_of_account_id')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- TIPE SALDO --}}
                <div class="col-span-1">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Tipe Saldo
                    </label>

                    <select name="balance_type"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300
                               focus:ring-brand-500/10 h-11 w-full rounded-lg border
                               @error('balance_type') border-error-300
                               @else border-gray-300 @enderror
                               bg-transparent px-4 py-2.5 text-sm
                               dark:border-gray-700 dark:text-white/90"
                        required>
                        <option value="">-- Pilih Tipe --</option>
                        <option value="DEBIT" {{ old('balance_type') == 'DEBIT' ? 'selected' : '' }}>
                            Debit
                        </option>
                        <option value="CREDIT" {{ old('balance_type') == 'CREDIT' ? 'selected' : '' }}>
                            Kredit
                        </option>
                    </select>

                    @error('balance_type')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- NOMINAL --}}
                <div class="col-span-1">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Nominal
                    </label>

                    <input type="text" id="amount_display"
                        value="{{ old('amount') ? 'Rp ' . number_format(old('amount'), 0, ',', '.') : '' }}"
                        placeholder="Masukkan nominal"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300
                        focus:ring-brand-500/10 h-11 w-full rounded-lg border
                        @error('amount') border-error-300
                        @else border-gray-300 @enderror
                        bg-transparent px-4 py-2.5 text-sm
                        dark:border-gray-700 dark:text-white/90" />

                    <input type="hidden" name="amount" id="amount">

                    @error('amount')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

            </div>

            {{-- ACTION --}}
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
