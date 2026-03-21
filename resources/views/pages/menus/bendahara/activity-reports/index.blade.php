@extends('layouts.app')

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

                {{-- BUTTON --}}
                <div class="flex items-end">
                    <x-ui.button type="submit" variant="primary"
                        class="w-full rounded-xl px-6 shadow-md shadow-primary/20">
                        Tampilkan
                    </x-ui.button>
                </div>
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
                    </p>
                    <p class="text-sm font-medium text-gray-500">Sub Periode: <span
                        class="text-primary">{{ $subPeriod->name }}</span>
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
                        <th class="border-b border-r border-gray-200 px-6 py-2 text-right">Debit</th>
                        <th class="border-b px-6 py-2 text-right">Kredit</th>
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
                                {{ $item->total_credit != 0 ? number_format($item->total_credit, 0, ',', '.') : '-' }}
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
                                {{ $item->total_debit != 0 ? number_format($item->total_debit, 0, ',', '.') : '-' }}
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
                                    <span class="block text-[10px] font-bold uppercase tracking-[0.2em] text-white/80">Hasil
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

            const res = await fetch(`/bendahara/periode/${periodId}/sub-periods`);
            const data = await res.json();

            subPeriodFilter.innerHTML = '<option value="">Semua</option>';

            data.forEach(sub => {
                subPeriodFilter.innerHTML += `<option value="${sub.id}">${sub.name}</option>`;
            });
        });
    </script>
@endsection
