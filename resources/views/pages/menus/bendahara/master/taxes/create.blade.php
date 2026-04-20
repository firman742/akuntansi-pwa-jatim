@extends('layouts.app')

@section('title', 'Master Data - Tambah Pajak')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Pajak" />

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

    <x-common.component-card title="Tambah Pajak">
        <form method="POST" action="{{ route('bendahara.master.taxes.store') }}">
            @csrf

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

                {{-- ================= INFORMASI DASAR ================= --}}
                <div class="col-span-1 md:col-span-2">
                    <p class="text-sm font-semibold text-gray-700">1. Informasi Pajak</p>
                </div>

                {{-- Nama --}}
                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Nama Pajak
                    </label>
                    <input type="text" name="name" value="{{ old('name') }}" placeholder="Contoh: PPN 11%"
                        class="h-11 w-full rounded-lg border px-4 text-sm
                        @error('name') border-error-300 @else border-gray-300 @enderror" />

                    @error('name')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- Type --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Tipe Pajak
                    </label>
                    <select name="type" id="taxType"
                        class="h-11 w-full rounded-lg border px-4 text-sm
                        @error('type') border-error-300 @else border-gray-300 @enderror">
                        <option value="">-- Pilih Tipe Pajak --</option>
                        <option value="PERCENTAGE" @selected(old('type') == 'PERCENTAGE')>
                            Persentase (%)
                        </option>
                        <option value="FIXED" @selected(old('type') == 'FIXED')>
                            Nominal Tetap
                        </option>
                    </select>

                    <p class="mt-1 text-xs text-gray-500">
                        Pilih tipe pajak terlebih dahulu untuk menentukan cara perhitungan
                    </p>

                    @error('type')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- Rate --}}
                <div id="rateWrapper" style="display: none;">
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Persentase Pajak (%)
                    </label>
                    <input type="number" step="0.01" name="rate" value="{{ old('rate') }}" placeholder="Contoh: 11"
                        class="h-11 w-full rounded-lg border px-4 text-sm
                        @error('rate') border-error-300 @else border-gray-300 @enderror" />

                    <p class="mt-1 text-xs text-gray-500">
                        Hanya diisi jika tipe pajak adalah Persentase
                    </p>

                    @error('rate')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>


                {{-- ================= KONFIGURASI AKUN ================= --}}
                <div class="col-span-1 md:col-span-2 mt-4">
                    <p class="text-sm font-semibold text-gray-700">2. Konfigurasi Akun (COA)</p>
                </div>

                {{-- COA PREPAID --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Pajak Dibayar Dimuka (Aset)
                    </label>
                    <select name="account_prepaid_id"
                        class="h-11 w-full rounded-lg border px-4 text-sm
                        @error('account_prepaid_id') border-error-300 @else border-gray-300 @enderror">
                        <option value="">-- Pilih Akun Aset --</option>
                        @foreach ($assetCoas as $coa)
                            <option value="{{ $coa->id }}" @selected(old('account_prepaid_id') == $coa->id)>
                                {{ $coa->code }} — {{ $coa->name }}
                            </option>
                        @endforeach
                    </select>

                    <p class="mt-1 text-xs text-gray-500">
                        Digunakan saat pajak dibayar di awal (prepaid tax)
                    </p>

                    @error('account_prepaid_id')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- COA PAYABLE --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Hutang Pajak (Liabilitas)
                    </label>
                    <select name="account_payable_id"
                        class="h-11 w-full rounded-lg border px-4 text-sm
                        @error('account_payable_id') border-error-300 @else border-gray-300 @enderror">
                        <option value="">-- Pilih Akun Liabilitas --</option>
                        @foreach ($liabilityCoas as $coa)
                            <option value="{{ $coa->id }}" @selected(old('account_payable_id') == $coa->id)>
                                {{ $coa->code }} — {{ $coa->name }}
                            </option>
                        @endforeach
                    </select>

                    <p class="mt-1 text-xs text-gray-500">
                        Digunakan saat pajak masih harus dibayar
                    </p>

                    @error('account_payable_id')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- COA EXPENSE --}}
                <div class="md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Beban Pajak (Opsional)
                    </label>
                    <select name="account_expense_id"
                        class="h-11 w-full rounded-lg border px-4 text-sm
                        @error('account_expense_id') border-error-300 @else border-gray-300 @enderror">
                        <option value="">-- Pilih Akun Beban --</option>
                        @foreach ($expenseCoas as $coa)
                            <option value="{{ $coa->id }}" @selected(old('account_expense_id') == $coa->id)>
                                {{ $coa->code }} — {{ $coa->name }}
                            </option>
                        @endforeach
                    </select>

                    <p class="mt-1 text-xs text-gray-500">
                        Digunakan jika pajak dicatat sebagai beban
                    </p>

                    @error('account_expense_id')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

            </div>

            {{-- ACTION --}}
            <div class="mt-8 flex justify-end gap-3">
                <a href="{{ route('bendahara.master.taxes.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Simpan
                </x-ui.button>
            </div>

        </form>
    </x-common.component-card>

    <script>
        const taxTypeSelect = document.getElementById('taxType');
        const rateWrapper = document.getElementById('rateWrapper');

        function toggleRateField() {
            if (taxTypeSelect.value === 'PERCENTAGE') {
                rateWrapper.style.display = 'block';
            } else {
                rateWrapper.style.display = 'none';
            }
        }

        taxTypeSelect.addEventListener('change', toggleRateField);

        // Handle old value saat validation error
        document.addEventListener('DOMContentLoaded', toggleRateField);
    </script>
@endsection
