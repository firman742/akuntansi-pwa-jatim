@extends('layouts.app')

@section('title', 'Detail Saldo Akun')

@section('content')

    {{-- Breadcrumb --}}
    <div class="mb-6">
        <x-common.page-breadcrumb pageTitle="Detail Saldo Akun"
            pageDescription="Rincian posisi saldo, penyerapan dana, dan riwayat aktivitas akun" pageIcon="money"
            parentTitle="Saldo Akun & Mutasi" :parentRoute="route('user.coa-balances.index')" currentTitle="Detail" />
    </div>

    {{-- Tombol Navigasi Utama --}}
    <div class="mb-6 flex items-center justify-between">
        <a href="{{ route('user.coa-balances.index') }}">
            <x-ui.button variant="outline"
                class="rounded-xl px-4 py-2 dark:bg-gray-800 dark:text-gray-300 dark:border-gray-700">
                <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                Kembali ke Daftar Saldo
            </x-ui.button>
        </a>

        <div class="flex items-center gap-2">
            <span
                class="text-xs px-3 py-1 rounded-full font-semibold uppercase tracking-wider
                {{ $account->is_active ? 'bg-emerald-100 text-emerald-800 dark:bg-emerald-500/20 dark:text-emerald-300' : 'bg-rose-100 text-rose-800 dark:bg-rose-500/20 dark:text-rose-300' }}">
                Status Akun: {{ $account->is_active ? 'Aktif' : 'Non-Aktif' }}
            </span>
        </div>
    </div>

    <div class="space-y-6">

        {{-- ROW 1: HEADER INFORMASI AKUN & SISA SALDO TERSEDIA --}}
        <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">

            {{-- Kartu Info COA --}}
            <div class="lg:col-span-2">
                <x-common.component-card class="dark:bg-gray-800 dark:border-gray-700 h-full flex flex-col justify-between">
                    <div class="flex flex-col sm:flex-row justify-between gap-6">
                        <div class="space-y-2">
                            <span class="text-xs font-semibold uppercase tracking-wider text-gray-400 dark:text-gray-500">
                                Kode & Nama Akun
                            </span>
                            <h2 class="text-3xl font-extrabold text-gray-900 dark:text-gray-100 tracking-tight font-mono">
                                {{ $account->code }}
                            </h2>
                            <p class="text-xl font-bold text-gray-700 dark:text-gray-200">
                                {{ $account->name }}
                            </p>
                            <div class="flex items-center gap-2 mt-1">
                                <span class="text-xs font-medium text-gray-500 dark:text-gray-400">Normal Balance:</span>
                                <span
                                    class="text-xs font-bold uppercase px-2 py-0.5 rounded bg-blue-50 text-blue-700 dark:bg-blue-900/30 dark:text-blue-300">
                                    {{ $account->normal_balance?->value ?? $account->normal_balance }}
                                </span>
                            </div>
                        </div>

                        <div
                            class="grid grid-cols-2 gap-4 border-t sm:border-t-0 sm:border-l border-gray-100 dark:border-gray-700 pt-4 sm:pt-0 sm:pl-6 min-w-[220px]">
                            <div>
                                <p class="text-xs text-gray-400 dark:text-gray-500 font-medium uppercase">Periode Utama</p>
                                <p class="font-bold text-gray-800 dark:text-gray-200 text-sm mt-0.5">
                                    {{ $coaBalance->period->name }}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 dark:text-gray-500 font-medium uppercase">Sub Periode</p>
                                <p class="font-bold text-gray-800 dark:text-gray-200 text-sm mt-0.5">
                                    {{ $coaBalance->subPeriod->name }}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 dark:text-gray-500 font-medium uppercase">Tgl Mulai</p>
                                <p class="font-semibold text-gray-700 dark:text-gray-300 text-xs mt-0.5">
                                    {{ $coaBalance->subPeriod->start_date->format('d M Y') }}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 dark:text-gray-500 font-medium uppercase">Tgl Selesai</p>
                                <p class="font-semibold text-gray-700 dark:text-gray-300 text-xs mt-0.5">
                                    {{ $coaBalance->subPeriod->end_date->format('d M Y') }}</p>
                            </div>
                        </div>
                    </div>

                    {{-- Mini Stat Card Row --}}
                    <div
                        class="grid grid-cols-2 sm:grid-cols-4 gap-3 mt-6 pt-4 border-t border-gray-100 dark:border-gray-700">
                        <div class="p-3 bg-gray-50 dark:bg-gray-700/50 rounded-xl">
                            <p class="text-[11px] text-gray-400 dark:text-gray-400 uppercase font-semibold">Saldo Awal</p>
                            <p class="text-sm font-bold text-gray-800 dark:text-gray-200 mt-0.5">Rp
                                {{ number_format($summary['opening_balance'], 0, ',', '.') }}</p>
                        </div>
                        <div class="p-3 bg-emerald-50/60 dark:bg-emerald-950/20 rounded-xl">
                            <p class="text-[11px] text-emerald-600 dark:text-emerald-400 uppercase font-semibold">Total
                                Debit</p>
                            <p class="text-sm font-bold text-emerald-700 dark:text-emerald-300 mt-0.5">Rp
                                {{ number_format($summary['debit_total'], 0, ',', '.') }}</p>
                        </div>
                        <div class="p-3 bg-rose-50/60 dark:bg-rose-950/20 rounded-xl">
                            <p class="text-[11px] text-rose-600 dark:text-rose-400 uppercase font-semibold">Total Kredit</p>
                            <p class="text-sm font-bold text-rose-700 dark:text-rose-300 mt-0.5">Rp
                                {{ number_format($summary['credit_total'], 0, ',', '.') }}</p>
                        </div>
                        <div class="p-3 bg-blue-50/60 dark:bg-blue-950/20 rounded-xl">
                            <p class="text-[11px] text-blue-600 dark:text-blue-400 uppercase font-semibold">Batas Total Dana
                            </p>
                            <p class="text-sm font-bold text-blue-700 dark:text-blue-300 mt-0.5">Rp
                                {{ number_format($summary['total_funds'], 0, ',', '.') }}</p>
                        </div>
                    </div>
                </x-common.component-card>
            </div>

            {{-- Kartu Saldo Saat Ini (Highlight) --}}
            <div class="lg:col-span-1">
                <div
                    class="h-full rounded-2xl bg-gradient-to-br from-emerald-600 to-teal-700 dark:from-emerald-700 dark:to-teal-800 p-6 text-white shadow-lg flex flex-col justify-between">
                    <div>
                        <div class="flex items-center justify-between">
                            <p class="text-xs font-bold uppercase tracking-widest text-emerald-100 opacity-90">
                                Sisa Saldo Tersedia
                            </p>
                            <span class="p-1.5 bg-white/10 rounded-lg">
                                <svg class="w-5 h-5 text-emerald-100" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                            </span>
                        </div>
                        <h1 class="mt-3 text-3xl font-black lg:text-4xl tracking-tight">
                            Rp {{ number_format($summary['current_balance'], 0, ',', '.') }}
                        </h1>
                        <p class="text-xs text-emerald-100/80 mt-1">
                            Sisa dana aktif yang dapat digunakan pada periode berjalan.
                        </p>
                    </div>

                    <div class="mt-6 border-t border-emerald-400/30 pt-4 space-y-2">
                        <div class="flex justify-between text-xs text-emerald-100">
                            <span>Status Penyerapan Saldo</span>
                            <span class="font-bold">{{ $summary['used_percentage'] }}% Terpakai</span>
                        </div>
                        <div class="w-full bg-black/20 rounded-full h-2.5 overflow-hidden">
                            <div class="bg-amber-300 h-2.5 rounded-full transition-all duration-500"
                                style="width: {{ $summary['used_percentage'] }}%"></div>
                        </div>
                        <p class="text-[11px] text-emerald-100/70 text-right">
                            Sisa kuota: {{ $summary['remaining_percentage'] }}%
                        </p>
                    </div>
                </div>
            </div>

        </div>

        {{-- ROW 2: BAGAN REALTIME SALDO TERPAKAI VS SISA SALDO TERSEDIA & STATISTIK INFORMATIF --}}
        <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">

            {{-- POIN 1: BAGAN REALTIME SALDO TERPAKAI DAN SISA SALDO TERSEDIA --}}
            <div class="lg:col-span-1">
                <x-common.component-card title="Visualisasi Saldo" desc="Perbandingan Saldo Terpakai vs Sisa Tersedia">
                    <div class="flex flex-col items-center justify-center p-4">
                        <div class="w-48 h-48 relative flex items-center justify-center">
                            {{-- Donut SVG Visual --}}
                            <svg class="w-full h-full transform -rotate-90" viewBox="0 0 36 36">
                                {{-- Circle Background (Sisa Tersedia) --}}
                                <path class="text-emerald-500 dark:text-emerald-400 stroke-current" stroke-width="4"
                                    fill="none"
                                    d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" />
                                {{-- Circle Foreground (Saldo Terpakai) --}}
                                <path class="text-amber-500 stroke-current"
                                    stroke-dasharray="{{ $summary['used_percentage'] }}, 100" stroke-width="4"
                                    stroke-linecap="round" fill="none"
                                    d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" />
                            </svg>
                            <div class="absolute flex flex-col items-center text-center">
                                <span class="text-xs font-medium text-gray-400 dark:text-gray-500">Penyerapan</span>
                                <span
                                    class="text-2xl font-black text-gray-800 dark:text-gray-100">{{ $summary['used_percentage'] }}%</span>
                            </div>
                        </div>

                        {{-- Legend --}}
                        <div class="w-full mt-6 space-y-2 border-t border-gray-100 dark:border-gray-700 pt-4">
                            <div class="flex items-center justify-between text-xs">
                                <div class="flex items-center gap-2">
                                    <span class="w-3 h-3 rounded-full bg-emerald-500"></span>
                                    <span class="text-gray-600 dark:text-gray-300">Sisa Saldo Tersedia:</span>
                                </div>
                                <span class="font-mono font-bold text-gray-800 dark:text-gray-200">Rp
                                    {{ number_format($summary['current_balance'], 0, ',', '.') }}</span>
                            </div>
                            <div class="flex items-center justify-between text-xs">
                                <div class="flex items-center gap-2">
                                    <span class="w-3 h-3 rounded-full bg-amber-500"></span>
                                    <span class="text-gray-600 dark:text-gray-300">Saldo Terpakai:</span>
                                </div>
                                <span class="font-mono font-bold text-gray-800 dark:text-gray-200">Rp
                                    {{ number_format($summary['used_balance'], 0, ',', '.') }}</span>
                            </div>
                        </div>
                    </div>
                </x-common.component-card>
            </div>

            {{-- POIN 2 & 4: BAGAN INFORMATIF LAINNYA & INFORMASI TAMBAHAN --}}
            <div class="lg:col-span-2">
                <x-common.component-card title="Metrik & Statistik Mutasi"
                    desc="Informasi ringkasan transaksi & pola penggunaan akun">

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">

                        {{-- Card 1: Frekuensi Mutasi --}}
                        <div
                            class="p-4 rounded-xl border border-gray-100 dark:border-gray-700 bg-gray-50/50 dark:bg-gray-800/50 flex items-start gap-4">
                            <div class="p-3 rounded-lg bg-blue-100 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400">
                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                                </svg>
                            </div>
                            <div>
                                <p class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase">Frekuensi
                                    Mutasi</p>
                                <h4 class="text-lg font-bold text-gray-800 dark:text-gray-100 mt-0.5">
                                    {{ $summary['debit_count'] + $summary['credit_count'] }} Transaksi
                                </h4>
                                <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">
                                    {{ $summary['debit_count'] }} Posisi Debit • {{ $summary['credit_count'] }} Posisi
                                    Kredit
                                </p>
                            </div>
                        </div>

                        {{-- Card 2: Rata-Rata Transaksi Debit --}}
                        <div
                            class="p-4 rounded-xl border border-gray-100 dark:border-gray-700 bg-gray-50/50 dark:bg-gray-800/50 flex items-start gap-4">
                            <div
                                class="p-3 rounded-lg bg-emerald-100 text-emerald-600 dark:bg-emerald-900/30 dark:text-emerald-400">
                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
                                </svg>
                            </div>
                            <div>
                                <p class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase">Rata-Rata Nilai
                                    Debit</p>
                                <h4 class="text-lg font-bold text-emerald-600 dark:text-emerald-400 mt-0.5 font-mono">
                                    Rp {{ number_format($summary['avg_debit_amount'], 0, ',', '.') }}
                                </h4>
                                <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">
                                    Berdasarkan {{ $summary['debit_count'] }} baris transaksi debit
                                </p>
                            </div>
                        </div>

                        {{-- Card 3: Rata-Rata Transaksi Kredit --}}
                        <div
                            class="p-4 rounded-xl border border-gray-100 dark:border-gray-700 bg-gray-50/50 dark:bg-gray-800/50 flex items-start gap-4">
                            <div class="p-3 rounded-lg bg-rose-100 text-rose-600 dark:bg-rose-900/30 dark:text-rose-400">
                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M13 17h8m0 0V9m0 8l-8-8-4 4-6-6" />
                                </svg>
                            </div>
                            <div>
                                <p class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase">Rata-Rata Nilai
                                    Kredit</p>
                                <h4 class="text-lg font-bold text-rose-600 dark:text-rose-400 mt-0.5 font-mono">
                                    Rp {{ number_format($summary['avg_credit_amount'], 0, ',', '.') }}
                                </h4>
                                <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">
                                    Berdasarkan {{ $summary['credit_count'] }} baris transaksi kredit
                                </p>
                            </div>
                        </div>

                        {{-- Card 4: Waktu Transaksi Terakhir --}}
                        <div
                            class="p-4 rounded-xl border border-gray-100 dark:border-gray-700 bg-gray-50/50 dark:bg-gray-800/50 flex items-start gap-4">
                            <div
                                class="p-3 rounded-lg bg-purple-100 text-purple-600 dark:bg-purple-900/30 dark:text-purple-400">
                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                            </div>
                            <div>
                                <p class="text-xs font-semibold text-gray-400 dark:text-gray-500 uppercase">Aktivitas
                                    Terakhir</p>
                                <h4 class="text-base font-bold text-gray-800 dark:text-gray-100 mt-0.5">
                                    {{ $summary['last_transaction_at'] ? $summary['last_transaction_at']->format('d M Y H:i') : 'Belum Ada Transaksi' }}
                                </h4>
                                <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">
                                    Pembaruan saldo otomatis dari jurnal transaksi
                                </p>
                            </div>
                        </div>

                    </div>

                </x-common.component-card>
            </div>

        </div>

        {{-- POIN 3: TIMELINE AKTIVITAS SALDO (SALDO AWAL, TRANSAKSI DEBIT, TRANSAKSI KREDIT) --}}
        <x-common.component-card title="Timeline Aktivitas Saldo Akun"
            desc="Rincian pergerakan saldo berdasarkan riwayat saldo awal dan posisi mutasi debit/kredit">

            <div x-data="{ activeTab: 'saldo_awal' }" class="space-y-6 mt-2">

                {{-- Tab Headers --}}
                <div
                    class="flex overflow-x-auto border-b border-gray-200 dark:border-gray-700 scrollbar-none whitespace-nowrap">
                    {{-- Tab 1: Saldo Awal --}}
                    <button @click="activeTab='saldo_awal'"
                        :class="activeTab === 'saldo_awal' ? 'border-primary-500 text-primary-600 dark:text-primary-400' :
                            'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400'"
                        class="flex items-center gap-2 border-b-2 px-5 py-3 text-sm font-semibold transition-all">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M3 10h18M7 15h1m4 0h1m-7 4h12a2 2 0 002-2V6a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                        </svg>
                        Riwayat Saldo Awal
                        <span
                            :class="activeTab === 'saldo_awal' ?
                                'bg-primary-100 text-primary-700 dark:bg-primary-500/20 dark:text-primary-400' :
                                'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400'"
                            class="rounded-full px-2 py-0.5 text-xs font-bold">
                            {{ $openingBalancesHistory->count() }}
                        </span>
                    </button>

                    {{-- Tab 2: Transaksi DEBIT --}}
                    <button @click="activeTab='debit'"
                        :class="activeTab === 'debit' ? 'border-emerald-500 text-emerald-600 dark:text-emerald-400' :
                            'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400'"
                        class="flex items-center gap-2 border-b-2 px-5 py-3 text-sm font-semibold transition-all">
                        <svg class="w-4 h-4 text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M7 11l5-5m0 0l5 5m-5-5v12" />
                        </svg>
                        Riwayat Transaksi Debit
                        <span
                            :class="activeTab === 'debit' ?
                                'bg-emerald-100 text-emerald-700 dark:bg-emerald-500/20 dark:text-emerald-400' :
                                'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400'"
                            class="rounded-full px-2 py-0.5 text-xs font-bold">
                            {{ $debitTransactions->count() }}
                        </span>
                    </button>

                    {{-- Tab 3: Transaksi KREDIT --}}
                    <button @click="activeTab='kredit'"
                        :class="activeTab === 'kredit' ? 'border-rose-500 text-rose-600 dark:text-rose-400' :
                            'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400'"
                        class="flex items-center gap-2 border-b-2 px-5 py-3 text-sm font-semibold transition-all">
                        <svg class="w-4 h-4 text-rose-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M17 13l-5 5m0 0l-5-5m5 5V6" />
                        </svg>
                        Riwayat Transaksi Kredit
                        <span
                            :class="activeTab === 'kredit' ?
                                'bg-rose-100 text-rose-700 dark:bg-rose-500/20 dark:text-rose-400' :
                                'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400'"
                            class="rounded-full px-2 py-0.5 text-xs font-bold">
                            {{ $creditTransactions->count() }}
                        </span>
                    </button>
                </div>

                {{-- Konten Tabs --}}
                <div class="space-y-4">

                    {{-- TAB 1: SALDO AWAL --}}
                    <div x-show="activeTab === 'saldo_awal'" x-transition class="space-y-3">
                        @forelse($openingBalancesHistory as $item)
                            <div
                                class="flex flex-col sm:flex-row justify-between items-start sm:items-center p-4 rounded-xl border border-gray-100 bg-gray-50 dark:border-gray-700 dark:bg-gray-800 gap-2">
                                <div>
                                    <h4 class="font-bold text-gray-800 dark:text-gray-200">Penetapan Saldo Awal</h4>
                                    <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
                                        Petugas / Pembuat: <span
                                            class="font-medium text-gray-700 dark:text-gray-300">{{ $item->creator?->name ?? 'Sistem' }}</span>
                                    </p>
                                    @if ($item->is_correction)
                                        <span
                                            class="mt-1.5 inline-flex rounded-full bg-amber-50 dark:bg-amber-500/10 border border-amber-200 dark:border-amber-500 px-2 py-0.5 text-[10px] font-bold text-amber-700 dark:text-amber-300">
                                            Koreksi Saldo
                                        </span>
                                    @endif
                                </div>
                                <div
                                    class="sm:text-right w-full sm:w-auto border-t border-gray-100 dark:border-gray-700 sm:border-t-0 pt-2 sm:pt-0">
                                    <p class="text-base font-black text-gray-800 dark:text-gray-200 font-mono">
                                        Rp {{ number_format($item->amount, 0, ',', '.') }}
                                    </p>
                                    <p class="text-[11px] text-gray-400 dark:text-gray-500 mt-0.5">
                                        {{ $item->created_at?->format('d M Y H:i') }}
                                    </p>
                                </div>
                            </div>
                        @empty
                            <div
                                class="rounded-xl border border-dashed border-gray-200 dark:border-gray-700 p-8 text-center text-sm text-gray-400 dark:text-gray-500">
                                Belum ada penetapan saldo awal pada sub periode ini.
                            </div>
                        @endforelse
                    </div>

                    {{-- TAB 2: TRANSAKSI DEBIT --}}
                    <div x-show="activeTab === 'debit'" x-transition class="space-y-3">
                        @forelse($debitTransactions as $line)
                            <div
                                class="flex flex-col sm:flex-row justify-between items-start sm:items-center p-4 rounded-xl border border-emerald-100 bg-emerald-50/30 dark:border-emerald-900/30 dark:bg-gray-800 gap-2">
                                <div>
                                    <div class="flex items-center gap-2">
                                        <span
                                            class="px-2 py-0.5 text-[10px] font-bold uppercase rounded bg-emerald-100 text-emerald-800 dark:bg-emerald-900/50 dark:text-emerald-300">
                                            DEBIT
                                        </span>
                                        <h4 class="font-bold text-gray-800 dark:text-gray-200">
                                            {{ $line->description ?: $line->transaction?->description }}
                                        </h4>
                                    </div>
                                    <p class="text-xs text-gray-500 dark:text-gray-400 mt-1 font-mono">
                                        No. Transaksi: {{ $line->transaction?->transaction_number }}
                                    </p>
                                    <p class="text-[11px] text-gray-400 dark:text-gray-500">
                                        Petugas: {{ $line->transaction?->creator?->name ?? '-' }}
                                    </p>
                                </div>
                                <div
                                    class="sm:text-right w-full sm:w-auto border-t border-gray-100 dark:border-gray-700 sm:border-t-0 pt-2 sm:pt-0">
                                    <p class="text-base font-black text-emerald-600 dark:text-emerald-400 font-mono">
                                        + Rp {{ number_format($line->amount, 0, ',', '.') }}
                                    </p>
                                    <p class="text-[11px] text-gray-400 dark:text-gray-500 mt-0.5">
                                        {{ $line->transaction?->transaction_date?->format('d M Y') }}
                                    </p>
                                </div>
                            </div>
                        @empty
                            <div
                                class="rounded-xl border border-dashed border-gray-200 dark:border-gray-700 p-8 text-center text-sm text-gray-400 dark:text-gray-500">
                                Belum ada aktivitas transaksi posisi debit pada sub periode ini.
                            </div>
                        @endforelse
                    </div>

                    {{-- TAB 3: TRANSAKSI KREDIT --}}
                    <div x-show="activeTab === 'kredit'" x-transition class="space-y-3">
                        @forelse($creditTransactions as $line)
                            <div
                                class="flex flex-col sm:flex-row justify-between items-start sm:items-center p-4 rounded-xl border border-rose-100 bg-rose-50/30 dark:border-rose-900/30 dark:bg-gray-800 gap-2">
                                <div>
                                    <div class="flex items-center gap-2">
                                        <span
                                            class="px-2 py-0.5 text-[10px] font-bold uppercase rounded bg-rose-100 text-rose-800 dark:bg-rose-900/50 dark:text-rose-300">
                                            KREDIT
                                        </span>
                                        <h4 class="font-bold text-gray-800 dark:text-gray-200">
                                            {{ $line->description ?: $line->transaction?->description }}
                                        </h4>
                                    </div>
                                    <p class="text-xs text-gray-500 dark:text-gray-400 mt-1 font-mono">
                                        No. Transaksi: {{ $line->transaction?->transaction_number }}
                                    </p>
                                    <p class="text-[11px] text-gray-400 dark:text-gray-500">
                                        Petugas: {{ $line->transaction?->creator?->name ?? '-' }}
                                    </p>
                                </div>
                                <div
                                    class="sm:text-right w-full sm:w-auto border-t border-gray-100 dark:border-gray-700 sm:border-t-0 pt-2 sm:pt-0">
                                    <p class="text-base font-black text-rose-600 dark:text-rose-400 font-mono">
                                        - Rp {{ number_format($line->amount, 0, ',', '.') }}
                                    </p>
                                    <p class="text-[11px] text-gray-400 dark:text-gray-500 mt-0.5">
                                        {{ $line->transaction?->transaction_date?->format('d M Y') }}
                                    </p>
                                </div>
                            </div>
                        @empty
                            <div
                                class="rounded-xl border border-dashed border-gray-200 dark:border-gray-700 p-8 text-center text-sm text-gray-400 dark:text-gray-500">
                                Belum ada aktivitas transaksi posisi kredit pada sub periode ini.
                            </div>
                        @endforelse
                    </div>

                </div>

            </div>

        </x-common.component-card>

    </div>

@endsection
