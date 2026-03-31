@extends('layouts.app')

@section('title', 'Neraca Saldo Awal - Buat Manual')

@section('content')
    <x-common.page-breadcrumb pageTitle="Neraca Saldo Awal - Buat Manual" />

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

    <x-common.component-card title="Buat Manual Saldo Awal">
        {{-- DESKRIPSI --}}
        {{-- ============================= --}}
        <div
            class="mb-6 rounded-lg border border-gray-200 bg-gray-50 p-4 text-sm text-gray-600 dark:border-gray-700 dark:bg-white/5 dark:text-gray-300">
            <p class="font-medium mb-1">
                Informasi
            </p>

            <p>
                Fitur ini digunakan untuk menambahkan atau mereset saldo awal pada suatu akun di sub periode tertentu.
                Saldo awal ini akan menjadi dasar perhitungan saldo berjalan sebelum transaksi jurnal dilakukan pada periode
                tersebut.
            </p>

            <p class="mt-2 text-xs text-gray-500">
                Catatan: Saldo awal hanya dapat dibuat jika pada sub periode yang dipilih belum terdapat transaksi jurnal.
            </p>
        </div>

        <form method="POST" action="{{ route('bendahara.opening-balances.store') }}">
            @csrf


            {{-- ============================= --}}
            {{-- PERIODE --}}
            {{-- ============================= --}}

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

                <div>

                    <label class="block text-sm font-medium mb-2">
                        Periode
                    </label>

                    <select name="period_id" id="period_id"
                        class="h-11 w-full rounded-lg border border-gray-300 px-4 text-sm dark:border-gray-700 dark:bg-dark-900 dark:text-white">

                        <option value="">-- Pilih Periode --</option>

                        @foreach ($periods as $period)
                            <option value="{{ $period->id }}">
                                {{ $period->name }}
                            </option>
                        @endforeach

                    </select>

                </div>


                <div>

                    <label class="block text-sm font-medium mb-2">
                        Sub Periode
                    </label>

                    <select name="sub_period_id" id="sub_period_id"
                        class="h-11 w-full rounded-lg border border-gray-300 px-4 text-sm dark:border-gray-700 dark:bg-dark-900 dark:text-white">

                        <option value="">-- Pilih Sub Periode --</option>

                        @foreach ($subPeriods as $subPeriod)
                            <option value="{{ $subPeriod->id }}">
                                {{ $subPeriod->name }}
                            </option>
                        @endforeach

                    </select>

                </div>

            </div>



            {{-- ============================= --}}
            {{-- CORE INPUT --}}
            {{-- ============================= --}}

            <div class="border-t pt-6 mt-6">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">


                    {{-- COA --}}
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



                    {{-- TIPE SALDO --}}
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



                {{-- NOMINAL --}}
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

        const periodSelect = document.getElementById('period_id');
        const subPeriodSelect = document.getElementById('sub_period_id');

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

        periodSelect.addEventListener('change', async function() {

            let periodId = this.value;

            subPeriodSelect.innerHTML = '<option value="">Loading...</option>';

            if (!periodId) {
                subPeriodSelect.innerHTML = '<option value="">-- Pilih Sub Periode --</option>';
                return;
            }

            try {

                const response = await fetch(`/bendahara/periods/${periodId}/sub-periods`);
                const data = await response.json();

                subPeriodSelect.innerHTML = '<option value="">-- Pilih Sub Periode --</option>';

                data.forEach(sub => {
                    subPeriodSelect.innerHTML += `
            <option value="${sub.id}">
                ${sub.name}
            </option>
        `;
                });

            } catch (error) {

                subPeriodSelect.innerHTML = '<option value="">Gagal mengambil data</option>';

            }

        });
    </script>
@endsection
