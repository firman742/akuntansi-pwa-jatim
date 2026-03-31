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

                        @if ($coa)
                            <a
                                href="{{ route('bendahara.reports.ledger.export', [
                                    'period_id' => request('period_id'),
                                    'sub_period_id' => request('sub_period_id'),
                                    'start_date' => request('start_date'),
                                    'end_date' => request('end_date'),
                                    'coa_id' => request('coa_id'),
                                ]) }}" class="flex-1">
                                <x-ui.button variant="primary" class="w-full justify-center rounded-xl px-5 py-2.5">
                                    Export
                                </x-ui.button>
                            </a>
                        @endif
                    </div>
                </div>
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

            const res = await fetch(`/bendahara/periods/${periodId}/sub-periods`);
            const data = await res.json();

            subPeriodFilter.innerHTML = '<option value="">Semua</option>';

            data.forEach(sub => {
                subPeriodFilter.innerHTML += `<option value="${sub.id}">${sub.name}</option>`;
            });
        });
    </script>
@endsection
