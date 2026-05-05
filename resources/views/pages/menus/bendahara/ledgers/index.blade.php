@extends('layouts.app')

@section('title', 'Buku Besar')

@section('content')
    <x-common.page-breadcrumb pageTitle="Buku Besar" />

    {{-- FILTER CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
        <form method="GET" class="space-y-6">

            {{-- ===================== --}}
            {{-- 1. CONTEXT (PERIOD - SUB - AKUN) --}}
            {{-- ===================== --}}
            <div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                    {{-- PERIOD --}}
                    <div class="flex flex-col gap-2">
                        <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                            Periode
                        </label>
                        <select name="period_id" id="filter_period"
                            class="w-full rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
                            <option value="">-- Pilih Periode --</option>
                            @foreach ($periods as $period)
                                <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                                    {{ $period->name }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    {{-- SUB PERIOD --}}
                    <div class="flex flex-col gap-2">
                        <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                            Sub Periode
                        </label>
                        <select name="sub_period_id" id="filter_sub_period"
                            class="w-full rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
                            @foreach ($subPeriods as $sub)
                                <option value="{{ $sub->id }}" @selected(request('sub_period_id') == $sub->id)>
                                    {{ $sub->name }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    {{-- AKUN --}}
                    <div class="flex flex-col gap-2">
                        <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                            Akun
                        </label>
                        <select name="coa_id" id="filter_coa"
                            class="w-full rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
                            <option value="">-- Pilih Akun --</option>
                            @foreach ($coas as $c)
                                <option value="{{ $c->id }}" @selected(optional($coa)->id === $c->id)>
                                    {{ $c->code }} - {{ $c->name }}
                                </option>
                            @endforeach
                        </select>
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

                        {{-- @if ($coa)
                            <a href="{{ route('bendahara.reports.ledger.export', [
                                'period_id' => request('period_id'),
                                'sub_period_id' => request('sub_period_id'),
                                'start_date' => request('start_date'),
                                'end_date' => request('end_date'),
                                'coa_id' => request('coa_id'),
                            ]) }}"
                                class="flex-1">
                                <x-ui.button variant="primary" class="w-full justify-center rounded-xl px-5 py-2.5">
                                    Export
                                </x-ui.button>
                            </a>
                        @endif --}}
                    </div>
                </div>
            </div>
        </form>
    </div>


    {{-- LEDGER TABLE --}}
    @if ($coa)
        <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">

            {{-- HEADER: Lebih Informatif --}}
            <div
                class="flex flex-col justify-between border-b border-gray-100 bg-gradient-to-r from-gray-50 to-white p-6 sm:flex-row sm:items-center">
                <div class="flex items-center gap-4">
                    {{-- <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 text-primary">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="浸-9 5H9a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-1M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                        </svg>
                    </div> --}}
                    <div>
                        <h2 class="text-xl font-bold text-gray-800">{{ $coa->name }}</h2>
                        <p class="text-sm font-medium text-gray-500">
                            Kode Akun: <span class="font-mono font-bold text-primary">{{ $coa->code }}</span>
                            <span class="mx-2 text-gray-300">|</span>
                            Normal: <span
                                class="badge {{ $coa->normal_balance === 'DEBIT' ? 'bg-blue-100 text-blue-700' : 'bg-purple-100 text-purple-700' }} px-2 py-0.5 rounded text-xs font-bold">{{ $coa->normal_balance }}</span>
                        </p>
                    </div>
                </div>

                <div class="mt-4 flex flex-col items-end sm:mt-0">
                    <p class="text-xs font-bold uppercase tracking-widest text-gray-400">Total Saldo Akhir</p>
                    <div class="flex items-baseline gap-1">
                        <span class="text-sm font-bold text-gray-500">Rp</span>
                        <span class="text-3xl font-black tracking-tight text-gray-900">
                            {{ number_format($endingBalance, 0, ',', '.') }}
                        </span>
                    </div>
                </div>
            </div>

            {{-- TABLE AREA --}}
            <div class="overflow-x-auto">
                <table class="w-full border-separate border-spacing-0">
                    <thead>
                        <tr class="bg-gray-50/80 text-xs font-bold uppercase tracking-wider text-gray-600">
                            {{-- Border hanya di bawah untuk header agar kesan 'airy' --}}
                            <th rowspan="2" class="sticky top-0 border-b border-gray-200 px-6 py-4 text-center">Tanggal
                            </th>
                            <th rowspan="2" class="sticky top-0 border-b border-gray-200 px-6 py-4 text-left">Keterangan
                            </th>
                            <th rowspan="2" class="sticky top-0 border-b border-gray-200 px-6 py-4 text-left">Pembuat
                            </th>
                            <th rowspan="2" class="sticky top-0 border-b border-gray-200 px-6 py-4 text-center">Debit
                            </th>
                            <th rowspan="2" class="sticky top-0 border-b border-gray-200 px-6 py-4 text-center border-r">
                                Kredit</th>
                            <th colspan="2"
                                class="sticky top-0 border-b border-gray-200 px-6 py-3 text-center bg-gray-100/50 font-black italic">
                                Saldo Kumulatif</th>
                        </tr>
                        <tr class="bg-gray-50/80 text-[10px] font-bold uppercase text-gray-500">
                            <th class="border-b border-gray-200 px-6 py-2 text-center bg-gray-100/30">Debit</th>
                            <th class="border-b border-gray-200 px-6 py-2 text-center bg-gray-100/30 border-l ">
                                Kredit</th>
                        </tr>
                    </thead>

                    <tbody class="text-sm">
                        {{-- DATA TRANSAKSI --}}
                        @forelse ($ledger as $index => $row)
                            <tr
                                class="{{ $index % 2 === 0 ? 'bg-gray-50 dark:bg-white/[0.02]' : 'bg-white dark:bg-white/[0.03]' }} border-b border-gray-100 transition hover:bg-gray-100 dark:border-white/[0.05]">
                                {{-- Gunakan border-b (bawah) yang tipis dan halus --}}
                                <td class="border-b border-gray-100 px-6 py-4 text-center text-gray-600">
                                    {{ $row['date']->format('d M Y') }}
                                </td>
                                <td class="border-b border-gray-100 px-6 py-4">
                                    <div class="font-semibold text-gray-800 leading-tight">{{ $row['description'] }}</div>
                                    <div class="mt-1 font-mono text-[10px] text-primary/70 tracking-tighter">
                                        {{ $row['ref_code'] }}</div>
                                </td>
                                <td class="border-b border-gray-100 px-6 py-4 text-gray-500">
                                    {{ $row['posted_by'] }}
                                </td>
                                <td class="border-b border-gray-100 px-6 py-4 text-right font-medium text-gray-700">
                                    {{ $row['debit'] > 0 ? number_format($row['debit'], 0, ',', '.') : '-' }}
                                </td>
                                <td
                                    class="border-b border-gray-100 border-r px-6 py-4 text-right font-medium text-red-600/80">
                                    {{ $row['credit'] > 0 ? number_format($row['credit'], 0, ',', '.') : '-' }}
                                </td>

                                {{-- Kolom Saldo dengan shading tipis --}}
                                <td
                                    class="border-b border-gray-100 bg-gray-50/40 px-6 py-4 text-right font-bold text-gray-800 group-hover:bg-transparent transition-colors">
                                    {{ $row['normal_balance'] === 'DEBIT' ? number_format($row['current_balance'], 0, ',', '.') : '-' }}
                                </td>
                                <td
                                    class="border-b border-gray-100 bg-gray-50/40 px-6 py-4 text-right font-bold text-gray-800 group-hover:bg-transparent transition-colors border-l">
                                    {{ $row['normal_balance'] === 'KREDIT' ? number_format($row['current_balance'], 0, ',', '.') : '-' }}
                                </td>
                            </tr>
                            @empty{{-- Tampilan JIKA DATA KOSONG --}}
                            <tr>
                                <td colspan="8" class="px-6 py-20 text-center text-gray-400">
                                    <svg class="w-12 h-12 mx-auto mb-4 opacity-20" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path
                                            d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"
                                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                    <p class="text-sm font-medium">Tidak ada transaksi ditemukan pada periode ini.</p>
                                    {{-- @if (!$coaId) --}}
                                        <p class="text-xs">Silakan pilih Akun (COA) terlebih dahulu.</p>
                                    {{-- @endif --}}
                                </td>
                            </tr>
                        @endforelse
                    </tbody>

                    @if (count($ledger) > 0)
                        <tfoot>
                            <tr class="bg-gray-800 text-white py-2">
                                <td colspan="5"
                                    class="px-6 py-5 text-right text-xs font-bold uppercase tracking-widest text-gray-300">
                                    Total Saldo Akhir
                                </td>
                                {{-- Border pada footer dibuat sangat halus agar tidak memotong teks --}}
                                <td class="border-r border-white/5 px-6 py-5 text-right font-black text-base">
                                    {{ $row['normal_balance'] === 'DEBIT' ? 'Rp' . number_format($endingBalance, 0, ',', '.') : '-' }}
                                </td>
                                <td class="px-6 py-5 text-right font-black text-base text-white">
                                    {{ $row['normal_balance'] === 'KREDIT' ? 'Rp' . number_format($endingBalance, 0, ',', '.') : '-' }}
                                </td>
                            </tr>
                        </tfoot>
                    @endif
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
