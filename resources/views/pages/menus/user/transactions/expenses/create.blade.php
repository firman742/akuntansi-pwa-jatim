@extends('layouts.app')

@section('title', 'Buat Transaksi Pengeluaran')

@section('content')

    {{-- HEADER & BACK BUTTON --}}
    <x-common.page-breadcrumb pageTitle="Tambah Transaksi Pengeluaran" defaultTitle="Tambah Transaksi Pengeluaran"
        pageDescription="Monitoring dan pencatatan transaksi pengeluaran kas dalam sistem" pageIcon="transaction"
        parentTitle="Transaksi Pengeluaran" :parentRoute="route('user.transactions.expenses.index')" currentTitle="Tambah" />

    <a href="{{ route('user.transactions.expenses.index') }}" class="inline-flex shrink-0 mb-5">
        <x-ui.button variant="outline" size="sm"
            class="inline-flex items-center gap-2 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
            Kembali
        </x-ui.button>
    </a>

    {{-- ALERTS --}}
    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li class="text-sm text-rose-600 dark:text-rose-400">{{ $error }}</li>
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

    {{-- FORM CONTAINER --}}
    <div x-data="transactionForm()" x-init="init()" class="mx-auto pb-10">
        <form method="POST" action="{{ route('user.transactions.expenses.store') }}">
            @csrf

            <div class="grid lg:grid-cols-3 gap-8 items-start">

                {{-- LEFT COLUMN: FORM INPUTS --}}
                <div class="lg:col-span-2 space-y-6">

                    {{-- CARD 1: INFORMASI UTAMA --}}
                    <x-common.component-card title="Informasi Utama">
                        <div class="space-y-5">

                            <div class="grid md:grid-cols-2 gap-5">
                                <div class="space-y-1">
                                    <x-form.select id="sub_period_id" name="sub_period_id" label="Sub Periode"
                                        placeholder="Pilih Sub Periode" x-model="sub_period_id" required>
                                        @foreach ($subPeriods as $s)
                                            <option value="{{ $s->id }}">{{ $s->name }}</option>
                                        @endforeach
                                    </x-form.select>
                                    <input type="hidden" name="period_id" value="{{ $selectedPeriodId }}">
                                </div>

                                <div>
                                    <x-form.date-picker id="transaction_date" name="transaction_date"
                                        label="Tanggal Transaksi" placeholder="Tentukan Tanggal Transaksi"
                                        defaultDate="{{ now()->format('Y-m-d') }}" />
                                </div>
                            </div>

                            <div class="grid md:grid-cols-1 gap-5">
                                <div>
                                    <x-form.select name="user_account_balance_id" label="Pilih Sumber Kas"
                                        placeholder="-- Pilih Sumber Kas --" x-model="selectedBalance"
                                        @change="onCashChange" required>
                                        @foreach ($cashCoas as $cash)
                                            <option value="{{ $cash['user_account_balance_id'] }}"
                                                data-balance="{{ $cash['remaining_balance'] }}">
                                                {{ $cash['coa_code'] }} - {{ $cash['coa_name'] }} (Rp
                                                {{ number_format($cash['remaining_balance']) }})
                                            </option>
                                        @endforeach
                                    </x-form.select>

                                    {{-- Live Balance Badge --}}
                                    <div
                                        class="mt-2.5 flex items-center justify-between p-2.5 rounded-lg bg-slate-50 dark:bg-slate-800/60 border border-slate-200/80 dark:border-slate-700/80">
                                        <span class="text-xs text-slate-500 dark:text-slate-400 font-medium">Sisa Saldo Kas
                                            Terpilih:</span>
                                        <span class="text-xs font-bold px-2 py-0.5 rounded-md"
                                            :class="balance > 0 ?
                                                'bg-emerald-100 text-emerald-700 dark:bg-emerald-950/60 dark:text-emerald-400' :
                                                'bg-slate-200 text-slate-600 dark:bg-slate-700 dark:text-slate-300'"
                                            x-text="'Rp ' + formatRupiah(balance)">
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div>
                                <x-form.text-area name="description" label="Deskripsi Transaksi"
                                    placeholder="Masukkan penjelasan detail mengenai transaksi pengeluaran ini..."
                                    rows="3" required />
                            </div>

                        </div>
                    </x-common.component-card>

                    {{-- CARD 2: RINCIAN PENGELUARAN --}}
                    <x-common.component-card title="Rincian Pengeluaran">
                        <div class="space-y-4">

                            {{-- Header Table (Desktop) --}}
                            <div
                                class="hidden md:grid md:grid-cols-12 gap-3 text-xs font-bold text-slate-400 uppercase tracking-wider px-1">
                                <div class="col-span-7">Akun Pengeluaran (COA)</div>
                                <div class="col-span-4">Nominal (Rp)</div>
                                <div class="col-span-1 text-center">Aksi</div>
                            </div>

                            {{-- Line Items --}}
                            <template x-for="(line, index) in lines" :key="index">
                                <div
                                    class="grid grid-cols-1 md:grid-cols-12 gap-3 items-center p-3 rounded-xl bg-slate-50/70 dark:bg-slate-800/40 border border-slate-200/60 dark:border-slate-700/60 transition-all hover:border-slate-300">

                                    <div class="md:col-span-7">
                                        <label class="block md:hidden text-xs font-medium text-slate-500 mb-1">Akun
                                            Pengeluaran</label>
                                        <x-form.select name="" placeholder="-- Pilih Akun Keluar --"
                                            x-bind:name="`expense_lines[${index}][coa_id]`" required>
                                            @foreach ($expenseCoas as $coa)
                                                <option value="{{ $coa->id }}">
                                                    {{ $coa->code }} - {{ $coa->name }}
                                                </option>
                                            @endforeach
                                        </x-form.select>
                                    </div>

                                    <div class="md:col-span-4">
                                        <label
                                            class="block md:hidden text-xs font-medium text-slate-500 mb-1">Nominal</label>
                                        <x-form.input name="" type="text" @input="onAmountInput($event, index)"
                                            placeholder="Rp 0" required />
                                        <input type="hidden" :name="`expense_lines[${index}][amount]`"
                                            x-model="line.amount">
                                    </div>

                                    <div class="md:col-span-1 flex justify-center">
                                        <button type="button" @click="removeLine(index)" :disabled="lines.length === 1"
                                            class="w-full md:w-auto p-2 text-rose-500 hover:text-rose-700 hover:bg-rose-50 dark:hover:bg-rose-950/40 rounded-lg transition-colors flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed"
                                            title="Hapus Baris">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                            </svg>
                                        </button>
                                    </div>

                                </div>
                            </template>

                            {{-- Add Line Button --}}
                            <button type="button" @click="addLine"
                                class="w-full group border-2 border-dashed border-slate-300 dark:border-slate-700 hover:border-indigo-500 dark:hover:border-indigo-400 rounded-xl py-3 text-slate-600 dark:text-slate-400 hover:text-indigo-600 dark:hover:text-indigo-400 transition-all flex items-center justify-center gap-2 font-medium text-sm bg-white dark:bg-slate-800">
                                <svg class="w-4 h-4 transition-transform group-hover:scale-110" fill="none"
                                    stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 4v16m8-8H4" />
                                </svg>
                                Tambah Rincian Pengeluaran
                            </button>

                        </div>
                    </x-common.component-card>

                </div>

                {{-- RIGHT COLUMN: SUMMARY & ACTIONS --}}
                <div class="lg:col-span-1">
                    <div
                        class="sticky top-6 rounded-2xl border border-slate-200 dark:border-slate-700/80 bg-white dark:bg-slate-800 p-6 shadow-sm space-y-6">

                        <div
                            class="flex items-center justify-between pb-4 border-b border-slate-100 dark:border-slate-700/60">
                            <h3 class="text-base font-bold text-slate-900 dark:text-slate-100">Ringkasan</h3>
                            <span
                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-slate-100 dark:bg-slate-700 text-slate-700 dark:text-slate-300"
                                x-text="lines.length + ' Item'"></span>
                        </div>

                        {{-- Total Display Card --}}
                        <div
                            class="p-4 rounded-xl bg-indigo-50/50 dark:bg-indigo-950/30 border border-indigo-100 dark:border-indigo-900/50">
                            <div class="text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400">
                                Total Pengeluaran</div>
                            <div class="mt-2 text-3xl font-black text-indigo-600 dark:text-indigo-400 tracking-tight"
                                x-text="'Rp ' + formatRupiah(total)"></div>
                        </div>

                        {{-- Insufficient Balance Warning --}}
                        <template x-if="balance > 0 && total > balance">
                            <div
                                class="p-3 rounded-xl bg-amber-50 dark:bg-amber-950/40 border border-amber-200 dark:border-amber-800/60 text-amber-800 dark:text-amber-300 text-xs flex items-start gap-2.5">
                                <svg class="w-4 h-4 text-amber-600 dark:text-amber-400 mt-0.5 shrink-0" fill="none"
                                    stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                                </svg>
                                <span>Total pengeluaran melebihi sisa saldo kas yang Anda pilih.</span>
                            </div>
                        </template>

                        {{-- Distinct Action Buttons --}}
                        <div class="space-y-3 pt-2">

                            {{-- PRIMARY BUTTON: SIMPAN --}}
                            <button type="submit" name="status" value="POSTED"
                                class="w-full h-11 inline-flex items-center justify-center gap-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 active:bg-indigo-800 text-white font-semibold text-sm shadow-md shadow-indigo-600/20 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition-all cursor-pointer">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M5 13l4 4L19 7" />
                                </svg>
                                Simpan Transaksi
                            </button>

                            {{-- SECONDARY BUTTON: DRAFT --}}
                            <button type="submit" name="status" value="DRAFT"
                                class="w-full h-11 inline-flex items-center justify-center gap-2 rounded-xl border border-slate-300 dark:border-slate-600 bg-white dark:bg-slate-800 text-slate-700 dark:text-slate-200 font-medium text-sm hover:bg-slate-50 dark:hover:bg-slate-700 focus:outline-none focus:ring-2 focus:ring-slate-400 transition-all shadow-sm cursor-pointer">
                                <svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4" />
                                </svg>
                                Simpan sebagai Draft
                            </button>

                        </div>

                    </div>
                </div>

            </div>

        </form>
    </div>

    {{-- SCRIPT ALPINE.JS --}}
    <script>
        function transactionForm() {
            return {
                sub_period_id: '',
                selectedBalance: '',
                balance: 0,
                total: 0,
                lines: [{
                    amount: 0
                }],

                init() {
                    this.$nextTick(() => {
                        const select = document.querySelector('[name="user_account_balance_id"]');
                        if (select && select.selectedOptions.length) {
                            this.balance = Number(select.selectedOptions[0].dataset.balance || 0);
                        }
                    });
                },

                formatRupiah(v) {
                    return new Intl.NumberFormat('id-ID').format(v || 0);
                },

                strip(v) {
                    return String(v).replace(/\D/g, '');
                },

                onCashChange(e) {
                    const option = e.target.selectedOptions[0];
                    this.balance = Number(option ? option.dataset.balance : 0);
                },

                onAmountInput(e, index) {
                    let raw = this.strip(e.target.value);
                    this.lines[index].amount = Number(raw);

                    e.target.value = raw ? 'Rp ' + this.formatRupiah(raw) : '';
                    this.calculate();
                },

                calculate() {
                    this.total = this.lines.reduce(
                        (sum, line) => sum + Number(line.amount || 0),
                        0
                    );
                },

                addLine() {
                    this.lines.push({
                        amount: 0
                    });
                },

                removeLine(index) {
                    if (this.lines.length > 1) {
                        this.lines.splice(index, 1);
                        this.calculate();
                    }
                }
            }
        }
    </script>

@endsection
