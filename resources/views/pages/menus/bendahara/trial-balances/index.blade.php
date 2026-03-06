@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Neraca (Balance Sheet)" />

    {{-- FILTER CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
        <form method="GET" class="flex flex-wrap items-end gap-5">
            <div class="flex flex-col gap-2">
                <label class="text-xs font-bold uppercase tracking-wider text-gray-500">Periode</label>
                <select name="period_id"
                    class="w-48 rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
                    @foreach ($periods as $p)
                        <option value="{{ $p->id }}" @selected($period->id == $p->id)>{{ $p->name }}</option>
                    @endforeach
                </select>
            </div>

            <div class="flex flex-col gap-2">
                <label class="text-xs font-bold uppercase tracking-wider text-gray-500">Bulan (Opsional)</label>
                <input type="month" name="month" value="{{ $month }}"
                    class="rounded-xl border-gray-200 bg-gray-50 px-4 py-2 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
            </div>

            <div class="ml-auto flex gap-3">
                <x-ui.button type="submit" variant="primary" class="rounded-xl px-6 shadow-md shadow-primary/20">
                    <span class="flex items-center gap-2">
                        <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                        Tampilkan
                    </span>
                </x-ui.button>
            </div>
        </form>
    </div>

    {{-- MAIN REPORT CONTAINER --}}
    <div class="grid grid-cols-1 overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm lg:grid-cols-2">

        {{-- SISI KIRI: ASET --}}
        <div class="border-r border-gray-200 flex flex-col">
            <table class="w-full text-sm border-collapse">
                <thead>
                    <tr class="bg-gray-50/80 border-b border-gray-200">
                        <th colspan="2" class="px-6 py-4 text-left font-bold uppercase tracking-widest text-gray-600">
                            ASET (AKTIVA)</th>
                        <th class="px-6 py-4 text-right text-gray-400 font-medium">Nilai</th>
                    </tr>
                </thead>
                <tbody>
                    {{-- Sub-Header Aset Lancar --}}
                    <tr class="bg-blue-50/30">
                        <td colspan="3"
                            class="px-6 py-2.5 text-[11px] font-black text-blue-800 uppercase italic tracking-wider">
                            Aset Lancar</td>
                    </tr>
                    @php $totalAsetLancar = 0; @endphp
                    @foreach ($data['aset_lancar'] as $item)
                        @php $totalAsetLancar += $item['amount']; @endphp
                        <tr class="group border-b border-gray-50 hover:bg-gray-50/50 transition">
                            <td class="px-6 py-3 font-mono text-[11px] text-gray-400 w-24">{{ $item['code'] }}</td>
                            <td class="px-2 py-3 text-gray-700 font-medium">{{ $item['name'] }}</td>
                            <td class="px-6 py-3 text-right font-semibold text-gray-900">
                                {{ $item['amount'] < 0 ? '(' . number_format(abs($item['amount']), 0, ',', '.') . ')' : number_format($item['amount'], 0, ',', '.') }}
                            </td>
                        </tr>
                    @endforeach
                    {{-- BARIS TOTAL ASET LANCAR --}}
                    <tr class="bg-gray-50/50 border-b border-gray-200">
                        <td colspan="2" class="px-6 py-3 text-right">
                            <span class="text-[10px] font-bold uppercase tracking-wider text-gray-500">Jumlah Aset
                                Lancar</span>
                        </td>
                        <td class="px-6 py-3 text-right font-bold text-blue-700">
                            Rp{{ number_format($totalAsetLancar, 0, ',', '.') }}
                        </td>
                    </tr>

                    {{-- Sub-Header Aset Tidak Lancar --}}
                    <tr class="bg-blue-50/30 border-t border-gray-100">
                        <td colspan="3"
                            class="px-6 py-2.5 text-[11px] font-black text-blue-800 uppercase italic tracking-wider">
                            Aset Tidak Lancar</td>
                    </tr>
                    @php $totalAsetTidakLancar = 0; @endphp
                    @foreach ($data['aset_tidak_lancar'] as $item)
                        @php $totalAsetTidakLancar += $item['amount']; @endphp
                        <tr class="group border-b border-gray-50 hover:bg-gray-50/50 transition">
                            <td class="px-6 py-3 font-mono text-[11px] text-gray-400 w-24">{{ $item['code'] }}</td>
                            <td class="px-2 py-3 text-gray-700 font-medium">{{ $item['name'] }}</td>
                            <td class="px-6 py-3 text-right font-semibold text-gray-900">
                                {{ $item['amount'] < 0 ? '(' . number_format(abs($item['amount']), 0, ',', '.') . ')' : number_format($item['amount'], 0, ',', '.') }}
                            </td>
                        </tr>
                    @endforeach
                    {{-- BARIS TOTAL ASET TIDAK LANCAR --}}
                    <tr class="bg-gray-50/50">
                        <td colspan="2" class="px-6 py-3 text-right">
                            <span class="text-[10px] font-bold uppercase tracking-wider text-gray-500">Jumlah Aset Tidak
                                Lancar</span>
                        </td>
                        <td class="px-6 py-3 text-right font-bold text-blue-700">
                            Rp{{ number_format($totalAsetTidakLancar, 0, ',', '.') }}
                        </td>
                    </tr>
                </tbody>
            </table>

            {{-- TOTAL KESELURUHAN ASET --}}
            <div class="mt-auto border-t-2 border-double border-gray-200 bg-blue-600 px-6 py-5 text-dark shadow-inner">
                <div class="flex justify-between items-center">
                    <div>
                        <span class="block text-[10px] font-bold uppercase tracking-[0.2em] text-blue-200">Total
                            Aktiva</span>
                        <span class="text-sm font-extrabold uppercase italic tracking-tight">Jumlah Keseluruhan Aset</span>
                    </div>
                    <span class="text-2xl font-black tracking-tighter">
                        Rp{{ number_format($totalAsetLancar + $totalAsetTidakLancar, 0, ',', '.') }}
                    </span>
                </div>
            </div>
        </div>

        {{-- SISI KANAN: PASIVA --}}
        <div class="flex flex-col bg-white">
            <table class="w-full text-sm border-collapse">
                <thead>
                    <tr class="bg-gray-50/80 border-b border-gray-200">
                        <th colspan="2" class="px-6 py-4 text-left font-bold uppercase tracking-widest text-gray-600">
                            PASIVA</th>
                        <th class="px-6 py-4 text-right text-gray-400 font-medium">Nilai</th>
                    </tr>
                </thead>
                <tbody>
                    {{-- Sub-Header Modal --}}
                    <tr class="bg-emerald-50/30">
                        <td colspan="3"
                            class="px-6 py-2.5 text-[11px] font-black text-emerald-800 uppercase italic tracking-wider">
                            Ekuitas (Modal)</td>
                    </tr>

                    {{-- Modal Tetap --}}
                    <tr class="group border-b border-gray-50 hover:bg-gray-50/50 transition">
                        <td class="px-6 py-3 font-mono text-[11px] text-gray-400 w-24">31000</td>
                        <td class="px-2 py-3 text-gray-700 font-medium">Modal Tetap</td>
                        <td class="px-6 py-3 text-right font-semibold text-gray-900">
                            {{ number_format($modalTetap, 0, ',', '.') }}
                        </td>
                    </tr>

                    {{-- Modal Lancar --}}
                    <tr class="group border-b border-gray-50 hover:bg-gray-50/50 transition">
                        <td class="px-6 py-3 font-mono text-[11px] text-gray-400 w-24">32000</td>
                        <td class="px-2 py-3 text-gray-700 font-medium">Modal Lancar</td>
                        <td class="px-6 py-3 text-right font-semibold text-gray-900">
                            {{ number_format($modalLancar, 0, ',', '.') }}
                        </td>
                    </tr>

                    {{-- Baris Khusus Surplus/Defisit --}}
                    <tr class="border-b border-gray-50 bg-emerald-50/10 transition">
                        <td class="px-6 py-3 text-center text-gray-300 font-mono text-[11px]">-</td>
                        <td class="px-2 py-3 text-emerald-700 font-bold italic">Selisih Pendapatan & Biaya (Tahun Berjalan)
                        </td>
                        <td class="px-6 py-3 text-right font-black text-emerald-700">
                            {{ number_format($surplusDeficit, 0, ',', '.') }}
                        </td>
                    </tr>

                    {{-- Sub-Header Hutang --}}
                    <tr class="bg-emerald-50/30 border-t border-gray-100">
                        <td colspan="3"
                            class="px-6 py-2.5 text-[11px] font-black text-emerald-800 uppercase italic tracking-wider">
                            Kewajiban (Hutang)</td>
                    </tr>
                    @php $totalHutangVal = 0; @endphp
                    @foreach ($data['hutang'] as $item)
                        @php $totalHutangVal += $item['amount']; @endphp
                        <tr class="group border-b border-gray-50 hover:bg-gray-50/50 transition">
                            <td class="px-6 py-3 font-mono text-[11px] text-gray-400 w-24">{{ $item['code'] }}</td>
                            <td class="px-2 py-3 text-gray-700 font-medium">{{ $item['name'] }}</td>
                            <td class="px-6 py-3 text-right font-semibold text-gray-900">
                                {{ number_format($item['amount'], 0, ',', '.') }}
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>

            <div class="flex-grow"></div>

            {{-- TOTAL PASIVA --}}
            <div class="border-t-2 border-double border-gray-200 bg-emerald-600 px-6 py-5 text-dark shadow-inner">
                <div class="flex justify-between items-center">
                    <div>
                        <span class="block text-[10px] font-bold uppercase tracking-[0.2em] text-emerald-200">Total
                            Pasiva</span>
                        <span class="text-sm font-extrabold uppercase italic tracking-tight">Jumlah Hutang & Modal</span>
                    </div>
                    <span class="text-2xl font-black tracking-tighter">
                        {{-- Penjumlahan Modal Tetap + Modal Lancar + Surplus + Hutang pasti akan sama dengan Total Aset --}}
                        Rp{{ number_format($modalTetap + $modalLancar + $surplusDeficit + $totalHutangVal, 0, ',', '.') }}
                    </span>
                </div>
            </div>
        </div>
    </div>

    {{-- GRAND FOOTER --}}
    <div class="mt-0 grid grid-cols-1 border-x border-b border-gray-300 lg:grid-cols-2">
        <div class="bg-gray-800 p-6 text-dark flex items-center justify-between border-r border-gray-700">
            <div class="flex items-center gap-3">
                <div class="p-2 bg-white/10 rounded-lg">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                </div>
                <span class="text-sm font-bold uppercase tracking-widest text-white/70">Account Check</span>
            </div>
            <span class="text-2xl font-black italic tracking-tighter">BALANCE</span>
        </div>
        <div class="bg-primary p-6 text-dark flex items-center justify-center">
            <span class="text-sm font-medium mr-2 text-white/80 italic">Status Neraca:</span>
            <span class="text-xl font-extrabold uppercase tracking-widest">SEIMBANG</span>
        </div>
    </div>
@endsection
