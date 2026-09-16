@extends('layouts.app')

@section('title', 'Edit Transaksi Penerimaan')

@section('content')

    <x-common.page-breadcrumb defaultTitle="Edit Transaksi Penerimaan" pageTitle="Transaksi Penerimaan"
        pageDescription="Perbarui data transaksi penerimaan kas" pageIcon="transaction" parentTitle="Transaksi Penerimaan"
        :parentRoute="route('user.transactions.incomes.index')" currentTitle="Edit" />

    <a href="{{ route('user.transactions.incomes.index') }}" class="inline-flex shrink-0 mb-5">
        <x-ui.button variant="outline" size="sm">Kembali</x-ui.button>
    </a>

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li class="text-sm text-rose-600">{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    @php
        $initialSubPeriodName = $subPeriods->firstWhere('id', $transaction->sub_period_id)?->name ?? '-';
        $initialCashName = collect($cashCoas)->firstWhere('user_account_balance_id', $selectedUserBalanceId);
        $initialCashLabel = $initialCashName ? "{$initialCashName['coa_code']} - {$initialCashName['coa_name']}" : '-';

        $initialIncomeCoa = $incomeCoas->firstWhere('id', $selectedCreditLine?->chart_of_account_id);
        $initialIncomeCoaLabel = $initialIncomeCoa ? "{$initialIncomeCoa->code} - {$initialIncomeCoa->name}" : '-';
    @endphp

    <div class="mx-auto pb-10" x-data="incomeForm(
        @js($cashCoas),
        @js($transaction->gross_amount),
        @js($selectedUserBalanceId),
        @js($transaction->transaction_date->format('Y-m-d')),
        @js($transaction->description)
    )" x-init="init()">

        <form action="{{ route('user.transactions.incomes.update', $transaction->id) }}" method="POST">
            @csrf
            @method('PUT')

            {{-- Hidden inputs untuk field yang dikunci agar tetap terkirim ke backend --}}
            <input type="hidden" name="period_id" value="{{ $selectedPeriodId }}">
            <input type="hidden" name="sub_period_id" value="{{ $transaction->sub_period_id }}">
            <input type="hidden" name="user_account_balance_id" value="{{ $selectedUserBalanceId }}">
            <input type="hidden" name="income_coa_id" value="{{ $selectedCreditLine?->chart_of_account_id }}">

            <div class="grid lg:grid-cols-3 gap-8 items-start">
                <div class="lg:col-span-2 space-y-6">

                    {{-- INFORMASI TRANSAKSI --}}
                    <x-common.component-card title="Informasi Transaksi" desc="Ubah informasi dasar transaksi">
                        <div class="grid md:grid-cols-2 gap-5">
                            <div>
                                {{-- Sub Periode Dikunci (Disabled) --}}
                                <x-form.select id="sub_period_id_disabled" name="sub_period_id_disabled"
                                    label="Sub Periode (Terkunci)" disabled>
                                    @foreach ($subPeriods as $subPeriod)
                                        <option value="{{ $subPeriod->id }}" @selected($transaction->sub_period_id == $subPeriod->id)>
                                            {{ $subPeriod->name }}
                                        </option>
                                    @endforeach
                                </x-form.select>
                            </div>
                            <div>
                                <x-form.date-picker id="transaction_date" name="transaction_date" label="Tanggal Transaksi"
                                    defaultDate="{{ old('transaction_date', $transaction->transaction_date->format('Y-m-d')) }}"
                                    x-model="transactionDate" />
                            </div>
                        </div>
                    </x-common.component-card>

                    {{-- KAS PENERIMA --}}
                    <x-common.component-card title="Kas Penerima" desc="Akun kas penerima (Terkunci)">
                        <div class="space-y-4">
                            <x-form.select id="user_account_balance_id_disabled" name="user_account_balance_id_disabled"
                                label="Akun Kas Penerima" disabled>
                                <option value="">-- Pilih Akun Kas --</option>
                                @foreach ($cashCoas as $cash)
                                    <option value="{{ $cash['user_account_balance_id'] }}" @selected($selectedUserBalanceId == $cash['user_account_balance_id'])>
                                        {{ $cash['coa_code'] }} - {{ $cash['coa_name'] }}
                                    </option>
                                @endforeach
                            </x-form.select>
                        </div>
                    </x-common.component-card>

                    {{-- DETAIL PENERIMAAN --}}
                    <x-common.component-card title="Detail Penerimaan" desc="Ubah sumber penerimaan dan nominal">
                        <div class="space-y-5">
                            {{-- Akun Sumber Penerimaan Dikunci (Disabled) --}}
                            <x-form.select name="income_coa_id_disabled" label="Akun Sumber Penerimaan (Terkunci)" disabled>
                                @foreach ($incomeCoas as $coa)
                                    <option value="{{ $coa->id }}" @selected($selectedCreditLine?->chart_of_account_id == $coa->id)>
                                        {{ $coa->code }} - {{ $coa->name }}
                                    </option>
                                @endforeach
                            </x-form.select>

                            <div>
                                <x-form.input name="nominal_display" label="Nominal Penerimaan" type="text"
                                    x-model="displayAmount" @input="inputAmount($event)" required />
                                <input type="hidden" name="amount" x-model="amount">
                            </div>

                            <div>
                                <x-form.text-area name="description" label="Deskripsi" x-model="description" rows="4"
                                    required />
                            </div>
                        </div>
                    </x-common.component-card>

                </div>

                {{-- SUMMARY SIDEBAR --}}
                <div class="lg:col-span-1">
                    <div
                        class="sticky top-6 rounded-2xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-6 shadow-sm space-y-6">
                        <h3 class="text-base font-bold text-slate-900 dark:text-slate-100">Ringkasan Perubahan</h3>

                        <div class="space-y-4 text-xs divide-y divide-slate-100 dark:divide-slate-700">
                            {{-- Tanggal --}}
                            <div class="pt-3 first:pt-0 space-y-1">
                                <span class="text-slate-500 font-medium block">Tanggal Transaksi:</span>
                                <div class="flex items-center justify-between text-slate-700 dark:text-slate-300">
                                    <span class="line-through text-slate-400" x-text="formatDate(initialDate)"></span>
                                    <span>→</span>
                                    <span class="font-bold text-emerald-600 dark:text-emerald-400"
                                        x-text="formatDate(transactionDate)"></span>
                                </div>
                            </div>

                            {{-- Nominal --}}
                            <div class="pt-3 space-y-1">
                                <span class="text-slate-500 font-medium block">Nominal Penerimaan:</span>
                                <div class="flex items-center justify-between text-slate-700 dark:text-slate-300">
                                    <span class="line-through text-slate-400" x-text="'Rp ' + format(initialAmount)"></span>
                                    <span>→</span>
                                    <span class="font-bold text-emerald-600 dark:text-emerald-400"
                                        x-text="'Rp ' + format(amount)"></span>
                                </div>
                            </div>

                            {{-- Deskripsi --}}
                            <div class="pt-3 space-y-1">
                                <span class="text-slate-500 font-medium block">Deskripsi:</span>
                                <p class="text-slate-500 italic truncate" x-text="'Lama: ' + initialDescription"></p>
                                <p class="font-semibold text-slate-800 dark:text-slate-200 line-clamp-2"
                                    x-text="'Baru: ' + description"></p>
                            </div>

                            {{-- Info Tetap (Terkunci) --}}
                            <div class="pt-3 space-y-1">
                                <span class="text-slate-500 font-medium block">Sub Periode (Tetap):</span>
                                <span
                                    class="font-medium text-slate-700 dark:text-slate-300">{{ $initialSubPeriodName }}</span>
                            </div>

                            <div class="pt-3 space-y-1">
                                <span class="text-slate-500 font-medium block">Akun Kas & Sumber (Tetap):</span>
                                <span class="font-medium text-slate-700 dark:text-slate-300 block truncate"
                                    title="{{ $initialCashLabel }}">Kas: {{ $initialCashLabel }}</span>
                                <span class="font-medium text-slate-700 dark:text-slate-300 block truncate"
                                    title="{{ $initialIncomeCoaLabel }}">Sumber: {{ $initialIncomeCoaLabel }}</span>
                            </div>
                        </div>

                        <button type="submit"
                            class="w-full h-11 bg-emerald-600 hover:bg-emerald-700 text-white font-semibold rounded-xl shadow-md transition-colors cursor-pointer">
                            Simpan Perubahan
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    @push('scripts')
        <script>
            function incomeForm(cashCoas = [], initialAmount = 0, initialCash = '', initialDate = '', initialDescription = '') {
                return {
                    cashCoas: cashCoas,
                    selectedCash: initialCash,
                    amount: initialAmount,
                    initialAmount: initialAmount,
                    initialDate: initialDate,
                    initialDescription: initialDescription,
                    transactionDate: initialDate,
                    description: initialDescription,
                    displayAmount: 'Rp ' + new Intl.NumberFormat('id-ID').format(initialAmount),

                    init() {
                        if (!this.selectedCash && this.cashCoas.length > 0) {
                            this.selectedCash = this.cashCoas[0].user_account_balance_id;
                        }
                    },
                    inputAmount(event) {
                        const raw = String(event.target.value).replace(/\D/g, '');
                        this.amount = raw ? Number(raw) : 0;
                        this.displayAmount = raw ? 'Rp ' + new Intl.NumberFormat('id-ID').format(raw) : '';
                        event.target.value = this.displayAmount;
                    },
                    format(value) {
                        return new Intl.NumberFormat('id-ID').format(Number(value) || 0);
                    },
                    formatDate(dateStr) {
                        if (!dateStr) return '-';
                        return new Date(dateStr).toLocaleDateString('id-ID', {
                            day: '2-digit',
                            month: 'short',
                            year: 'numeric'
                        });
                    }
                }
            }
        </script>
    @endpush
@endsection
