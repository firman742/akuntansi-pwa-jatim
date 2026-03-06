@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Laporan Aktivitas" />

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
                {{--  <a href="#"> 
                    <x-ui.button variant="outline" type="button"
                        class="rounded-xl border-gray-300 bg-white hover:bg-gray-50">
                        Export PDF
                    </x-ui.button>
                </a> --}}
            </div>
        </form>
    </div>

    {{-- MAIN REPORT CARD --}}
    <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">
        {{-- HEADER STATUS --}}
        <div class="flex flex-col justify-between border-b border-gray-100 bg-gray-50/50 p-6 sm:flex-row sm:items-center">
            <div class="flex items-center gap-4">
                <div>
                    <h2 class="text-xl font-bold text-gray-800">Laporan Aktivitas</h2>
                    <p class="text-sm font-medium text-gray-500">Periode: <span
                            class="text-primary">{{ $period->name }}</span>
                        @if ($month)
                            | Bulan: <span class="text-primary">{{ \Carbon\Carbon::parse($month)->format('F Y') }}</span>
                        @endif
                    </p>
                </div>
            </div>
            <div class="mt-4 text-right sm:mt-0">
                <p class="text-xs font-bold uppercase tracking-widest text-gray-400">Surplus / Defisit</p>
                <p class="text-2xl font-black {{ $surplusDeficit >= 0 ? 'text-green-600' : 'text-red-600' }}">
                    Rp{{ number_format($surplusDeficit, 0, ',', '.') }}
                </p>
            </div>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full border-collapse">
                <thead>
                    <tr class="bg-gray-50 text-[11px] font-bold uppercase tracking-wider text-gray-600">
                        <th rowspan="2" class="border-b border-r border-gray-200 px-6 py-4 text-center">Akun</th>
                        <th rowspan="2" class="border-b border-r border-gray-200 px-6 py-4 text-left">Uraian</th>
                        <th colspan="2" class="border-b border-gray-200 bg-gray-100/50 px-6 py-2 text-center">Jumlah</th>
                    </tr>
                    <tr class="bg-gray-50 text-[10px] font-bold uppercase tracking-wider text-gray-500">
                        <th class="border-b border-r border-gray-200 px-6 py-2 text-right">Debit (Kiri)</th>
                        <th class="border-b px-6 py-2 text-right">Kredit (Kanan)</th>
                    </tr>
                </thead>

                <tbody class="text-sm">
                    {{-- SECTION PENDAPATAN --}}
                    <tr class="bg-blue-50/30">
                        <td class="px-6 py-3 font-bold text-gray-800 border-b border-gray-100">(40000)</td>
                        <td colspan="3"
                            class="px-6 py-3 font-bold text-gray-800 border-b border-gray-100 uppercase tracking-wide">
                            Pendapatan</td>
                    </tr>
                    @foreach ($revenueData as $item)
                        <tr class="group border-b border-gray-100 transition hover:bg-gray-50/80">
                            <td class="px-6 py-3 text-center text-gray-500 font-mono text-xs">{{ $item->code }}</td>
                            <td class="px-6 py-3 text-gray-700" style="padding-left: {{ $item->level * 1.5 + 1.5 }}rem">
                                {{ $item->name }}
                            </td>
                            <td class="px-6 py-3 text-right text-gray-300 border-r border-gray-100">-</td>
                            <td class="px-6 py-3 text-right font-medium text-gray-900">
                                {{ $item->amount != 0 ? number_format($item->amount, 0, ',', '.') : '-' }}
                            </td>
                        </tr>
                    @endforeach
                    <tr class="bg-gray-50/50 font-bold">
                        <td class="px-6 py-4 border-b border-gray-200"></td>
                        <td class="px-6 py-4 text-center border-b border-gray-200 uppercase text-xs text-gray-500">Jumlah
                            Pendapatan</td>
                        <td class="px-6 py-4 text-right border-b border-r border-gray-200 text-gray-900">
                            {{ number_format($totalRevenue, 0, ',', '.') }}</td>
                        <td class="px-6 py-4 text-right border-b border-gray-200 text-gray-900">
                            {{ number_format($totalRevenue, 0, ',', '.') }}</td>
                    </tr>

                    {{-- SPACING --}}
                    <tr>
                        <td colspan="4" class="py-4"></td>
                    </tr>

                    {{-- SECTION BIAYA --}}
                    <tr class="bg-red-50/30">
                        <td class="px-6 py-3 font-bold text-gray-800 border-b border-gray-100">(50000)</td>
                        <td colspan="3"
                            class="px-6 py-3 font-bold text-gray-800 border-b border-gray-100 uppercase tracking-wide">
                            Biaya-Biaya</td>
                    </tr>
                    @foreach ($expenseData as $item)
                        <tr class="group border-b border-gray-100 transition hover:bg-gray-50/80">
                            <td class="px-6 py-3 text-center text-gray-500 font-mono text-xs">{{ $item->code }}</td>
                            <td class="px-6 py-3 text-gray-700" style="padding-left: {{ $item->level * 1.5 + 1.5 }}rem">
                                {{ $item->name }}
                            </td>
                            <td class="px-6 py-3 text-right border-r border-gray-100 font-medium text-gray-900">
                                {{ $item->amount != 0 ? number_format($item->amount, 0, ',', '.') : '-' }}
                            </td>
                            <td class="px-6 py-3 text-right text-gray-300">-</td>
                        </tr>
                    @endforeach
                    <tr class="bg-gray-50/50 font-bold">
                        <td class="px-6 py-4 border-b border-gray-200"></td>
                        <td class="px-6 py-4 text-center border-b border-gray-200 uppercase text-xs text-gray-500">Jumlah
                            Biaya</td>
                        <td class="px-6 py-4 text-right border-b border-r border-gray-200 text-gray-900">
                            {{ number_format($totalExpense, 0, ',', '.') }}</td>
                        <td class="px-6 py-4 text-right border-b border-gray-200 text-gray-900">
                            {{ number_format($totalExpense, 0, ',', '.') }}</td>
                    </tr>
                </tbody>
                {{-- FOOTER SELISIH --}}
                <tfoot class="border-t-2 border-gray-800">
                    <tr
                        class="{{ $surplusDeficit >= 0 ? 'bg-gray-400' : 'bg-gray-600' }} text-white transition-colors duration-500">
                        <td colspan="2" class="px-6 py-6">
                            <div class="flex items-center gap-4">
                                {{-- Icon Dinamis --}}
                                <div
                                    class="flex h-12 w-12 items-center justify-center rounded-full bg-white/20 shadow-inner">
                                    @if ($surplusDeficit >= 0)
                                        <svg class="h-7 w-7 text-white" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5"
                                                d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
                                        </svg>
                                    @else
                                        <svg class="h-7 w-7 text-white" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5"
                                                d="M13 17h8m0 0v-8m0 8l-8-8-4 4-6-6" />
                                        </svg>
                                    @endif
                                </div>
                                <div>
                                    <span
                                        class="block text-[10px] font-bold uppercase tracking-[0.2em] text-white/80">Hasil
                                        Akhir Laporan</span>
                                    <span class="text-lg font-extrabold uppercase tracking-tight">
                                        SELISIH PENDAPATAN & BIAYA
                                        ({{ $surplusDeficit >= 0 ? 'Surplus' : 'Defisit' }})
                                    </span>
                                </div>
                            </div>
                        </td>
                        <td colspan="2" class="px-6 py-6 text-right">
                            <div class="inline-block rounded-lg bg-black/10 px-4 py-2 backdrop-blur-sm">
                                <span class="block text-[10px] font-bold uppercase text-white/70">Total Nilai</span>
                                <span class="text-3xl font-black tracking-tighter">
                                    Rp{{ number_format(abs($surplusDeficit), 0, ',', '.') }}
                                </span>
                            </div>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
@endsection
