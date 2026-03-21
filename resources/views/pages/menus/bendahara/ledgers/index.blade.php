@extends('layouts.app')

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
                            <option value="">Semua</option>
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
                            <option value="">Semua</option>
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

            {{-- ===================== --}}
            {{-- ACTION --}}
            {{-- ===================== --}}
            <div class="flex justify-end gap-3 pt-4">
                <x-ui.button type="submit" variant="primary" class="rounded-xl px-6 shadow-md shadow-primary/20">
                    <span class="flex items-center gap-2">
                        <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                        Tampilkan
                    </span>
                </x-ui.button>

                @if ($coa)
                    <a
                        href="{{ route('bendahara.ledgers.export', [
                            'period_id' => request('period_id'),
                            'sub_period_id' => request('sub_period_id'),
                            'start_date' => request('start_date'),
                            'end_date' => request('end_date'),
                            'coa_id' => request('coa_id'),
                        ]) }}">
                        <x-ui.button variant="outline" type="button"
                            class="rounded-xl border-gray-300 bg-white hover:bg-gray-50">
                            Export
                        </x-ui.button>
                    </a>
                @endif
            </div>

        </form>
    </div>

    {{-- LEDGER TABLE --}}
    @if ($coa)
        <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">

            {{-- HEADER --}}
            <div
                class="flex flex-col justify-between border-b border-gray-100 bg-gray-50/50 p-6 sm:flex-row sm:items-center">
                <div>
                    <h2 class="text-xl font-bold text-gray-800">{{ $coa->name }}</h2>
                    <p class="text-sm font-medium text-gray-500">
                        Kode Akun: <span class="text-primary">{{ $coa->code }}</span>
                    </p>
                </div>

                <div class="mt-4 text-right sm:mt-0">
                    <p class="text-xs font-bold uppercase tracking-widest text-gray-400">Total Saldo Akhir</p>
                    <p class="text-2xl font-black text-gray-900">
                        Rp{{ number_format($endingBalance, 0, ',', '.') }}
                    </p>
                </div>
            </div>

            {{-- TABLE --}}
            <div class="overflow-x-auto">
                <table class="w-full border-collapse">

                    <thead>
                        <tr class="bg-gray-50 text-[11px] font-bold uppercase tracking-wider text-gray-600">
                            <th rowspan="2" class="border-b border-r px-4 py-4 text-center">Tanggal</th>
                            <th rowspan="2" class="border-b border-r px-4 py-4 text-left">Keterangan</th>
                            <th rowspan="2" class="border-b border-r px-4 py-4 text-center">Ref</th>
                            <th rowspan="2" class="border-b border-r px-4 py-4 text-right">Debit</th>
                            <th rowspan="2" class="border-b border-r px-4 py-4 text-right text-red-500">Kredit</th>
                            <th colspan="2" class="border-b px-4 py-2 text-center">Saldo</th>
                        </tr>
                        <tr class="bg-gray-50 text-[10px] font-bold uppercase tracking-wider text-gray-500">
                            <th class="border-r px-4 py-2 text-right">Debit</th>
                            <th class="px-4 py-2 text-right">Kredit</th>
                        </tr>
                    </thead>

                    <tbody class="text-sm">

                        {{-- SALDO AWAL --}}
                        <tr class="bg-blue-50/50">
                            <td class="px-4 py-4 text-center text-gray-400 italic">Mulai</td>
                            <td class="px-4 py-4 font-bold text-blue-700">Saldo Awal</td>
                            <td class="px-4 py-4 text-center">-</td>
                            <td class="px-4 py-4 text-right">-</td>
                            <td class="border-r px-4 py-4 text-right">-</td>
                            <td class="border-r px-4 py-4 text-right font-bold">
                                {{ $coa->normal_balance === 'DEBIT' ? number_format($openingBalance, 0, ',', '.') : '-' }}
                            </td>
                            <td class="px-4 py-4 text-right font-bold">
                                {{ $coa->normal_balance === 'KREDIT' ? number_format($openingBalance, 0, ',', '.') : '-' }}
                            </td>
                        </tr>

                        {{-- DATA --}}
                        @forelse ($ledger as $row)
                            <tr class="border-b hover:bg-gray-50">
                                <td class="px-4 py-4 text-center">
                                    {{ $row['date']->format('d M Y') }}
                                </td>
                                <td class="px-4 py-4">
                                    {{ $row['description'] }}
                                </td>
                                <td class="px-4 py-4 text-center font-mono text-xs text-blue-600">
                                    {{ $row['ref_code'] }}
                                </td>
                                <td class="px-4 py-4 text-right">
                                    {{ $row['debit'] > 0 ? number_format($row['debit'], 0, ',', '.') : '-' }}
                                </td>
                                <td class="border-r px-4 py-4 text-right text-red-600">
                                    {{ $row['credit'] > 0 ? number_format($row['credit'], 0, ',', '.') : '-' }}
                                </td>
                                <td class="border-r px-4 py-4 text-right font-bold">
                                    {{ $row['normal_balance'] === 'DEBIT' ? number_format($row['current_balance'], 0, ',', '.') : '-' }}
                                </td>
                                <td class="px-4 py-4 text-right font-bold">
                                    {{ $row['normal_balance'] === 'KREDIT' ? number_format($row['current_balance'], 0, ',', '.') : '-' }}
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="7" class="px-4 py-20 text-center text-gray-400">
                                    Tidak ada transaksi
                                </td>
                            </tr>
                        @endforelse

                    </tbody>

                    <tfoot>
                        <tr class="bg-gray-400 text-white">
                            <td colspan="5" class="px-4 py-4 text-right text-xs font-bold uppercase">
                                Saldo Akhir
                            </td>
                            <td class="border-r px-4 py-4 text-right font-black">
                                {{ $coa->normal_balance === 'DEBIT' ? 'Rp' . number_format($endingBalance, 0, ',', '.') : '-' }}
                            </td>
                            <td class="px-4 py-4 text-right font-black">
                                {{ $coa->normal_balance === 'KREDIT' ? 'Rp' . number_format($endingBalance, 0, ',', '.') : '-' }}
                            </td>
                        </tr>
                    </tfoot>

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

            const res = await fetch(`/bendahara/periode/${periodId}/sub-periods`);
            const data = await res.json();

            subPeriodFilter.innerHTML = '<option value="">Semua</option>';

            data.forEach(sub => {
                subPeriodFilter.innerHTML += `<option value="${sub.id}">${sub.name}</option>`;
            });
        });
    </script>
@endsection
