@extends('layouts.app')

@section('title', 'Laporan Aktivitas Bendahara')

@section('content')
    <x-common.page-breadcrumb pageTitle="Laporan Aktivitas" />

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

                    <a href="{{ route('bendahara.reports.activity.index') }}" class="flex-1">
                        <x-ui.button variant="outline" class="w-full justify-center rounded-xl px-5 py-2.5">
                            Reset
                        </x-ui.button>
                    </a>
                </div>
            </div>

        </form>
    </div>

    {{-- MAIN REPORT CARD --}}
    <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">

        {{-- HEADER STATUS: Selaras dengan Ledger --}}
        <div
            class="flex flex-col justify-between border-b border-gray-100 bg-gradient-to-r from-gray-50 to-white p-6 sm:flex-row sm:items-center">
            <div class="flex items-center gap-4">
                {{-- <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 text-primary">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                </div> --}}
                <div>
                    <h2 class="text-xl font-bold text-gray-800">Laporan Aktivitas</h2>
                    <div class="flex flex-wrap items-center gap-x-3 gap-y-1 text-sm font-medium text-gray-500">
                        <span>Periode: <span class="font-bold text-primary">{{ $period->name }}</span></span>
                        <span class="hidden md:inline text-gray-300">|</span>
                        <span>Sub: <span class="font-bold text-primary">{{ $subPeriod->name }}</span></span>
                    </div>
                </div>
            </div>

            <div class="mt-4 flex flex-col items-end sm:mt-0">
                <p class="text-xs font-bold uppercase tracking-widest text-gray-400">Surplus / Defisit</p>
                <div class="flex items-baseline gap-1">
                    <span class="text-sm font-bold {{ $surplusDeficit >= 0 ? 'text-green-500' : 'text-red-500' }}">Rp</span>
                    <span
                        class="text-3xl font-black tracking-tight {{ $surplusDeficit >= 0 ? 'text-green-600' : 'text-red-600' }}">
                        {{ number_format(abs($surplusDeficit), 0, ',', '.') }}
                    </span>
                </div>
            </div>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full border-separate border-spacing-0">
                <thead>
                    <tr class="bg-gray-50/80 text-[11px] font-bold uppercase tracking-wider text-gray-600">
                        <th rowspan="2" class="sticky top-0 border-b border-r border-gray-200 px-6 py-4 text-center">Kode
                            Akun</th>
                        <th rowspan="2" class="sticky top-0 border-b border-r border-gray-200 px-6 py-4 text-left">Uraian
                            Transaksi</th>
                        <th colspan="2"
                            class="sticky top-0 border-b border-gray-200 bg-gray-100/50 px-6 py-2 text-center italic font-black">
                            Jumlah Pergerakan</th>
                    </tr>
                    <tr class="bg-gray-50/80 text-[10px] font-bold uppercase tracking-wider text-gray-500">
                        <th class="border-b px-6 py-2 text-center">Debit <br> (Arus Keluar)</th>
                        <th class="border-b px-6 py-2 text-center">Kredit <br> (Arus Masuk)</th>
                    </tr>
                </thead>

                <tbody class="text-sm">
                    {{-- SECTION PENDAPATAN --}}
                    <tr class="bg-blue-500 text-white">
                        <td class="px-6 py-3 font-mono text-xs font-bold text-blue-100 border-b border-blue-700/50">(40000)
                        </td>
                        <td colspan="3"
                            class="px-6 py-3 font-black uppercase tracking-[0.1em] border-b border-blue-700/50">
                            <div class="flex items-center gap-2">
                                <span class="h-2 w-2 rounded-full bg-blue-300"></span>
                                Pendapatan
                            </div>
                        </td>
                    </tr>

                    @foreach ($revenueData as $index => $item)
                        {{-- Zebra Striping: Genap/Ganjil menggunakan bg-blue-50/20 --}}
                        <tr
                            class="group  {{ $index % 2 == 0 ? 'bg-gray-50 dark:bg-white/[0.02]' : 'bg-white dark:bg-white/[0.03]' }} transition hover:bg-gray-100">
                            <td
                                class="border-b border-gray-100 border-r px-6 py-3 text-center text-gray-400 font-mono text-xs">
                                {{ $item->code }}
                            </td>
                            <td class="border-b border-gray-100 border-r px-6 py-3 text-gray-700"
                                style="padding-left: {{ $item->level * 1.5 + 1.5 }}rem">
                                <span class="{{ $item->level == 0 ? 'font-bold text-gray-800' : 'font-medium' }}">
                                    {{ $item->name }}
                                </span>
                            </td>
                            <td
                                class="border-b border-gray-100 border-r px-6 py-3 text-right text-gray-300 italic">
                                -</td>
                            <td class="border-b border-gray-100 px-6 py-3 text-right font-bold text-blue-700/80">
                                {{ $item->total_credit != 0 ? number_format($item->total_credit, 0, ',', '.') : '-' }}
                            </td>
                        </tr>
                    @endforeach

                    {{-- TOTAL PENDAPATAN --}}
                    <tr class="bg-gray-100/80 font-bold">
                        <td class="px-6 py-4 border-b border-gray-200"></td>
                        <td
                            class="px-6 py-4 text-center border-b border-gray-200 uppercase text-[10px] tracking-widest text-gray-500">
                            Subtotal Pendapatan
                        </td>
                        <td class="px-6 py-4 text-right border-b border-r border-gray-200 text-gray-400">-</td>
                        <td class="px-6 py-4 text-right border-b border-gray-200 text-green-600 text-lg">
                            {{ number_format($totalRevenue, 0, ',', '.') }}
                        </td>
                    </tr>

                    {{-- SPACING: Elegant Gap --}}
                    <tr class="bg-white">
                        <td colspan="4" class="py-3 border-b border-gray-100 shadow-inner bg-gray-50/30"></td>
                    </tr>

                    {{-- SECTION BIAYA --}}
                    <tr class="bg-blue-500 text-white">
                        <td class="px-6 py-3 font-mono text-xs font-bold text-rose-100 border-b border-rose-700/50">(50000)
                        </td>
                        <td colspan="3"
                            class="px-6 py-3 font-black uppercase tracking-[0.1em] border-b border-rose-700/50">
                            <div class="flex items-center gap-2">
                                <span class="h-2 w-2 rounded-full bg-rose-300"></span>
                                Biaya-Biaya
                            </div>
                        </td>
                    </tr>

                    @foreach ($expenseData as $index => $item)
                        {{-- Zebra Striping: Genap/Ganjil menggunakan bg-rose-50/20 --}}
                        <tr
                            class="group {{ $index % 2 == 0 ? 'bg-gray-50 dark:bg-white/[0.02]' : 'bg-white dark:bg-white/[0.03]' }} transition hover:bg-gray-100">
                            <td
                                class="border-b border-gray-100 border-r px-6 py-3 text-center text-gray-400 font-mono text-xs">
                                {{ $item->code }}
                            </td>
                            <td class="border-b border-gray-100 border-r px-6 py-3 text-gray-700"
                                style="padding-left: {{ $item->level * 1.5 + 1.5 }}rem">
                                <span class="{{ $item->level == 0 ? 'font-bold text-gray-800' : 'font-medium' }}">
                                    {{ $item->name }}
                                </span>
                            </td>
                            <td
                                class="border-b border-gray-100 border-r px-6 py-3 text-right font-bold text-rose-700/80">
                                {{ $item->total_debit != 0 ? number_format($item->total_debit, 0, ',', '.') : '-' }}
                            </td>
                            <td class="border-b border-gray-100 px-6 py-3 text-right text-gray-300 italic">-</td>
                        </tr>
                    @endforeach

                    {{-- TOTAL BIAYA --}}
                    <tr class="bg-gray-100/80 font-bold">
                        <td class="px-6 py-4 border-b border-gray-200"></td>
                        <td
                            class="px-6 py-4 text-center border-b border-gray-200 uppercase text-[10px] tracking-widest text-gray-500">
                            Subtotal Biaya
                        </td>
                        <td class="px-6 py-4 text-right border-b border-r border-gray-200 text-red-600 text-lg">
                            {{ number_format($totalExpense, 0, ',', '.') }}
                        </td>
                        <td class="px-6 py-4 text-right border-b border-gray-200 text-gray-400">-</td>
                    </tr>
                </tbody>

                {{-- FOOTER SELISIH: Bold & Professional --}}
                <tfoot>
                    <tr>
                        <td colspan="4" class="p-0">
                            <div
                                class="flex items-center justify-between {{ $surplusDeficit >= 0 ? 'bg-green-100 text-green-600' : 'bg-red-100 text-red-600' }} p-6 shadow-lg">
                                <div class="flex items-center gap-5">
                                    <div
                                        class="flex h-14 w-14 items-center justify-center rounded-2xl {{ $surplusDeficit >= 0 ? 'bg-green-50' : 'bg-red-50' }} }} backdrop-blur-md">
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
                                        <p class="text-[10px] font-black uppercase tracking-[0.3em]">Summary
                                            Report</p>
                                        <h3 class="text-xl font-black uppercase leading-none">
                                            SELISIH {{ $surplusDeficit >= 0 ? 'SURPLUS' : 'DEFISIT' }}
                                        </h3>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <p class="text-[10px] font-bold uppercase">Total Nilai Akhir</p>
                                    <p class="text-3xl font-black tracking-tighter">
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
