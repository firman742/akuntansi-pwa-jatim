@extends('layouts.app')

@section('title', 'Laporan Aktivitas')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Laporan Aktivitas" pageTitle="Monitoring Laporan Aktivitas"
        pageDescription="Laporan Aktivitas Keuangan (Pendapatan & Biaya)" pageIcon="ledger" />

    {{-- FILTER CONTAINER --}}
    <div class="mb-6 rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
        <form method="GET" action="{{ route('bendahara.reports.activity.index') }}" id="filterForm" class="space-y-4">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                {{-- PERIODE --}}
                <x-form.select id="filter_period" name="period_id" label="Periode">
                    @foreach ($periods as $p)
                        <option value="{{ $p->id }}" @selected($period && $period->id == $p->id)>
                            {{ $p->name }}
                        </option>
                    @endforeach
                </x-form.select>

                {{-- SUB PERIODE --}}
                <x-form.select id="filter_sub_period" name="sub_period_id" label="Sub Periode"
                    onchange="this.form.submit()">
                    <option value="">Semua Sub Periode</option>
                    @foreach ($subPeriods as $sp)
                        <option value="{{ $sp->id }}" @selected($subPeriodId == $sp->id)>
                            {{ $sp->name }}
                        </option>
                    @endforeach
                </x-form.select>

                {{-- ACTION BUTTONS --}}
                <div class="flex items-end gap-2">
                    <x-ui.button type="submit" variant="primary" class="flex-1 justify-center rounded-xl py-2.5 text-xs">
                        Tampilkan Data
                    </x-ui.button>
                    <a href="{{ route('bendahara.reports.activity.index') }}" class="flex-1">
                        <x-ui.button type="button" variant="outline"
                            class="w-full justify-center rounded-xl py-2.5 text-xs">
                            Reset Filter
                        </x-ui.button>
                    </a>
                </div>
            </div>
        </form>
    </div>

    {{-- MAIN REPORT CARD --}}
    <div
        class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-xl dark:border-gray-800 dark:bg-gray-900">

        {{-- REPORT HEADER (MATCHING SHEET BANNER) --}}
        <div
            class="border-b border-gray-200 bg-gray-50/80 p-6 dark:border-gray-800 dark:bg-gray-800/50 flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div>
                <span class="text-xs font-bold uppercase tracking-widest text-blue-600 dark:text-blue-400">
                    Laporan Keuangan Nirlaba
                </span>
                <h2 class="text-2xl font-black text-gray-900 dark:text-white uppercase tracking-tight mt-0.5">
                    LAPORAN AKTIVITAS
                </h2>
                <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                    Periode: <span class="font-semibold text-gray-800 dark:text-gray-200">{{ $period->name ?? '-' }}</span>
                    @if ($subPeriod)
                        | Sub Periode: <span
                            class="font-semibold text-gray-800 dark:text-gray-200">{{ $subPeriod->name }}</span>
                    @endif
                </p>
            </div>

            <div
                class="flex items-center gap-3 bg-white dark:bg-gray-800 p-3 rounded-xl border border-gray-200 dark:border-gray-700 shadow-xs">
                <div
                    class="p-2.5 rounded-lg {{ $surplusDeficit >= 0 ? 'bg-emerald-50 text-emerald-600 dark:bg-emerald-900/30 dark:text-emerald-400' : 'bg-rose-50 text-rose-600 dark:bg-rose-900/30 dark:text-rose-400' }}">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="{{ $surplusDeficit >= 0 ? 'M13 7h8m0 0v8m0-8l-8 8-4-4-6 6' : 'M13 17h8m0 0v-8m0 8l-8-8-4 4-6-6' }}" />
                    </svg>
                </div>
                <div>
                    <p class="text-[10px] font-bold uppercase tracking-wider text-gray-400">Hasil Akhir</p>
                    <p
                        class="text-lg font-black {{ $surplusDeficit >= 0 ? 'text-emerald-600 dark:text-emerald-400' : 'text-rose-600 dark:text-rose-400' }}">
                        Rp{{ number_format(abs($surplusDeficit), 0, ',', '.') }}
                        <span class="text-xs font-semibold">({{ $surplusDeficit >= 0 ? 'Surplus' : 'Defisit' }})</span>
                    </p>
                </div>
            </div>
        </div>

        {{-- TABLE CONTAINER --}}
        <div class="overflow-x-auto">
            <table class="w-full border-collapse text-sm">
                <thead>
                    <tr
                        class="bg-gray-100/70 dark:bg-gray-800/80 text-xs font-bold uppercase tracking-wider text-gray-600 dark:text-gray-300 border-b border-gray-200 dark:border-gray-700">
                        <th class="w-32 px-6 py-3.5 text-center border-r border-gray-200 dark:border-gray-700">Kode Akun
                        </th>
                        <th class="px-6 py-3.5 text-left border-r border-gray-200 dark:border-gray-700">Uraian Akun</th>
                        <th class="w-48 px-6 py-3.5 text-right border-r border-gray-200 dark:border-gray-700">Jumlah (Rp)
                        </th>
                        <th class="w-52 px-6 py-3.5 text-right">Total Subkelompok (Rp)</th>
                    </tr>
                </thead>

                <tbody class="divide-y divide-gray-100 dark:divide-gray-800">

                    {{-- ==================== 1. PENDAPATAN (40000) ==================== --}}
                    <tr class="bg-blue-600 text-white dark:bg-blue-700 font-bold">
                        <td class="px-6 py-2.5 text-center font-mono text-xs text-blue-100">40000</td>
                        <td colspan="3" class="px-6 py-2.5 uppercase tracking-wider text-xs">
                            (40000) PENDAPATAN
                        </td>
                    </tr>

                    @foreach ($revenueData as $item)
                        @php
                            $netAmount = ($item->total_credit ?? 0) - ($item->total_debit ?? 0);
                        @endphp
                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors">
                            <td
                                class="px-6 py-2 text-center font-mono text-xs text-gray-400 border-r border-gray-100 dark:border-gray-800">
                                {{ $item->code }}
                            </td>
                            <td
                                class="px-6 py-2 border-r border-gray-100 dark:border-gray-800 text-gray-700 dark:text-gray-300">
                                {{ $item->name }}
                            </td>
                            <td
                                class="px-6 py-2 text-right font-mono text-gray-800 dark:text-gray-200 border-r border-gray-100 dark:border-gray-800">
                                {{ $netAmount != 0 ? number_format($netAmount, 0, ',', '.') : '-' }}
                            </td>
                            <td class="px-6 py-2 text-right text-gray-300 dark:text-gray-700">-</td>
                        </tr>
                    @endforeach

                    {{-- SUBTOTAL PENDAPATAN --}}
                    <tr
                        class="bg-blue-50/60 dark:bg-blue-950/30 font-bold border-t border-b border-blue-200 dark:border-blue-800">
                        <td colspan="2"
                            class="px-6 py-3 text-right text-xs uppercase tracking-wider text-blue-900 dark:text-blue-300">
                            Total Pendapatan
                        </td>
                        <td class="px-6 py-3 border-r border-blue-100 dark:border-blue-900"></td>
                        <td class="px-6 py-3 text-right font-mono text-base text-blue-700 dark:text-blue-400">
                            {{ number_format($totalRevenue, 0, ',', '.') }}
                        </td>
                    </tr>

                    {{-- SPACING ROW --}}
                    <tr class="bg-gray-50/50 dark:bg-gray-900">
                        <td colspan="4" class="py-3"></td>
                    </tr>

                    {{-- ==================== 2. BIAYA-BIAYA (50000) ==================== --}}
                    <tr class="bg-rose-600 text-white dark:bg-rose-700 font-bold">
                        <td class="px-6 py-2.5 text-center font-mono text-xs text-rose-100">50000</td>
                        <td colspan="3" class="px-6 py-2.5 uppercase tracking-wider text-xs">
                            (50000) BIAYA-BIAYA
                        </td>
                    </tr>

                    @foreach ($expenseData as $item)
                        @php
                            $netAmount = ($item->total_debit ?? 0) - ($item->total_credit ?? 0);
                        @endphp
                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors">
                            <td
                                class="px-6 py-2 text-center font-mono text-xs text-gray-400 border-r border-gray-100 dark:border-gray-800">
                                {{ $item->code }}
                            </td>
                            <td
                                class="px-6 py-2 border-r border-gray-100 dark:border-gray-800 text-gray-700 dark:text-gray-300">
                                {{ $item->name }}
                            </td>
                            <td
                                class="px-6 py-2 text-right font-mono text-gray-800 dark:text-gray-200 border-r border-gray-100 dark:border-gray-800">
                                {{ $netAmount != 0 ? number_format($netAmount, 0, ',', '.') : '-' }}
                            </td>
                            <td class="px-6 py-2 text-right text-gray-300 dark:text-gray-700">-</td>
                        </tr>
                    @endforeach

                    {{-- SUBTOTAL BIAYA --}}
                    <tr
                        class="bg-rose-50/60 dark:bg-rose-950/30 font-bold border-t border-b border-rose-200 dark:border-rose-800">
                        <td colspan="2"
                            class="px-6 py-3 text-right text-xs uppercase tracking-wider text-rose-900 dark:text-rose-300">
                            Total Biaya-Biaya
                        </td>
                        <td class="px-6 py-3 border-r border-rose-100 dark:border-rose-900"></td>
                        <td class="px-6 py-3 text-right font-mono text-base text-rose-700 dark:text-rose-400">
                            {{ number_format($totalExpense, 0, ',', '.') }}
                        </td>
                    </tr>

                </tbody>

                {{-- FOOTER SELISIH PENDAPATAN & BIAYA --}}
                <tfoot>
                    <tr class="{{ $surplusDeficit >= 0 ? 'bg-emerald-600 text-white' : 'bg-rose-600 text-white' }}">
                        <td colspan="2" class="px-6 py-4 text-left font-black text-sm uppercase tracking-widest">
                            SELISIH PENDAPATAN & BIAYA (SURPLUS / DEFISIT)
                        </td>
                        <td colspan="2" class="px-6 py-4 text-right font-mono text-xl font-black">
                            Rp{{ number_format($surplusDeficit, 0, ',', '.') }}
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>

    {{-- SCRIPT DYNAMIC SUB-PERIODE FETCH & AUTO SUBMIT --}}
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const periodFilter = document.getElementById('filter_period');
            const subPeriodFilter = document.getElementById('filter_sub_period');
            const filterForm = document.getElementById('filterForm');

            if (periodFilter && subPeriodFilter) {
                periodFilter.addEventListener('change', async function() {
                    let periodId = this.value;
                    subPeriodFilter.innerHTML = '<option value="">Memuat...</option>';

                    if (!periodId) {
                        subPeriodFilter.innerHTML = '<option value="">Semua Sub Periode</option>';
                        filterForm.submit();
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
                    } catch (err) {
                        subPeriodFilter.innerHTML =
                        '<option value="">Gagal memuat sub periode</option>';
                    } finally {
                        filterForm.submit();
                    }
                });
            }
        });
    </script>
@endsection
