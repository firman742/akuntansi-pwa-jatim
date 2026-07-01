@extends('layouts.app')

@section('title', 'Alokasikan Dana Operasional Pengguna')

@section('content')

    <x-common.page-breadcrumb defaultTitle="Dana Operasional Pengguna" pageTitle="Alokasikan Dana Operasional Pengguna"
        pageDescription="Alokasikan Dana Operasional Ke Pengguna" pageIcon="transaction" parentTitle="Dana Operational Pengguna"
        :parentRoute="route('user.user-account-balances.index')" currentTitle="Alokasikan" />

    {{-- ERROR --}}
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

    {{-- STEP 1 --}}
    <x-common.component-card title="1. Pilih Sumber Saldo">

        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">

            {{-- PERIOD --}}
            <div>
                <label class="text-sm font-medium mb-2 block">
                    Periode
                </label>

                <select id="period_id"
                    class="w-full border rounded-lg p-2 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-400">

                    <option value="">
                        Pilih Periode
                    </option>

                    @foreach ($periods as $period)
                        <option value="{{ $period->id }}">
                            {{ $period->name }}
                        </option>
                    @endforeach

                </select>
            </div>

            {{-- SUB PERIOD --}}
            <div>
                <label class="text-sm font-medium mb-2 block">
                    Sub Periode
                </label>

                <select id="sub_period_id"
                    class="w-full border rounded-lg p-2 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-400">

                    <option value="">
                        Pilih Sub Periode
                    </option>

                </select>
            </div>

            {{-- COA BALANCE --}}
            <div>
                <label class="text-sm font-medium mb-2 block">
                    Saldo Akun Sumber
                </label>

                <select id="coa_balance_id"
                    class="w-full border rounded-lg p-2 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-400">

                    <option value="">
                        Pilih Saldo Akun
                    </option>

                    @foreach ($coaBalances as $balance)
                        <option value="{{ $balance->id }}" data-balance="{{ $balance->current_balance }}"
                            data-coa="{{ $balance->chart_of_account_id }}">

                            {{ $balance->chartOfAccount->code }}
                            -
                            {{ $balance->chartOfAccount->name }}

                        </option>
                    @endforeach

                </select>
            </div>

        </div>

        <div class="mt-4 flex justify-end">

            <x-ui.button type="button" id="btn_continue" variant="primary">
                Lanjutkan
            </x-ui.button>

        </div>

    </x-common.component-card>

    {{-- STEP 2 --}}
    <div id="form_container" style="display: none;" class="mt-6">

        <x-common.component-card title="2. Detail Pembagian Saldo">

            <form method="POST" action="{{ route('bendahara.user-account-balances.store') }}">

                @csrf

                {{-- HIDDEN --}}
                <input type="hidden" name="period_id" id="final_period_id">
                <input type="hidden" name="sub_period_id" id="final_sub_period_id">
                <input type="hidden" name="coa_balance_id" id="final_coa_balance_id">

                {{-- AVAILABLE BALANCE --}}
                <div class="grid grid-cols-1 gap-6 mb-6">

                    <div id="available_box"
                        class="hidden p-4 bg-green-50 border rounded-lg dark:bg-gray-900 dark:border-gray-700">

                        <div class="text-sm text-gray-500">
                            Saldo Tersedia Saat Ini
                        </div>

                        <div class="text-xl font-bold text-green-700" id="available_value">
                            Rp 0
                        </div>

                    </div>

                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                    {{-- USER ACCOUNT --}}
                    <div>

                        <label class="text-sm font-medium mb-2 block">
                            Pengguna Tujuan
                        </label>

                        <select name="user_account_id" id="user_account_id"
                            class="w-full border rounded-lg p-2 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-400"
                            required>

                            <option value="">
                                Pilih Pengguna
                            </option>

                        </select>

                        <p id="empty_user_info" class="hidden mt-2 text-xs text-red-500">
                            Tidak ada pengguna yang terhubung dengan akun COA ini.
                        </p>

                    </div>

                    {{-- AMOUNT --}}
                    <div>

                        <label class="text-sm font-medium mb-2 block">
                            Nominal Pembagian
                        </label>

                        <input type="text" id="allocated_display"
                            class="h-11 w-full rounded-lg border border-blue-300 px-4 text-sm focus:ring-2 focus:ring-blue-500 dark:bg-dark-900 dark:border-gray-700"
                            placeholder="Masukkan nominal distribusi" required>

                        <input type="hidden" name="allocated_balance" id="allocated_balance" value="0">

                    </div>

                </div>

                {{-- DESCRIPTION --}}
                <div class="grid grid-cols-1 gap-6 mt-6">

                    <div>

                        <label class="text-sm font-medium mb-2 block">
                            Keterangan
                        </label>

                        <textarea name="description" class="w-full border rounded-lg p-2 dark:border-gray-700" rows="4"
                            placeholder="Contoh: Pembagian saldo operasional bulan Mei"></textarea>

                    </div>

                </div>

                {{-- SUMMARY --}}
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-6">

                    {{-- CURRENT --}}
                    <div class="p-4 border rounded-lg bg-blue-50 dark:bg-gray-900 dark:border-gray-700">

                        <div class="text-sm text-gray-500">
                            Saldo Saat Ini
                        </div>

                        <div class="text-xl font-bold text-blue-700" id="summary_current">
                            Rp 0
                        </div>

                    </div>

                    {{-- ALLOCATED --}}
                    <div class="p-4 border rounded-lg bg-yellow-50 dark:bg-gray-900 dark:border-gray-700">

                        <div class="text-sm text-gray-500">
                            Akan Dibagikan
                        </div>

                        <div class="text-xl font-bold text-yellow-700" id="summary_allocated">
                            Rp 0
                        </div>

                    </div>

                    {{-- REMAINING --}}
                    <div class="p-4 border rounded-lg bg-green-50 dark:bg-gray-900 dark:border-gray-700">

                        <div class="text-sm text-gray-500">
                            Sisa Saldo
                        </div>

                        <div class="text-xl font-bold text-green-700" id="summary_remaining">
                            Rp 0
                        </div>

                    </div>

                </div>

                {{-- ACTION --}}
                <div class="mt-6 flex justify-end gap-3">

                    <a href="{{ route('bendahara.user-account-balances.index') }}">

                        <x-ui.button variant="outline" size="sm">
                            Kembali
                        </x-ui.button>

                    </a>

                    <x-ui.button type="submit" variant="primary" size="sm">
                        Simpan Pembagian
                    </x-ui.button>

                </div>

            </form>

        </x-common.component-card>

    </div>

    <script>
        const period = document.getElementById('period_id');
        const subPeriod = document.getElementById('sub_period_id');
        const coaBalance = document.getElementById('coa_balance_id');
        const btnContinue = document.getElementById('btn_continue');

        const formContainer = document.getElementById('form_container');

        const availableBox = document.getElementById('available_box');
        const availableValue = document.getElementById('available_value');

        const userSelect = document.getElementById('user_account_id');
        const emptyUserInfo = document.getElementById('empty_user_info');

        const allocatedDisplay = document.getElementById('allocated_display');
        const allocatedHidden = document.getElementById('allocated_balance');

        const summaryCurrent = document.getElementById('summary_current');
        const summaryAllocated = document.getElementById('summary_allocated');
        const summaryRemaining = document.getElementById('summary_remaining');

        let currentBalance = 0;

        function formatRupiah(value) {

            return new Intl.NumberFormat('id-ID', {
                style: 'currency',
                currency: 'IDR',
                minimumFractionDigits: 0
            }).format(value || 0);

        }

        /**
         * LOAD SUB PERIOD
         */
        period.addEventListener('change', async function() {

            let periodId = this.value;

            subPeriod.innerHTML = '<option value="">Loading...</option>';

            if (!periodId) {
                subPeriod.innerHTML = '<option value="">Pilih Sub Periode</option>';
                return;
            }

            try {

                const response = await fetch(
                    `/bendahara/periods/${periodId}/sub-periods`
                );

                const data = await response.json();

                subPeriod.innerHTML = '<option value="">Pilih Sub Periode</option>';

                data.forEach(sub => {

                    subPeriod.innerHTML += `
                        <option value="${sub.id}">
                            ${sub.name}
                        </option>
                    `;

                });

            } catch (error) {

                subPeriod.innerHTML = `
                    <option value="">
                        Gagal mengambil data
                    </option>
                `;

            }

        });

        /**
         * CONTINUE
         */
        btnContinue.addEventListener('click', async function() {

            if (!period.value || !subPeriod.value || !coaBalance.value) {

                alert('Lengkapi periode, sub periode, dan saldo akun terlebih dahulu.');

                return;

            }

            document.getElementById('final_period_id').value = period.value;
            document.getElementById('final_sub_period_id').value = subPeriod.value;
            document.getElementById('final_coa_balance_id').value = coaBalance.value;

            btnContinue.innerText = 'Loading...';
            btnContinue.disabled = true;

            try {

                const selectedOption =
                    coaBalance.options[coaBalance.selectedIndex];

                const coaId = selectedOption.dataset.coa;

                currentBalance = Number(
                    selectedOption.dataset.balance || 0
                );

                /**
                 * LOAD USER ACCOUNTS
                 */
                const response = await fetch(
                    `/bendahara/user-account-balances/coas/${coaId}/users`
                );

                const users = await response.json();

                userSelect.innerHTML = `
                    <option value="">
                        Pilih Pengguna
                    </option>
                `;

                if (users.length === 0) {

                    emptyUserInfo.classList.remove('hidden');

                } else {

                    emptyUserInfo.classList.add('hidden');

                    users.forEach(user => {

                        userSelect.innerHTML += `
                            <option value="${user.id}">
                                ${user.name}
                            </option>
                        `;

                    });

                }

                /**
                 * SHOW BALANCE
                 */
                availableBox.classList.remove('hidden');

                availableValue.innerText =
                    formatRupiah(currentBalance);

                summaryCurrent.innerText =
                    formatRupiah(currentBalance);

                summaryAllocated.innerText =
                    formatRupiah(0);

                summaryRemaining.innerText =
                    formatRupiah(currentBalance);

                formContainer.style.display = 'block';

                formContainer.scrollIntoView({
                    behavior: 'smooth'
                });

            } catch (error) {

                alert('Gagal memuat data pengguna.');

            } finally {

                btnContinue.innerText = 'Lanjutkan';
                btnContinue.disabled = false;

            }

        });

        /**
         * FORMAT NOMINAL
         */
        allocatedDisplay.addEventListener('input', function(e) {

            let rawValue = e.target.value.replace(/[^0-9]/g, '');

            let amount = Number(rawValue || 0);

            allocatedHidden.value = amount;

            e.target.value = amount ?
                formatRupiah(amount) :
                '';

            summaryAllocated.innerText =
                formatRupiah(amount);

            summaryRemaining.innerText =
                formatRupiah(currentBalance - amount);

        });
    </script>

@endsection
