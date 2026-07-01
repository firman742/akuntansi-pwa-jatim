@extends('layouts.app')

@section('title', 'Laporan Neraca')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Laporan Neraca" pageTitle="Monitoring Laporan Neraca"
        pageDescription="Monitoring Laporan Neraca berdasarkan periode" pageIcon="balance" />


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

    {{-- MAIN REPORT CONTAINER --}}
    <div
        class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-xl dark:border-gray-700 dark:bg-gray-800">
        <div class="grid grid-cols-1 lg:grid-cols-2">

            {{-- SISI KIRI: ASET --}}
            <div class="flex flex-col border-r border-gray-100 dark:border-gray-700">
                <div
                    class="bg-slate-50/80 px-6 py-4 border-b border-gray-200 flex justify-between items-center dark:bg-gray-700 dark:border-gray-600">
                    <h3 class="font-bold text-gray-700 tracking-tight uppercase dark:text-gray-200">Aset (Aktiva)</h3>
                    <span
                        class="text-[10px] bg-blue-100 text-blue-700 px-2 py-1 rounded-md font-bold dark:bg-blue-900 dark:text-blue-700">DEBIT</span>
                </div>

                <div class="flex-grow">
                    <table class="w-full text-sm">
                        <tbody>
                            {{-- Header Lancar --}}
                            <tr class="bg-blue-50/40 dark:bg-blue-900/40">
                                <td colspan="3"
                                    class="px-6 py-2 text-[11px] font-bold text-blue-600 uppercase tracking-widest italic border-b border-blue-100/50 dark:text-blue-300 dark:border-blue-800">
                                    Aset Lancar
                                </td>
                            </tr>
                            @php $totalAsetLancar = 0; @endphp
                            @foreach ($data['aset_lancar'] as $index => $item)
                                @php $totalAsetLancar += $item['amount']; @endphp
                                <tr
                                    class="group {{ $index % 2 == 0 ? 'bg-gray-50 dark:bg-gray-700' : 'bg-white dark:bg-gray-800' }} transition hover:bg-gray-100 dark:hover:bg-gray-600">
                                    <td class="px-6 py-3 font-mono text-[10px] text-gray-400 w-20 dark:text-gray-500">
                                        {{ $item['code'] }}</td>
                                    <td class="px-2 py-3 text-gray-600 font-medium dark:text-gray-300">{{ $item['name'] }}
                                    </td>
                                    <td
                                        class="px-6 py-3 text-right font-semibold text-gray-900 tabular-nums dark:text-gray-100">
                                        {{ $item['amount'] < 0 ? '(' . number_format(abs($item['amount']), 0, ',', '.') . ')' : number_format($item['amount'], 0, ',', '.') }}
                                    </td>
                                </tr>
                            @endforeach
                            <tr class="bg-gray-50/30 dark:bg-gray-700">
                                <td colspan="2"
                                    class="px-6 py-3 text-right text-[11px] font-bold text-gray-500 uppercase dark:text-gray-400">
                                    Subtotal
                                    Lancar</td>
                                <td
                                    class="px-6 py-3 text-right font-bold text-blue-600 tabular-nums border-b-2 border-blue-100 dark:text-blue-300 dark:border-blue-800">
                                    {{ number_format($totalAsetLancar, 0, ',', '.') }}
                                </td>
                            </tr>

                            {{-- Header Tidak Lancar --}}
                            <tr class="bg-blue-50/40 dark:bg-blue-900/40">
                                <td colspan="3"
                                    class="px-6 py-2 text-[11px] font-bold text-blue-600 uppercase tracking-widest italic border-b border-blue-100/50 dark:text-blue-300 dark:border-blue-800">
                                    Aset Tidak Lancar
                                </td>
                            </tr>
                            @php $totalAsetTidakLancar = 0; @endphp
                            @foreach ($data['aset_tidak_lancar'] as $index => $item)
                                @php $totalAsetTidakLancar += $item['amount']; @endphp
                                <tr
                                    class="group {{ $index % 2 == 0 ? 'bg-gray-50 dark:bg-gray-700' : 'bg-white dark:bg-gray-800' }} transition hover:bg-gray-100 dark:hover:bg-gray-600">
                                    <td class="px-6 py-3 font-mono text-[10px] text-gray-400 w-20 dark:text-gray-500">
                                        {{ $item['code'] }}</td>
                                    <td class="px-2 py-3 text-gray-600 font-medium dark:text-gray-300">{{ $item['name'] }}
                                    </td>
                                    <td
                                        class="px-6 py-3 text-right font-semibold text-gray-900 tabular-nums dark:text-gray-100">
                                        {{ $item['amount'] < 0 ? '(' . number_format(abs($item['amount']), 0, ',', '.') . ')' : number_format($item['amount'], 0, ',', '.') }}
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>

                <div class="mt-10 bg-blue-100 px-6 py-6 text-blue-600 dark:bg-blue-900 dark:text-blue-300">
                    <div class="flex justify-between items-end">
                        <div>
                            <p
                                class="text-[10px] font-bold text-blue-400 uppercase tracking-[0.2em] mb-1 dark:text-blue-500">
                                Total Aktiva</p>
                            <h4 class="text-lg font-bold">Total Nilai Aset</h4>
                        </div>
                        <div class="text-2xl font-black tabular-nums tracking-tighter text-blue-400 dark:text-blue-200">
                            Rp{{ number_format($totalAsetLancar + $totalAsetTidakLancar, 0, ',', '.') }}
                        </div>
                    </div>
                </div>
            </div>

            {{-- SISI KANAN: PASIVA --}}
            <div class="flex flex-col">

                {{-- HEADER --}}
                <div
                    class="flex items-center justify-between border-b border-gray-200 bg-slate-50/80 px-6 py-4 dark:border-gray-600 dark:bg-gray-700">
                    <h3 class="font-bold uppercase tracking-tight text-gray-700 dark:text-gray-200">
                        Pasiva
                    </h3>

                    <span
                        class="rounded-md bg-green-100 px-2 py-1 text-[10px] font-bold text-green-700 dark:bg-green-900/40 dark:text-green-300">
                        KREDIT
                    </span>
                </div>

                <div class="flex-grow">
                    <table class="w-full text-sm">
                        <tbody>

                            {{-- EKUITAS --}}
                            <tr class="bg-green-50/40 dark:bg-green-900/40">
                                <td colspan="3"
                                    class="border-b border-green-100/50 px-6 py-2 text-[11px] font-bold uppercase italic tracking-widest text-green-700 dark:border-green-800 dark:text-green-300">
                                    Ekuitas (Modal)
                                </td>
                            </tr>

                            <tr
                                class="group bg-gray-50 transition hover:bg-gray-100 dark:bg-gray-700 dark:hover:bg-gray-600">
                                <td class="w-20 px-6 py-3 font-mono text-[10px] text-gray-400 dark:text-gray-500">
                                    31000
                                </td>

                                <td class="px-2 py-3 font-medium text-gray-600 dark:text-gray-300">
                                    Modal Tetap
                                </td>

                                <td
                                    class="px-6 py-3 text-right font-semibold tabular-nums text-gray-900 dark:text-gray-100">
                                    {{ number_format($modalTetap, 0, ',', '.') }}
                                </td>
                            </tr>

                            <tr class="group bg-white transition hover:bg-gray-100 dark:bg-gray-800 dark:hover:bg-gray-600">
                                <td class="w-20 px-6 py-3 font-mono text-[10px] text-gray-400 dark:text-gray-500">
                                    32000
                                </td>

                                <td class="px-2 py-3 font-medium text-gray-600 dark:text-gray-300">
                                    Modal Lancar
                                </td>

                                <td
                                    class="px-6 py-3 text-right font-semibold tabular-nums text-gray-900 dark:text-gray-100">
                                    {{ number_format($modalLancar, 0, ',', '.') }}
                                </td>
                            </tr>

                            <tr class="bg-green-50/30 dark:bg-green-900/30">
                                <td class="px-6 py-3 text-center font-mono text-[10px] text-gray-400 dark:text-gray-500">
                                    -
                                </td>

                                <td class="px-2 py-3 font-bold italic text-green-700 dark:text-green-300">
                                    Surplus / Defisit Berjalan
                                </td>

                                <td class="px-6 py-3 text-right font-black tabular-nums text-green-700 dark:text-green-300">
                                    {{ number_format($surplusDeficit, 0, ',', '.') }}
                                </td>
                            </tr>

                            {{-- KEWAJIBAN --}}
                            <tr class="border-t border-gray-200 bg-green-50/40 dark:border-gray-700 dark:bg-green-900/40">
                                <td colspan="3"
                                    class="border-b border-green-100/50 px-6 py-3 text-[11px] font-bold uppercase italic tracking-widest text-green-700 dark:border-green-800 dark:text-green-300">
                                    Kewajiban (Hutang)
                                </td>
                            </tr>

                            @php
                                $totalHutangVal = 0;
                            @endphp

                            @foreach ($data['hutang'] as $index => $item)
                                @php
                                    $totalHutangVal += $item['amount'];
                                @endphp

                                <tr
                                    class="group {{ $index % 2 == 0 ? 'bg-gray-50 dark:bg-gray-700' : 'bg-white dark:bg-gray-800' }} transition hover:bg-gray-100 dark:hover:bg-gray-600">

                                    <td class="w-20 px-6 py-3 font-mono text-[10px] text-gray-400 dark:text-gray-500">
                                        {{ $item['code'] }}
                                    </td>

                                    <td class="px-2 py-3 font-medium text-gray-600 dark:text-gray-300">
                                        {{ $item['name'] }}
                                    </td>

                                    <td
                                        class="px-6 py-3 text-right font-semibold tabular-nums text-gray-900 dark:text-gray-100">
                                        {{ number_format($item['amount'], 0, ',', '.') }}
                                    </td>

                                </tr>
                            @endforeach

                            {{-- SUBTOTAL --}}
                            <tr class="bg-green-50/30 dark:bg-green-900/30">

                                <td colspan="2"
                                    class="px-6 py-3 text-right text-[11px] font-bold uppercase text-gray-500 dark:text-gray-400">
                                    Subtotal Hutang
                                </td>

                                <td
                                    class="border-b-2 border-green-100 px-6 py-3 text-right font-bold tabular-nums text-green-700 dark:border-green-800 dark:text-green-300">
                                    {{ number_format($totalHutangVal, 0, ',', '.') }}
                                </td>

                            </tr>

                        </tbody>
                    </table>
                </div>

                {{-- TOTAL PASIVA --}}
                <div class="mt-10 bg-green-100 px-6 py-6 text-green-700 dark:bg-green-900/40 dark:text-green-300">

                    <div class="flex items-end justify-between">

                        <div>

                            <p
                                class="mb-1 text-[10px] font-bold uppercase tracking-[0.2em] text-slate-400 dark:text-slate-500">
                                Total Pasiva
                            </p>

                            <h4 class="text-lg font-bold">
                                Hutang & Modal
                            </h4>

                        </div>

                        <div class="text-2xl font-black tracking-tighter tabular-nums text-green-500 dark:text-green-200">
                            Rp{{ number_format($modalTetap + $modalLancar + $surplusDeficit + $totalHutangVal, 0, ',', '.') }}
                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>

    {{-- STATUS BAR --}}
    <div
        class="mt-4 flex items-center justify-center gap-4 py-4 border-4 border-dashed border-gray-600 rounded-2xl bg-gray-50/50 shadow-sm dark:bg-gray-700 dark:border-gray-600">
        <div class="flex items-center gap-2">
            <div class="w-2 h-2 rounded-full bg-green-500 animate-pulse dark:bg-green-300"></div>
            <span class="text-xs font-bold text-gray-500 uppercase tracking-widest dark:text-gray-300">Status
                Laporan:</span>
        </div>
        <div
            class="px-4 py-1 bg-green-500 text-white text-xs font-black rounded-full shadow-sm italic tracking-widest dark:bg-green-700 dark:text-green-200">
            SEIMBANG / BALANCED
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
