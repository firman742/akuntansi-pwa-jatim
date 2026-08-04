@extends('layouts.app')

@section('title', 'Daftar Transaksi Penerimaan')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Daftar Transaksi Penerimaan" pageTitle="Monitoring Daftar Transaksi Penerimaan"
        pageDescription="Monitoring Daftar Transaksi Penerimaan berdasarkan periode" pageIcon="transaction" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li class="text-dark-500">{{ $error }}</li>
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

    {{-- MONITORING SUMMARY CARDS --}}
    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4 mb-6">
        <!-- Card 1: Total Penerimaan -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-xs font-medium uppercase tracking-wider text-gray-500 dark:text-gray-400">Total
                        Penerimaan</p>
                    <h3 class="mt-2 text-xl font-bold text-gray-900 dark:text-white">
                        Rp {{ number_format($stats['total_amount'] ?? 0, 0, ',', '.') }}
                    </h3>
                </div>
                <div
                    class="flex h-11 w-11 items-center justify-center rounded-xl bg-rose-50 text-rose-600 dark:bg-rose-500/10 dark:text-rose-400">
                    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
                    </svg>
                </div>
            </div>
            <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Kumulatif berdasarkan filter aktif</p>
        </div>

        <!-- Card 2: Total Transaksi -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-xs font-medium uppercase tracking-wider text-gray-500 dark:text-gray-400">Total Transaksi
                    </p>
                    <h3 class="mt-2 text-xl font-bold text-gray-900 dark:text-white">
                        {{ number_format($stats['total_count'] ?? 0) }} <span
                            class="text-xs font-normal text-gray-500">Item</span>
                    </h3>
                </div>
                <div
                    class="flex h-11 w-11 items-center justify-center rounded-xl bg-blue-50 text-blue-600 dark:bg-blue-500/10 dark:text-blue-400">
                    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M9 12h6m-6 4h6M7 4h10a2 2 0 012 2v12a2 2 0 01-2 2H7a2 2 0 01-2-2V6a2 2 0 012-2z" />
                    </svg>
                </div>
            </div>
            <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Catatan Penerimaan tercatat</p>
        </div>

        <!-- Card 3: Status Posted -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-xs font-medium uppercase tracking-wider text-gray-500 dark:text-gray-400">Diposting</p>
                    <h3 class="mt-2 text-xl font-bold text-emerald-600 dark:text-emerald-400">
                        {{ number_format($stats['posted_count'] ?? 0) }} <span
                            class="text-xs font-normal text-gray-500">Transaksi</span>
                    </h3>
                </div>
                <div
                    class="flex h-11 w-11 items-center justify-center rounded-xl bg-emerald-50 text-emerald-600 dark:bg-emerald-500/10 dark:text-emerald-400">
                    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                </div>
            </div>
            <p class="mt-2 text-xs text-emerald-600 dark:text-emerald-400 font-medium">Sah & Terverifikasi</p>
        </div>

        <!-- Card 4: Status Draft -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-xs font-medium uppercase tracking-wider text-gray-500 dark:text-gray-400">Draft</p>
                    <h3 class="mt-2 text-xl font-bold text-amber-600 dark:text-amber-400">
                        {{ number_format($stats['draft_count'] ?? 0) }} <span
                            class="text-xs font-normal text-gray-500">Transaksi</span>
                    </h3>
                </div>
                <div
                    class="flex h-11 w-11 items-center justify-center rounded-xl bg-amber-50 text-amber-600 dark:bg-amber-500/10 dark:text-amber-400">
                    <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                    </svg>
                </div>
            </div>
            <p class="mt-2 text-xs text-amber-600 dark:text-amber-400 font-medium">Perlu review / posting</p>
        </div>
    </div>

    {{-- MAIN TABLE SECTION --}}
    <div class="space-y-6">
        <x-core.basic-tables.core-table needFilter resetUrl="{{ route('user.transactions.incomes.index') }}">
            {{-- SLOT search --}}
            <x-slot name="search">
                <x-form.input id="searchId" name="name" placeholder="Cari berdasarkan kode atau nama COA..."
                    startIconSearch endIconSearch />
            </x-slot>

            {{-- SLOT Filter --}}
            <x-slot name="filters">
                <x-form.select id="filter_period" name="period_id" placeholder="Pilih Periode">
                    @foreach ($periods as $period)
                        <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                            {{ $period->name }}
                        </option>
                    @endforeach
                </x-form.select>

                <x-form.select id="filter_sub_period" name="sub_period_id" placeholder="Pilih Sub Periode">
                    <option value="">Semua</option>
                    @foreach ($subPeriods as $subPeriod)
                        <option value="{{ $subPeriod->id }}" @selected(request('sub_period_id') == $subPeriod->id)>
                            {{ $subPeriod->name }}
                        </option>
                    @endforeach
                </x-form.select>

                <x-form.date-picker id="start_date" name="start_date" placeholder="Pilih Dari Tanggal"
                    defaultDate="{{ request('start_date') }}" />

                <x-form.date-picker id="end_date" name="end_date" placeholder="Pilih Sampai Tanggal"
                    defaultDate="{{ request('end_date') }}" />
            </x-slot>

            <x-slot name="actions">
                <div class="flex gap-3">
                    <a href="{{ route('user.transactions.incomes.create') }}">
                        <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                            + Buat Transaksi Penerimaan Baru
                        </x-ui.button>
                    </a>
                </div>
            </x-slot>

            <x-core.basic-tables.user.income-table :transactions="$transactions" />
        </x-core.basic-tables.core-table>
    </div>

    {{-- SCRIPT: DEPENDENT SUB PERIOD --}}
    <script>
        const periodFilter = document.getElementById('filter_period');
        const subPeriodFilter = document.getElementById('filter_sub_period');

        periodFilter.addEventListener('change', async function() {

            let periodId = this.value;

            subPeriodFilter.innerHTML = '<option>Loading...</option>';

            if (!periodId) {
                subPeriodFilter.innerHTML = '<option value="">Semua</option>';
                return;
            }

            const res = await fetch(`/bendahara/periods/${periodId}/sub-periods`);
            const data = await res.json();

            subPeriodFilter.innerHTML = '';

            data.forEach(sub => {
                subPeriodFilter.innerHTML += `<option value="${sub.id}">${sub.name}</option>`;
            });
        });
    </script>
@endsection
