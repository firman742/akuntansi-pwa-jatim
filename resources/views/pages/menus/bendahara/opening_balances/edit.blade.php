@extends('layouts.app')

@section('title', 'Edit Saldo Awal')

@section('content')

    <x-common.page-breadcrumb pageTitle="Edit Saldo Awal" pageDescription="Koreksi nominal saldo awal" pageIcon="money"
        parentTitle="Kelola Saldo Awal" :parentRoute="route('bendahara.opening-balances.index')" currentTitle="Edit Data" />

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

    <x-common.component-card title="Informasi Saldo Awal" desc="Data referensi yang tidak dapat diubah">

        <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
            <x-form.input label="Kode Akun" :value="$openingBalance->chartOfAccount->code" readonly /> 
                
            <x-form.input label="Nama Akun" :value="$openingBalance->chartOfAccount->name" readonly /> 
                
            <x-form.input label="Periode" :value="$openingBalance->period->name" readonly /> 
            
            <x-form.input label="Sub Periode" :value="$openingBalance->subPeriod->name" readonly />

            <x-form.input label="Tipe Saldo" :value="$openingBalance->balance_type" readonly />

        </div>

    </x-common.component-card>

    <div class="mt-6">

        <x-common.component-card title="Koreksi Saldo Awal" desc="Hanya nominal saldo yang dapat diubah">

            <form method="POST" action="{{ route('bendahara.opening-balances.update', $openingBalance->id) }}">

                @csrf
                @method('PUT')

                <div class="grid grid-cols-1 gap-6 md:grid-cols-3">

                    <div>
                        <x-form.input id="old_amount" label="Saldo Saat Ini" :value="number_format($openingBalance->amount, 0, ',', '.')" readonly />
                    </div>

                    <div>

                        <x-form.input id="amount_display" label="Saldo Baru" value="{{ old('additional_amount') }}"/>
                    
                        <input
                            type="hidden"
                            id="additional_amount"
                            name="additional_amount"
                            value="{{ old('additional_amount') }}"
                        >
                    </div>

                    <div class="rounded-xl border border-blue-200 bg-blue-50 p-4">

                        <div class="text-xs font-semibold uppercase text-blue-700">
                            Preview
                        </div>

                        <div id="preview" class="mt-2 text-2xl font-bold text-blue-800">

                            Rp {{ number_format($openingBalance->amount, 0, ',', '.') }}

                        </div>

                    </div>

                </div>

                <div class="mt-8 flex justify-end gap-3 border-t pt-6">

                    <a href="{{ route('bendahara.opening-balances.index') }}">
                        <x-ui.button variant="outline">
                            Kembali
                        </x-ui.button>
                    </a>

                    <x-ui.button type="submit" variant="primary">

                        Simpan Perubahan

                    </x-ui.button>

                </div>

            </form>

        </x-common.component-card>

    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
    
            const oldAmount = document.getElementById('old_amount');
            const displayInput = document.getElementById('amount_display');
            const hiddenInput = document.getElementById('additional_amount');
            const preview = document.getElementById('preview');
    
            function cleanNumber(value) {
                return value.replace(/\D/g, '');
            }
    
            function formatRupiah(value) {
                let nominal = new Intl.NumberFormat('id-ID').format(value || 0);
                return 'Rp ' + nominal;
            }

            oldAmount.addEventListener('input', function () {
                const numericValue = cleanNumber(this.value);
                this.value = formatRupiah(numericValue);
            });

            oldAmount.dispatchEvent(new Event('input'));
    
            displayInput.addEventListener('input', function () {
    
                const numericValue = cleanNumber(this.value);
    
                hiddenInput.value = numericValue;
    
                this.value = formatRupiah(numericValue);
    
                preview.innerText = formatRupiah(numericValue);
            });
    
            displayInput.dispatchEvent(new Event('input'));
        });
    </script>

@endsection
