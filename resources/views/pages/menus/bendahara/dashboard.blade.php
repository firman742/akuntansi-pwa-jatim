@extends('layouts.app')

@section('title', 'Beranda Bendahara')

@section('content')
    <x-common.page-breadcrumb pageTitle="Beranda Bendahara"
        pageDescription="Monitoring Keuangan, Visualisasi Arus Kas & Ekosistem Akuntansi" pageIcon="dashboard" />

    {{-- ALERTS --}}
    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside">
                    @foreach ($errors->all() as $error)
                        <li class="text-red-500">{{ $error }}</li>
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

    <div class="space-y-6">

        {{-- HERO BANNER --}}
        <div
            class="relative overflow-hidden rounded-3xl border border-blue-100/80 bg-gradient-to-br from-blue-50/80 via-indigo-50/30 to-white p-6 shadow-sm dark:border-blue-900/30 dark:bg-gradient-to-br dark:from-slate-900 dark:via-gray-900 dark:to-blue-950/40">

            {{-- AMBIENT GLOW EFFECT (TOP-RIGHT & BOTTOM-LEFT) --}}
            <div
                class="absolute -right-10 -top-10 h-64 w-64 rounded-full bg-gradient-to-br from-blue-400/20 to-indigo-500/20 blur-3xl dark:from-blue-600/20 dark:to-indigo-600/20 pointer-events-none">
            </div>
            <div
                class="absolute -left-10 -bottom-10 h-48 w-48 rounded-full bg-gradient-to-tr from-indigo-300/15 to-purple-400/15 blur-2xl dark:from-indigo-600/10 dark:to-purple-600/10 pointer-events-none">
            </div>

            <div class="relative z-10 flex flex-col gap-6 xl:flex-row xl:items-center xl:justify-between">
                <div>
                    <span
                        class="inline-flex items-center gap-1.5 rounded-full bg-blue-100/80 px-3 py-1 text-xs font-bold text-blue-700 dark:bg-blue-900/50 dark:text-blue-300 border border-blue-200/50 dark:border-blue-800/50">
                        <span class="w-2 h-2 rounded-full bg-blue-500 animate-pulse"></span>
                        Periode Aktif: {{ $activePeriod->name ?? 'Belum Set' }}
                    </span>
                    <h1 class="mt-3 text-3xl font-black text-gray-900 dark:text-white tracking-tight">
                        Selamat Datang, {{ auth()->user()->name }} 👋
                    </h1>
                    <p class="mt-1 text-sm text-gray-600 dark:text-gray-300 max-w-xl leading-relaxed">
                        Kelola arus kas, pantau jurnal otomatis, dan pastikan keseimbangan laporan neraca institusi dalam
                        satu panel terintegrasi.
                    </p>
                </div>

                <div class="flex flex-col sm:flex-row items-stretch gap-4">
                    {{-- REALTIME CLOCK --}}
                    <div
                        class="rounded-2xl border border-gray-200/80 bg-white/80 backdrop-blur-md px-5 py-3 text-center dark:border-gray-800 dark:bg-gray-800/60 flex flex-col justify-center shadow-xs">
                        <p class="text-[10px] font-bold uppercase tracking-wider text-gray-400">Waktu Realtime</p>
                        <h2 id="clock" class="text-xl font-black text-gray-800 dark:text-white font-mono tabular-nums">
                            00:00:00</h2>
                        <p id="date-now" class="text-xs text-gray-500 dark:text-gray-400 mt-0.5"></p>
                    </div>

                    {{-- SUB-PERIOD FILTER --}}
                    <form method="GET"
                        class="rounded-2xl border border-gray-200/80 bg-white/80 backdrop-blur-md p-3 shadow-xs dark:border-gray-800 dark:bg-gray-800/60 flex flex-col justify-center min-w-[200px]">
                        <label class="mb-1 block text-[10px] font-bold uppercase tracking-wider text-gray-400">Filter Sub
                            Periode</label>
                        <select name="sub_period_id" onchange="this.form.submit()"
                            class="w-full h-9 rounded-xl border border-gray-200 bg-gray-50/80 px-3 text-xs font-semibold text-gray-700 outline-none transition focus:border-blue-500 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-200">
                            <option value="">Semua Sub Periode</option>
                            @foreach ($subPeriods as $subPeriod)
                                <option value="{{ $subPeriod->id }}" @selected($selectedSubPeriodId == $subPeriod->id)>
                                    {{ $subPeriod->name }}
                                </option>
                            @endforeach
                        </select>
                    </form>
                </div>
            </div>
        </div>

        {{-- DISMISSIBLE CLOSING REMINDER WARNING --}}
        @if ($closingReminder)
            <div x-data="{ showWarning: true, collapsed: false }" x-show="showWarning" x-transition
                class="overflow-hidden rounded-3xl border transition-all shadow-sm
                {{ $closingStatus == 'expired'
                    ? 'border-rose-200 bg-rose-50/70 dark:border-rose-900/50 dark:bg-rose-950/20'
                    : ($closingStatus == 'today'
                        ? 'border-amber-200 bg-amber-50/70 dark:border-amber-900/50 dark:bg-amber-950/20'
                        : 'border-blue-200 bg-blue-50/70 dark:border-blue-900/50 dark:bg-blue-950/20') }}">

                {{-- REMINDER HEADER --}}
                <div class="px-6 py-4 border-b border-black/5 dark:border-white/5 flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <span class="flex h-3 w-3 relative">
                            <span
                                class="animate-ping absolute inline-flex h-full w-full rounded-full {{ $closingStatus == 'expired' ? 'bg-rose-400' : 'bg-amber-400' }} opacity-75"></span>
                            <span
                                class="relative inline-flex rounded-full h-3 w-3 {{ $closingStatus == 'expired' ? 'bg-rose-500' : 'bg-amber-500' }}"></span>
                        </span>
                        <h3 class="font-bold text-sm text-gray-900 dark:text-white">
                            @switch($closingStatus)
                                @case('expired')
                                    Peringatan: Penutupan Sub Periode Tertunda
                                @break

                                @case('today')
                                    Hari Terakhir Penutupan Sub Periode
                                @break

                                @default
                                    Reminder Jadwal Penutupan Sub Periode
                            @endswitch
                            — <span class="underline decoration-dotted">{{ $closingReminder->name }}</span>
                        </h3>
                    </div>

                    <div class="flex items-center gap-2">
                        <button @click="collapsed = !collapsed"
                            class="text-xs font-semibold text-gray-500 hover:text-gray-700 dark:text-gray-400 px-2 py-1 rounded-lg border border-black/10 dark:border-white/10 bg-white/50 dark:bg-gray-800/50">
                            <span x-text="collapsed ? 'Tampilkan Detail' : 'Sembunyikan Detail'"></span>
                        </button>
                        <button @click="showWarning = false"
                            class="text-gray-400 hover:text-gray-600 dark:hover:text-gray-200 p-1">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                </div>

                {{-- REMINDER BODY --}}
                <div x-show="!collapsed" x-collapse class="p-6 grid gap-6 lg:grid-cols-2">
                    <div>
                        <h4 class="text-xs font-bold uppercase tracking-wider text-gray-500 mb-3">Checklist Persyaratan
                            Penutupan</h4>
                        <div class="space-y-2">
                            @foreach ($closingChecks as $check)
                                <div
                                    class="flex items-center gap-3 p-2.5 rounded-xl border border-gray-200/60 bg-white dark:border-gray-800 dark:bg-gray-800/80">
                                    <span
                                        class="flex h-5 w-5 items-center justify-center rounded-full text-xs font-bold {{ $check['passed'] ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/50 dark:text-emerald-300' : 'bg-rose-100 text-rose-700 dark:bg-rose-900/50 dark:text-rose-300' }}">
                                        {{ $check['passed'] ? '✓' : '✕' }}
                                    </span>
                                    <span
                                        class="text-xs font-medium text-gray-700 dark:text-gray-300">{{ $check['label'] }}</span>
                                </div>
                            @endforeach
                        </div>
                    </div>

                    <div
                        class="flex flex-col justify-between rounded-2xl border border-amber-200/80 bg-amber-100/40 p-5 dark:border-amber-900/40 dark:bg-amber-900/10">
                        <div>
                            <h4 class="font-bold text-amber-900 dark:text-amber-300 text-sm flex items-center gap-1.5">
                                <span>⚠️</span> Konsekuensi Penutupan Periode
                            </h4>
                            <p class="mt-2 text-xs leading-relaxed text-amber-800 dark:text-amber-200/80">
                                Setelah ditutup, seluruh jurnal & transaksi pada sub-periode ini akan **dikunci mutlak**.
                                Anda tidak akan dapat menambah, mengubah, atau menghapus entri data transaksi.
                            </p>
                        </div>
                        <div class="mt-4 flex justify-end">
                            <a href="{{ route('bendahara.sub-periods.index') }}">
                                <x-ui.button variant="danger" class="rounded-xl text-xs py-2 px-4 shadow-sm">
                                    🔒 Proses Penutupan Sub Periode
                                </x-ui.button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        @endif

        {{-- SUMMARY METRICS GRID --}}
        <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">
            {{-- SALDO KAS --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <span class="text-xs font-bold uppercase tracking-wider text-gray-400">Total Saldo Kas</span>
                    <div class="p-2.5 bg-blue-50 text-blue-600 rounded-2xl dark:bg-blue-900/30 dark:text-blue-400">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                </div>
                <h3 class="mt-3 text-2xl font-black text-gray-900 dark:text-white tabular-nums font-mono">
                    Rp{{ number_format($totalCashBalance, 0, ',', '.') }}
                </h3>
                <p class="mt-1 text-[11px] text-gray-400">Termasuk Saldo Awal:
                    Rp{{ number_format($totalOpeningBalance, 0, ',', '.') }}</p>
            </div>

            {{-- PENERIMAAN --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <span class="text-xs font-bold uppercase tracking-wider text-emerald-600 dark:text-emerald-400">Total
                        Penerimaan</span>
                    <div
                        class="p-2.5 bg-emerald-50 text-emerald-600 rounded-2xl dark:bg-emerald-900/30 dark:text-emerald-400">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M7 11l5-5m0 0l5 5m-5-5v12" />
                        </svg>
                    </div>
                </div>
                <h3 class="mt-3 text-2xl font-black text-emerald-600 dark:text-emerald-400 tabular-nums font-mono">
                    Rp{{ number_format($totalIncome, 0, ',', '.') }}
                </h3>
                <p class="mt-1 text-[11px] text-gray-400">Total Arus Masuk</p>
            </div>

            {{-- PENGELUARAN --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <span class="text-xs font-bold uppercase tracking-wider text-rose-600 dark:text-rose-400">Total
                        Pengeluaran</span>
                    <div class="p-2.5 bg-rose-50 text-rose-600 rounded-2xl dark:bg-rose-900/30 dark:text-rose-400">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M17 13l-5 5m0 0l-5-5m5 5V6" />
                        </svg>
                    </div>
                </div>
                <h3 class="mt-3 text-2xl font-black text-rose-600 dark:text-rose-400 tabular-nums font-mono">
                    Rp{{ number_format($totalExpense, 0, ',', '.') }}
                </h3>
                <p class="mt-1 text-[11px] text-gray-400">Total Arus Keluar</p>
            </div>

            {{-- SURPLUS / DEFISIT BERJALAN --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <span class="text-xs font-bold uppercase tracking-wider text-purple-600 dark:text-purple-400">Surplus /
                        Defisit</span>
                    <div class="p-2.5 bg-purple-50 text-purple-600 rounded-2xl dark:bg-purple-900/30 dark:text-purple-400">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                        </svg>
                    </div>
                </div>
                <h3
                    class="mt-3 text-2xl font-black {{ $netBalance >= 0 ? 'text-purple-600 dark:text-purple-400' : 'text-rose-600' }} tabular-nums font-mono">
                    Rp{{ number_format($netBalance, 0, ',', '.') }}
                </h3>
                <p class="mt-1 text-[11px] text-gray-400">Penerimaan dikurangi Pengeluaran</p>
            </div>
        </div>

        {{-- DIAGRAM TREN ARUS KAS & QUICK LAPORAN AKUNTANSI --}}
        <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">
            {{-- CHART: TREN ARUS KAS --}}
            <div
                class="lg:col-span-2 rounded-3xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-800 dark:bg-gray-900 flex flex-col justify-between">
                <div class="flex items-center justify-between mb-4">
                    <div>
                        <h3 class="text-base font-bold text-gray-900 dark:text-white">Grafik Tren Arus Kas</h3>
                        <p class="text-xs text-gray-500">Perbandingan Penerimaan dan Pengeluaran per Sub Periode</p>
                    </div>
                    <span
                        class="text-xs font-bold text-blue-600 bg-blue-50 px-3 py-1 rounded-full dark:bg-blue-900/40 dark:text-blue-300">Visual
                        Realtime</span>
                </div>
                <div class="relative h-64 w-full">
                    <canvas id="cashFlowChart"></canvas>
                </div>
            </div>

            {{-- QUICK ACCESIBILTY TO FINANCIAL REPORTS --}}
            <div
                class="rounded-3xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-800 dark:bg-gray-900 flex flex-col justify-between">
                <div>
                    <h3 class="text-base font-bold text-gray-900 dark:text-white">Akses Laporan Utama</h3>
                    <p class="text-xs text-gray-500 mb-4">Pintas cepat menuju laporan akuntansi standar</p>

                    <div class="space-y-3">
                        <a href="{{ route('bendahara.reports.journal.index') }}"
                            class="group flex items-center justify-between p-3.5 rounded-2xl border border-gray-100 bg-gray-50/50 hover:bg-emerald-50/60 hover:border-emerald-200 dark:border-gray-800 dark:bg-gray-800/40 dark:hover:bg-emerald-950/30 transition-all">
                            <div class="flex items-center gap-3">
                                <span class="text-lg text-emerald-600">
                                    <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24"
                                        height="24" fill="none" viewBox="0 0 24 24">
                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                            stroke-width="2"
                                            d="M19 6c0 1.657-3.134 3-7 3S5 7.657 5 6m14 0c0-1.657-3.134-3-7-3S5 4.343 5 6m14 0v6M5 6v6m0 0c0 1.657 3.134 3 7 3s7-1.343 7-3M5 12v6c0 1.657 3.134 3 7 3s7-1.343 7-3v-6" />
                                    </svg>
                                </span>
                                <div>
                                    <h4
                                        class="text-xs font-bold text-gray-800 dark:text-gray-200 group-hover:text-emerald-600">
                                        Jurnal Umum</h4>
                                    <p class="text-[10px] text-gray-400">Histori Posting Transaksi</p>
                                </div>
                            </div>
                            <svg class="w-4 h-4 text-gray-400 group-hover:text-emerald-600" fill="none"
                                stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                            </svg>
                        </a>

                        <a href="{{ route('bendahara.reports.ledger.index') }}"
                            class="group flex items-center justify-between p-3.5 rounded-2xl border border-gray-100 bg-gray-50/50 hover:bg-purple-50/60 hover:border-purple-200 dark:border-gray-800 dark:bg-gray-800/40 dark:hover:bg-purple-950/30 transition-all">
                            <div class="flex items-center gap-3">
                                <span class="text-lg text-purple-600">
                                    <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24"
                                        height="24" fill="none" viewBox="0 0 24 24">
                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                            stroke-width="2"
                                            d="M18 5V4a1 1 0 0 0-1-1H8.914a1 1 0 0 0-.707.293L4.293 7.207A1 1 0 0 0 4 7.914V20a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-5M9 3v4a1 1 0 0 1-1 1H4m11.383.772 2.745 2.746m1.215-3.906a2.089 2.089 0 0 1 0 2.953l-6.65 6.646L9 17.95l.739-3.692 6.646-6.646a2.087 2.087 0 0 1 2.958 0Z" />
                                    </svg>
                                </span>
                                <div>
                                    <h4
                                        class="text-xs font-bold text-gray-800 dark:text-gray-200 group-hover:text-purple-600">
                                        Buku Besar (Ledger)</h4>
                                    <p class="text-[10px] text-gray-400">Mutasi & Saldo per Akun</p>
                                </div>
                            </div>
                            <svg class="w-4 h-4 text-gray-400 group-hover:text-purple-600" fill="none"
                                stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                            </svg>
                        </a>

                        <a href="{{ route('bendahara.reports.trial-balance.index') }}"
                            class="group flex items-center justify-between p-3.5 rounded-2xl border border-gray-100 bg-gray-50/50 hover:bg-blue-50/60 hover:border-blue-200 dark:border-gray-800 dark:bg-gray-800/40 dark:hover:bg-blue-950/30 transition-all">
                            <div class="flex items-center gap-3">
                                <span class="text-lg text-blue-600">
                                    <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24"
                                        height="24" fill="none" viewBox="0 0 24 24">
                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                            stroke-width="2"
                                            d="M5.5 21h13M12 21V7m0 0a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm2-1.8c3.073.661 2.467 2.8 5 2.8M5 8c3.359 0 2.192-2.115 5.012-2.793M7 9.556V7.75m0 1.806-1.95 4.393a.773.773 0 0 0 .37.962.785.785 0 0 0 .362.089h2.436a.785.785 0 0 0 .643-.335.776.776 0 0 0 .09-.716L7 9.556Zm10 0V7.313m0 2.243-1.95 4.393a.773.773 0 0 0 .37.962.786.786 0 0 0 .362.089h2.436a.785.785 0 0 0 .643-.335.775.775 0 0 0 .09-.716L17 9.556Z" />
                                    </svg>
                                </span>
                                <div>
                                    <h4
                                        class="text-xs font-bold text-gray-800 dark:text-gray-200 group-hover:text-blue-600">
                                        Laporan Neraca</h4>
                                    <p class="text-[10px] text-gray-400">Aset, Kewajiban & Ekuitas</p>
                                </div>
                            </div>
                            <svg class="w-4 h-4 text-gray-400 group-hover:text-blue-600" fill="none"
                                stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                            </svg>
                        </a>
                    </div>
                </div>

                <div class="mt-4 pt-3 border-t border-gray-100 dark:border-gray-800 text-center">
                    <a href="#"
                        class="text-xs font-bold text-blue-600 dark:text-blue-400 hover:underline inline-flex items-center gap-1">
                        {{-- svg book --}}
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 20h9M12 4h9m-9 8h9M3 6h.01M3 10h.01M3 14h.01M3 18h.01M3 6a2 2 0 012-2h1a2 2 0 012 2v12a2 2 0 01-2 2H5a2 2 0 01-2-2V6z" />
                        </svg>
                        Lihat Buku Panduan Akuntansi Kompleks &rarr;
                    </a>
                </div>
            </div>
        </div>

        {{-- RESTRUCTURED ACCOUNTING WORKFLOW --}}
        <div class="rounded-3xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-800 dark:bg-gray-900">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3 mb-6">
                <div>
                    <h3 class="text-base font-bold text-gray-900 dark:text-white">Siklus & Workflow Akuntansi</h3>
                    <p class="text-xs text-gray-500">Urutan proses pencatatan standar untuk menjaga integritas data
                        keuangan</p>
                </div>
                <span
                    class="text-xs font-bold bg-gray-100 text-gray-600 px-3 py-1 rounded-full dark:bg-gray-800 dark:text-gray-300 w-fit">
                    Standar Akuntansi Siklus Terutup
                </span>
            </div>

            @php
                $actualFlows = [
                    [
                        'step' => '01',
                        'title' => 'Setup COA & Saldo Awal',
                        'desc' => 'Struktur akun & entri saldo awal periode.',
                        'icon' =>
                            '<svg class="w-5 h-5 text-emerald-600 dark:text-emerald-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/></svg>',
                    ],
                    [
                        'step' => '02',
                        'title' => 'Input Transaksi Kas',
                        'desc' => 'Pencatatan penerimaan & pengeluaran.',
                        'icon' =>
                            '<svg class="w-5 h-5 text-blue-600 dark:text-blue-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a2 2 0 002-2V7a2 2 0 00-2-2H6a2 2 0 00-2 2v10a2 2 0 002 2z"/></svg>',
                    ],
                    [
                        'step' => '03',
                        'title' => 'Posting Jurnal Otomatis',
                        'desc' => 'Pembentukan entri debit & kredit.',
                        'icon' =>
                            '<svg class="w-5 h-5 text-yellow-600 dark:text-yellow-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/></svg>',
                    ],
                    [
                        'step' => '04',
                        'title' => 'Buku Besar (Ledger)',
                        'desc' => 'Akumulasi mutasi per kode akun.',
                        'icon' =>
                            '<svg class="w-5 h-5 text-green-600 dark:text-green-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 ２h-２a２ ２ ０ ０１-２-２z"/></svg>',
                    ],
                    [
                        'step' => '05',
                        'title' => 'Laporan Neraca Saldo',
                        'desc' => 'Validasi kesetaraan debit & kredit.',
                        'icon' =>
                            '<svg class="w-5 h-5 text-purple-600 dark:text-purple-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v18m0-18L4 7m8-4l8 4M4 7l3 6m-3-6h6m8 0l3 6m-3-6h6M7 13a3 3 0 100 6 3 3 0 000-6zm10 0a3 3 0 100 6 3 3 0 000-6z"/></svg>',
                    ],
                    [
                        'step' => '06',
                        'title' => 'Penutupan Sub Periode',
                        'desc' => 'Kunci transaksi & isolasi saldo.',
                        'icon' =>
                            '<svg class="w-5 h-5 text-yellow-600 dark:text-yellow-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 002-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/></svg>',
                    ],
                ];
            @endphp

            <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6">
                @foreach ($actualFlows as $flow)
                    <div
                        class="relative flex flex-col justify-between rounded-2xl border border-gray-100 bg-gray-50/60 p-4 dark:border-gray-800 dark:bg-gray-800/40 hover:border-blue-300 transition-all">
                        <div>
                            <div class="flex items-center justify-between mb-2">
                                <div class="p-1.5 rounded-lg bg-gray-100 dark:bg-gray-700/50">
                                    {!! $flow['icon'] !!}
                                </div>
                                <span
                                    class="text-[10px] font-black text-blue-600 bg-blue-100 px-2 py-0.5 rounded-md dark:bg-blue-900/50 dark:text-blue-300">
                                    {{ $flow['step'] }}
                                </span>
                            </div>
                            <h4 class="text-xs font-bold text-gray-800 dark:text-gray-200 mb-1">{{ $flow['title'] }}</h4>
                            <p class="text-[11px] text-gray-400 leading-snug">{{ $flow['desc'] }}</p>
                        </div>
                    </div>
                @endforeach
            </div>
        </div>

        {{-- RECENT RECOGNITIONS (TRANSACTIONS & JOURNALS) --}}
        <div class="grid grid-cols-1 gap-6 lg:grid-cols-2">

            {{-- TRANSAKSI TERBARU --}}
            <div
                class="overflow-hidden rounded-3xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between border-b border-gray-100 p-5 dark:border-gray-800">
                    <div>
                        <h3 class="text-base font-bold text-gray-900 dark:text-white">Transaksi Kas Terbaru</h3>
                        <p class="text-xs text-gray-500">5 entri penerimaan/pengeluaran terakhir</p>
                    </div>
                    <a href="{{ route('bendahara.reports.transactions.index') }}"
                        class="text-xs font-bold text-blue-600 dark:text-blue-400 hover:underline">
                        Lihat Semua &rarr;
                    </a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-xs text-left">
                        <thead class="bg-gray-50 text-gray-400 font-bold uppercase tracking-wider dark:bg-gray-800/50">
                            <tr>
                                <th class="px-5 py-3">Deskripsi</th>
                                <th class="px-3 py-3">Tanggal</th>
                                <th class="px-5 py-3 text-right">Nominal</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                            @forelse ($recentTransactions as $trx)
                                <tr class="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors">
                                    <td class="px-5 py-3 font-medium text-gray-800 dark:text-gray-200">
                                        <p class="line-clamp-1">{{ $trx->description }}</p>
                                        <span class="text-[10px] text-gray-400">By:
                                            {{ $trx->creator->name ?? '-' }}</span>
                                    </td>
                                    <td class="px-3 py-3 text-gray-500 whitespace-nowrap">
                                        {{ $trx->transaction_date->format('d/m/Y') }}</td>
                                    <td
                                        class="px-5 py-3 text-right font-mono font-bold whitespace-nowrap {{ $trx->transaction_type === 'INCOME' ? 'text-emerald-600' : 'text-rose-600' }}">
                                        Rp{{ number_format($trx->gross_amount, 0, ',', '.') }}
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="3" class="px-5 py-8 text-center text-gray-400">Belum ada data
                                        transaksi.</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>

            {{-- JURNAL TERBARU --}}
            <div
                class="overflow-hidden rounded-3xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between border-b border-gray-100 p-5 dark:border-gray-800">
                    <div>
                        <h3 class="text-base font-bold text-gray-900 dark:text-white">Jurnal Diposting Terbaru</h3>
                        <p class="text-xs text-gray-500">5 nomor jurnal otomatis terakhir</p>
                    </div>
                    <a href="{{ route('bendahara.reports.journal.index') }}"
                        class="text-xs font-bold text-blue-600 dark:text-blue-400 hover:underline">
                        Lihat Semua &rarr;
                    </a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-xs text-left">
                        <thead class="bg-gray-50 text-gray-400 font-bold uppercase tracking-wider dark:bg-gray-800/50">
                            <tr>
                                <th class="px-5 py-3">No. Jurnal</th>
                                <th class="px-3 py-3">Waktu Posting</th>
                                <th class="px-5 py-3 text-right">Status</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                            @forelse ($recentJournals as $jrn)
                                <tr class="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors">
                                    <td class="px-5 py-3 font-mono font-bold text-blue-600 dark:text-blue-400">
                                        {{ $jrn->journal_number }}
                                        <p class="text-[10px] text-gray-400 font-sans font-normal">Oleh:
                                            {{ $jrn->postedBy->name ?? '-' }}</p>
                                    </td>
                                    <td class="px-3 py-3 text-gray-500 whitespace-nowrap">
                                        {{ $jrn->created_at->format('d/m/Y H:i') }}</td>
                                    <td class="px-5 py-3 text-right">
                                        <span
                                            class="inline-flex items-center px-2 py-0.5 rounded-md text-[10px] font-bold uppercase bg-blue-100 text-blue-700 dark:bg-blue-900/40 dark:text-blue-300">
                                            Posted
                                        </span>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="3" class="px-5 py-8 text-center text-gray-400">Belum ada jurnal
                                        diposting.</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

    </div>
@endsection

@push('scripts')
    {{-- CHART.JS INTEGRATION --}}
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Realtime Clock
            function updateClock() {
                const now = new Date();
                document.getElementById('clock').innerHTML = now.toLocaleTimeString('id-ID');
                document.getElementById('date-now').innerHTML = now.toLocaleDateString('id-ID', {
                    weekday: 'long',
                    year: 'numeric',
                    month: 'short',
                    day: 'numeric'
                });
            }
            setInterval(updateClock, 1000);
            updateClock();

            // Cash Flow Chart initialization
            const ctx = document.getElementById('cashFlowChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: @json($chartLabels),
                    datasets: [{
                            label: 'Penerimaan (Rp)',
                            data: @json($chartIncomeData),
                            backgroundColor: 'rgba(16, 185, 129, 0.85)',
                            borderRadius: 8,
                        },
                        {
                            label: 'Pengeluaran (Rp)',
                            data: @json($chartExpenseData),
                            backgroundColor: 'rgba(244, 63, 94, 0.85)',
                            borderRadius: 8,
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                boxWidth: 12,
                                font: {
                                    size: 11
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(156, 163, 175, 0.1)'
                            },
                            ticks: {
                                font: {
                                    size: 10
                                },
                                callback: function(value) {
                                    return 'Rp' + (value / 1000).toLocaleString() + 'k';
                                }
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                font: {
                                    size: 10
                                }
                            }
                        }
                    }
                }
            });
        });
    </script>
@endpush
