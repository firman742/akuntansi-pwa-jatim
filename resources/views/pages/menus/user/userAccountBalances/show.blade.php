@extends('layouts.app')

@section('title', 'Detail Saldo Pengguna')

@section('content')
    <x-common.page-breadcrumb pageTitle="Detail Saldo Pengguna" />

    @php
        $allocated = (float) ($userAccountBalance->allocated_balance ?? 0);
        $income = (float) ($userAccountBalance->income_balance ?? 0);
        $used = (float) ($userAccountBalance->used_balance ?? 0);
        $remaining = (float) ($userAccountBalance->remaining_balance ?? 0);

        $totalAvailable = $allocated + $income;
        $percentage = $totalAvailable > 0 ? min(100, round(($used / $totalAvailable) * 100, 1)) : 0;
    @endphp

    <div class="space-y-6">

        {{-- Header Card --}}
        <div class="bg-white dark:bg-gray-800 rounded-2xl border border-gray-100 dark:border-gray-700/60 p-6 shadow-sm">
            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                <div class="flex items-center gap-4">
                    <div class="p-3 bg-blue-50 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 rounded-xl">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M3 10h18M7 15h1m4 0h1m-7 4h12a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
                        </svg>
                    </div>
                    <div>
                        <div class="flex items-center gap-2">
                            <h1 class="text-xl font-bold text-gray-900 dark:text-white">
                                {{ $userAccountBalance->coaBalance->chartOfAccount->name }}
                            </h1>
                            <span
                                class="px-2.5 py-0.5 text-xs font-mono font-semibold text-blue-700 bg-blue-100 dark:bg-blue-900/50 dark:text-blue-300 rounded-full">
                                {{ $userAccountBalance->coaBalance->chartOfAccount->code }}
                            </span>
                        </div>
                        <p class="mt-0.5 text-sm text-gray-500 dark:text-gray-400">
                            Sub Periode: <span
                                class="font-medium text-gray-700 dark:text-gray-300">{{ $userAccountBalance->subPeriod?->name ?? '-' }}</span>
                        </p>
                    </div>
                </div>

                <a href="{{ route('user.user-account-balances.index') }}"
                    class="inline-flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 text-sm font-medium text-gray-700 dark:text-gray-200 hover:bg-gray-50 dark:hover:bg-gray-700 transition shadow-sm">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                    Kembali
                </a>
            </div>
        </div>

        {{-- Top KPI Stat Cards (4 Cards + Subtext Info) --}}
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">

            {{-- 1. Alokasi Awal --}}
            <div class="bg-white dark:bg-gray-800 border border-gray-100 dark:border-gray-700/60 rounded-2xl p-5 shadow-sm">
                <div class="flex items-center justify-between">
                    <span class="text-xs font-semibold uppercase tracking-wider text-gray-400">Alokasi Awal (Pagu)</span>
                    <span class="p-2 bg-blue-50 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 rounded-lg">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </span>
                </div>
                <h3 class="mt-3 text-2xl font-extrabold text-gray-900 dark:text-white">
                    Rp {{ number_format($allocated, 0, ',', '.') }}
                </h3>
                <p class="text-[11px] text-gray-400 mt-2">Batas pagu awal periode</p>
            </div>

            {{-- 2. Total Penerimaan --}}
            <div class="bg-white dark:bg-gray-800 border border-gray-100 dark:border-gray-700/60 rounded-2xl p-5 shadow-sm">
                <div class="flex items-center justify-between">
                    <span class="text-xs font-semibold uppercase tracking-wider text-gray-400">Total Penerimaan</span>
                    <span
                        class="p-2 bg-emerald-50 dark:bg-emerald-900/30 text-emerald-600 dark:text-emerald-400 rounded-lg">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M7 11l5-5m0 0l5 5m-5-5v12" />
                        </svg>
                    </span>
                </div>
                <h3 class="mt-3 text-2xl font-extrabold text-emerald-600 dark:text-emerald-400">
                    + Rp {{ number_format($income, 0, ',', '.') }}
                </h3>
                <p class="text-[11px] text-gray-400 mt-2">Dana penerimaan kas masuk</p>
            </div>

            {{-- 3. Total Pengeluaran --}}
            <div class="bg-white dark:bg-gray-800 border border-gray-100 dark:border-gray-700/60 rounded-2xl p-5 shadow-sm">
                <div class="flex items-center justify-between">
                    <span class="text-xs font-semibold uppercase tracking-wider text-gray-400">Total Pengeluaran</span>
                    <span class="p-2 bg-rose-50 dark:bg-rose-900/30 text-rose-600 dark:text-rose-400 rounded-lg">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M17 13l-5 5m0 0l-5-5m5 5V6" />
                        </svg>
                    </span>
                </div>
                <h3 class="mt-3 text-2xl font-extrabold text-rose-600 dark:text-rose-400">
                    - Rp {{ number_format($used, 0, ',', '.') }}
                </h3>
                <p class="text-[11px] text-gray-400 mt-2">Belanja/pengeluaran kas</p>
            </div>

            {{-- 4. Sisa Saldo Tersedia --}}
            <div class="bg-white dark:bg-gray-800 border border-gray-100 dark:border-gray-700/60 rounded-2xl p-5 shadow-sm">
                <div class="flex items-center justify-between">
                    <span class="text-xs font-semibold uppercase tracking-wider text-gray-400">Sisa Saldo Tersedia</span>
                    <span class="p-2 bg-teal-50 dark:bg-teal-900/30 text-teal-600 dark:text-teal-400 rounded-lg">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </span>
                </div>
                <h3 class="mt-3 text-2xl font-extrabold text-teal-700 dark:text-teal-400">
                    Rp {{ number_format($remaining, 0, ',', '.') }}
                </h3>
                <p class="text-[11px] text-gray-400 mt-2">Saldo aktif siap transaksi</p>
            </div>

        </div>

        {{-- Visualisation & Metadata Section --}}
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

            {{-- Diagram Statistik (Donut Chart & Bar Indicator) --}}
            <div
                class="bg-white dark:bg-gray-800 border border-gray-100 dark:border-gray-700/60 rounded-2xl p-6 shadow-sm flex flex-col justify-between">
                <div>
                    <h2 class="text-base font-bold text-gray-900 dark:text-white mb-1">
                        Analisis Alokasi Saldo
                    </h2>
                    <p class="text-xs text-gray-500 dark:text-gray-400">
                        Perbandingan saldo terpakai vs sisa anggaran dari total ketersediaan dana (Alokasi + Penerimaan)
                    </p>
                </div>

                {{-- Container Chart --}}
                <div class="my-4 flex justify-center items-center relative min-h-[220px]">
                    <div id="balanceDonutChart" class="w-full"></div>
                </div>

                {{-- Progress Bar Integrasi --}}
                <div class="space-y-2 border-t border-gray-100 dark:border-gray-700/60 pt-4">
                    <div class="flex justify-between text-xs font-semibold">
                        <span class="text-gray-500 dark:text-gray-400">Tingkat Penggunaan</span>
                        <span class="{{ $percentage >= 85 ? 'text-red-500' : 'text-gray-700 dark:text-gray-300' }}">
                            {{ $percentage }}% / 100%
                        </span>
                    </div>
                    <div class="w-full h-2.5 bg-gray-100 dark:bg-gray-700 rounded-full overflow-hidden">
                        <div class="h-full rounded-full transition-all duration-700 {{ $percentage >= 85 ? 'bg-red-500' : ($percentage >= 50 ? 'bg-amber-500' : 'bg-emerald-500') }}"
                            style="width: {{ $percentage }}%">
                        </div>
                    </div>
                </div>
            </div>

            {{-- Detail Informasi Grid (Akun & Alokasi) --}}
            <div class="lg:col-span-2 grid grid-cols-1 md:grid-cols-2 gap-6">

                {{-- Informasi Akun --}}
                <div
                    class="bg-white dark:bg-gray-800 border border-gray-100 dark:border-gray-700/60 rounded-2xl p-6 shadow-sm space-y-4">
                    <div class="flex items-center gap-2 border-b border-gray-100 dark:border-gray-700/60 pb-3">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                        </svg>
                        <h2 class="font-bold text-gray-900 dark:text-white">Informasi Akun</h2>
                    </div>

                    <div class="space-y-3.5 text-sm">
                        <div>
                            <p class="text-xs uppercase tracking-wider text-gray-400 font-medium">Kode Akun (COA)</p>
                            <p class="font-semibold text-gray-900 dark:text-white mt-0.5">
                                {{ $userAccountBalance->coaBalance->chartOfAccount->code }}
                            </p>
                        </div>

                        <div>
                            <p class="text-xs uppercase tracking-wider text-gray-400 font-medium">Nama Akun</p>
                            <p class="font-semibold text-gray-900 dark:text-white mt-0.5">
                                {{ $userAccountBalance->coaBalance->chartOfAccount->name }}
                            </p>
                        </div>

                        <div>
                            <p class="text-xs uppercase tracking-wider text-gray-400 font-medium">Sub Periode</p>
                            <p class="font-semibold text-gray-900 dark:text-white mt-0.5">
                                {{ $userAccountBalance->subPeriod?->name ?? '-' }}
                            </p>
                        </div>
                    </div>
                </div>

                {{-- Informasi Alokasi & Rekapitulasi --}}
                <div
                    class="bg-white dark:bg-gray-800 border border-gray-100 dark:border-gray-700/60 rounded-2xl p-6 shadow-sm space-y-4">
                    <div class="flex items-center gap-2 border-b border-gray-100 dark:border-gray-700/60 pb-3">
                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 7h6m0 10v-3m-3 3h.01M9 17h.01M9 14h.01M12 14h.01M15 11h.01M12 11h.01M9 11h.01M7 21h10a2 2 0 002-2V5a2 2 0 00-2-2H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
                        </svg>
                        <h2 class="font-bold text-gray-900 dark:text-white">Rekapitulasi Dana</h2>
                    </div>

                    <div class="space-y-3.5 text-sm">
                        <div>
                            <p class="text-xs uppercase tracking-wider text-gray-400 font-medium">Total Dana Kelolaan</p>
                            <p class="font-semibold text-blue-700 dark:text-blue-400 mt-0.5">
                                Rp {{ number_format($totalAvailable, 0, ',', '.') }}
                                <span class="text-[11px] font-normal text-gray-400">(Alokasi + Penerimaan)</span>
                            </p>
                        </div>

                        <div>
                            <p class="text-xs uppercase tracking-wider text-gray-400 font-medium">Dialokasikan Oleh</p>
                            <p class="font-semibold text-gray-900 dark:text-white mt-0.5">
                                {{ $userAccountBalance->allocatedBy?->name ?? 'Sistem' }}
                            </p>
                        </div>

                        <div>
                            <p class="text-xs uppercase tracking-wider text-gray-400 font-medium">Tanggal Alokasi</p>
                            <p class="font-semibold text-gray-900 dark:text-white mt-0.5">
                                {{ optional($userAccountBalance->allocated_at)->format('d M Y, H:i') ?? '-' }}
                            </p>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        {{-- Daftar Transaksi Terkait --}}
        <div
            class="bg-white dark:bg-gray-800 border border-gray-100 dark:border-gray-700/60 rounded-2xl shadow-sm overflow-hidden">
            <div
                class="px-6 py-5 border-b border-gray-100 dark:border-gray-700/60 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div>
                    <h2 class="font-bold text-gray-900 dark:text-white text-base">
                        Daftar Transaksi Terkait
                    </h2>
                    <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
                        Riwayat transaksi pengeluaran dan penerimaan pada akun kas ini
                    </p>
                </div>
                <span
                    class="px-3 py-1 text-xs font-semibold text-gray-600 dark:text-gray-300 bg-gray-100 dark:bg-gray-700 rounded-full self-start sm:self-auto">
                    Total: {{ $transactions->total() }} Transaksi
                </span>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse text-sm">
                    <thead>
                        <tr
                            class="bg-gray-50/50 dark:bg-gray-700/40 text-xs font-semibold uppercase text-gray-500 dark:text-gray-400 border-b border-gray-100 dark:border-gray-700/60">
                            <th class="px-6 py-3.5">No. Transaksi</th>
                            <th class="px-6 py-3.5">Tanggal</th>
                            <th class="px-6 py-3.5">Tipe</th>
                            <th class="px-6 py-3.5">Deskripsi</th>
                            <th class="px-6 py-3.5 text-right">Nominal</th>
                            <th class="px-6 py-3.5 text-center">Status</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100 dark:divide-gray-700/60 text-gray-700 dark:text-gray-300">
                        @forelse($transactions as $trx)
                            @php
                                $type = is_object($trx->transaction_type)
                                    ? $trx->transaction_type->value
                                    : $trx->transaction_type;
                                $line = $trx->transactionLines->first();
                                $amount = $line?->amount ?? ($trx->net_amount ?? 0);

                                $linkDetail =
                                    $type === 'EXPENSE'
                                        ? route('user.transactions.expenses.show', $trx->id)
                                        : route('user.transactions.incomes.show', $trx->id);
                            @endphp
                            <tr class="hover:bg-gray-50/80 dark:hover:bg-gray-700/30 transition">
                                <td class="px-6 py-4 font-mono text-xs font-semibold text-blue-600 dark:text-blue-400">
                                    <a href="{{ $linkDetail }}" title="Lihat Detail Transaksi"
                                        class="hover:underline hover:text-blue-700 dark:hover:text-blue-300">
                                        {{ $trx->transaction_number ?? 'TRX' }}
                                    </a>
                                </td>
                                <td class="px-6 py-4 text-xs whitespace-nowrap">
                                    {{ optional($trx->transaction_date)->format('d M Y') }}
                                </td>
                                <td class="px-6 py-4 text-xs">
                                    <span
                                        class="px-2 py-1 font-medium text-xs rounded-md {{ $type === 'INCOME' ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/40 dark:text-emerald-300' : 'bg-rose-100 text-rose-700 dark:bg-rose-900/40 dark:text-rose-300' }}">
                                        {{ $type }}
                                    </span>
                                </td>
                                <td class="px-6 py-4 max-w-xs truncate text-xs">
                                    {{ $trx->description ?? '-' }}
                                </td>
                                <td
                                    class="px-6 py-4 text-right font-semibold {{ $type === 'INCOME' ? 'text-emerald-600 dark:text-emerald-400' : 'text-rose-600 dark:text-rose-400' }} whitespace-nowrap">
                                    {{ $type === 'INCOME' ? '+' : '-' }} Rp {{ number_format($amount, 0, ',', '.') }}
                                </td>
                                <td class="px-6 py-4 text-center whitespace-nowrap">
                                    @php
                                        $statusVal = is_object($trx->status) ? $trx->status->value : $trx->status;
                                    @endphp
                                    <span
                                        class="px-2.5 py-1 text-xs font-medium rounded-full inline-block
                                        {{ strtolower($statusVal) === 'approved' ||
                                        strtolower($statusVal) === 'posted' ||
                                        strtolower($statusVal) === 'success'
                                            ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/40 dark:text-emerald-300'
                                            : (strtolower($statusVal) === 'pending'
                                                ? 'bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-300'
                                                : 'bg-red-100 text-red-700 dark:bg-red-900/40 dark:text-red-300') }}">
                                        {{ ucfirst($statusVal) }}
                                    </span>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="6"
                                    class="px-6 py-10 text-center text-gray-400 dark:text-gray-500 text-sm">
                                    <div class="flex flex-col items-center justify-center">
                                        <svg class="w-10 h-10 mb-2 opacity-60" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                                d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                        </svg>
                                        Belum ada transaksi yang tercatat untuk saldo akun ini.
                                    </div>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            @if ($transactions->hasPages())
                <div class="px-6 py-4 border-t border-gray-100 dark:border-gray-700/60">
                    {{ $transactions->links() }}
                </div>
            @endif
        </div>

    </div>

    {{-- Script ApexCharts --}}
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const usedAmount = {{ $used }};
            const remainingAmount = {{ $remaining }};
            const totalAvailableAmount = {{ $totalAvailable }};

            const options = {
                series: [usedAmount, remainingAmount],
                labels: ['Saldo Terpakai', 'Sisa Saldo Tersedia'],
                chart: {
                    type: 'donut',
                    height: 230,
                    fontFamily: 'Inter, sans-serif'
                },
                colors: ['#f43f5e', '#10b981'],
                legend: {
                    position: 'bottom',
                    fontSize: '13px'
                },
                dataLabels: {
                    enabled: true,
                    formatter: function(val) {
                        return val.toFixed(1) + "%";
                    }
                },
                plotOptions: {
                    pie: {
                        donut: {
                            size: '70%',
                            labels: {
                                show: true,
                                total: {
                                    show: true,
                                    label: 'Total Kelolaan Dana',
                                    fontSize: '11px',
                                    color: '#6b7280',
                                    formatter: function(w) {
                                        return 'Rp ' + totalAvailableAmount.toLocaleString('id-ID');
                                    }
                                }
                            }
                        }
                    }
                },
                tooltip: {
                    y: {
                        formatter: function(val) {
                            return 'Rp ' + val.toLocaleString('id-ID');
                        }
                    }
                }
            };

            const chart = new ApexCharts(document.querySelector("#balanceDonutChart"), options);
            chart.render();
        });
    </script>
@endsection
