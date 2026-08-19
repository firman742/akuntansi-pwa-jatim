@extends('layouts.app')

@section('title', 'Daftar Transaksi Pengeluaran')

@section('content')
    <div class="space-y-6">
        {{-- BREADCRUMB --}}
        <x-common.page-breadcrumb defaultTitle="Transaksi Pengeluaran" pageTitle="Monitoring Transaksi Pengeluaran"
            pageDescription="Pusat pencatatan dan evaluasi histori beban & pengeluaran kas" pageIcon="transaction" />

        {{-- RESTRUCTURED EXPENSE KPI SUMMARY CARDS --}}
        <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">

            <!-- Card 1: Total Akumulasi Pengeluaran (Nominal) -->
            <div
                class="rounded-3xl border border-rose-100 bg-gradient-to-br from-rose-50/60 via-white to-white p-5 shadow-xs dark:border-rose-900/30 dark:from-rose-950/20 dark:via-gray-900 dark:to-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-wider text-rose-600 dark:text-rose-400">Total
                            Pengeluaran</p>
                        <h3 class="mt-2 text-2xl font-black text-rose-600 dark:text-rose-400 font-mono tabular-nums">
                            Rp {{ number_format($stats['total_amount'] ?? 0, 0, ',', '.') }}
                        </h3>
                    </div>
                    <div
                        class="flex h-12 w-12 items-center justify-center rounded-2xl bg-rose-100 text-rose-600 dark:bg-rose-900/40 dark:text-rose-400">
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M17 13l-5 5m0 0l-5-5m5 5V6" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Akumulasi kas keluar (filtered)</p>
            </div>

            <!-- Card 2: Total Catatan Transaksi -->
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400">Total Entri
                            Data</p>
                        <h3 class="mt-2 text-2xl font-black text-gray-900 dark:text-white font-mono tabular-nums">
                            {{ number_format($stats['total_count'] ?? 0) }} <span
                                class="text-xs font-normal text-gray-400">Transaksi</span>
                        </h3>
                    </div>
                    <div
                        class="flex h-12 w-12 items-center justify-center rounded-2xl bg-blue-50 text-blue-600 dark:bg-blue-900/30 dark:text-blue-400">
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Jumlah dokumen pengeluaran</p>
            </div>

            <!-- Card 3: Transaksi Terposting (Posted) -->
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-wider text-emerald-600 dark:text-emerald-400">
                            Terverifikasi (Posted)</p>
                        <h3 class="mt-2 text-2xl font-black text-emerald-600 dark:text-emerald-400 font-mono tabular-nums">
                            {{ number_format($stats['posted_count'] ?? 0) }} <span
                                class="text-xs font-normal text-gray-400">Entri</span>
                        </h3>
                    </div>
                    <div
                        class="flex h-12 w-12 items-center justify-center rounded-2xl bg-emerald-50 text-emerald-600 dark:bg-emerald-900/30 dark:text-emerald-400">
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Masuk ke Buku Besar & Jurnal</p>
            </div>

            <!-- Card 4: Draft / Pending Verification -->
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-wider text-amber-600 dark:text-amber-400">Status
                            Draft</p>
                        <h3 class="mt-2 text-2xl font-black text-amber-600 dark:text-amber-400 font-mono tabular-nums">
                            {{ number_format($stats['draft_count'] ?? 0) }} <span
                                class="text-xs font-normal text-gray-400">Entri</span>
                        </h3>
                    </div>
                    <div
                        class="flex h-12 w-12 items-center justify-center rounded-2xl bg-amber-50 text-amber-600 dark:bg-amber-900/30 dark:text-amber-400">
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Menunggu finalisasi/posting</p>
            </div>
        </div>

        {{-- ACCORDION FILTER CARD --}}
        @php
            $hasActiveFilters = request()->hasAny([
                'search',
                'period_id',
                'sub_period_id',
                'start_date',
                'end_date',
                'status',
            ]);
            $activeFilterCount = collect(
                request()->only(['search', 'period_id', 'sub_period_id', 'start_date', 'end_date', 'status']),
            )
                ->filter(fn($val) => filled($val))
                ->count();
        @endphp

        <div x-data="{ openFilter: @js($hasActiveFilters) }"
            class="rounded-3xl border border-gray-200 bg-white shadow-xs dark:border-gray-800 dark:bg-gray-900 overflow-hidden transition-all">

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
                            <h3 class="text-base font-semibold text-gray-900 dark:text-white">Filter & Pencarian Pengeluaran
                            </h3>
                            @if ($activeFilterCount > 0)
                                <span
                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold bg-rose-50 text-rose-700 border border-rose-200 dark:bg-rose-900/30 dark:text-rose-400 dark:border-rose-800">
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
                <form method="GET" action="{{ route('user.transactions.expenses.index') }}" class="space-y-4 pt-2">
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

                        {{-- Status Transaksi --}}
                        <div>
                            <x-form.select id="filter_status" name="status" placeholder="Semua Status">
                                <option value="">Semua Status</option>
                                <option value="DRAFT" @selected(request('status') === 'DRAFT')>Draft</option>
                                <option value="POSTED" @selected(request('status') === 'POSTED')>Posted</option>
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
                        <a href="{{ route('user.transactions.expenses.index') }}">
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
            <x-slot name="actions">
                <div class="flex gap-3">
                    <a href="{{ route('user.transactions.expenses.create') }}">
                        <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                            + Buat Transaksi Pengeluaran Baru
                        </x-ui.button>
                    </a>
                </div>
            </x-slot>
            <x-core.basic-tables.user.expense-table :transactions="$transactions" />
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
