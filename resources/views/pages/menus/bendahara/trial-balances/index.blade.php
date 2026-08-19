@extends('layouts.app')

@section('title', 'Laporan Neraca (Balance Sheet)')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Laporan Neraca" pageTitle="Monitoring Laporan Neraca"
        pageDescription="Posisi Keuangan (Aset, Kewajiban, dan Ekuitas) Terintegrasi" pageIcon="balance" />

    {{-- TOP SUMMARY CARDS & STATUS --}}
    <div class="mb-6 grid grid-cols-1 md:grid-cols-3 gap-4">
        {{-- Total Aktiva --}}
        <div
            class="p-5 bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 shadow-sm flex items-center justify-between">
            <div>
                <p class="text-xs font-bold text-blue-600 dark:text-blue-400 uppercase tracking-wider">Total Aktiva (Aset)
                </p>
                <h3 class="text-2xl font-black text-gray-900 dark:text-white mt-1 tabular-nums">
                    Rp{{ number_format($totalAktiva, 0, ',', '.') }}
                </h3>
            </div>
            <div class="p-3 bg-blue-50 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 rounded-xl">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 6l9-4 9 4v12l-9 4-9-4V6z" />
                </svg>
            </div>
        </div>

        {{-- Total Pasiva --}}
        <div
            class="p-5 bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 shadow-sm flex items-center justify-between">
            <div>
                <p class="text-xs font-bold text-emerald-600 dark:text-emerald-400 uppercase tracking-wider">Total Pasiva
                    (Kewajiban & Ekuitas)</p>
                <h3 class="text-2xl font-black text-gray-900 dark:text-white mt-1 tabular-nums">
                    Rp{{ number_format($totalPasiva, 0, ',', '.') }}
                </h3>
            </div>
            <div class="p-3 bg-emerald-50 dark:bg-emerald-900/30 text-emerald-600 dark:text-emerald-400 rounded-xl">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
            </div>
        </div>

        {{-- Status Balance Banner Card --}}
        <div
            class="p-5 bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 shadow-sm flex items-center justify-between">
            <div>
                <p class="text-xs font-bold text-gray-400 uppercase tracking-wider">Status Neraca</p>
                <div class="mt-1 flex items-center gap-2">
                    <span
                        class="inline-flex items-center px-3 py-1 rounded-full text-xs font-black uppercase tracking-wider {{ $isBalanced ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/40 dark:text-emerald-300' : 'bg-rose-100 text-rose-700 dark:bg-rose-900/40 dark:text-rose-300' }}">
                        <span
                            class="w-2 h-2 rounded-full mr-1.5 {{ $isBalanced ? 'bg-emerald-500 animate-pulse' : 'bg-rose-500 animate-bounce' }}"></span>
                        {{ $isBalanced ? 'SEIMBANG / BALANCED' : 'TIDAK SEIMBANG' }}
                    </span>
                </div>
            </div>
            <div
                class="p-3 {{ $isBalanced ? 'bg-emerald-50 text-emerald-600 dark:bg-emerald-900/30 dark:text-emerald-400' : 'bg-rose-50 text-rose-600 dark:bg-rose-900/30 dark:text-rose-400' }} rounded-xl">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 6h18M3 12h18M3 18h18" />
                </svg>
            </div>
        </div>
    </div>

    {{-- FILTER CONTAINER --}}
    <div class="mb-6 rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
        <form method="GET" action="{{ route('bendahara.reports.trial-balance.index') }}" id="filterForm"
            class="space-y-4">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                {{-- PERIODE --}}
                <x-form.select id="filter_period" name="period_id" label="Periode">
                    @foreach ($periods as $p)
                        <option value="{{ $p->id }}" @selected($periodId == $p->id)>
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

                {{-- ACTIONS --}}
                <div class="flex items-end gap-2">
                    <x-ui.button type="submit" variant="primary" class="flex-1 justify-center rounded-xl py-2.5 text-xs">
                        Tampilkan Data
                    </x-ui.button>
                    <a href="{{ route('bendahara.reports.trial-balance.index') }}" class="flex-1">
                        <x-ui.button type="button" variant="outline"
                            class="w-full justify-center rounded-xl py-2.5 text-xs">
                            Reset Filter
                        </x-ui.button>
                    </a>
                </div>
            </div>
        </form>
    </div>

    {{-- MAIN REPORT CONTAINER --}}
    <div
        class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-xl dark:border-gray-800 dark:bg-gray-900">

        {{-- REPORT HEADER --}}
        <div
            class="border-b border-gray-200 bg-gray-50/80 p-6 dark:border-gray-800 dark:bg-gray-800/50 flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div>
                <span class="text-xs font-bold uppercase tracking-widest text-blue-600 dark:text-blue-400">
                    Laporan Posisi Keuangan
                </span>
                <h2 class="text-2xl font-black text-gray-900 dark:text-white uppercase tracking-tight mt-0.5">
                    LAPORAN NERACA
                </h2>
                <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                    Periode: <span
                        class="font-semibold text-gray-800 dark:text-gray-200">{{ $selectedPeriod->name ?? '-' }}</span>
                    @if ($subPeriodId)
                        @php $spName = $subPeriods->firstWhere('id', $subPeriodId)->name ?? ''; @endphp
                        | Sub Periode: <span
                            class="font-semibold text-gray-800 dark:text-gray-200">{{ $spName }}</span>
                    @endif
                </p>
            </div>
        </div>

        {{-- TWO-COLUMN NERACA GRID --}}
        <div
            class="grid grid-cols-1 lg:grid-cols-2 divide-y lg:divide-y-0 lg:divide-x divide-gray-200 dark:divide-gray-800">

            {{-- SISI KIRI: AKTIVA (ASET) --}}
            <div class="flex flex-col">
                <div
                    class="bg-blue-50/70 dark:bg-blue-950/40 px-6 py-3.5 border-b border-gray-200 dark:border-gray-800 flex justify-between items-center">
                    <h3 class="font-black text-blue-900 dark:text-blue-300 text-sm tracking-wide uppercase">SISI AKTIVA
                        (ASET)</h3>
                    <span
                        class="text-[10px] bg-blue-100 text-blue-700 px-2.5 py-1 rounded-md font-bold dark:bg-blue-900/60 dark:text-blue-300">DEBIT</span>
                </div>

                <div class="flex-grow">
                    <table class="w-full text-sm">
                        <tbody class="divide-y divide-gray-100 dark:divide-gray-800/60">
                            {{-- Section: Aset Lancar --}}
                            <tr class="bg-gray-100/60 dark:bg-gray-800/60">
                                <td colspan="3"
                                    class="px-6 py-2.5 text-xs font-bold text-gray-700 dark:text-gray-300 uppercase tracking-wider">
                                    1. Aset Lancar
                                </td>
                            </tr>
                            @foreach ($data['aset_lancar'] as $index => $item)
                                <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/40 transition-colors">
                                    <td class="px-6 py-2.5 font-mono text-xs text-gray-400 w-24">
                                        {{ $item['code'] }}
                                    </td>
                                    <td class="px-2 py-2.5 text-gray-700 dark:text-gray-300 font-medium">
                                        {{ $item['name'] }}
                                    </td>
                                    <td
                                        class="px-6 py-2.5 text-right font-mono font-semibold text-gray-900 dark:text-gray-100 tabular-nums">
                                        {{ $item['amount'] < 0 ? '(' . number_format(abs($item['amount']), 0, ',', '.') . ')' : ($item['amount'] != 0 ? number_format($item['amount'], 0, ',', '.') : '-') }}
                                    </td>
                                </tr>
                            @endforeach
                            <tr
                                class="bg-blue-50/30 dark:bg-blue-900/20 font-bold border-t border-blue-100 dark:border-blue-900">
                                <td colspan="2"
                                    class="px-6 py-2.5 text-right text-xs uppercase text-blue-800 dark:text-blue-300">
                                    Subtotal Aset Lancar
                                </td>
                                <td class="px-6 py-2.5 text-right font-mono text-blue-700 dark:text-blue-300 tabular-nums">
                                    {{ number_format($totalAsetLancar, 0, ',', '.') }}
                                </td>
                            </tr>

                            {{-- Section: Aset Tidak Lancar --}}
                            <tr class="bg-gray-100/60 dark:bg-gray-800/60">
                                <td colspan="3"
                                    class="px-6 py-2.5 text-xs font-bold text-gray-700 dark:text-gray-300 uppercase tracking-wider">
                                    2. Aset Tidak Lancar
                                </td>
                            </tr>
                            @foreach ($data['aset_tidak_lancar'] as $index => $item)
                                <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/40 transition-colors">
                                    <td class="px-6 py-2.5 font-mono text-xs text-gray-400 w-24">
                                        {{ $item['code'] }}
                                    </td>
                                    <td class="px-2 py-2.5 text-gray-700 dark:text-gray-300 font-medium">
                                        {{ $item['name'] }}
                                    </td>
                                    <td
                                        class="px-6 py-2.5 text-right font-mono font-semibold text-gray-900 dark:text-gray-100 tabular-nums">
                                        {{ $item['amount'] < 0 ? '(' . number_format(abs($item['amount']), 0, ',', '.') . ')' : ($item['amount'] != 0 ? number_format($item['amount'], 0, ',', '.') : '-') }}
                                    </td>
                                </tr>
                            @endforeach
                            <tr
                                class="bg-blue-50/30 dark:bg-blue-900/20 font-bold border-t border-blue-100 dark:border-blue-900">
                                <td colspan="2"
                                    class="px-6 py-2.5 text-right text-xs uppercase text-blue-800 dark:text-blue-300">
                                    Subtotal Aset Tidak Lancar
                                </td>
                                <td class="px-6 py-2.5 text-right font-mono text-blue-700 dark:text-blue-300 tabular-nums">
                                    {{ number_format($totalAsetTidakLancar, 0, ',', '.') }}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                {{-- FOOTER TOTAL AKTIVA --}}
                <div class="bg-blue-600 dark:bg-blue-700 px-6 py-4 text-white mt-auto">
                    <div class="flex justify-between items-center">
                        <div>
                            <p class="text-[10px] font-bold uppercase tracking-widest text-blue-200">Total Keseluruhan</p>
                            <h4 class="text-base font-black uppercase">TOTAL AKTIVA (ASET)</h4>
                        </div>
                        <div class="text-xl font-mono font-black tabular-nums">
                            Rp{{ number_format($totalAktiva, 0, ',', '.') }}
                        </div>
                    </div>
                </div>
            </div>

            {{-- SISI KANAN: PASIVA (KEWAJIBAN & EKUITAS) --}}
            <div class="flex flex-col">
                <div
                    class="bg-emerald-50/70 dark:bg-emerald-950/40 px-6 py-3.5 border-b border-gray-200 dark:border-gray-800 flex justify-between items-center">
                    <h3 class="font-black text-emerald-900 dark:text-emerald-300 text-sm tracking-wide uppercase">SISI
                        PASIVA (KEWAJIBAN & EKUITAS)</h3>
                    <span
                        class="text-[10px] bg-emerald-100 text-emerald-700 px-2.5 py-1 rounded-md font-bold dark:bg-emerald-900/60 dark:text-emerald-300">KREDIT</span>
                </div>

                <div class="flex-grow">
                    <table class="w-full text-sm">
                        <tbody class="divide-y divide-gray-100 dark:divide-gray-800/60">
                            {{-- Section: Ekuitas / Modal --}}
                            <tr class="bg-gray-100/60 dark:bg-gray-800/60">
                                <td colspan="3"
                                    class="px-6 py-2.5 text-xs font-bold text-gray-700 dark:text-gray-300 uppercase tracking-wider">
                                    1. Ekuitas (Modal)
                                </td>
                            </tr>
                            <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/40 transition-colors">
                                <td class="px-6 py-2.5 font-mono text-xs text-gray-400 w-24">31000</td>
                                <td class="px-2 py-2.5 text-gray-700 dark:text-gray-300 font-medium">Modal Tetap</td>
                                <td
                                    class="px-6 py-2.5 text-right font-mono font-semibold text-gray-900 dark:text-gray-100 tabular-nums">
                                    {{ number_format($modalTetap, 0, ',', '.') }}
                                </td>
                            </tr>
                            <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/40 transition-colors">
                                <td class="px-6 py-2.5 font-mono text-xs text-gray-400 w-24">32000</td>
                                <td class="px-2 py-2.5 text-gray-700 dark:text-gray-300 font-medium">Modal Lancar</td>
                                <td
                                    class="px-6 py-2.5 text-right font-mono font-semibold text-gray-900 dark:text-gray-100 tabular-nums">
                                    {{ number_format($modalLancar, 0, ',', '.') }}
                                </td>
                            </tr>
                            <tr class="bg-emerald-50/40 dark:bg-emerald-950/20 hover:bg-emerald-50/60 transition-colors">
                                <td class="px-6 py-2.5 font-mono text-xs text-emerald-600 dark:text-emerald-400 w-24">-
                                </td>
                                <td class="px-2 py-2.5 text-emerald-800 dark:text-emerald-300 font-bold italic">Surplus /
                                    Defisit Berjalan</td>
                                <td
                                    class="px-6 py-2.5 text-right font-mono font-bold text-emerald-700 dark:text-emerald-300 tabular-nums">
                                    {{ number_format($surplusDeficit, 0, ',', '.') }}
                                </td>
                            </tr>

                            {{-- Section: Kewajiban (Hutang) --}}
                            <tr class="bg-gray-100/60 dark:bg-gray-800/60 border-t border-gray-200 dark:border-gray-800">
                                <td colspan="3"
                                    class="px-6 py-2.5 text-xs font-bold text-gray-700 dark:text-gray-300 uppercase tracking-wider">
                                    2. Kewajiban (Hutang)
                                </td>
                            </tr>
                            @foreach ($data['hutang'] as $index => $item)
                                <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/40 transition-colors">
                                    <td class="px-6 py-2.5 font-mono text-xs text-gray-400 w-24">
                                        {{ $item['code'] }}
                                    </td>
                                    <td class="px-2 py-2.5 text-gray-700 dark:text-gray-300 font-medium">
                                        {{ $item['name'] }}
                                    </td>
                                    <td
                                        class="px-6 py-2.5 text-right font-mono font-semibold text-gray-900 dark:text-gray-100 tabular-nums">
                                        {{ $item['amount'] != 0 ? number_format($item['amount'], 0, ',', '.') : '-' }}
                                    </td>
                                </tr>
                            @endforeach
                            <tr
                                class="bg-emerald-50/30 dark:bg-emerald-900/20 font-bold border-t border-emerald-100 dark:border-emerald-900">
                                <td colspan="2"
                                    class="px-6 py-2.5 text-right text-xs uppercase text-emerald-800 dark:text-emerald-300">
                                    Subtotal Kewajiban
                                </td>
                                <td
                                    class="px-6 py-2.5 text-right font-mono text-emerald-700 dark:text-emerald-300 tabular-nums">
                                    {{ number_format($totalHutang, 0, ',', '.') }}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                {{-- FOOTER TOTAL PASIVA --}}
                <div class="bg-emerald-600 dark:bg-emerald-700 px-6 py-4 text-white mt-auto">
                    <div class="flex justify-between items-center">
                        <div>
                            <p class="text-[10px] font-bold uppercase tracking-widest text-emerald-200">Total Keseluruhan
                            </p>
                            <h4 class="text-base font-black uppercase">TOTAL PASIVA (HUTANG & MODAL)</h4>
                        </div>
                        <div class="text-xl font-mono font-black tabular-nums">
                            Rp{{ number_format($totalPasiva, 0, ',', '.') }}
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    {{-- SCRIPT AUTO SUBMIT & AJAX --}}
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
