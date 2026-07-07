@extends('layouts.app')

@section('title', 'Buku Besar')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Buku Besar" pageTitle="Monitoring Buku Besar"
        pageDescription="Monitoring Buku Besar berdasarkan periode" pageIcon="ledger" />

    {{-- FILTER CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-white/[0.03] shadow-sm p-6">
        <form method="GET" class="space-y-6">

            {{-- ===================== --}}
            {{-- 1. CONTEXT (PERIOD - SUB - AKUN) --}}
            {{-- ===================== --}}
            <div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                    {{-- PERIOD --}}
                    <div class="flex flex-col gap-2">
                        <x-form.select id="filter_period" name="period_id" label="Periode" placeholder="Pilih Periode">
                            @foreach ($periods as $period)
                                <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                                    {{ $period->name }}
                                </option>
                            @endforeach
                        </x-form.select>
                    </div>

                    {{-- SUB PERIOD --}}
                    <div class="flex flex-col gap-2">
                        <x-form.select id="filter_sub_period" name="sub_period_id" label="Sub Periode"
                            placeholder="Pilih Sub Periode">
                            <option value="">Semua</option>
                            @foreach ($subPeriods as $subPeriod)
                                <option value="{{ $subPeriod->id }}" @selected(request('sub_period_id') == $subPeriod->id)>
                                    {{ $subPeriod->name }}
                                </option>
                            @endforeach
                        </x-form.select>
                    </div>

                    {{-- AKUN --}}
                    <div class="flex flex-col gap-2">
                        <x-form.select id="filter_coa" name="coa_id" label="Akun" placeholder="Pilih Akun">
                            @foreach ($coas as $c)
                                <option value="{{ $c->id }}" @selected(optional($coa)->id === $c->id)>
                                    {{ $c->code }} - {{ $c->name }}
                                </option>
                            @endforeach
                        </x-form.select>
                    </div>

                </div>
            </div>

            {{-- ===================== --}}
            {{-- 2. DATE RANGE --}}
            {{-- ===================== --}}
            <div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">

                    {{-- START DATE --}}
                    <div class="flex flex-col gap-2">
                        <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                            Dari Tanggal
                        </label>
                        <x-form.date-picker id="start_date" name="start_date" defaultDate="{{ request('start_date') }}" />
                    </div>

                    {{-- END DATE --}}
                    <div class="flex flex-col gap-2">
                        <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                            Sampai Tanggal
                        </label>
                        <x-form.date-picker id="end_date" name="end_date" defaultDate="{{ request('end_date') }}" />
                    </div>

                </div>
            </div>
            <div>
                <div class="grid grid-cols md:grid-cols-2 gap-5">
                    {{-- FILTER ACTION --}}
                    <div class="flex items-end gap-3 col-span-1 md:col-span-2 lg:col-span-2">
                        <x-ui.button type="submit" variant="primary"
                            class="flex-1 justify-center rounded-xl px-5 py-2.5 shadow-sm">
                            Tampilkan
                        </x-ui.button>

                        <a href="{{ route('bendahara.reports.ledger.index') }}" class="flex-1">
                            <x-ui.button variant="outline" class="w-full justify-center rounded-xl px-5 py-2.5">
                                Reset
                            </x-ui.button>
                        </a>
                    </div>
                </div>
            </div>
        </form>
    </div>

    {{-- Tombol export pdf & export excel --}}
    <div class="mb-6 flex flex-col items-start gap-3 sm:flex-row sm:items-center sm:justify-end">

        <div class="flex flex-col gap-2 sm:flex-row">
            {{-- Export PDF --}}
            <a href="#" target="_blank">
                <x-ui.button variant="primary" class="flex items-center gap-2 rounded-xl px-4 py-2 shadow-sm">
                    Export PDF
                </x-ui.button>
            </a>

            {{-- Export Excel --}}
            <a href="#">
                <x-ui.button variant="outline" class="flex items-center gap-2 rounded-xl px-4 py-2 shadow-sm">
                    Export Excel
                </x-ui.button>
            </a>
        </div>
    </div>


    {{-- LEDGER TABLE --}}
    @if ($coa)
        <div
            class="overflow-hidden border border-gray-200 bg-white dark:border-gray-700 dark:bg-gray-800 shadow-lg rounded-2xl">
            {{-- HEADER: Lebih Informatif --}}
            <div
                class="flex flex-col justify-between border-b border-gray-200 dark:border-gray-700
                bg-gray-50 dark:bg-gray-900
                p-6 sm:flex-row sm:items-center">
                <div class="flex items-center gap-4">
                    <div>
                        <h2 class="text-2xl font-extrabold text-gray-800 dark:text-gray-100">{{ $coa->name }}</h2>
                        <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                            Kode Akun: <span
                                class="font-mono font-bold text-primary dark:text-primary-light">{{ $coa->code }}</span>
                            <span class="mx-2 text-gray-300 dark:text-gray-500">|</span>
                            Normal: <span
                                class="badge {{ $coa->normal_balance === 'DEBIT' ? 'bg-blue-100 text-blue-700 dark:bg-blue-900/20 dark:text-blue-400' : 'bg-purple-100 text-purple-700 dark:bg-purple-900/20 dark:text-purple-400' }} px-2 py-0.5 rounded text-xs font-bold">{{ $coa->normal_balance }}</span>
                        </p>
                    </div>
                </div>

                <div class="mt-4 flex flex-col items-end sm:mt-0">
                    <p class="text-xs font-bold uppercase tracking-widest text-gray-400 dark:text-gray-500">Total Saldo
                        Akhir</p>
                    <div class="flex items-baseline gap-1">
                        <span class="text-sm font-bold text-gray-500 dark:text-gray-400">Rp</span>
                        <span class="text-3xl font-extrabold tracking-tight text-gray-900 dark:text-gray-100">
                            {{ number_format($endingBalance, 0, ',', '.') }}
                        </span>
                    </div>
                </div>
            </div>

            {{-- TABLE AREA --}}
            <div class="overflow-x-auto">
                <table class="w-full border-separate border-spacing-0">
                    <thead>
                        <tr
                            class="bg-gray-50 dark:bg-gray-900 border-b border-gray-200 dark:border-gray-700 text-xs font-semibold uppercase tracking-wider text-gray-700 dark:text-gray-300">
                            <th rowspan="2"
                                class="sticky top-0 border-b border-gray-200 dark:border-gray-600 px-6 py-4 text-center">
                                Tanggal
                            </th>
                            <th rowspan="2"
                                class="sticky top-0 border-b border-gray-200 dark:border-gray-600 px-6 py-4 text-left">
                                Keterangan
                            </th>
                            <th rowspan="2"
                                class="sticky top-0 border-b border-gray-200 dark:border-gray-600 px-6 py-4 text-left">
                                Pembuat
                            </th>
                            <th rowspan="2"
                                class="sticky top-0 border-b border-gray-200 dark:border-gray-600 px-6 py-4 text-center">
                                Debit
                            </th>
                            <th rowspan="2"
                                class="sticky top-0 border-b border-gray-200 dark:border-gray-600 px-6 py-4 text-center border-r">
                                Kredit
                            </th>
                            <th colspan="2"
                                class="sticky top-0 border-b border-gray-200 dark:border-gray-700 bg-gray-100 dark:bg-gray-800 px-6 py-3 text-center font-semibold">
                                Saldo Kumulatif
                            </th>
                        </tr>
                        <tr
                            class="bg-gray-100 dark:bg-gray-800 text-[11px] font-semibold uppercase tracking-wide text-gray-600 dark:text-gray-400">
                            <th
                                class="border-b border-gray-200 dark:border-gray-600 px-6 py-2 text-center bg-gray-100/30 dark:bg-gray-700/30">
                                Saldo Debit
                            </th>
                            <th
                                class="border-b border-gray-200 dark:border-gray-600 px-6 py-2 text-center bg-gray-100/30 dark:bg-gray-700/30 border-l">
                                Saldo Kredit
                            </th>
                        </tr>
                    </thead>

                    <tbody class="text-sm">
                        {{-- OPENING BALANCE --}}
                        @if ($coa)
                            <tr class="border-b border-blue-100 bg-blue-50 dark:border-blue-900 dark:bg-blue-500/10">
                                <td class="px-6 py-4 text-center font-medium text-blue-700 dark:text-blue-400">
                                    {{ $openingBalanceDate ?? '-' }}
                                </td>
                                <td class="px-6 py-4">
                                    <div class="font-bold text-blue-700 dark:text-blue-300 dark:text-blue-300">
                                        Saldo Awal
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-gray-500 dark:text-gray-400 text-center">
                                    {{ $openingBalanceCreatedBy ?? '-' }}
                                </td>
                                <td class="px-6 py-4 text-right font-semibold text-blue-700 dark:text-blue-400">
                                    {{ $coa->normal_balance === 'DEBIT' ? number_format(abs($openingBalance), 0, ',', '.') : '-' }}
                                </td>
                                <td class="px-6 py-4 text-right font-semibold text-blue-700 dark:text-blue-400 border-r">
                                    {{ $coa->normal_balance === 'CREDIT' ? number_format(abs($openingBalance), 0, ',', '.') : '-' }}
                                </td>
                                <td
                                    class="px-6 py-4 text-right font-bold text-blue-900 dark:text-blue-300 bg-blue-50 dark:bg-blue-900/10">
                                    {{ $coa->normal_balance === 'DEBIT' ? number_format(abs($openingBalance), 0, ',', '.') : '-' }}
                                </td>
                                <td
                                    class="px-6 py-4 text-right font-bold text-blue-900 dark:text-blue-300 bg-blue-50 dark:bg-blue-900/10 border-l">
                                    {{ $coa->normal_balance === 'CREDIT' ? number_format(abs($openingBalance), 0, ',', '.') : '-' }}
                                </td>
                            </tr>
                        @endif

                        {{-- DATA TRANSAKSI --}}
                        @forelse ($ledger as $index => $row)
                            <tr
                                class="{{ $index % 2 === 0 ? 'bg-white dark:bg-gray-900' : 'bg-gray-50 dark:bg-gray-800' }}
                                border-b border-gray-200 dark:border-gray-700
                                hover:bg-gray-100 dark:hover:bg-gray-800
                                transition-colors">
                                <td class="px-6 py-4 text-center text-gray-600 dark:text-gray-400">
                                    {{ $row['date']->format('d M Y') }}
                                </td>
                                <td class="px-6 py-4">
                                    <div class="font-semibold text-gray-800 dark:text-gray-200">{{ $row['description'] }}
                                    </div>
                                    <div class="mt-1 font-light text-gray-700 dark:text-blue-500 tracking-tighter">
                                        {{ $row['ref_code'] }} - {{ $row['ref_name'] }}
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-gray-500 dark:text-gray-400">
                                    {{ $row['posted_by'] }}
                                </td>
                                <td class="px-6 py-4 text-right font-medium text-gray-700 dark:text-gray-300">
                                    {{ $row['debit'] > 0 ? number_format($row['debit'], 0, ',', '.') : '-' }}
                                </td>
                                <td class="px-6 py-4 text-right font-medium text-red-600/80 dark:text-red-400 border-r">
                                    {{ $row['credit'] > 0 ? number_format($row['credit'], 0, ',', '.') : '-' }}
                                </td>
                                <td
                                    class="px-6 py-4 text-right font-bold text-gray-800 dark:text-gray-200 bg-gray-50 dark:bg-gray-800">
                                    {{ $row['normal_balance'] === 'DEBIT' ? number_format($row['current_balance'], 0, ',', '.') : '-' }}
                                </td>
                                <td
                                    class="px-6 py-4 text-right font-bold text-gray-800 dark:text-gray-200 bg-gray-50 dark:bg-gray-800 border-l">
                                    {{ $row['normal_balance'] === 'KREDIT' ? number_format($row['current_balance'], 0, ',', '.') : '-' }}
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="8" class="px-6 py-20 text-center text-gray-400 dark:text-gray-500">
                                    <svg class="w-12 h-12 mx-auto mb-4 opacity-20 dark:opacity-30" fill="none"
                                        stroke="currentColor" viewBox="0 0 24 24">
                                        <path
                                            d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"
                                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                    <p class="text-sm font-medium">Tidak ada transaksi ditemukan pada periode ini.</p>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                    <tfoot>
                        <tr class="border-t-2 border-gray-300 bg-gray-100 dark:border-gray-600 dark:bg-gray-900">
                            <td colspan="5"
                                class="px-6 py-5 text-right text-base font-bold uppercase tracking-wide text-gray-800 dark:text-gray-200">
                                Total Saldo
                            </td>

                            <td
                                class="px-6 py-5 text-right text-lg font-extrabold text-primary dark:text-primary-400 bg-gray-50 dark:bg-gray-800">
                                {{ $coa->normal_balance === 'DEBIT' ? number_format(abs($endingBalance), 0, ',', '.') : '-' }}
                            </td>

                            <td
                                class="border-l border-gray-300 px-6 py-5 text-right text-lg font-extrabold text-primary dark:border-gray-600 dark:text-primary-400 bg-gray-50 dark:bg-gray-800">
                                {{ $coa->normal_balance === 'CREDIT' ? number_format(abs($endingBalance), 0, ',', '.') : '-' }}
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    @endif


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
