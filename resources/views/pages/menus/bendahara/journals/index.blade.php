@extends('layouts.app')

@section('title', 'Jurnal Umum')

@section('styles')
    <link rel="stylesheet" href="{{ asset('build/assets/custom.css') }}">
@endsection

@section('content')
    {{-- BREADCRUMB --}}
    <x-common.page-breadcrumb defaultTitle="Jurnal Umum" pageTitle="Monitoring Jurnal Umum"
        pageDescription="Monitoring transaksi jurnal umum terintegrasi per akun Aset" pageIcon="database" />

    <div class="space-y-6">
        {{-- SUMMARY STATS CARDS --}}
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div
                class="p-5 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm flex items-center justify-between">
                <div>
                    <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Total Transaksi</p>
                    <h3 class="text-2xl font-bold text-gray-900 dark:text-white mt-1">
                        {{ number_format($journals->count()) }}</h3>
                </div>
                <div class="p-3 bg-blue-50 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 rounded-xl">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                </div>
            </div>

            <div
                class="p-5 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm flex items-center justify-between">
                <div>
                    <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Akun Aset Aktif</p>
                    <h3 class="text-2xl font-bold text-indigo-600 dark:text-indigo-400 mt-1">{{ count($groupedJournals) }}
                    </h3>
                </div>
                <div class="p-3 bg-indigo-50 dark:bg-indigo-900/30 text-indigo-600 dark:text-indigo-400 rounded-xl">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 01-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                    </svg>
                </div>
            </div>

            <div
                class="p-5 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm flex items-center justify-between">
                <div>
                    <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Total Debit</p>
                    <h3 class="text-xl font-bold text-emerald-600 dark:text-emerald-400 mt-1">
                        Rp{{ number_format($grandTotalDebit, 0, ',', '.') }}</h3>
                </div>
                <div class="p-3 bg-emerald-50 dark:bg-emerald-900/30 text-emerald-600 dark:text-emerald-400 rounded-xl">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M7 11l5-5m0 0l5 5m-5-5v12" />
                    </svg>
                </div>
            </div>

            <div
                class="p-5 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm flex items-center justify-between">
                <div>
                    <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Total Kredit</p>
                    <h3 class="text-xl font-bold text-rose-600 dark:text-rose-400 mt-1">
                        Rp{{ number_format($grandTotalCredit, 0, ',', '.') }}</h3>
                </div>
                <div class="p-3 bg-rose-50 dark:bg-rose-900/30 text-rose-600 dark:text-rose-400 rounded-xl">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M17 13l-5 5m0 0l-5-5m5 5V6" />
                    </svg>
                </div>
            </div>
        </div>

        {{-- MAIN CARD CONTAINER --}}
        <div
            class="p-6 bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 shadow-sm space-y-6">

            {{-- FORM FILTER & SEARCH --}}
            <form method="GET" action="{{ route('bendahara.reports.journal.index') }}" id="filterForm" class="space-y-4">

                {{-- TOP BAR: SEARCH & PRIMARY FILTERS --}}
                <div class="flex flex-col lg:flex-row gap-4 justify-between items-stretch lg:items-center">
                    {{-- Search Input --}}
                    <div class="w-full lg:w-1/3">
                        <x-form.input id="searchId" name="search" value="{{ request('search') }}"
                            placeholder="Cari No. Jurnal, Keterangan, atau COA..." startIconSearch />
                    </div>

                    {{-- Period & Date Filters --}}
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-3 w-full lg:w-2/3">
                        <x-form.select id="filter_period" name="period_id">
                            <option value="">Semua Periode</option>
                            @foreach ($periods as $period)
                                <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                                    {{ $period->name }}
                                </option>
                            @endforeach
                        </x-form.select>

                        <x-form.select id="filter_sub_period" name="sub_period_id">
                            <option value="">Semua Sub Periode</option>
                            @foreach ($subPeriods as $subPeriod)
                                <option value="{{ $subPeriod->id }}" @selected(request('sub_period_id') == $subPeriod->id)>
                                    {{ $subPeriod->name }}
                                </option>
                            @endforeach
                        </x-form.select>

                        <x-form.date-picker id="start_date" name="start_date" placeholder="Dari Tanggal"
                            defaultDate="{{ request('start_date') }}" />

                        <x-form.date-picker id="end_date" name="end_date" placeholder="Sampai Tanggal"
                            defaultDate="{{ request('end_date') }}" />
                    </div>
                </div>

                <div class="border-t border-gray-200 dark:border-gray-700/60 my-2"></div>

                {{-- SECONDARY BAR: SORTING & ACTIONS (SEPARATED) --}}
                <div
                    class="flex flex-col sm:flex-row gap-4 justify-between items-center bg-gray-50 dark:bg-gray-900/50 p-3.5 rounded-xl border border-gray-100 dark:border-gray-700/50">

                    {{-- SORTING CONTROLS --}}
                    <div class="flex flex-wrap items-center gap-3 w-full sm:w-auto">
                        <span
                            class="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400 flex items-center gap-1.5">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M3 4h13M3 8h9m-9 4h6m4 0l4-4m0 0l4 4m-4-4v12" />
                            </svg>
                            Urutkan:
                        </span>

                        <div class="w-44">
                            <x-form.select id="sort_by" name="sort_by" onchange="this.form.submit()">
                                <option value="journal_date" @selected(request('sort_by', 'journal_date') == 'journal_date')>Tgl Transaksi</option>
                                <option value="journal_number" @selected(request('sort_by') == 'journal_number')>No. Jurnal</option>
                                <option value="created_at" @selected(request('sort_by') == 'created_at')>Waktu Input</option>
                            </x-form.select>
                        </div>

                        <div class="w-48">
                            <x-form.select id="sort_dir" name="sort_dir" onchange="this.form.submit()">
                                <option value="desc" @selected(request('sort_dir', 'desc') == 'desc')>Terbaru (Descending)</option>
                                <option value="asc" @selected(request('sort_dir') == 'asc')>Terlama (Ascending)</option>
                            </x-form.select>
                        </div>
                    </div>

                    {{-- EXPORT & RESET BUTTONS --}}
                    <div class="flex items-center gap-2.5 w-full sm:w-auto justify-end">
                        @if (request()->anyFilled(['search', 'period_id', 'sub_period_id', 'start_date', 'end_date', 'sort_by']))
                            <a href="{{ route('bendahara.reports.journal.index') }}">
                                <x-ui.button type="button" variant="outline" class="rounded-xl px-4 py-2 text-xs">
                                    Reset Filter
                                </x-ui.button>
                            </a>
                        @endif

                        <x-ui.button type="submit" variant="primary" class="rounded-xl px-4 py-2 text-xs">
                            Terapkan Filter
                        </x-ui.button>

                        <a href="{{ route('bendahara.reports.journal.export-pdf', request()->query()) }}"
                            target="_blank">
                            <x-ui.button type="button" variant="outline" class="rounded-xl px-4 py-2 text-xs">
                                PDF
                            </x-ui.button>
                        </a>
                    </div>
                </div>
            </form>

            {{-- COMPONENT TABEL JURNAL --}}
            <x-core.basic-tables.bendahara.journal-table :groupedJournals="$groupedJournals" :journals="$journals" :grandTotalDebit="$grandTotalDebit"
                :grandTotalCredit="$grandTotalCredit" />
        </div>
    </div>

    <script>
        const periodFilter = document.getElementById('filter_period');
        const subPeriodFilter = document.getElementById('filter_sub_period');

        if (periodFilter && subPeriodFilter) {
            periodFilter.addEventListener('change', async function() {
                let periodId = this.value;
                subPeriodFilter.innerHTML = '<option value="">Loading...</option>';

                if (!periodId) {
                    subPeriodFilter.innerHTML = '<option value="">Semua Sub Periode</option>';
                    return;
                }

                try {
                    const res = await fetch(`/bendahara/periods/${periodId}/sub-periods`);
                    const data = await res.json();

                    subPeriodFilter.innerHTML = '<option value="">Semua Sub Periode</option>';
                    data.forEach(sub => {
                        subPeriodFilter.innerHTML += `<option value="${sub.id}">${sub.name}</option>`;
                    });
                } catch (err) {
                    subPeriodFilter.innerHTML = '<option value="">Gagal memuat sub periode</option>';
                }
            });
        }
    </script>
@endsection
