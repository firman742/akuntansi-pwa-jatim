@extends('layouts.app')

@section('title', 'Laporan Aktivitas Bendahara')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Laporan Aktifitas" pageTitle="Monitoring Laporan Aktifitas"
        pageDescription="Monitoring Laporan Aktifitas berdasarkan periode" pageIcon="ledger" />

    {{-- FILTER CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-white/[0.03] shadow-sm p-6">
        <form method="GET" class="space-y-6">

            <div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-5">
                    {{-- PERIOD --}}
                    <div class="flex flex-col gap-2">
                        <x-form.select id="filter_period" name="period_id" label="Periode" placeholder="Pilih Periode">
                            @foreach ($periods as $p)
                                <option value="{{ $p->id }}" @selected($periodId == $p->id)>
                                    {{ $p->name }}
                                </option>
                            @endforeach
                        </x-form.select>
                    </div>

                    {{-- SUB PERIOD --}}
                    <div class="flex flex-col gap-2">
                        <x-form.select id="filter_sub_period" name="sub_period_id" label="Sub Periode"
                            placeholder="Pilih Sub Periode">
                            <option value="">Semua</option>
                            @foreach ($subPeriods as $sp)
                                <option value="{{ $sp->id }}" @selected($subPeriodId == $sp->id)>
                                    {{ $sp->name }}
                                </option>
                            @endforeach
                        </x-form.select>
                    </div>
                </div>
            </div>

            {{-- FILTER ACTION --}}
            <div>
                <div class="grid grid-cols md:grid-cols-2 gap-5">
                    <div class="flex flex-col gap-2">
                        <x-ui.button type="submit" variant="primary"
                            class="flex-1 justify-center rounded-xl px-5 py-2.5 shadow-sm">
                            Tampilkan
                        </x-ui.button>

                    </div>
                    <div class="flex flex-col gap-2">
                        <a href="{{ route('bendahara.reports.activity.index') }}" class="flex-1">
                            <x-ui.button variant="outline" class="w-full justify-center rounded-xl px-5 py-2.5">
                                Reset
                            </x-ui.button>
                        </a>
                    </div>
                </div>
            </div>

        </form>
    </div>

    {{-- MAIN REPORT CARD --}}
    <div
        class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-900">

        {{-- HEADER --}}
        <div
            class="flex flex-col justify-between border-b border-gray-200 bg-gray-50 p-6 dark:border-gray-700 dark:bg-gray-800 sm:flex-row sm:items-center">

            <div class="flex items-center gap-4">
                <div>
                    <h2 class="text-xl font-bold text-gray-900 dark:text-gray-100">
                        Laporan Aktivitas
                    </h2>

                    <div
                        class="mt-1 flex flex-wrap items-center gap-x-3 gap-y-1 text-sm font-medium text-gray-500 dark:text-gray-400">

                        <span>
                            Periode :
                            <span class="font-semibold text-blue-600 dark:text-blue-400">
                                {{ $period->name }}
                            </span>
                        </span>

                        <span class="hidden text-gray-300 dark:text-gray-600 md:inline">|</span>

                        <span>
                            Sub :
                            <span class="font-semibold text-blue-600 dark:text-blue-400">
                                {{ $subPeriod->name }}
                            </span>
                        </span>

                    </div>
                </div>
            </div>

            <div class="mt-4 flex flex-col items-end sm:mt-0">

                <p class="text-xs font-semibold uppercase tracking-widest text-gray-500 dark:text-gray-400">
                    Surplus / Defisit
                </p>

                <div class="flex items-baseline gap-1">

                    <span
                        class="text-sm font-bold {{ $surplusDeficit >= 0 ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400' }}">
                        Rp
                    </span>

                    <span
                        class="text-3xl font-extrabold tracking-tight {{ $surplusDeficit >= 0 ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400' }}">
                        {{ number_format(abs($surplusDeficit), 0, ',', '.') }}
                    </span>

                </div>

            </div>
        </div>

        {{-- TABLE --}}
        <div class="overflow-x-auto">

            <table class="w-full border-collapse">

                <thead>

                    <tr
                        class="bg-gray-50 text-xs font-semibold uppercase tracking-wider text-gray-700 dark:bg-gray-800 dark:text-gray-300">

                        <th rowspan="2"
                            class="border-b border-r border-gray-200 px-6 py-4 text-center dark:border-gray-700">
                            Kode Akun
                        </th>

                        <th rowspan="2"
                            class="border-b border-r border-gray-200 px-6 py-4 text-left dark:border-gray-700">
                            Uraian Transaksi
                        </th>

                        <th colspan="2"
                            class="border-b border-gray-200 bg-gray-100 px-6 py-3 text-center font-semibold italic dark:border-gray-700 dark:bg-gray-700">
                            Jumlah Pergerakan
                        </th>

                    </tr>

                    <tr
                        class="bg-gray-100 text-[11px] font-semibold uppercase tracking-wide text-gray-600 dark:bg-gray-700 dark:text-gray-400">

                        <th class="border-b border-gray-200 px-6 py-3 text-center dark:border-gray-700">
                            Debit <br>
                            (Arus Keluar)
                        </th>

                        <th class="border-b border-gray-200 px-6 py-3 text-center dark:border-gray-700">
                            Kredit <br>
                            (Arus Masuk)
                        </th>

                    </tr>

                </thead>

                <tbody class="text-sm">

                    {{-- PENDAPATAN --}}
                    <tr class="bg-blue-600 text-white dark:bg-blue-700">

                        <td
                            class="border-b border-blue-500 px-6 py-3 font-mono text-xs font-bold text-blue-100 dark:border-blue-600">
                            (40000)
                        </td>

                        <td colspan="3"
                            class="border-b border-blue-500 px-6 py-3 font-black uppercase tracking-widest dark:border-blue-600">

                            <div class="flex items-center gap-2">

                                <span class="h-2 w-2 rounded-full bg-blue-300"></span>

                                Pendapatan

                            </div>

                        </td>

                    </tr>

                    @foreach ($revenueData as $index => $item)
                        <tr
                            class="{{ $index % 2 == 0 ? 'bg-gray-50 dark:bg-gray-800' : 'bg-white dark:bg-gray-900' }}
                    border-b border-gray-200 transition-colors hover:bg-gray-100 dark:border-gray-700 dark:hover:bg-gray-800">

                            <td
                                class="border-r border-gray-200 px-6 py-3 text-center font-mono text-xs text-gray-500 dark:border-gray-700 dark:text-gray-400">
                                {{ $item->code }}
                            </td>

                            <td class="border-r border-gray-200 px-6 py-3 dark:border-gray-700"
                                style="padding-left: {{ $item->level * 1.5 + 1.5 }}rem">

                                <span
                                    class="{{ $item->level == 0
                                        ? 'font-bold text-gray-900 dark:text-gray-100'
                                        : 'font-medium text-gray-700 dark:text-gray-300' }}">

                                    {{ $item->name }}

                                </span>

                            </td>

                            <td
                                class="border-r border-gray-200 px-6 py-3 text-right text-gray-400 dark:border-gray-700 dark:text-gray-500">
                                -
                            </td>

                            <td class="px-6 py-3 text-right font-semibold text-blue-600 dark:text-blue-400">

                                {{ $item->total_credit != 0 ? number_format($item->total_credit, 0, ',', '.') : '-' }}

                            </td>

                        </tr>
                    @endforeach

                    {{-- SUBTOTAL --}}
                    <tr class="bg-gray-100 font-semibold dark:bg-gray-800">

                        <td class="border-b border-gray-200 dark:border-gray-700"></td>

                        <td
                            class="border-b border-gray-200 px-6 py-4 text-center text-xs uppercase tracking-widest text-gray-600 dark:border-gray-700 dark:text-gray-300">

                            Subtotal Pendapatan

                        </td>

                        <td
                            class="border-b border-r border-gray-200 px-6 py-4 text-right text-gray-400 dark:border-gray-700 dark:text-gray-500">

                            -

                        </td>

                        <td
                            class="border-b border-gray-200 px-6 py-4 text-right text-lg font-bold text-green-600 dark:border-gray-700 dark:text-green-400">

                            {{ number_format($totalRevenue, 0, ',', '.') }}

                        </td>

                    </tr>

                    {{-- SPACING --}}
                    <tr class="bg-gray-50 dark:bg-gray-800">

                        <td colspan="4" class="border-b border-gray-200 py-3 dark:border-gray-700">
                        </td>

                    </tr>

                    {{-- SECTION BIAYA --}}
                    <tr class="bg-red-600 text-white dark:bg-red-700">

                        <td
                            class="border-b border-red-500 px-6 py-3 font-mono text-xs font-bold text-red-100 dark:border-red-600">
                            (50000)
                        </td>

                        <td colspan="3"
                            class="border-b border-red-500 px-6 py-3 font-black uppercase tracking-widest dark:border-red-600">

                            <div class="flex items-center gap-2">

                                <span class="h-2 w-2 rounded-full bg-red-300"></span>

                                Biaya-Biaya

                            </div>

                        </td>

                    </tr>

                    {{-- expense loop tetap sama, cukup mengikuti pattern row revenue di atas --}}

                </tbody>

                <tfoot>

                    <tr>

                        <td colspan="4" class="p-0">

                            <div
                                class="flex items-center justify-between border-t border-gray-200 p-6 dark:border-gray-700
                        {{ $surplusDeficit >= 0
                            ? 'bg-green-200 text-green-700 dark:bg-green-900/20 dark:text-green-300'
                            : 'bg-red-200 text-red-700 dark:bg-red-900/20 dark:text-red-300' }}">

                                <div class="flex items-center gap-5">

                                    <div
                                        class="flex h-14 w-14 items-center justify-center rounded-2xl
                                {{ $surplusDeficit >= 0 ? 'bg-green-100 dark:bg-green-800/40' : 'bg-red-100 dark:bg-red-800/40' }}">

                                        {{-- icon --}}
                                        @if ($surplusDeficit >= 0)
                                            <svg class="h-8 w-8" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3"
                                                    d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
                                            </svg>
                                        @else
                                            <svg class="h-8 w-8" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3"
                                                    d="M13 17h8m0 0v-8m0 8l-8-8-4 4-6-6" />
                                            </svg>
                                        @endif

                                    </div>

                                    <div>

                                        <p class="text-[10px] font-bold uppercase tracking-[0.3em]">
                                            Summary Report
                                        </p>

                                        <h3 class="text-xl font-black uppercase">

                                            SELISIH
                                            {{ $surplusDeficit >= 0 ? 'SURPLUS' : 'DEFISIT' }}

                                        </h3>

                                    </div>

                                </div>

                                <div class="text-right">

                                    <p class="text-[10px] font-semibold uppercase">
                                        Total Nilai Akhir
                                    </p>

                                    <p class="text-3xl font-black">

                                        Rp{{ number_format(abs($surplusDeficit), 0, ',', '.') }}

                                    </p>

                                </div>

                            </div>

                        </td>

                    </tr>

                </tfoot>

            </table>

        </div>

    </div>


    {{-- SCRIPT DEPENDENT --}}
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

            subPeriodFilter.innerHTML = '<option value="">Semua</option>';

            data.forEach(sub => {
                subPeriodFilter.innerHTML += `<option value="${sub.id}">${sub.name}</option>`;
            });
        });
    </script>
@endsection
