@extends('layouts.app')

@section('title', 'Buat Transaksi Pengeluaran')

@section('content')

    {{-- HEADER & BREADCRUMB --}}
    <x-common.page-breadcrumb defaultTitle="Buat Transaksi Pengeluaran" pageTitle="Transaksi Pengeluaran"
        pageDescription="Monitoring dan pencatatan transaksi pengeluaran kas dalam sistem" pageIcon="transaction"
        parentTitle="Transaksi Pengeluaran" :parentRoute="route('user.transactions.expenses.index')" currentTitle="Tambah" />

    <div class="mb-5">
        <a href="{{ route('user.transactions.expenses.index') }}" class="inline-flex shrink-0">
            <x-ui.button variant="outline" size="sm"
                class="inline-flex items-center gap-2 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                Kembali
            </x-ui.button>
        </a>
    </div>

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
    <div class="mx-auto pb-10" x-data="expenseForm(@js($cashCoas))" x-init="init()">
        <form action="{{ route('user.transactions.expenses.store') }}" method="POST" enctype="multipart/form-data">
            @csrf
            <input type="hidden" name="period_id" value="{{ $selectedPeriodId }}">

            <div class="grid lg:grid-cols-3 gap-8 items-start">

                {{-- LEFT COLUMN: FORM INPUTS --}}
                <div class="lg:col-span-2 space-y-6">

                    {{-- CARD 1: INFORMASI TRANSAKSI --}}
                    <x-common.component-card title="Informasi Transaksi"
                        desc="Informasi dasar waktu dan periode pengeluaran">
                        <div class="grid md:grid-cols-2 gap-5">
                            {{-- SUB PERIODE --}}
                            <div>
                                <x-form.select id="sub_period_id" name="sub_period_id" label="Sub Periode"
                                    placeholder="Pilih Sub Periode" x-model="subPeriod" required>
                                    @foreach ($subPeriods as $s)
                                        <option value="{{ $s->id }}">{{ $s->name }}</option>
                                    @endforeach
                                </x-form.select>
                            </div>

                            {{-- TANGGAL TRANSAKSI --}}
                            <div>
                                <x-form.date-picker id="transaction_date" name="transaction_date" label="Tanggal Transaksi"
                                    placeholder="Tentukan Tanggal Transaksi"
                                    defaultDate="{{ old('transaction_date', now()->format('Y-m-d')) }}" />
                            </div>
                        </div>
                    </x-common.component-card>

                    {{-- CARD 2: KAS SUMBER PENGELUARAN --}}
                    <x-common.component-card title="Sumber Kas Pengeluaran"
                        desc="Pilih akun kas yang digunakan untuk pembayaran">
                        <div class="space-y-4">
                            <div>
                                <x-form.select id="user_account_balance_id" name="user_account_balance_id"
                                    label="Pilih Sumber Kas" x-model="selectedCash" required>
                                    <option value="">-- Pilih Sumber Kas --</option>
                                    @foreach ($cashCoas as $cash)
                                        <option value="{{ $cash['user_account_balance_id'] }}">
                                            {{ $cash['coa_code'] }} - {{ $cash['coa_name'] }}
                                            ({{ $cash['remaining_balance'] < 0 ? 'Defisit: ' : 'Saldo: ' }}{{ number_format($cash['remaining_balance'], 0, ',', '.') }})
                                        </option>
                                    @endforeach
                                </x-form.select>
                            </div>

                            {{-- Live Balance Indicator --}}
                            <div class="p-4 rounded-xl border flex items-center justify-between transition-colors"
                                :class="balance < 0 ?
                                    'bg-rose-50/70 dark:bg-rose-950/30 border-rose-200 dark:border-rose-900/50' :
                                    'bg-slate-50 dark:bg-slate-800/60 border-slate-200/80 dark:border-slate-700/80'">
                                <div class="flex items-center gap-2.5">
                                    <div class="w-2.5 h-2.5 rounded-full"
                                        :class="balance < 0 ? 'bg-rose-500 animate-pulse' : 'bg-emerald-500 animate-pulse'">
                                    </div>
                                    <span
                                        class="text-xs font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400">
                                        Sisa Saldo Kas Terpilih
                                    </span>
                                </div>

                                <div class="flex items-center gap-2">
                                    <template x-if="selectedCash">
                                        <span class="px-2 py-0.5 rounded-md text-[10px] font-bold uppercase tracking-wider"
                                            :class="balance < 0 ?
                                                'bg-rose-100 dark:bg-rose-900/60 text-rose-700 dark:text-rose-300' :
                                                'bg-emerald-100 dark:bg-emerald-900/60 text-emerald-700 dark:text-emerald-300'"
                                            x-text="balance < 0 ? 'Defisit' : 'Tersedia'">
                                        </span>
                                    </template>
                                    <span class="text-base font-black font-mono"
                                        :class="balance < 0 ? 'text-rose-600 dark:text-rose-400' :
                                            'text-slate-900 dark:text-slate-100'"
                                        x-text="formatRupiah(balance)">
                                    </span>
                                </div>
                            </div>

                            {{-- Alert Kas Defisit --}}
                            <template x-if="selectedCash && balance < 0">
                                <div
                                    class="p-3.5 rounded-xl bg-amber-50 dark:bg-amber-950/40 border border-amber-200 dark:border-amber-800/60 text-amber-800 dark:text-amber-300 text-xs flex items-start gap-2.5">
                                    <svg class="w-4 h-4 text-amber-600 dark:text-amber-400 mt-0.5 shrink-0" fill="none"
                                        stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                                    </svg>
                                    <span>Akun kas ini sedang posisi <strong>Defisit</strong>. Pengeluaran ini akan menambah
                                        besaran minus saldo kas.</span>
                                </div>
                            </template>
                        </div>
                    </x-common.component-card>

                    {{-- CARD 3: RINCIAN PENGELUARAN (STACKED 2-TIER CARD LAYOUT) --}}
                    <x-common.component-card title="Rincian Pengeluaran"
                        desc="Tambahkan rincian akun pengeluaran beserta nominalnya">
                        <div class="space-y-4">

                            {{-- Line Items Loop --}}
                            <template x-for="(line, index) in lines" :key="index">
                                <div
                                    class="p-4 rounded-xl bg-slate-50/70 dark:bg-slate-800/40 border border-slate-200 dark:border-slate-700/70 transition-all hover:border-indigo-300 dark:hover:border-indigo-800 space-y-4 shadow-sm">

                                    {{-- LAPIS 1: HEADER ITEM & TOMBOL HAPUS (Proporsi 10 : 2 / Flex Between) --}}
                                    <div
                                        class="flex items-center justify-between pb-3 border-b border-slate-200 dark:border-slate-700">
                                        <div class="flex items-center gap-2">
                                            <span
                                                class="w-6 h-6 rounded-full bg-indigo-100 dark:bg-indigo-900/60 text-indigo-700 dark:text-indigo-300 font-bold text-xs flex items-center justify-center font-mono"
                                                x-text="index + 1"></span>
                                            <h4 class="text-xs font-bold uppercase tracking-wider text-slate-700 dark:text-slate-300"
                                                x-text="`Rincian Item #${index + 1}`"></h4>
                                        </div>

                                        {{-- Tombol Hapus Baris --}}
                                        <button type="button" @click="removeLine(index)" :disabled="lines.length === 1"
                                            class="px-3 py-1.5 text-xs font-semibold text-rose-600 dark:text-rose-400 hover:text-rose-700 hover:bg-rose-50 dark:hover:bg-rose-950/50 rounded-lg border border-rose-200 dark:border-rose-900/40 transition-colors disabled:opacity-30 disabled:cursor-not-allowed flex items-center gap-1.5 shrink-0"
                                            title="Hapus item ini">
                                            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                            </svg>
                                            <span>Hapus</span>
                                        </button>
                                    </div>

                                    {{-- LAPIS 2: BAGIAN INPUT BERSIFAT FULL WIDTH / GRID RESPONSID --}}
                                    <div class="space-y-3">

                                        {{-- Baris 1: Akun Pengeluaran (COA) - Lebar Penuh --}}
                                        <div>
                                            <label
                                                class="block text-xs font-semibold text-slate-600 dark:text-slate-400 mb-1.5">
                                                Akun Pengeluaran (COA) <span class="text-rose-500">*</span>
                                            </label>
                                            <select :name="`expense_lines[${index}][coa_id]`" required
                                                class="w-full h-10 px-3 py-2 text-sm rounded-lg border border-slate-300 dark:border-slate-600 bg-white dark:bg-slate-800 text-slate-800 dark:text-slate-200 focus:outline-none focus:ring-2 focus:ring-indigo-500">
                                                <option value="">-- Pilih Akun Keluar --</option>
                                                @foreach ($expenseCoas as $coa)
                                                    <option value="{{ $coa->id }}">{{ $coa->code }} -
                                                        {{ $coa->name }}</option>
                                                @endforeach
                                            </select>
                                        </div>

                                        {{-- Baris 2 & 3: Nominal (Rp) & Keterangan Detail --}}
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-3">

                                            {{-- Nominal Input --}}
                                            <div>
                                                <label
                                                    class="block text-xs font-semibold text-slate-600 dark:text-slate-400 mb-1.5">
                                                    Nominal (Rp) <span class="text-rose-500">*</span>
                                                </label>
                                                <input type="text" @input="onAmountInput($event, index)"
                                                    placeholder="Rp 0" required
                                                    class="w-full h-10 px-3 py-2 text-sm font-mono rounded-lg border border-slate-300 dark:border-slate-600 bg-white dark:bg-slate-800 text-slate-800 dark:text-slate-200 focus:outline-none focus:ring-2 focus:ring-indigo-500">
                                                <input type="hidden" :name="`expense_lines[${index}][amount]`"
                                                    x-model="line.amount">
                                            </div>

                                            {{-- Keterangan Detail Input --}}
                                            <div>
                                                <label
                                                    class="block text-xs font-semibold text-slate-600 dark:text-slate-400 mb-1.5">
                                                    Keterangan Detail <span
                                                        class="text-slate-400 font-normal">(Opsional)</span>
                                                </label>
                                                <input type="text" :name="`expense_lines[${index}][description]`"
                                                    x-model="line.description" placeholder="Catatan detail item..."
                                                    class="w-full h-10 px-3 py-2 text-sm rounded-lg border border-slate-300 dark:border-slate-600 bg-white dark:bg-slate-800 text-slate-800 dark:text-slate-200 focus:outline-none focus:ring-2 focus:ring-indigo-500">
                                            </div>

                                        </div>

                                    </div>

                                </div>
                            </template>

                            {{-- Add Line Button --}}
                            <button type="button" @click="addLine()"
                                class="w-full group border-2 border-dashed border-slate-300 dark:border-slate-700 hover:border-indigo-500 dark:hover:border-indigo-400 rounded-xl py-3 text-slate-600 dark:text-slate-400 hover:text-indigo-600 dark:hover:text-indigo-400 transition-all flex items-center justify-center gap-2 font-medium text-sm bg-white dark:bg-slate-800">
                                <svg class="w-4 h-4 transition-transform group-hover:scale-110" fill="none"
                                    stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 4v16m8-8H4" />
                                </svg>
                                Tambah Baris Pengeluaran
                            </button>

                        </div>
                    </x-common.component-card>
                    {{-- CARD 4: BUKTI TRANSAKSI (TANPA DESKRIPSI PARENT) --}}
                    <x-common.component-card title="Bukti Transaksi"
                        desc="Unggah dokumen atau struk pengeluaran (Opsional)">
                        <div class="space-y-2">
                            <div class="flex items-center justify-center w-full">
                                <label for="proof_file"
                                    class="flex flex-col items-center justify-center w-full h-40 border-2 border-dashed border-slate-300 dark:border-slate-700 rounded-xl cursor-pointer bg-slate-50/50 dark:bg-slate-800/40 hover:bg-slate-100/80 dark:hover:bg-slate-800 hover:border-indigo-500 dark:hover:border-indigo-400 transition-all relative overflow-hidden group">

                                    {{-- Belum ada file --}}
                                    <template x-if="!proofPreview && !proofFileName">
                                        <div class="flex flex-col items-center justify-center pt-4 pb-5 px-4 text-center">
                                            <div
                                                class="p-3 rounded-full bg-indigo-50 dark:bg-indigo-950/50 text-indigo-600 dark:text-indigo-400 mb-2 group-hover:scale-110 transition-transform">
                                                <svg class="w-6 h-6" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                        d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                </svg>
                                            </div>
                                            <p class="mb-1 text-sm font-semibold text-slate-700 dark:text-slate-300">
                                                <span class="text-indigo-600 dark:text-indigo-400">Klik untuk unggah</span>
                                                atau seret file ke sini
                                            </p>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Format: JPG, PNG, JPEG,
                                                atau PDF (Maks. 2MB)</p>
                                        </div>
                                    </template>

                                    {{-- Preview Gambar --}}
                                    <template x-if="proofPreview">
                                        <div class="relative w-full h-full p-2 flex items-center justify-center">
                                            <img :src="proofPreview"
                                                class="max-h-full max-w-full object-contain rounded-lg shadow-sm"
                                                alt="Preview Bukti">
                                        </div>
                                    </template>

                                    {{-- Preview Non-Gambar (PDF) --}}
                                    <template x-if="!proofPreview && proofFileName">
                                        <div class="flex flex-col items-center justify-center p-4 text-center">
                                            <div
                                                class="p-3 rounded-full bg-slate-100 dark:bg-slate-700 text-indigo-600 dark:text-indigo-400 mb-2">
                                                <svg class="w-8 h-8" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                                </svg>
                                            </div>
                                            <p class="text-xs font-semibold text-slate-700 dark:text-slate-200 truncate max-w-[200px]"
                                                x-text="proofFileName"></p>
                                        </div>
                                    </template>

                                    <input id="proof_file" name="proof_file" type="file" class="hidden"
                                        accept="image/*,.pdf" @change="handleFileChange($event)" />
                                </label>
                            </div>

                            {{-- Footer File --}}
                            <template x-if="proofFileName">
                                <div
                                    class="flex items-center justify-between p-3 rounded-xl bg-slate-100/80 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-xs">
                                    <div class="flex items-center gap-2 truncate pr-2">
                                        <svg class="w-4 h-4 text-indigo-600 dark:text-indigo-400 shrink-0" fill="none"
                                            stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M5 13l4 4L19 7" />
                                        </svg>
                                        <span class="text-slate-700 dark:text-slate-300 font-medium truncate"
                                            x-text="proofFileName"></span>
                                    </div>
                                    <button type="button" @click="removeFile()"
                                        class="text-rose-500 hover:text-rose-700 font-semibold transition-colors shrink-0 flex items-center gap-1">
                                        <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                        </svg>
                                        Hapus
                                    </button>
                                </div>
                            </template>
                        </div>
                    </x-common.component-card>

                </div>

                {{-- RIGHT COLUMN: SUMMARY & ACTIONS --}}
                <div class="lg:col-span-1">
                    <div
                        class="sticky top-6 rounded-2xl border border-slate-200 dark:border-slate-700/80 bg-white dark:bg-slate-800 p-6 shadow-sm space-y-6">

                        <div
                            class="flex items-center justify-between pb-4 border-b border-slate-100 dark:border-slate-700/60">
                            <h3 class="text-base font-bold text-slate-900 dark:text-slate-100">Ringkasan Transaksi</h3>
                            <span
                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-indigo-100 dark:bg-indigo-950/60 text-indigo-700 dark:text-indigo-400"
                                x-text="lines.length + ' Item'"></span>
                        </div>

                        <div class="space-y-4">
                            {{-- Saldo Kas Saat Ini --}}
                            <div class="flex items-center justify-between text-sm">
                                <span class="text-slate-500 dark:text-slate-400">Saldo Kas Saat Ini:</span>
                                <span class="font-semibold font-mono"
                                    :class="balance < 0 ? 'text-rose-600 dark:text-rose-400' :
                                        'text-slate-700 dark:text-slate-300'"
                                    x-text="formatRupiah(balance)"></span>
                            </div>

                            {{-- Total Pengeluaran --}}
                            <div class="flex items-center justify-between text-sm">
                                <span class="text-slate-500 dark:text-slate-400">Total Pengeluaran:</span>
                                <span class="font-bold font-mono text-rose-600 dark:text-rose-400"
                                    x-text="'- ' + formatRupiah(total)"></span>
                            </div>

                            {{-- Proyeksi Saldo Akhir --}}
                            <div class="border-t border-slate-100 dark:border-slate-700/60 pt-4">
                                <div class="p-4 rounded-xl border transition-colors space-y-1"
                                    :class="afterBalance() < 0 ?
                                        'bg-rose-50/60 dark:bg-rose-950/30 border-rose-200 dark:border-rose-900/50' :
                                        'bg-indigo-50/60 dark:bg-indigo-950/30 border-indigo-100 dark:border-indigo-900/50'">
                                    <div class="text-xs font-semibold uppercase tracking-wider"
                                        :class="afterBalance() < 0 ? 'text-rose-800 dark:text-rose-400' :
                                            'text-indigo-800 dark:text-indigo-400'">
                                        Proyeksi Saldo Akhir
                                    </div>
                                    <div class="text-2xl font-black font-mono tracking-tight"
                                        :class="afterBalance() < 0 ? 'text-rose-600 dark:text-rose-400' :
                                            'text-indigo-600 dark:text-indigo-400'"
                                        x-text="formatRupiah(afterBalance())">
                                    </div>
                                </div>
                            </div>
                        </div>

                        {{-- Alert Proyeksi Defisit --}}
                        <template x-if="selectedCash && afterBalance() < 0">
                            <div
                                class="p-3 rounded-xl bg-amber-50 dark:bg-amber-950/40 border border-amber-200 dark:border-amber-800/60 text-amber-800 dark:text-amber-300 text-xs flex items-start gap-2.5">
                                <svg class="w-4 h-4 text-amber-600 dark:text-amber-400 mt-0.5 shrink-0" fill="none"
                                    stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                                </svg>
                                <span>Total pengeluaran ini menyebabkan saldo kas menjadi <strong>Defisit</strong>.</span>
                            </div>
                        </template>

                        {{-- Action Buttons --}}
                        <div class="space-y-3 pt-2">
                            <button type="submit" name="status" value="POSTED"
                                class="w-full h-11 inline-flex items-center justify-center gap-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 active:bg-indigo-800 text-white font-semibold text-sm shadow-md shadow-indigo-600/20 focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-all cursor-pointer">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M5 13l4 4L19 7" />
                                </svg>
                                Simpan Transaksi
                            </button>

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

    @push('scripts')
        <script>
            function expenseForm(cashCoas = []) {
                return {
                    cashCoas: cashCoas,
                    selectedCash: '',
                    subPeriod: '{{ $selectedSubPeriodId }}',
                    proofPreview: null,
                    proofFileName: '',
                    lines: [{
                        amount: 0,
                        description: '',
                    }],

                    init() {
                        if (this.cashCoas.length > 0) {
                            this.selectedCash = this.cashCoas[0].user_account_balance_id;
                        }
                    },

                    get balance() {
                        if (!this.selectedCash) return 0;
                        const found = this.cashCoas.find(
                            item => String(item.user_account_balance_id) === String(this.selectedCash)
                        );
                        return found ? Number(found.remaining_balance) : 0;
                    },

                    get total() {
                        return this.lines.reduce(
                            (sum, line) => sum + Number(line.amount || 0),
                            0
                        );
                    },

                    afterBalance() {
                        return Number(this.balance) - Number(this.total);
                    },

                    onlyNumber(value) {
                        return String(value).replace(/\D/g, '');
                    },

                    formatRupiah(value) {
                        const num = Number(value) || 0;
                        const absFormatted = new Intl.NumberFormat('id-ID').format(Math.abs(num));
                        return num < 0 ? `- Rp ${absFormatted}` : `Rp ${absFormatted}`;
                    },

                    onAmountInput(event, index) {
                        const raw = this.onlyNumber(event.target.value);
                        this.lines[index].amount = Number(raw);
                        event.target.value = raw ? this.formatRupiah(raw) : '';
                    },

                    addLine() {
                        this.lines.push({
                            amount: 0,
                            description: '',
                        });
                    },

                    removeLine(index) {
                        if (this.lines.length > 1) {
                            this.lines.splice(index, 1);
                        }
                    },

                    handleFileChange(event) {
                        const file = event.target.files[0];
                        if (!file) return;

                        this.proofFileName = file.name;

                        if (file.type.startsWith('image/')) {
                            this.proofPreview = URL.createObjectURL(file);
                        } else {
                            this.proofPreview = null;
                        }
                    },

                    removeFile() {
                        this.proofPreview = null;
                        this.proofFileName = '';
                        const input = document.getElementById('proof_file');
                        if (input) input.value = '';
                    }
                };
            }
        </script>
    @endpush

@endsection
