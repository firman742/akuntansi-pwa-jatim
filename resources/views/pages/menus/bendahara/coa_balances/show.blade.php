@extends('layouts.app')

@section('title', 'Detail Saldo Akun')

@section('content')

    {{-- Breadcrumb --}}
    <div class="mb-6">
        <x-common.page-breadcrumb pageTitle="Detail Saldo Akun"
            pageDescription="Monitoring riwayat saldo akun yang aktif saat ini" pageIcon="money" parentTitle="Saldo Akun"
            :parentRoute="route('bendahara.coa-balances.index')" currentTitle="Detail" />
    </div>

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

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
                    <x-ui.button variant="outline"
                        class="rounded-xl px-4 py-2 dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 hover:dark:bg-gray-700">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                        </svg>
                        Kembali
                    </x-ui.button>
                </a>
            </div>
            <div>
                <!-- Tombol Tambah Saldo -->
                <x-ui.button variant="primary"
                    class="rounded-xl px-4 py-2 dark:bg-green-700 dark:text-gray-100 hover:dark:bg-green-600"
                    onclick="toggleModal('topUpBalanceModal')">
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                    </svg>
                    Tambah Saldo
                </x-ui.button>
            </div>
        </div>

        {{-- Row 1: Informasi Akun & Ringkasan Saldo Utama --}}
        <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">

            {{-- Informasi Akun --}}
            <div class="lg:col-span-2">
                <x-common.component-card class="dark:bg-gray-800 dark:border-gray-700">
                    <div class="flex flex-col justify-between h-full gap-6 sm:flex-row sm:items-start">
                        <div class="space-y-1">
                            <span
                                class="text-xs font-semibold uppercase tracking-wider text-gray-400 dark:text-gray-500">Kode
                                Akun</span>
                            <h2 class="text-3xl font-extrabold text-gray-900 dark:text-gray-100 tracking-tight">
                                {{ $coaBalance->chartOfAccount->code }}
                            </h2>
                            <p class="text-lg font-medium text-gray-600 dark:text-gray-300">
                                {{ $coaBalance->chartOfAccount->name }}
                            </p>
                            <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                {{ $coaBalance->chartOfAccount->normal_balance }}
                            </p>
                        </div>

                        <div
                            class="grid grid-cols-2 gap-x-6 gap-y-4 border-t border-gray-100 dark:border-gray-700 pt-4 sm:border-t-0 sm:pt-0 min-w-[240px]">
                            <div>
                                <p class="text-xs text-gray-400 dark:text-gray-500 font-medium uppercase tracking-wider">
                                    Periode</p>
                                <p class="font-semibold text-gray-800 dark:text-gray-200 text-sm mt-0.5">
                                    {{ $coaBalance->period->name }}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 dark:text-gray-500 font-medium uppercase tracking-wider">Sub
                                    Periode</p>
                                <p class="font-semibold text-gray-800 dark:text-gray-200 text-sm mt-0.5">
                                    {{ $coaBalance->subPeriod->name }}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 dark:text-gray-500 font-medium uppercase tracking-wider">
                                    Mulai</p>
                                <p class="font-semibold text-gray-800 dark:text-gray-200 text-sm mt-0.5">
                                    {{ $coaBalance->subPeriod->start_date->format('d M Y') }}</p>
                            </div>
                            <div>
                                <p class="text-xs text-gray-400 dark:text-gray-500 font-medium uppercase tracking-wider">
                                    Selesai</p>
                                <p class="font-semibold text-gray-800 dark:text-gray-200 text-sm mt-0.5">
                                    {{ $coaBalance->subPeriod->end_date->format('d M Y') }}</p>
                            </div>
                        </div>
                    </div>
                </x-common.component-card>

                {{-- Row 2: Grid Ringkasan Detail Saldo Per Kategori --}}
                <div class="grid grid-cols-2 gap-4 xl:grid-cols-4 mt-3">
                    <div
                        class="bg-white dark:bg-gray-800 p-4 rounded-xl border border-gray-100 dark:border-gray-700 shadow-sm">
                        <p class="text-xs font-medium text-gray-400 dark:text-gray-500 uppercase tracking-wider">Saldo Awal
                        </p>
                        <h3 class="mt-2 text-lg sm:text-xl font-bold text-gray-800 dark:text-gray-200">
                            Rp {{ number_format($summary['opening_balance'], 0, ',', '.') }}
                        </h3>
                    </div>

                    <div
                        class="bg-white dark:bg-gray-800 p-4 rounded-xl border border-gray-100 dark:border-gray-700 shadow-sm">
                        <p class="text-xs font-medium text-gray-400 dark:text-gray-500 uppercase tracking-wider">Total Debit
                        </p>
                        <h3 class="mt-2 text-lg sm:text-xl font-bold text-green-600 dark:text-green-400">
                            Rp {{ number_format($summary['debit_total'], 0, ',', '.') }}
                        </h3>
                    </div>

                    <div
                        class="bg-white dark:bg-gray-800 p-4 rounded-xl border border-gray-100 dark:border-gray-700 shadow-sm">
                        <p class="text-xs font-medium text-gray-400 dark:text-gray-500 uppercase tracking-wider">Total
                            Kredit</p>
                        <h3 class="mt-2 text-lg sm:text-xl font-bold text-red-600 dark:text-red-400">
                            Rp {{ number_format($summary['credit_total'], 0, ',', '.') }}
                        </h3>
                    </div>

                    <div
                        class="bg-white dark:bg-gray-800 p-4 rounded-xl border border-gray-100 dark:border-gray-700 shadow-sm">
                        <p class="text-xs font-medium text-gray-400 dark:text-gray-500 uppercase tracking-wider">Saldo Akhir
                        </p>
                        <h3 class="mt-2 text-lg sm:text-xl font-bold text-blue-600 dark:text-blue-400">
                            Rp {{ number_format($summary['current_balance'], 0, ',', '.') }}
                        </h3>
                    </div>
                </div>

            </div>

            {{-- Kartu Saldo Saat Ini --}}
            <div class="lg:col-span-1">
                <div
                    class="h-full rounded-2xl bg-green-600 dark:bg-green-700 p-6 text-white shadow-md flex flex-col justify-between">
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
                    class="flex overflow-x-auto border-b border-gray-200 dark:border-gray-700 scrollbar-none whitespace-nowrap">
                    <button @click="activeTab='saldo'"
                        :class="activeTab === 'saldo' ? 'border-primary-500 text-primary-600 dark:text-primary-400' :
                            'border-transparent text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300'"
                        class="flex items-center gap-2 border-b-2 px-4 py-3 text-sm font-semibold transition-all">
                        Riwayat Saldo
                        <span
                            :class="activeTab === 'saldo' ?
                                'bg-primary-100 text-primary-700 dark:bg-primary-500/20 dark:text-primary-400' :
                                'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400'"
                            class="rounded-full px-2 py-0.5 text-xs font-bold">
                            {{ $openingBalances->count() }}
                        </span>
                    </button>

                    <button @click="activeTab='transaksi'"
                        :class="activeTab === 'transaksi' ? 'border-primary-500 text-primary-600 dark:text-primary-400' :
                            'border-transparent text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300'"
                        class="flex items-center gap-2 border-b-2 px-4 py-3 text-sm font-semibold transition-all">
                        Riwayat Transaksi
                        <span
                            :class="activeTab === 'transaksi' ?
                                'bg-primary-100 text-primary-700 dark:bg-primary-500/20 dark:text-primary-400' :
                                'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400'"
                            class="rounded-full px-2 py-0.5 text-xs font-bold">
                            {{ $transactions->count() }}
                        </span>
                    </button>

                    <button @click="activeTab='alokasi'"
                        :class="activeTab === 'alokasi' ? 'border-primary-500 text-primary-600 dark:text-primary-400' :
                            'border-transparent text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300'"
                        class="flex items-center gap-2 border-b-2 px-4 py-3 text-sm font-semibold transition-all">
                        Alokasi Antar Akun
                        <span
                            :class="activeTab === 'alokasi' ?
                                'bg-primary-100 text-primary-700 dark:bg-primary-500/20 dark:text-primary-400' :
                                'bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-400'"
                            class="rounded-full px-2 py-0.5 text-xs font-bold">
                            {{ $budgetAllocations->count() }}
                        </span>
                    </button>
                </div>

                {{-- Konten Tab --}}
                <div class="space-y-4">

                    {{-- Tab 1: Riwayat Saldo --}}
                    <div x-show="activeTab === 'saldo'" x-transition class="space-y-3">
                        @forelse($openingBalances as $balance)
                            <div
                                class="flex flex-col sm:flex-row justify-between items-start sm:items-center p-4 rounded-xl border border-gray-100 bg-gray-50 dark:border-gray-700 dark:bg-gray-800 gap-2">
                                <div>
                                    <h4 class="font-bold text-gray-800 dark:text-gray-200">Saldo Awal</h4>
                                    <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">Dibuat oleh: <span
                                            class="font-medium text-gray-700 dark:text-gray-300">{{ $balance->creator?->name }}</span>
                                    </p>
                                    @if ($balance->is_correction)
                                        <span
                                            class="mt-1.5 inline-flex rounded-full bg-amber-50 dark:bg-amber-500/10 border border-amber-200 dark:border-amber-500 px-2 py-0.5 text-[10px] font-bold text-amber-700 dark:text-amber-300">
                                            Koreksi Saldo
                                        </span>
                                    @endif
                                </div>
                                <div
                                    class="sm:text-right w-full sm:w-auto border-t border-gray-100 dark:border-gray-700 sm:border-t-0 pt-2 sm:pt-0">
                                    <p class="text-base font-black text-green-600 dark:text-green-400">Rp
                                        {{ number_format($balance->amount, 0, ',', '.') }}</p>
                                    <p class="text-[11px] text-gray-400 dark:text-gray-500 mt-0.5">
                                        {{ $balance->created_at?->format('d M Y H:i') }}</p>
                                </div>
                            </div>
                        @empty
                            <div
                                class="rounded-xl border border-dashed border-gray-200 dark:border-gray-700 p-8 text-center text-sm text-gray-400 dark:text-gray-500">
                                Belum ada riwayat saldo.</div>
                        @endforelse
                    </div>

                    {{-- Tab 2: Transaksi --}}
                    <div x-show="activeTab === 'transaksi'" x-transition class="space-y-3">
                        @forelse($transactions as $transaction)
                            <div
                                class="flex flex-col sm:flex-row justify-between items-start sm:items-center p-4 rounded-xl border border-gray-100 bg-gray-50 dark:border-gray-700 dark:bg-gray-800 gap-2">
                                <div>
                                    <h4 class="font-bold text-gray-800 dark:text-gray-200">{{ $transaction->description }}
                                    </h4>
                                    <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5 font-mono">
                                        {{ $transaction->transaction_number }}</p>
                                    <p class="text-[11px] text-gray-400 dark:text-gray-500">Petugas:
                                        {{ $transaction->creator?->name }}</p>
                                </div>
                                <div
                                    class="sm:text-right w-full sm:w-auto border-t border-gray-100 dark:border-gray-700 sm:border-t-0 pt-2 sm:pt-0">
                                    <p class="text-base font-black text-gray-800 dark:text-gray-200">Rp
                                        {{ number_format($transaction->net_amount, 0, ',', '.') }}</p>
                                    <p class="text-[11px] text-gray-400 dark:text-gray-500 mt-0.5">
                                        {{ $transaction->transaction_date?->format('d M Y') }}</p>
                                </div>
                            </div>
                        @empty
                            <div
                                class="rounded-xl border border-dashed border-gray-200 dark:border-gray-700 p-8 text-center text-sm text-gray-400 dark:text-gray-500">
                                Belum ada transaksi.</div>
                        @endforelse
                    </div>

                    {{-- Tab 3: Alokasi Akun --}}
                    <div x-show="activeTab === 'alokasi'" x-transition class="space-y-3">
                        @forelse($budgetAllocations as $allocation)
                            <div
                                class="flex flex-col sm:flex-row justify-between items-start sm:items-center p-4 rounded-xl border border-gray-100 bg-gray-50 dark:border-gray-700 dark:bg-gray-800 gap-2">
                                <div>
                                    <h4 class="font-bold text-gray-800 dark:text-gray-200">Alokasi Dana</h4>
                                    <div
                                        class="mt-1 flex items-center gap-1.5 text-xs font-mono bg-gray-100 dark:bg-gray-700 px-2 py-0.5 rounded w-max text-gray-600 dark:text-gray-300">
                                        <span>{{ $allocation->fromChartOfAccount?->code }}</span>
                                        <span>➔</span>
                                        <span>{{ $allocation->toChartOfAccount?->code }}</span>
                                    </div>
                                    <p class="text-[11px] text-gray-500 dark:text-gray-400 mt-1">
                                        {{ $allocation->description }}</p>
                                </div>
                                <div
                                    class="sm:text-right w-full sm:w-auto border-t border-gray-100 dark:border-gray-700 sm:border-t-0 pt-2 sm:pt-0">
                                    <p class="text-base font-black text-blue-600 dark:text-blue-400">Rp
                                        {{ number_format($allocation->amount, 0, ',', '.') }}</p>
                                    <p class="text-[11px] text-gray-400 dark:text-gray-500 mt-0.5">
                                        {{ $allocation->created_at?->format('d M Y H:i') }}</p>
                                </div>
                            </div>
                        @empty
                            <div
                                class="rounded-xl border border-dashed border-gray-200 dark:border-gray-700 p-8 text-center text-sm text-gray-400 dark:text-gray-500">
                                Belum ada alokasi antar akun.</div>
                        @endforelse
                    </div>

                </div>
            </div>

        </x-common.component-card>

        <!-- Modal Form Top-Up Saldo -->
        <div id="topUpBalanceModal" class="fixed inset-0 z-99999 overflow-y-auto bg-black/70 p-4 hidden">
            <div class="flex items-center justify-center">
                <div
                    class="w-full max-w-lg sm:max-w-xl lg:max-w-2xl overflow-hidden rounded-2xl bg-gray-50 dark:bg-gray-800 shadow-2xl">

                    {{-- HEADER --}}
                    <div class="border-b border-gray-200 dark:border-gray-700 px-6 py-5">
                        <div class="flex items-center gap-3">
                            <div
                                class="flex h-12 w-12 items-center justify-center rounded-full bg-green-100 dark:bg-green-500/20 text-green-600 dark:text-green-400">

                                {{-- svg tambah --}}
                                <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 4v16m8-8H4" />
                                </svg>

                            </div>

                            <div>
                                <h3 class="text-lg font-semibold text-gray-900 dark:text-gray-100">
                                    Top-Up Saldo Akun
                                </h3>
                                <p class="text-sm text-gray-600 dark:text-gray-400">
                                    Tambahkan saldo ke akun <span
                                        class="font-semibold text-gray-900 dark:text-gray-100">{{ $coaBalance->chartOfAccount->code }}
                                        -
                                        {{ $coaBalance->chartOfAccount->name }}</span> untuk periode
                                    <span
                                        class="font-semibold text-gray-900 dark:text-gray-100">{{ $coaBalance->period->name }}
                                        -
                                        {{ $coaBalance->subPeriod->name }}</span>.
                                </p>
                            </div>
                        </div>
                    </div>

                    {{-- BODY --}}
                    <div class="p-6 space-y-5">

                        {{-- ALERT --}}
                        <div
                            class="rounded-xl border border-amber-200 dark:border-amber-500 bg-amber-50 dark:bg-amber-500/10 p-4">
                            <p class="text-sm text-amber-700 dark:text-amber-300">
                                Pastikan jumlah top-up saldo sesuai dengan kebutuhan dan telah disetujui oleh pihak yang
                                berwenang.
                            </p>
                        </div>

                        {{-- Akun COA --}}
                        <div>
                            <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                                Akun COA
                            </label>
                            <div
                                class="rounded-lg bg-gray-100 dark:bg-gray-700 p-4 text-sm text-gray-700 dark:text-gray-300">
                                {{ $account->code }} - {{ $account->name }}
                            </div>
                            <input type="hidden" name="chart_of_account_id" value="{{ $account->id }}"
                                form="approve-form">
                        </div>

                        {{-- Periode --}}
                        <div>
                            <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                                Periode
                            </label>
                            <div
                                class="rounded-lg bg-gray-100 dark:bg-gray-700 p-4 text-sm text-gray-700 dark:text-gray-300">
                                {{ $coaBalance->period->name }}
                            </div>
                            <input type="hidden" name="period_id" value="{{ $coaBalance->period->id }}"
                                form="approve-form">
                        </div>

                        {{-- Sub Periode --}}
                        <div>
                            <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                                Sub Periode
                            </label>
                            <div
                                class="rounded-lg bg-gray-100 dark:bg-gray-700 p-4 text-sm text-gray-700 dark:text-gray-300">
                                {{ $coaBalance->subPeriod->name }}
                            </div>
                            <input type="hidden" name="sub_period_id" value="{{ $coaBalance->subPeriod->id }}"
                                form="approve-form">
                        </div>

                        {{-- Jumlah TopUp --}}
                        <div>
                            <x-form.input type="number" id="amount" name="amount" label="Jumlah Topup"
                                form="approve-form" placeholder="Masukkan jumlah top-up saldo" required />
                        </div>

                        {{-- Alasan Penyesuaian --}}
                        <div>
                            <x-form.text-area name="reason" label="Catatan / Alasan Penyesuaian"
                                placeholder="Contoh: Penyesuaian saldo untuk menutupi kekurangan dana operasional bulan ini."
                                rows="4" form="approve-form" required />
                        </div>
                    </div>

                    {{-- FOOTER --}}
                    <div class="flex justify-end gap-3 border-t border-gray-200 dark:border-gray-700 px-6 py-4">
                        <button type="button" onclick="toggleModal('topUpBalanceModal')"
                            class="rounded-lg border border-gray-300 dark:border-gray-600 px-4 py-2 text-sm font-medium text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700">
                            Batal
                        </button>
                        <form id="approve-form" method="POST" action="{{ route('bendahara.coa-balances.topup') }}">
                            @csrf
                            <button type="submit"
                                class="rounded-lg bg-green-600 dark:bg-green-700 px-5 py-2 text-sm font-semibold text-white hover:bg-green-700 dark:hover:bg-green-600">
                                Top-Up Saldo
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>

    {{-- Script Grafik --}}
    <script>
        // Function to toggle modal visibility
        function toggleModal(modalId) {
            const modal = document.getElementById(modalId);
            modal.classList.toggle('hidden');
        }

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
