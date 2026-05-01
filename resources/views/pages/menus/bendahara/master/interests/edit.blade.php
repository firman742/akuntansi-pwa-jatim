@extends('layouts.app')

@section('title', 'Master Data - Edit Bunga')

@section('content')
    <x-common.page-breadcrumb pageTitle="Edit Bunga" />

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

    <x-common.component-card title="Edit Bunga">
        <form method="POST" action="{{ route('bendahara.master.interests.update', $interest->id) }}">
            @csrf
            @method('PUT')

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

                {{-- ================= INFORMASI DASAR ================= --}}
                <div class="col-span-1 md:col-span-2">
                    <p class="text-sm font-semibold text-gray-700">
                        1. Informasi Bunga
                    </p>
                </div>

                {{-- Nama --}}
                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Nama Bunga
                    </label>

                    <input type="text" name="name" value="{{ old('name', $interest->name) }}"
                        placeholder="Contoh: Bunga Pinjaman 10%"
                        class="h-11 w-full rounded-lg border px-4 text-sm
                        @error('name') border-error-300 @else border-gray-300 @enderror" />

                    @error('name')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- Type --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Tipe Bunga
                    </label>

                    <select name="type" id="interestType"
                        class="h-11 w-full rounded-lg border px-4 text-sm
                        @error('type') border-error-300 @else border-gray-300 @enderror">
                        <option value="">-- Pilih Tipe Bunga --</option>

                        <option value="PERCENTAGE" @selected(old('type', $interest->type) == 'PERCENTAGE')>
                            Persentase (%)
                        </option>

                        <option value="FIXED" @selected(old('type', $interest->type) == 'FIXED')>
                            Nominal Tetap
                        </option>
                    </select>

                    <p class="mt-1 text-xs text-gray-500">
                        Pilih tipe bunga untuk menentukan metode perhitungan
                    </p>

                    @error('type')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- Rate --}}
                <div id="rateWrapper" style="display: none;">
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Nilai Bunga (%)
                    </label>

                    <input type="number" step="1" min="0" name="rate"
                        value="{{ old('rate', $interest->rate) }}" placeholder="Contoh: 10"
                        class="h-11 w-full rounded-lg border px-4 text-sm
                        @error('rate') border-error-300 @else border-gray-300 @enderror" />

                    <p class="mt-1 text-xs text-gray-500">
                        Isi jika bunga menggunakan sistem persentase
                    </p>

                    @error('rate')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- ================= KONFIGURASI AKUN ================= --}}
                <div class="col-span-1 md:col-span-2 mt-4">
                    <p class="text-sm font-semibold text-gray-700">
                        2. Konfigurasi Akun (COA)
                    </p>
                </div>

                {{-- Account Interest --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Akun Pendapatan Bunga
                    </label>

                    <select name="account_interest_id"
                        class="h-11 w-full rounded-lg border px-4 text-sm
                        @error('account_interest_id') border-error-300 @else border-gray-300 @enderror">
                        <option value="">-- Pilih Akun Pendapatan --</option>

                        @foreach ($revenueCoas as $coa)
                            <option value="{{ $coa->id }}" @selected(old('account_interest_id', $interest->account_interest_id) == $coa->id)>
                                {{ $coa->code }} — {{ $coa->name }}
                            </option>
                        @endforeach
                    </select>

                    <p class="mt-1 text-xs text-gray-500">
                        Digunakan untuk mencatat pendapatan bunga
                    </p>

                    @error('account_interest_id')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- Account Expense --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Akun Beban Bunga
                    </label>

                    <select name="account_expense_id"
                        class="h-11 w-full rounded-lg border px-4 text-sm
                        @error('account_expense_id') border-error-300 @else border-gray-300 @enderror">
                        <option value="">-- Pilih Akun Beban --</option>

                        @foreach ($expenseCoas as $coa)
                            <option value="{{ $coa->id }}" @selected(old('account_expense_id', $interest->account_expense_id) == $coa->id)>
                                {{ $coa->code }} — {{ $coa->name }}
                            </option>
                        @endforeach
                    </select>

                    <p class="mt-1 text-xs text-gray-500">
                        Digunakan untuk mencatat beban bunga
                    </p>

                    @error('account_expense_id')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

            </div>

            {{-- ACTION --}}
            <div class="mt-8 flex justify-end gap-3">
                <a href="{{ route('bendahara.master.interests.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Simpan Perubahan
                </x-ui.button>
            </div>

        </form>
    </x-common.component-card>

    <script>
        const interestTypeSelect = document.getElementById('interestType');
        const rateWrapper = document.getElementById('rateWrapper');

        function toggleRateField() {
            if (interestTypeSelect.value === 'PERCENTAGE') {
                rateWrapper.style.display = 'block';
            } else {
                rateWrapper.style.display = 'none';
            }
        }

        interestTypeSelect.addEventListener('change', toggleRateField);
        document.addEventListener('DOMContentLoaded', toggleRateField);
    </script>
@endsection
