@extends('layouts.app')

@section('title', 'Riwayat Transaksi')

@section('content')
    <div class="space-y-6">
        {{-- BREADCRUMB --}}
        <x-common.page-breadcrumb defaultTitle="Riwayat Transaksi" pageTitle="Monitoring Riwayat Transaksi"
            pageDescription="Laporan dan rekam jejak riwayat seluruh pencatatan transaksi keuangan pengguna"
            pageIcon="report" />

        {{-- KPI SUMMARY CARDS --}}
        <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
            <!-- Card 1: Total Transaksi -->
            <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-medium uppercase tracking-wider text-gray-500 dark:text-gray-400">Total
                            Transaksi</p>
                        <h3 class="mt-2 text-xl font-bold text-gray-900 dark:text-white">
                            {{ number_format($stats['total_count'] ?? 0) }} <span
                                class="text-xs font-normal text-gray-500">Catatan</span>
                        </h3>
                    </div>
                    <div
                        class="flex h-11 w-11 items-center justify-center rounded-xl bg-blue-50 text-blue-600 dark:bg-blue-500/10 dark:text-blue-400">
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Sesuai filter pencarian</p>
            </div>

            <!-- Card 2: Total Pemasukan -->
            <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-medium uppercase tracking-wider text-gray-500 dark:text-gray-400">Total
                            Pemasukan</p>
                        <h3 class="mt-2 text-xl font-bold text-emerald-600 dark:text-emerald-400">
                            + Rp {{ number_format($stats['total_income'] ?? 0, 0, ',', '.') }}
                        </h3>
                    </div>
                    <div
                        class="flex h-11 w-11 items-center justify-center rounded-xl bg-emerald-50 text-emerald-600 dark:bg-emerald-500/10 dark:text-emerald-400">
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-emerald-600 dark:text-emerald-400 font-medium">Kas Masuk</p>
            </div>

            <!-- Card 3: Total Pengeluaran -->
            <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-medium uppercase tracking-wider text-gray-500 dark:text-gray-400">Total
                            Pengeluaran</p>
                        <h3 class="mt-2 text-xl font-bold text-rose-600 dark:text-rose-400">
                            - Rp {{ number_format($stats['total_expense'] ?? 0, 0, ',', '.') }}
                        </h3>
                    </div>
                    <div
                        class="flex h-11 w-11 items-center justify-center rounded-xl bg-rose-50 text-rose-600 dark:bg-rose-500/10 dark:text-rose-400">
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-rose-600 dark:text-rose-400 font-medium">Kas Keluar</p>
            </div>

            <!-- Card 4: Arus Kas Bersih -->
            <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-medium uppercase tracking-wider text-gray-500 dark:text-gray-400">Arus Kas
                            Bersih</p>
                        <h3
                            class="mt-2 text-xl font-bold {{ ($stats['net_balance'] ?? 0) >= 0 ? 'text-gray-900 dark:text-white' : 'text-rose-600 dark:text-rose-400' }}">
                            Rp {{ number_format($stats['net_balance'] ?? 0, 0, ',', '.') }}
                        </h3>
                    </div>
                    <div
                        class="flex h-11 w-11 items-center justify-center rounded-xl bg-amber-50 text-amber-600 dark:bg-amber-500/10 dark:text-amber-400">
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Surplus / Defisit</p>
            </div>
        </div>

        {{-- ACCORDION FILTER CARD --}}
        @php
            $hasActiveFilters = request()->hasAny([
                'search',
                'period_id',
                'sub_period_id',
                'transaction_type',
                'start_date',
                'end_date',
            ]);
            $activeFilterCount = collect(
                request()->only(['search', 'period_id', 'sub_period_id', 'transaction_type', 'start_date', 'end_date']),
            )
                ->filter(fn($val) => filled($val))
                ->count();
        @endphp

        <div x-data="{ openFilter: @js($hasActiveFilters) }"
            class="rounded-2xl border border-gray-200 bg-white shadow-xs dark:border-gray-800 dark:bg-gray-900 overflow-hidden transition-all">

            {{-- ACCORDION HEADER / TRIGGER --}}
            <button type="button" @click="openFilter = !openFilter"
                class="w-full flex items-center justify-between p-5 text-left transition hover:bg-gray-50/80 dark:hover:bg-gray-800/50 cursor-pointer">
                <div class="flex items-center gap-3">
                    <div
                        class="flex h-9 w-9 items-center justify-center rounded-xl bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-300">
                        <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z" />
                        </svg>
                    </div>
                    <div>
                        <div class="flex items-center gap-2">
                            <h3 class="text-base font-semibold text-gray-900 dark:text-white">Filter & Pencarian Riwayat
                            </h3>
                            @if ($activeFilterCount > 0)
                                <span
                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-blue-50 text-blue-700 border border-blue-200 dark:bg-blue-500/10 dark:text-blue-400 dark:border-blue-500/20">
                                    {{ $activeFilterCount }} Filter Aktif
                                </span>
                            @endif
                        </div>
                        <p class="text-xs text-gray-500 dark:text-gray-400">
                            Klik untuk <span x-text="openFilter ? 'menyembunyikan' : 'menampilkan'"></span> parameter
                            pencarian
                        </p>
                    </div>
                </div>

                <div class="flex items-center gap-2 text-gray-400">
                    <span class="text-xs font-medium hidden sm:inline"
                        x-text="openFilter ? 'Sembunyikan' : 'Buka Filter'"></span>
                    <svg class="w-5 h-5 transform transition-transform duration-200" :class="{ 'rotate-180': openFilter }"
                        fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                    </svg>
                </div>
            </button>

            {{-- ACCORDION CONTENT FORM --}}
            <div x-show="openFilter" x-transition:enter="transition ease-out duration-200"
                x-transition:enter-start="opacity-0 -translate-y-2" x-transition:enter-end="opacity-100 translate-y-0"
                x-transition:leave="transition ease-in duration-150" x-transition:leave-start="opacity-100 translate-y-0"
                x-transition:leave-end="opacity-0 -translate-y-2"
                class="px-6 pb-6 pt-2 border-t border-gray-100 dark:border-gray-800">
                <form method="GET" action="{{ route('user.transactions.histories.index') }}" class="space-y-4 pt-2">
                    {{-- BARIS 1: SEARCH BAR --}}
                    <div>
                        <x-form.input id="search" name="search" value="{{ request('search') }}"
                            placeholder="Cari berdasarkan No. Transaksi, Deskripsi, atau Nama/Kode Akun COA..."
                            startIconSearch />
                    </div>

                    {{-- BARIS 2: DROPDOWNS & DATES GRID --}}
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4">
                        {{-- Periode --}}
                        <div>
                            <x-form.select id="filter_period" name="period_id" placeholder="Semua Periode">
                                <option value="">Semua Periode</option>
                                @foreach ($periods as $period)
                                    <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                                        {{ $period->name }}
                                    </option>
                                @endforeach
                            </x-form.select>
                        </div>

                        {{-- Sub Periode --}}
                        <div>
                            <x-form.select id="filter_sub_period" name="sub_period_id" placeholder="Semua Sub Periode">
                                <option value="">Semua Sub Periode</option>
                                @foreach ($subPeriods as $subPeriod)
                                    <option value="{{ $subPeriod->id }}" @selected(request('sub_period_id') == $subPeriod->id)>
                                        {{ $subPeriod->name }}
                                    </option>
                                @endforeach
                            </x-form.select>
                        </div>

                        {{-- Jenis Transaksi --}}
                        <div>
                            <x-form.select id="filter_transaction_type" name="transaction_type"
                                placeholder="Semua Jenis">
                                <option value="">Semua Jenis Transaksi</option>
                                @foreach (\App\Enums\TransactionType::cases() as $type)
                                    <option value="{{ $type->value }}" @selected(request('transaction_type') == $type->value)>
                                        {{ $type->label() }}
                                    </option>
                                @endforeach
                            </x-form.select>
                        </div>

                        {{-- Dari Tanggal --}}
                        <div>
                            <x-form.date-picker id="start_date" name="start_date" placeholder="Dari Tanggal"
                                defaultDate="{{ request('start_date') }}" />
                        </div>

                        {{-- Sampai Tanggal --}}
                        <div>
                            <x-form.date-picker id="end_date" name="end_date" placeholder="Sampai Tanggal"
                                defaultDate="{{ request('end_date') }}" />
                        </div>
                    </div>

                    {{-- BARIS 3: TOMBOL AKSI --}}
                    <div class="flex items-center justify-end gap-3 pt-2">
                        <a href="{{ route('user.transactions.histories.index') }}">
                            <x-ui.button type="button" variant="outline" size="sm" class="rounded-xl px-4 py-2">
                                Reset Filter
                            </x-ui.button>
                        </a>

                        <x-ui.button type="submit" variant="primary" size="sm"
                            class="rounded-xl px-6 py-2 shadow-sm font-medium">
                            <svg class="w-4 h-4 mr-1.5 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                            </svg>
                            Terapkan Filter
                        </x-ui.button>
                    </div>
                </form>
            </div>
        </div>

        {{-- TABLE CONTAINER --}}
        <x-core.basic-tables.core-table>
            <x-core.basic-tables.user.history-table :transactions="$transactions" />
        </x-core.basic-tables.core-table>
    </div>

    {{-- SCRIPT: DEPENDENT SUB PERIODE --}}
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const periodFilter = document.getElementById('filter_period');
            const subPeriodFilter = document.getElementById('filter_sub_period');

            if (!periodFilter || !subPeriodFilter) return;

            periodFilter.addEventListener('change', async function() {
                let periodId = this.value;

                subPeriodFilter.innerHTML = '<option value="">Memuat...</option>';

                if (!periodId) {
                    subPeriodFilter.innerHTML = '<option value="">Semua Sub Periode</option>';
                    return;
                }

                try {
                    const res = await fetch(`/bendahara/periods/${periodId}/sub-periods`);
                    const data = await res.json();

                    subPeriodFilter.innerHTML = '<option value="">Semua Sub Periode</option>';
                    data.forEach(sub => {
                        subPeriodFilter.innerHTML +=
                            `<option value="${sub.id}">${sub.name}</option>`;
                    });
                } catch (error) {
                    subPeriodFilter.innerHTML = '<option value="">Gagal memuat sub periode</option>';
                }
            });
        });
    </script>
@endsection
