@extends('layouts.app')

@section('title', 'Detail Saldo Akun')

@section('content')

    {{-- Breadcrumb --}}
    <div class="mb-6">
        <x-common.page-breadcrumb pageTitle="Detail Saldo Akun"
            pageDescription="Monitoring riwayat saldo akun yang aktif saat ini" pageIcon="money" parentTitle="Saldo Akun"
            :parentRoute="route('bendahara.coa-balances.index')" currentTitle="Detail" />
    </div>

    {{-- Alert Error --}}
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
    

    {{-- Grid Layout Utama --}}
    <div class="space-y-6">

        {{-- TODO: Bisa ditambahkan tombol2 lainnya, antara lain: Penambahan saldo (topup), Alokasi Dana, Dana Operational Pengguna --}}
        {{-- Tombol kembali --}}
        <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between mb-6">
            <div>
                <a href="{{ route('bendahara.coa-balances.index') }}">
                    <x-ui.button variant="outline" class="rounded-xl px-4 py-2">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                        </svg>
                        Kembali
                    </x-ui.button>
                </a>
            </div>
        </div>

        {{-- Row 1: Informasi Akun & Ringkasan Saldo Utama --}}
        <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">

            {{-- Informasi Akun --}}
            <div class="lg:col-span-2">
                <x-common.component-card>
                    <div class="flex flex-col justify-between h-full gap-6 sm:flex-row sm:items-start">
                        <div class="space-y-1">
                            <span class="text-xs font-semibold uppercase tracking-wider text-gray-400">Kode Akun</span>
                            <h2 class="text-3xl font-extrabold text-gray-900 tracking-tight">
                                {{ $coaBalance->chartOfAccount->code }}
                            </h2>
                            <p class="text-lg font-medium text-gray-600">
                                {{ $coaBalance->chartOfAccount->name }}
                            </p>
                        </div>

                        <div
                            class="grid grid-cols-2 gap-x-6 gap-y-4 border-t border-gray-100 pt-4 sm:border-t-0 sm:pt-0 min-w-[240px]">
                            <div>
                                <p class="text-xs text-gray-400 font-medium uppercase tracking-wider">Periode</p>
                                <p class="font-semibold text-gray-800 text-sm mt-0.5">{{ $coaBalance->period->name }}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 font-medium uppercase tracking-wider">Sub Periode</p>
                                <p class="font-semibold text-gray-800 text-sm mt-0.5">{{ $coaBalance->subPeriod->name }}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 font-medium uppercase tracking-wider">Mulai</p>
                                <p class="font-semibold text-gray-800 text-sm mt-0.5">
                                    {{ $coaBalance->subPeriod->start_date->format('d M Y') }}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 font-medium uppercase tracking-wider">Selesai</p>
                                <p class="font-semibold text-gray-800 text-sm mt-0.5">
                                    {{ $coaBalance->subPeriod->end_date->format('d M Y') }}</p>
                            </div>
                        </div>
                    </div>
                </x-common.component-card>

                {{-- Row 2: Grid Ringkasan Detail Saldo Per Kategori --}}
                <div class="grid grid-cols-2 gap-4 xl:grid-cols-4 mt-3">
                    <div
                        class="bg-white dark:bg-gray-900 p-4 rounded-xl border border-gray-100 dark:border-gray-800 shadow-sm">
                        <p class="text-xs font-medium text-gray-400 uppercase tracking-wider">Saldo Awal</p>
                        <h3 class="mt-2 text-lg sm:text-xl font-bold text-gray-800 dark:text-gray-200">
                            Rp {{ number_format($summary['opening_balance'], 0, ',', '.') }}
                        </h3>
                    </div>

                    <div
                        class="bg-white dark:bg-gray-900 p-4 rounded-xl border border-gray-100 dark:border-gray-800 shadow-sm">
                        <p class="text-xs font-medium text-gray-400 uppercase tracking-wider">Total Debit</p>
                        <h3 class="mt-2 text-lg sm:text-xl font-bold text-green-600">
                            Rp {{ number_format($summary['debit_total'], 0, ',', '.') }}
                        </h3>
                    </div>

                    <div
                        class="bg-white dark:bg-gray-900 p-4 rounded-xl border border-gray-100 dark:border-gray-800 shadow-sm">
                        <p class="text-xs font-medium text-gray-400 uppercase tracking-wider">Total Kredit</p>
                        <h3 class="mt-2 text-lg sm:text-xl font-bold text-red-600">
                            Rp {{ number_format($summary['credit_total'], 0, ',', '.') }}
                        </h3>
                    </div>

                    <div
                        class="bg-white dark:bg-gray-900 p-4 rounded-xl border border-gray-100 dark:border-gray-800 shadow-sm">
                        <p class="text-xs font-medium text-gray-400 uppercase tracking-wider">Saldo Akhir</p>
                        <h3 class="mt-2 text-lg sm:text-xl font-bold text-blue-600">
                            Rp {{ number_format($summary['current_balance'], 0, ',', '.') }}
                        </h3>
                    </div>
                </div>

            </div>

            {{-- Kartu Saldo Saat Ini --}}
            <div class="lg:col-span-1">
                <div class="h-full rounded-2xl bg-green-600 p-6 text-white shadow-md flex flex-col justify-between">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-widest text-emerald-100 opacity-90">
                            Saldo Saat Ini
                        </p>
                        <h1 class="mt-2 text-3xl font-black lg:text-4xl tracking-tight">
                            Rp {{ number_format($summary['current_balance'], 0, ',', '.') }}
                        </h1>
                    </div>

                    <div class="mt-6 grid grid-cols-3 gap-2 border-t border-emerald-500/30 pt-4 text-center sm:text-left">
                        <div>
                            <p class="text-[10px] uppercase font-medium text-emerald-100 opacity-80">Awal</p>
                            <p class="text-xs font-bold mt-0.5">Rp
                                {{ number_format($summary['opening_balance'], 0, ',', '.') }}</p>
                        </div>
                        <div>
                            <p class="text-[10px] uppercase font-medium text-emerald-100 opacity-80">Debit</p>
                            <p class="text-xs font-bold mt-0.5">Rp
                                {{ number_format($summary['debit_total'], 0, ',', '.') }}
                            </p>
                        </div>
                        <div>
                            <p class="text-[10px] uppercase font-medium text-emerald-100 opacity-80">Kredit</p>
                            <p class="text-xs font-bold mt-0.5">Rp
                                {{ number_format($summary['credit_total'], 0, ',', '.') }}</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>


        {{-- Row 3: Grafik Perubahan Saldo --}}
        {{-- TODO: Sementara dihida dulu --}}
        {{-- <x-common.component-card title="Grafik Perubahan Saldo" desc="Perkembangan saldo akun selama periode berjalan">

            <div x-data="{ hasChartData: @json($hasChartData) }" class="mt-4">

                <div x-show="hasChartData" class="h-[320px] sm:h-[400px] w-full">
                    <canvas id="balanceChart"></canvas>
                </div>

                <div x-show="!hasChartData"
                    class="flex flex-col items-center justify-center py-12 px-4 rounded-xl border border-dashed border-gray-200 text-center">
                    <div class="p-3 bg-gray-50 rounded-full text-gray-400 mb-3 dark:bg-gray-800">
                        <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M7 12l3-3 3 3 4-4M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z" />
                        </svg>
                    </div>
                    <h4 class="text-sm font-semibold text-gray-700 dark:text-gray-300">Belum Ada Perubahan Saldo</h4>
                    <p class="text-xs text-gray-400 max-w-xs mt-1">
                        Grafik tidak dapat ditampilkan karena belum ada aktivitas transaksi atau alokasi pada sub periode
                        ini.
                    </p>
                </div>

            </div>
        </x-common.component-card> --}}

        {{-- Row 4: Timeline Aktivitas Saldo (Tabs & Lists) --}}
        <x-common.component-card title="Timeline Aktivitas Saldo" desc="Riwayat aktivitas yang mempengaruhi saldo akun">

            <div x-data="{ activeTab: 'saldo' }" class="space-y-6 mt-4">

                {{-- Navigasi Tab Responsif --}}
                <div
                    class="flex overflow-x-auto border-b border-gray-200 dark:border-gray-800 scrollbar-none whitespace-nowrap">
                    <button @click="activeTab='saldo'"
                        :class="activeTab === 'saldo' ? 'border-primary-500 text-primary-600' :
                            'border-transparent text-gray-500 hover:text-gray-700'"
                        class="flex items-center gap-2 border-b-2 px-4 py-3 text-sm font-semibold transition-all">
                        Riwayat Saldo
                        <span
                            :class="activeTab === 'saldo' ? 'bg-primary-100 text-primary-700' : 'bg-gray-100 text-gray-600'"
                            class="rounded-full px-2 py-0.5 text-xs font-bold">
                            {{ $openingBalances->count() }}
                        </span>
                    </button>

                    <button @click="activeTab='transaksi'"
                        :class="activeTab === 'transaksi' ? 'border-primary-500 text-primary-600' :
                            'border-transparent text-gray-500 hover:text-gray-700'"
                        class="flex items-center gap-2 border-b-2 px-4 py-3 text-sm font-semibold transition-all">
                        Riwayat Transaksi
                        <span
                            :class="activeTab === 'transaksi' ? 'bg-primary-100 text-primary-700' : 'bg-gray-100 text-gray-600'"
                            class="rounded-full px-2 py-0.5 text-xs font-bold">
                            {{ $transactions->count() }}
                        </span>
                    </button>

                    <button @click="activeTab='alokasi'"
                        :class="activeTab === 'alokasi' ? 'border-primary-500 text-primary-600' :
                            'border-transparent text-gray-500 hover:text-gray-700'"
                        class="flex items-center gap-2 border-b-2 px-4 py-3 text-sm font-semibold transition-all">
                        Alokasi Antar Akun
                        <span
                            :class="activeTab === 'alokasi' ? 'bg-primary-100 text-primary-700' : 'bg-gray-100 text-gray-600'"
                            class="rounded-full px-2 py-0.5 text-xs font-bold">
                            {{ $budgetAllocations->count() }}
                        </span>
                    </button>

                    <button @click="activeTab='user'"
                        :class="activeTab === 'user' ? 'border-primary-500 text-primary-600' :
                            'border-transparent text-gray-500 hover:text-gray-700'"
                        class="flex items-center gap-2 border-b-2 px-4 py-3 text-sm font-semibold transition-all">
                        Alokasi Pengguna
                        <span
                            :class="activeTab === 'user' ? 'bg-primary-100 text-primary-700' : 'bg-gray-100 text-gray-600'"
                            class="rounded-full px-2 py-0.5 text-xs font-bold">
                            {{ $userAccountBalances->count() }}
                        </span>
                    </button>
                </div>

                {{-- Konten Tab --}}
                <div class="space-y-4">

                    {{-- Tab 1: Riwayat Saldo --}}
                    <div x-show="activeTab === 'saldo'" x-transition class="space-y-3">
                        @forelse($openingBalances as $balance)
                            <div
                                class="flex flex-col sm:flex-row justify-between items-start sm:items-center p-4 rounded-xl border border-gray-100 bg-gray-50/50 dark:border-gray-800 dark:bg-gray-900/50 gap-2">
                                <div>
                                    <h4 class="font-bold text-gray-800 dark:text-gray-200">Saldo Awal</h4>
                                    <p class="text-xs text-gray-500 mt-0.5">Dibuat oleh: <span
                                            class="font-medium text-gray-700">{{ $balance->creator?->name }}</span></p>
                                    @if ($balance->is_correction)
                                        <span
                                            class="mt-1.5 inline-flex rounded-full bg-amber-50 border border-amber-200 px-2 py-0.5 text-[10px] font-bold text-amber-700">
                                            Koreksi Saldo
                                        </span>
                                    @endif
                                </div>
                                <div
                                    class="sm:text-right w-full sm:w-auto border-t border-gray-100 sm:border-t-0 pt-2 sm:pt-0">
                                    <p class="text-base font-black text-green-600">Rp
                                        {{ number_format($balance->amount, 0, ',', '.') }}</p>
                                    <p class="text-[11px] text-gray-400 mt-0.5">
                                        {{ $balance->created_at?->format('d M Y H:i') }}</p>
                                </div>
                            </div>
                        @empty
                            <div
                                class="rounded-xl border border-dashed border-gray-200 p-8 text-center text-sm text-gray-400">
                                Belum ada riwayat saldo.</div>
                        @endforelse
                    </div>

                    {{-- Tab 2: Transaksi --}}
                    <div x-show="activeTab === 'transaksi'" x-transition class="space-y-3">
                        @forelse($transactions as $transaction)
                            <div
                                class="flex flex-col sm:flex-row justify-between items-start sm:items-center p-4 rounded-xl border border-gray-100 bg-gray-50/50 dark:border-gray-800 dark:bg-gray-900/50 gap-2">
                                <div>
                                    <h4 class="font-bold text-gray-800 dark:text-gray-200">{{ $transaction->description }}
                                    </h4>
                                    <p class="text-xs text-gray-500 mt-0.5 font-mono">
                                        {{ $transaction->transaction_number }}</p>
                                    <p class="text-[11px] text-gray-400">Petugas: {{ $transaction->creator?->name }}</p>
                                </div>
                                <div
                                    class="sm:text-right w-full sm:w-auto border-t border-gray-100 sm:border-t-0 pt-2 sm:pt-0">
                                    <p class="text-base font-black text-gray-800 dark:text-gray-200">Rp
                                        {{ number_format($transaction->net_amount, 0, ',', '.') }}</p>
                                    <p class="text-[11px] text-gray-400 mt-0.5">
                                        {{ $transaction->transaction_date?->format('d M Y') }}</p>
                                </div>
                            </div>
                        @empty
                            <div
                                class="rounded-xl border border-dashed border-gray-200 p-8 text-center text-sm text-gray-400">
                                Belum ada transaksi.</div>
                        @endforelse
                    </div>

                    {{-- Tab 3: Alokasi Akun --}}
                    {{-- TODO: Perlu dibuatkan perbedaan antara mana yang menjadi debit dan mana yang credit --}}
                    <div x-show="activeTab === 'alokasi'" x-transition class="space-y-3">
                        @forelse($budgetAllocations as $allocation)
                            <div
                                class="flex flex-col sm:flex-row justify-between items-start sm:items-center p-4 rounded-xl border border-gray-100 bg-gray-50/50 dark:border-gray-800 dark:bg-gray-900/50 gap-2">
                                <div>
                                    <h4 class="font-bold text-gray-800 dark:text-gray-200">Alokasi Dana</h4>
                                    <div
                                        class="mt-1 flex items-center gap-1.5 text-xs font-mono bg-gray-100 px-2 py-0.5 rounded w-max text-gray-600">
                                        <span>{{ $allocation->fromChartOfAccount?->code }}</span>
                                        <span>➔</span>
                                        <span>{{ $allocation->toChartOfAccount?->code }}</span>
                                    </div>
                                    <p class="text-[11px] text-gray-500 mt-1">{{ $allocation->description }}</p>
                                </div>
                                <div
                                    class="sm:text-right w-full sm:w-auto border-t border-gray-100 sm:border-t-0 pt-2 sm:pt-0">
                                    <p class="text-base font-black text-blue-600">Rp
                                        {{ number_format($allocation->amount, 0, ',', '.') }}</p>
                                    <p class="text-[11px] text-gray-400 mt-0.5">
                                        {{ $allocation->created_at?->format('d M Y H:i') }}</p>
                                </div>
                            </div>
                        @empty
                            <div
                                class="rounded-xl border border-dashed border-gray-200 p-8 text-center text-sm text-gray-400">
                                Belum ada alokasi antar akun.</div>
                        @endforelse
                    </div>

                    {{-- Tab 4: Alokasi User --}}
                    <div x-show="activeTab === 'user'" x-transition class="space-y-3">
                        @forelse($userAccountBalances as $allocation)
                            <div
                                class="flex flex-col sm:flex-row justify-between items-start sm:items-center p-4 rounded-xl border border-gray-100 bg-gray-50/50 dark:border-gray-800 dark:bg-gray-900/50 gap-2">
                                <div>
                                    <h4 class="font-bold text-gray-800 dark:text-gray-200">
                                        {{ $allocation->userAccount?->user->name ?? '-' }}</h4>
                                    <p class="text-xs text-gray-500 mt-0.5">Dialokasikan oleh: <span
                                            class="font-medium text-gray-700">{{ $allocation->allocatedBy?->name }}</span>
                                    </p>
                                    <p class="text-xs font-medium text-purple-700 mt-1">Sisa Saldo: Rp
                                        {{ number_format($allocation->remaining_balance, 0, ',', '.') }}</p>
                                </div>
                                <div
                                    class="sm:text-right w-full sm:w-auto border-t border-gray-100 sm:border-t-0 pt-2 sm:pt-0">
                                    <p class="text-base font-black text-purple-600">Rp
                                        {{ number_format($allocation->allocated_balance, 0, ',', '.') }}</p>
                                    <p class="text-[11px] text-gray-400 mt-0.5">
                                        {{ $allocation->allocated_at }}</p>
                                </div>
                            </div>
                        @empty
                            <div
                                class="rounded-xl border border-dashed border-gray-200 p-8 text-center text-sm text-gray-400">
                                Belum ada alokasi pengguna.</div>
                        @endforelse
                    </div>

                </div>
            </div>

        </x-common.component-card>

    </div>

    {{-- Script Grafik --}}
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const ctx = document.getElementById('balanceChart');
            if (!ctx) return;

            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: @json($chartData['labels'] ?? []),
                    datasets: [{
                        label: 'Saldo',
                        data: @json($chartData['data'] ?? []),
                        tension: 0.3,
                        fill: true,
                        backgroundColor: 'rgba(16, 185, 129, 0.05)',
                        borderColor: '#10b981',
                        borderWidth: 2.5,
                        pointRadius: 3,
                        pointHoverRadius: 5
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            grid: {
                                color: 'rgba(0, 0, 0, 0.03)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        });
    </script>

@endsection
