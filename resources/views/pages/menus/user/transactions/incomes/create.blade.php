@extends('layouts.app')

@section('title', 'Buat Transaksi Penerimaan')

@section('content')

    <x-common.page-breadcrumb defaultTitle="Buat Transaksi Penerimaan" pageTitle="Transaksi Penerimaan"
        pageDescription="Catat transaksi penerimaan kas yang diterima oleh pengguna" pageIcon="transaction" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li class="text-dark-500 dark:text-red-400">{{ $error }}</li>
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

    <div class="max-w-5xl mx-auto pb-20">
        <form action="{{ route('user.transactions.incomes.store') }}" method="POST" x-data="incomeForm()"
            x-init="init()">

            @csrf

            <input type="hidden" name="period_id" value="{{ $selectedPeriodId }}">

            <div class="grid grid-cols-1 gap-6 xl:grid-cols-3">

                {{-- LEFT CONTENT --}}
                <div class="space-y-6 xl:col-span-2">

                    {{-- INFORMASI TRANSAKSI --}}
                    <x-common.component-card title="Informasi Transaksi" desc="Informasi dasar transaksi penerimaan">
                        <div class="grid grid-cols-1 gap-5 md:grid-cols-2">

                            {{-- SUB PERIOD --}}
                            <div>
                                <x-form.select id="sub_period_id" name="sub_period_id" label="Sub Periode"
                                    placeholder="Pilih Sub Periode" x-model="subPeriod" required>
                                    @foreach ($subPeriods as $period)
                                        <option value="{{ $period->id }}">
                                            {{ $period->name }}
                                        </option>
                                    @endforeach
                                </x-form.select>
                            </div>

                            {{-- TANGGAL --}}
                            <div>
                                <x-form.date-picker id="transaction_date" name="transaction_date" label="Tanggal"
                                    placeholder="Tentukan Tanggal Transaksi"
                                    defaultDate="{{ old('transaction_date', now()->format('Y-m-d')) }}" />
                            </div>

                        </div>
                    </x-common.component-card>

                    {{-- KAS PENERIMA --}}
                    <x-common.component-card title="Kas Penerima" desc="Pilih akun kas yang akan menerima uang">
                        <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                            Akun Kas
                        </label>

                        <select name="user_account_balance_id" x-model="selectedCash" @change="changeCash"
                            class="h-11 w-full rounded-lg border border-gray-300 dark:border-gray-600 px-4 text-sm dark:bg-gray-800 dark:text-gray-300">

                            @foreach ($cashCoas as $cash)
                                <option value="{{ $cash['user_account_balance_id'] }}"
                                    data-balance="{{ $cash['remaining_balance'] }}">

                                    {{ $cash['coa_code'] }}
                                    -
                                    {{ $cash['coa_name'] }}

                                </option>
                            @endforeach

                        </select>

                        <div class="mt-4 rounded-lg border border-blue-100 dark:border-gray-500 bg-blue-50 dark:bg-gray-700 p-4">

                            <div class="text-sm text-gray-500 dark:text-gray-200">
                                Saldo Saat Ini
                            </div>

                            <div class="mt-1 text-2xl font-bold text-blue-700 dark:text-gray-100" x-text="'Rp ' + format(balance)">
                            </div>
                        </div>
                    </x-common.component-card>

                    {{-- PENERIMAAN --}}
                    <div class="rounded-xl border border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-800 p-6 shadow-sm">

                        <h2 class="text-lg font-semibold text-gray-900 dark:text-gray-100">
                            Detail Penerimaan
                        </h2>

                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                            Tentukan akun tujuan penerimaan beserta nominalnya.
                        </p>

                        <div class="mt-6 space-y-5">

                            {{-- AKUN --}}
                            <div>
                                <x-form.select name="income_coa_id" label="Akun Penerimaan"
                                    placeholder="-- Pilih Akun Penerimaan --">
                                    @foreach ($incomeCoas as $coa)
                                        <option value="{{ $coa->id }}">
                                            {{ $coa->code }} - {{ $coa->name }}
                                        </option>
                                    @endforeach
                                </x-form.select>
                            </div>

                            {{-- NOMINAL --}}
                            <div>
                                <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                                    Nominal
                                </label>

                                <input type="text" placeholder="Rp 0" @input="inputAmount"
                                    class="h-11 w-full rounded-lg border border-gray-300 dark:border-gray-600 px-4 text-sm dark:bg-gray-800 dark:text-gray-300">

                                <input type="hidden" name="amount" x-model="amount">
                            </div>

                            {{-- DESKRIPSI --}}
                            <div>
                                <x-form.text-area name="description" label="Deskripsi"
                                    placeholder="Masukkan deskripsi transaksi...." rows="4" required />
                            </div>

                        </div>

                    </div>

                </div>

                {{-- SUMMARY --}}
                <div>
                    <div class="sticky top-6 rounded-xl border border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-800 p-6 shadow-sm">

                        <h3 class="text-lg font-semibold text-gray-900 dark:text-gray-100">
                            Ringkasan
                        </h3>

                        <div class="mt-6 space-y-5">

                            <div>
                                <div class="text-sm text-gray-500 dark:text-gray-400">
                                    Saldo Saat Ini
                                </div>

                                <div class="mt-1 text-2xl font-bold text-gray-900 dark:text-gray-100" x-text="'Rp ' + format(balance)"></div>
                            </div>

                            <div>
                                <div class="text-sm text-gray-500 dark:text-gray-400">
                                    Total Penerimaan
                                </div>

                                <div class="mt-1 text-2xl font-bold text-green-600 dark:text-green-400" x-text="'Rp ' + format(amount)"></div>
                            </div>

                            <div class="border-t border-gray-200 dark:border-gray-600 pt-5">
                                <div class="text-sm text-gray-500 dark:text-gray-400">
                                    Saldo Setelah Transaksi
                                </div>

                                <div class="mt-1 text-3xl font-bold text-blue-600 dark:text-blue-400" x-text="'Rp ' + format(afterBalance())">
                                </div>
                            </div>

                            <button type="submit"
                                class="mt-6 h-11 w-full rounded-lg bg-blue-600 dark:bg-blue-500 font-medium text-white transition hover:bg-blue-700 dark:hover:bg-blue-600">
                                Simpan Transaksi
                            </button>

                        </div>

                    </div>
                </div>

            </div>

        </form>
    </div>

    @push('scripts')
        <script>
            function incomeForm() {
                return {
                    selectedCash: '',
                    subPeriod: '',
                    balance: 0,
                    amount: 0,
                    init() {
                        this.$nextTick(() => {
                            const select = this.$root.querySelector(
                                'select[name="user_account_balance_id"]'
                            );
                            if (!select) return;
                            if (select.selectedOptions.length) {
                                this.selectedCash = select.value;
                                this.balance = Number(
                                    select.selectedOptions[0].dataset.balance || 0
                                );
                            }
                        });
                    },
                    changeCash(event) {
                        const option = event.target.selectedOptions[0];
                        this.balance = Number(
                            option.dataset.balance || 0
                        );
                    },
                    inputAmount(event) {
                        const raw = this.onlyNumber(event.target.value);
                        this.amount = Number(raw);
                        event.target.value = raw ?
                            'Rp ' + this.format(raw) :
                            '';
                    },
                    onlyNumber(value) {
                        return value.replace(/\D/g, '');
                    },
                    format(value) {
                        return new Intl.NumberFormat(
                            'id-ID'
                        ).format(Number(value) || 0);
                    },
                    afterBalance() {
                        return Number(this.balance) + Number(this.amount);
                    }
                }
            }
        </script>
    @endpush
@endsection
