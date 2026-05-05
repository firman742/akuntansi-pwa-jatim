@extends('layouts.app')

@section('title', 'Neraca (Balance Sheet)')

@section('content')
    <x-common.page-breadcrumb pageTitle="Neraca (Balance Sheet)" />


    {{-- FILTER CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
        <form method="GET">

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5">

                {{-- PERIOD --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">Periode</label>
                    <select name="period_id" id="filter_period"
                        class="w-full rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm">
                        @foreach ($periods as $p)
                            <option value="{{ $p->id }}" @selected($periodId == $p->id)>
                                {{ $p->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                {{-- SUB PERIOD --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">Sub Periode</label>
                    <select name="sub_period_id" id="filter_sub_period"
                        class="w-full rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm">
                        <option value="">Semua</option>
                        @foreach ($subPeriods as $sp)
                            <option value="{{ $sp->id }}" @selected($subPeriodId == $sp->id)>
                                {{ $sp->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                {{-- FILTER ACTION --}}
                <div class="flex items-end gap-3 col-span-1 md:col-span-2 lg:col-span-2">
                    <x-ui.button type="submit" variant="primary"
                        class="flex-1 justify-center rounded-xl px-5 py-2.5 shadow-sm">
                        Tampilkan
                    </x-ui.button>

                    <a href="{{ route('bendahara.reports.trial-balance.index') }}" class="flex-1">
                        <x-ui.button variant="outline" class="w-full justify-center rounded-xl px-5 py-2.5">
                            Reset
                        </x-ui.button>
                    </a>
                </div>
            </div>

        </form>
    </div>

    {{-- MAIN REPORT CONTAINER --}}
    <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-xl">
        <div class="grid grid-cols-1 lg:grid-cols-2">

            {{-- SISI KIRI: ASET --}}
            <div class="flex flex-col border-r border-gray-100">
                <div class="bg-slate-50/80 px-6 py-4 border-b border-gray-200 flex justify-between items-center">
                    <h3 class="font-bold text-gray-700 tracking-tight uppercase">Aset (Aktiva)</h3>
                    <span class="text-[10px] bg-blue-100 text-blue-700 px-2 py-1 rounded-md font-bold">DEBIT</span>
                </div>

                <div class="flex-grow">
                    <table class="w-full text-sm">
                        <tbody>
                            {{-- Header Lancar --}}
                            <tr class="bg-blue-50/40">
                                <td colspan="3"
                                    class="px-6 py-2 text-[11px] font-bold text-blue-600 uppercase tracking-widest italic border-b border-blue-100/50">
                                    Aset Lancar
                                </td>
                            </tr>
                            @php $totalAsetLancar = 0; @endphp
                            @foreach ($data['aset_lancar'] as $index => $item)
                                @php $totalAsetLancar += $item['amount']; @endphp
                                <tr class="group {{ $index % 2 == 0 ? 'bg-gray-50 dark:bg-white/[0.02]' : 'bg-white dark:bg-white/[0.03]' }} transition hover:bg-gray-100">
                                    <td class="px-6 py-3 font-mono text-[10px] text-gray-400 w-20">{{ $item['code'] }}</td>
                                    <td class="px-2 py-3 text-gray-600 font-medium">{{ $item['name'] }}</td>
                                    <td class="px-6 py-3 text-right font-semibold text-gray-900 tabular-nums">
                                        {{ $item['amount'] < 0 ? '(' . number_format(abs($item['amount']), 0, ',', '.') . ')' : number_format($item['amount'], 0, ',', '.') }}
                                    </td>
                                </tr>
                            @endforeach
                            <tr class="bg-gray-50/30">
                                <td colspan="2"
                                    class="px-6 py-3 text-right text-[11px] font-bold text-gray-500 uppercase">Subtotal
                                    Lancar</td>
                                <td
                                    class="px-6 py-3 text-right font-bold text-blue-600 tabular-nums border-b-2 border-blue-100">
                                    {{ number_format($totalAsetLancar, 0, ',', '.') }}
                                </td>
                            </tr>

                            {{-- Header Tidak Lancar --}}
                            <tr class="bg-blue-50/40">
                                <td colspan="3"
                                    class="px-6 py-2 text-[11px] font-bold text-blue-600 uppercase tracking-widest italic border-b border-blue-100/50">
                                    Aset Tidak Lancar
                                </td>
                            </tr>
                            @php $totalAsetTidakLancar = 0; @endphp
                            @foreach ($data['aset_tidak_lancar'] as $index => $item)
                                @php $totalAsetTidakLancar += $item['amount']; @endphp
                                <tr class="group {{ $index % 2 == 0 ? 'bg-gray-50 dark:bg-white/[0.02]' : 'bg-white dark:bg-white/[0.03]' }} transition hover:bg-gray-100">
                                    <td class="px-6 py-3 font-mono text-[10px] text-gray-400 w-20">{{ $item['code'] }}</td>
                                    <td class="px-2 py-3 text-gray-600 font-medium">{{ $item['name'] }}</td>
                                    <td class="px-6 py-3 text-right font-semibold text-gray-900 tabular-nums">
                                        {{ $item['amount'] < 0 ? '(' . number_format(abs($item['amount']), 0, ',', '.') . ')' : number_format($item['amount'], 0, ',', '.') }}
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>

                <div class="mt-10 bg-blue-100 px-6 py-6 text-blue-600">
                    <div class="flex justify-between items-end">
                        <div>
                            <p class="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em] mb-1">Total Aktiva</p>
                            <h4 class="text-lg font-bold">Total Nilai Aset</h4>
                        </div>
                        <div class="text-2xl font-black tabular-nums tracking-tighter text-blue-400">
                            Rp{{ number_format($totalAsetLancar + $totalAsetTidakLancar, 0, ',', '.') }}
                        </div>
                    </div>
                </div>
            </div>

            {{-- SISI KANAN: PASIVA --}}
            <div class="flex flex-col bg-white">
                <div class="bg-slate-50/80 px-6 py-4 border-b border-gray-200 flex justify-between items-center">
                    <h3 class="font-bold text-gray-700 tracking-tight uppercase">Pasiva</h3>
                    <span class="text-[10px] bg-green-100 text-green-700 px-2 py-1 rounded-md font-bold">KREDIT</span>
                </div>

                <div class="flex-grow">
                    <table class="w-full text-sm">
                        <tbody>
                            {{-- Header Ekuitas --}}
                            <tr class="bg-green-50/40">
                                <td colspan="3"
                                    class="px-6 py-2 text-[11px] font-bold text-green-700 uppercase tracking-widest italic border-b border-green-100/50">
                                    Ekuitas (Modal)
                                </td>
                            </tr>
                            <tr class="border-b border-gray-50 bg-gray-50 dark:bg-white/[0.02] hover:bg-gray-50/80 transition-colors">
                                <td class="px-6 py-3 font-mono text-[10px] text-gray-400 w-20">31000</td>
                                <td class="px-2 py-3 text-gray-600 font-medium">Modal Tetap</td>
                                <td class="px-6 py-3 text-right font-semibold text-gray-900 tabular-nums">
                                    {{ number_format($modalTetap, 0, ',', '.') }}</td>
                            </tr>
                            <tr class="border-b border-gray-50 bg-white dark:bg-white/[0.03] hover:bg-gray-50/80 transition-colors">
                                <td class="px-6 py-3 font-mono text-[10px] text-gray-400 w-20">32000</td>
                                <td class="px-2 py-3 text-gray-600 font-medium">Modal Lancar</td>
                                <td class="px-6 py-3 text-right font-semibold text-gray-900 tabular-nums">
                                    {{ number_format($modalLancar, 0, ',', '.') }}</td>
                            </tr>
                            <tr class="bg-green-50/20">
                                <td class="px-6 py-3 text-center text-gray-300 font-mono text-[10px]">-</td>
                                <td class="px-2 py-3 text-green-800 font-bold italic">Surplus/Defisit Berjalan</td>
                                <td class="px-6 py-3 text-right font-black text-green-700 tabular-nums">
                                    {{ number_format($surplusDeficit, 0, ',', '.') }}</td>
                            </tr>

                            {{-- Header Kewajiban --}}
                            <tr class="bg-green-50/40 border-t border-gray-100">
                                <td colspan="3"
                                    class="px-6 py-2 text-[11px] font-bold text-green-700 uppercase tracking-widest italic border-b border-green-100/50">
                                    Kewajiban (Hutang)
                                </td>
                            </tr>
                            @php $totalHutangVal = 0; @endphp
                            @foreach ($data['hutang'] as $index => $item)
                                @php $totalHutangVal += $item['amount']; @endphp
                                <tr class="group {{ $index % 2 == 0 ? 'bg-gray-50 dark:bg-white/[0.02]' : 'bg-white dark:bg-white/[0.03]' }} transition hover:bg-gray-100">
                                    <td class="px-6 py-3 font-mono text-[10px] text-gray-400 w-20">{{ $item['code'] }}</td>
                                    <td class="px-2 py-3 text-gray-600 font-medium">{{ $item['name'] }}</td>
                                    <td class="px-6 py-3 text-right font-semibold text-gray-900 tabular-nums">
                                        {{ number_format($item['amount'], 0, ',', '.') }}</td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>

                <div class="mt-10 bg-green-100 px-6 py-6 text-green-600">
                    <div class="flex justify-between items-end">
                        <div>
                            <p class="text-[10px] font-bold uppercase tracking-[0.2em] mb-1">Total Pasiva
                            </p>
                            <h4 class="text-lg font-bold">Hutang & Modal</h4>
                        </div>
                        <div class="text-2xl font-black tabular-nums tracking-tighter">
                            Rp{{ number_format($modalTetap + $modalLancar + $surplusDeficit + $totalHutangVal, 0, ',', '.') }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    {{-- STATUS BAR --}}
    <div
        class="mt-4 flex items-center justify-center gap-4 py-4 border-4 border-dashed border-gray-600 rounded-2xl bg-gray-50/50 shadow-sm">
        <div class="flex items-center gap-2">
            <div class="w-2 h-2 rounded-full bg-green-500 animate-pulse"></div>
            <span class="text-xs font-bold text-gray-500 uppercase tracking-widest">Status Laporan:</span>
        </div>
        <div class="px-4 py-1 bg-green-500 text-white text-xs font-black rounded-full shadow-sm italic tracking-widest">
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
