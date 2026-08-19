@extends('layouts.app')

@section('title', 'Beranda Pengguna Akuntansi')

@section('content')
    <x-common.page-breadcrumb pageTitle="Beranda Pengguna Akuntansi"
        pageDescription="Monitoring & Input Transaksi Keuangan Personal Anda" pageIcon="dashboard" />

    <div class="space-y-6">

        {{-- HERO BANNER WITH GRADIENT & REALTIME CLOCK --}}
        <div
            class="relative overflow-hidden rounded-3xl border border-blue-100/80 bg-gradient-to-br from-blue-50/80 via-indigo-50/30 to-white p-6 shadow-sm dark:border-blue-900/30 dark:bg-gradient-to-br dark:from-slate-900 dark:via-gray-900 dark:to-blue-950/40">

            {{-- AMBIENT GLOW EFFECT --}}
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
                        Portal Akuntan &bull; Periode Aktif: {{ $activePeriod->name ?? 'Belum Set' }}
                    </span>
                    <h1 class="mt-3 text-3xl font-black text-gray-900 dark:text-white tracking-tight">
                        Halo, {{ auth()->user()->name }} 👋
                    </h1>
                    <p class="mt-1 text-sm text-gray-600 dark:text-gray-300 max-w-xl leading-relaxed">
                        Kelola dan entri transaksi harian Anda, atur pemetaan kode COA terlampir, serta pantau rekapan
                        pemasukan dan pengeluaran personal secara realtime.
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

        {{-- PERSONAL SUMMARY CARDS --}}
        <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">
            {{-- TOTAL TRANSAKSI --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <span class="text-xs font-bold uppercase tracking-wider text-gray-400">Transaksi Saya</span>
                    <div class="p-2.5 bg-blue-50 text-blue-600 rounded-2xl dark:bg-blue-900/30 dark:text-blue-400">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                        </svg>
                    </div>
                </div>
                <h3 class="mt-3 text-2xl font-black text-gray-900 dark:text-white tabular-nums font-mono">
                    {{ number_format($totalTransactions, 0, ',', '.') }} <span
                        class="text-xs font-normal text-gray-400">Entri</span>
                </h3>
                <p class="mt-1 text-[11px] text-gray-400">Total Transaksi yang Anda buat</p>
            </div>

            {{-- PEMASUKAN PERSONAL --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <span
                        class="text-xs font-bold uppercase tracking-wider text-emerald-600 dark:text-emerald-400">Pemasukan
                        Saya</span>
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
                <p class="mt-1 text-[11px] text-gray-400">Akumulasi Penerimaan Kas</p>
            </div>

            {{-- PENGELUARAN PERSONAL --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <span class="text-xs font-bold uppercase tracking-wider text-rose-600 dark:text-rose-400">Pengeluaran
                        Saya</span>
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
                <p class="mt-1 text-[11px] text-gray-400">Akumulasi Pengeluaran Kas</p>
            </div>

            {{-- SALDO BERSIH PERSONAL --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <span class="text-xs font-bold uppercase tracking-wider text-purple-600 dark:text-purple-400">Saldo
                        Bersih Saya</span>
                    <div class="p-2.5 bg-purple-50 text-purple-600 rounded-2xl dark:bg-purple-900/30 dark:text-purple-400">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                </div>
                <h3
                    class="mt-3 text-2xl font-black {{ $netBalance >= 0 ? 'text-purple-600 dark:text-purple-400' : 'text-rose-600' }} tabular-nums font-mono">
                    Rp{{ number_format($netBalance, 0, ',', '.') }}
                </h3>
                <p class="mt-1 text-[11px] text-gray-400">Net Arus Kas Anda</p>
            </div>
        </div>

        {{-- PERSONAL CASH FLOW CHART & QUICK ACTIONS --}}
        <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">
            {{-- CHART: TREN TRANSAKSI USER --}}
            <div
                class="lg:col-span-2 rounded-3xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-800 dark:bg-gray-900 flex flex-col justify-between">
                <div class="flex items-center justify-between mb-4">
                    <div>
                        <h3 class="text-base font-bold text-gray-900 dark:text-white">Grafik Transaksi Anda</h3>
                        <p class="text-xs text-gray-500">Rekapitulasi Pemasukan vs Pengeluaran yang Anda Kelola per
                            Sub-Periode</p>
                    </div>
                    <span
                        class="text-xs font-bold text-blue-600 bg-blue-50 px-3 py-1 rounded-full dark:bg-blue-900/40 dark:text-blue-300">Statistik
                        Saya</span>
                </div>
                <div class="relative h-64 w-full">
                    <canvas id="userCashFlowChart"></canvas>
                </div>
            </div>

            {{-- QUICK ACTIONS & SHORTCUTS --}}
            <div
                class="rounded-3xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-800 dark:bg-gray-900 flex flex-col justify-between">
                <div>
                    <h3 class="text-base font-bold text-gray-900 dark:text-white">Aksi Cepat & Pintas</h3>
                    <p class="text-xs text-gray-500 mb-4">Akses langsung ke menu input dan laporan personal</p>

                    <div class="space-y-3">
                        <a href="{{ route('user.transactions.histories.index') }}"
                            class="group flex items-center justify-between p-3.5 rounded-2xl border border-gray-100 bg-gray-50/50 hover:bg-blue-50/60 hover:border-blue-200 dark:border-gray-800 dark:bg-gray-800/40 dark:hover:bg-blue-950/30 transition-all">
                            <div class="flex items-center gap-3">
                                <span class="text-lg">💳</span>
                                <div>
                                    <h4
                                        class="text-xs font-bold text-gray-800 dark:text-gray-200 group-hover:text-blue-600">
                                        Histori Transaksi</h4>
                                    <p class="text-[10px] text-gray-400">Kelola & Tambah Transaksi Kas</p>
                                </div>
                            </div>
                            <svg class="w-4 h-4 text-gray-400 group-hover:text-blue-600" fill="none"
                                stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                            </svg>
                        </a>

                        <a href="{{ route('user.coas.index') }}"
                            class="group flex items-center justify-between p-3.5 rounded-2xl border border-gray-100 bg-gray-50/50 hover:bg-emerald-50/60 hover:border-emerald-200 dark:border-gray-800 dark:bg-gray-800/40 dark:hover:bg-emerald-950/30 transition-all">
                            <div class="flex items-center gap-3">
                                <span class="text-lg">📚</span>
                                <div>
                                    <h4
                                        class="text-xs font-bold text-gray-800 dark:text-gray-200 group-hover:text-emerald-600">
                                        Akun COA Terlampir</h4>
                                    <p class="text-[10px] text-gray-400">Daftar Akun yang Ditugaskan</p>
                                </div>
                            </div>
                            <svg class="w-4 h-4 text-gray-400 group-hover:text-emerald-600" fill="none"
                                stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                            </svg>
                        </a>
                    </div>
                </div>

                <div class="mt-4 pt-3 border-t border-gray-100 dark:border-gray-800 text-center">
                    <p class="text-[11px] text-gray-400">
                        Seluruh entri transaksi terhubung otomatis dengan modul jurnal umum institusi.
                    </p>
                </div>
            </div>
        </div>

        {{-- MAIN DATA GRID (TRANSACTIONS, COA & JOURNALS) --}}
        <div class="grid grid-cols-1 gap-6 xl:grid-cols-2">

            {{-- TRANSAKSI SAYA TERBARU --}}
            <div
                class="overflow-hidden rounded-3xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between border-b border-gray-100 p-5 dark:border-gray-800">
                    <div>
                        <h3 class="text-base font-bold text-gray-900 dark:text-white">Transaksi Saya Terbaru</h3>
                        <p class="text-xs text-gray-500">5 entri transaksi terakhir yang Anda catat</p>
                    </div>
                    <a href="{{ route('user.transactions.histories.index') }}"
                        class="text-xs font-bold text-blue-600 dark:text-blue-400 hover:underline">
                        Lihat Semua &rarr;
                    </a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-xs text-left">
                        <thead class="bg-gray-50 text-gray-400 font-bold uppercase tracking-wider dark:bg-gray-800/50">
                            <tr>
                                <th class="px-5 py-3">Deskripsi Transaksi</th>
                                <th class="px-3 py-3">Tanggal</th>
                                <th class="px-5 py-3 text-right">Nominal</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                            @forelse ($recentTransactions as $trx)
                                <tr class="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors">
                                    <td class="px-5 py-3 font-medium text-gray-800 dark:text-gray-200">
                                        <p class="line-clamp-1">{{ $trx->description }}</p>
                                        <span class="text-[10px] text-gray-400">
                                            Jenis: {{ $trx->transaction_type->label() }}
                                        </span>
                                    </td>
                                    <td class="px-3 py-3 text-gray-500 whitespace-nowrap">
                                        {{ $trx->transaction_date->format('d/m/Y') }}
                                    </td>
                                    <td
                                        class="px-5 py-3 text-right font-mono font-bold whitespace-nowrap {{ $trx->transaction_type->value === 'INCOME' ? 'text-emerald-600' : 'text-rose-600' }}">
                                        Rp{{ number_format($trx->gross_amount, 0, ',', '.') }}
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="3" class="px-5 py-8 text-center text-gray-400">Belum ada transaksi
                                        yang dibuat.</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>

            {{-- AKUN COA SAYA --}}
            <div
                class="overflow-hidden rounded-3xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between border-b border-gray-100 p-5 dark:border-gray-800">
                    <div>
                        <h3 class="text-base font-bold text-gray-900 dark:text-white">Akun COA Diberikan</h3>
                        <p class="text-xs text-gray-500">Master akun yang diotorisasikan untuk Anda</p>
                    </div>
                    <a href="{{ route('user.coas.index') }}"
                        class="text-xs font-bold text-blue-600 dark:text-blue-400 hover:underline">
                        Lihat Semua &rarr;
                    </a>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-xs text-left">
                        <thead class="bg-gray-50 text-gray-400 font-bold uppercase tracking-wider dark:bg-gray-800/50">
                            <tr>
                                <th class="px-5 py-3">Kode & Nama Akun</th>
                                <th class="px-3 py-3">Saldo Normal</th>
                                <th class="px-5 py-3 text-right">Status</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                            @forelse ($userCoas as $coa)
                                <tr class="hover:bg-gray-50/50 dark:hover:bg-gray-800/30 transition-colors">
                                    <td class="px-5 py-3 font-medium text-gray-800 dark:text-gray-200">
                                        <span
                                            class="font-mono font-bold text-blue-600 dark:text-blue-400">{{ $coa->code }}</span>
                                        <p class="text-[11px] text-gray-500 dark:text-gray-400">{{ $coa->name }}</p>
                                    </td>
                                    <td class="px-3 py-3">
                                        <span
                                            class="inline-flex items-center px-2 py-0.5 rounded-md text-[10px] font-bold uppercase bg-gray-100 text-gray-700 dark:bg-gray-800 dark:text-gray-300">
                                            {{ $coa->normal_balance }}
                                        </span>
                                    </td>
                                    <td class="px-5 py-3 text-right">
                                        <span
                                            class="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold uppercase bg-emerald-100 text-emerald-700 dark:bg-emerald-900/40 dark:text-emerald-300">
                                            Aktif
                                        </span>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="3" class="px-5 py-8 text-center text-gray-400">Tidak ada akun COA
                                        aktif yang ditautkan ke akun Anda.</td>
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
            // Realtime Clock Update
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

            // Personal Cash Flow Chart Initialization
            const ctx = document.getElementById('userCashFlowChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: @json($chartLabels),
                    datasets: [{
                            label: 'Pemasukan Saya (Rp)',
                            data: @json($chartIncomeData),
                            backgroundColor: 'rgba(16, 185, 129, 0.85)',
                            borderRadius: 8,
                        },
                        {
                            label: 'Pengeluaran Saya (Rp)',
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
