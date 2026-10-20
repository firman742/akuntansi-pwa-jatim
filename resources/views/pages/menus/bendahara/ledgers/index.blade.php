@extends('layouts.app')

@section('title', 'Buku Besar')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Buku Besar" pageTitle="Monitoring Buku Besar"
        pageDescription="Rincian Transaksi dan Mutasi Per Akun (General Ledger)" pageIcon="ledger" />

    {{-- FILTER CARD CONTAINER --}}
    <div class="mb-6 rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-800 dark:bg-gray-900">
        <form method="GET" action="{{ route('bendahara.reports.ledger.index') }}" id="filterForm" class="space-y-4">
            {{-- ROW 1: PERIODE, SUB PERIODE, AKUN --}}
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <x-form.select id="filter_period" name="period_id" label="Periode">
                    @foreach ($periods as $p)
                        <option value="{{ $p->id }}" @selected($periodId == $p->id)>
                            {{ $p->name }}
                        </option>
                    @endforeach
                </x-form.select>

                <x-form.select id="filter_sub_period" name="sub_period_id" label="Sub Periode"
                    onchange="this.form.submit()">
                    <option value="">Semua Sub Periode</option>
                    @foreach ($subPeriods as $sp)
                        <option value="{{ $sp->id }}" @selected($subPeriodId == $sp->id)>
                            {{ $sp->name }}
                        </option>
                    @endforeach
                </x-form.select>

                <x-form.select id="filter_coa" name="coa_id" label="Akun (COA)" onchange="this.form.submit()">
                    <option value="">-- Pilih Akun --</option>
                    @foreach ($coas as $c)
                        <option value="{{ $c->id }}" @selected(optional($coa)->id === $c->id)>
                            {{ $c->code }} - {{ $c->name }}
                        </option>
                    @endforeach
                </x-form.select>
            </div>

            {{-- ROW 2: TANGGAL & ACTIONS --}}
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
                <div>
                    <label class="block text-xs font-bold uppercase tracking-wider text-gray-500 mb-1.5 dark:text-gray-400">
                        Dari Tanggal
                    </label>
                    <x-form.date-picker id="start_date" name="start_date" defaultDate="{{ $startDate }}" />
                </div>

                <div>
                    <label class="block text-xs font-bold uppercase tracking-wider text-gray-500 mb-1.5 dark:text-gray-400">
                        Sampai Tanggal
                    </label>
                    <x-form.date-picker id="end_date" name="end_date" defaultDate="{{ $endDate }}" />
                </div>

                <div class="flex items-center gap-2">
                    <x-ui.button type="submit" variant="primary" class="flex-1 justify-center rounded-xl py-2.5 text-xs">
                        Tampilkan Ledger
                    </x-ui.button>
                    <a href="{{ route('bendahara.reports.ledger.index') }}" class="flex-1">
                        <x-ui.button type="button" variant="outline"
                            class="w-full justify-center rounded-xl py-2.5 text-xs">
                            Reset
                        </x-ui.button>
                    </a>
                </div>
            </div>
        </form>
    </div>

    @if ($coa)
        @php
            $normalBalStr = is_object($coa->normal_balance) ? $coa->normal_balance->value : $coa->normal_balance;
            $isDebitAcc = strtoupper($normalBalStr) === 'DEBIT';
        @endphp

        {{-- METRIC SUMMARY CARDS --}}
        <div class="mb-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            {{-- Saldo Awal --}}
            <div class="p-4 bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 shadow-sm">
                <p class="text-[11px] font-bold uppercase tracking-wider text-gray-400">Saldo Awal</p>
                <h4 class="text-xl font-black text-gray-800 dark:text-gray-100 mt-1 tabular-nums font-mono">
                    Rp{{ number_format(abs($openingBalance), 0, ',', '.') }}
                </h4>
                <p class="text-[10px] text-gray-400 mt-0.5">Oleh: {{ $openingBalanceCreatedBy }}</p>
            </div>

            {{-- Total Mutasi Debit --}}
            <div class="p-4 bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 shadow-sm">
                <p class="text-[11px] font-bold uppercase tracking-wider text-blue-600 dark:text-blue-400">Total Mutasi
                    Debit</p>
                <h4 class="text-xl font-black text-blue-600 dark:text-blue-400 mt-1 tabular-nums font-mono">
                    Rp{{ number_format($totalDebitMutation, 0, ',', '.') }}
                </h4>
                <p class="text-[10px] text-gray-400 mt-0.5">Total Penambahan/Pengurangan</p>
            </div>

            {{-- Total Mutasi Kredit --}}
            <div class="p-4 bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 shadow-sm">
                <p class="text-[11px] font-bold uppercase tracking-wider text-rose-600 dark:text-rose-400">Total Mutasi
                    Kredit</p>
                <h4 class="text-xl font-black text-rose-600 dark:text-rose-400 mt-1 tabular-nums font-mono">
                    Rp{{ number_format($totalCreditMutation, 0, ',', '.') }}
                </h4>
                <p class="text-[10px] text-gray-400 mt-0.5">Total Penambahan/Pengurangan</p>
            </div>

            {{-- Saldo Akhir --}}
            <div class="p-4 bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 shadow-sm">
                <p class="text-[11px] font-bold uppercase tracking-wider text-emerald-600 dark:text-emerald-400">Saldo Akhir
                    Kumulatif</p>
                <h4 class="text-xl font-black text-emerald-600 dark:text-emerald-400 mt-1 tabular-nums font-mono">
                    Rp{{ number_format(abs($endingBalance), 0, ',', '.') }}
                </h4>
                <p class="text-[10px] text-gray-400 mt-0.5">Posisi: {{ $isDebitAcc ? 'DEBIT' : 'KREDIT' }}</p>
            </div>
        </div>

        {{-- MAIN TABLE CARD --}}
        <div
            class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-xl dark:border-gray-800 dark:bg-gray-900">
            {{-- BANNER HEADER --}}
            <div
                class="border-b border-gray-200 bg-gray-50/80 p-5 dark:border-gray-800 dark:bg-gray-800/50 flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <div class="flex items-center gap-2">
                        <span
                            class="font-mono text-xs font-bold text-blue-600 dark:text-blue-400 bg-blue-50 dark:bg-blue-900/40 px-2 py-0.5 rounded">
                            {{ $coa->code }}
                        </span>
                        <span
                            class="text-xs font-bold uppercase tracking-wider px-2 py-0.5 rounded {{ $isDebitAcc ? 'bg-blue-100 text-blue-700 dark:bg-blue-900/50 dark:text-blue-300' : 'bg-purple-100 text-purple-700 dark:bg-purple-900/50 dark:text-purple-300' }}">
                            Saldo Normal: {{ strtoupper($normalBalStr) }}
                        </span>
                    </div>
                    <h2 class="text-xl font-black text-gray-900 dark:text-white uppercase tracking-tight mt-1">
                        {{ $coa->name }}
                    </h2>
                </div>

                {{-- EXPORT BUTTONS --}}
                <div class="flex items-center gap-2">
                    <a href="{{ route('bendahara.reports.ledger.export', request()->query()) }}" target="_blank">
                        <x-ui.button type="button" variant="outline" class="rounded-xl px-3 py-1.5 text-xs">
                            PDF
                        </x-ui.button>
                    </a>
                </div>
            </div>

            {{-- TABLE LEDGER --}}
            <div class="overflow-x-auto">
                <table class="w-full border-collapse text-sm">
                    <thead>
                        <tr
                            class="bg-gray-100/70 dark:bg-gray-800/80 text-xs font-bold uppercase tracking-wider text-gray-600 dark:text-gray-300 border-b border-gray-200 dark:border-gray-700">
                            <th rowspan="2"
                                class="w-28 px-4 py-3 text-center border-r border-gray-200 dark:border-gray-700">Tanggal
                            </th>
                            <th rowspan="2" class="px-4 py-3 text-left border-r border-gray-200 dark:border-gray-700">
                                Keterangan</th>
                            <th rowspan="2"
                                class="w-52 px-4 py-3 text-left border-r border-gray-200 dark:border-gray-700">Akun Lawan
                            </th>
                            <th rowspan="2"
                                class="w-32 px-4 py-3 text-left border-r border-gray-200 dark:border-gray-700">Kode
                                Akun</th>
                            <th rowspan="2"
                                class="w-32 px-4 py-3 text-left border-r border-gray-200 dark:border-gray-700">Posting Oleh
                            </th>
                            <th rowspan="2"
                                class="w-36 px-4 py-3 text-right border-r border-gray-200 dark:border-gray-700">Debit (Rp)
                            </th>
                            <th rowspan="2"
                                class="w-36 px-4 py-3 text-right border-r border-gray-200 dark:border-gray-700">Kredit (Rp)
                            </th>
                            <th colspan="2" class="px-4 py-2 text-center bg-gray-200/50 dark:bg-gray-700/50">Saldo
                                Kumulatif (Rp)</th>
                        </tr>
                        <tr
                            class="bg-gray-200/40 dark:bg-gray-700/40 text-[11px] font-bold uppercase tracking-wider text-gray-600 dark:text-gray-300 border-b border-gray-200 dark:border-gray-700">
                            <th class="w-36 px-4 py-2 text-right border-r border-gray-200 dark:border-gray-700">Saldo Debit
                            </th>
                            <th class="w-36 px-4 py-2 text-right">Saldo Kredit</th>
                        </tr>
                    </thead>

                    <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                        {{-- BARIS SALDO AWAL --}}
                        <tr
                            class="bg-blue-50/50 dark:bg-blue-950/20 font-semibold border-b border-blue-100 dark:border-blue-900">
                            <td
                                class="px-4 py-3 text-center text-xs font-mono text-blue-700 dark:text-blue-300 border-r border-gray-100 dark:border-gray-800">
                                {{ $openingBalanceDate }}
                            </td>
                            <td
                                class="px-4 py-3 text-blue-900 dark:text-blue-200 border-r border-gray-100 dark:border-gray-800">
                                Saldo Awal Periode
                            </td>
                            <td colspan="2"
                                class="px-4 py-3 text-xs text-gray-400 border-r border-gray-100 dark:border-gray-800">-
                            </td>
                            <td
                                class="px-4 py-3 text-xs text-gray-500 dark:text-gray-400 border-r border-gray-100 dark:border-gray-800">
                                {{ $openingBalanceCreatedBy }}
                            </td>
                            {{-- Mutasi Debit Saldo Awal --}}
                            <td
                                class="px-4 py-3 text-right font-mono text-blue-700 dark:text-blue-300 border-r border-gray-100 dark:border-gray-800">
                                {{ $openingDebit > 0 ? number_format($openingDebit, 0, ',', '.') : '-' }}
                            </td>
                            {{-- Mutasi Kredit Saldo Awal --}}
                            <td
                                class="px-4 py-3 text-right font-mono text-purple-700 dark:text-purple-300 border-r border-gray-100 dark:border-gray-800">
                                {{ $openingCredit > 0 ? number_format($openingCredit, 0, ',', '.') : '-' }}
                            </td>
                            {{-- Saldo Kumulatif Debit --}}
                            <td
                                class="px-4 py-3 text-right font-mono text-blue-700 dark:text-blue-300 border-r border-gray-100 dark:border-gray-800">
                                {{ $isDebitAcc ? number_format(abs($openingBalance), 0, ',', '.') : '-' }}
                            </td>
                            {{-- Saldo Kumulatif Kredit --}}
                            <td class="px-4 py-3 text-right font-mono text-purple-700 dark:text-purple-300">
                                {{ !$isDebitAcc ? number_format(abs($openingBalance), 0, ',', '.') : '-' }}
                            </td>
                        </tr>

                        {{-- BARIS TRANSAKSI --}}
                        @forelse ($ledger as $row)
                            <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/40 transition-colors">
                                {{-- Tanggal --}}
                                <td
                                    class="px-4 py-2.5 text-center font-mono text-xs text-gray-500 border-r border-gray-100 dark:border-gray-800">
                                    {{ $row['date']->format('d/m/Y') }}
                                </td>

                                {{-- Keterangan --}}
                                <td class="px-4 py-2.5 border-r border-gray-100 dark:border-gray-800">
                                    <p class="font-medium text-gray-800 dark:text-gray-200">{{ $row['description'] }}</p>
                                </td>

                                {{-- Akun Lawan (Single Line) --}}
                                <td class="px-4 py-2.5 border-r border-gray-100 dark:border-gray-800">
                                    <span class="text-xs text-gray-700 dark:text-gray-300">
                                        {{ $row['opposing_account_name'] }}
                                    </span>
                                </td>

                                {{-- Kode Akun Lawan (Single Line) --}}
                                <td class="px-4 py-2.5 border-r border-gray-100 dark:border-gray-800">
                                    <span
                                        class="font-mono text-xs font-bold text-blue-600 dark:text-blue-400 bg-blue-50 dark:bg-blue-900/40 px-1.5 py-0.5 rounded">
                                        {{ $row['opposing_account_code'] }}
                                    </span>
                                </td>

                                {{-- Posting Oleh --}}
                                <td
                                    class="px-4 py-2.5 text-xs text-gray-500 dark:text-gray-400 border-r border-gray-100 dark:border-gray-800">
                                    {{ $row['posted_by'] }}
                                </td>

                                {{-- Debit --}}
                                <td
                                    class="px-4 py-2.5 text-right font-mono text-gray-800 dark:text-gray-200 border-r border-gray-100 dark:border-gray-800">
                                    {{ $row['debit'] > 0 ? number_format($row['debit'], 0, ',', '.') : '-' }}
                                </td>

                                {{-- Kredit --}}
                                <td
                                    class="px-4 py-2.5 text-right font-mono text-rose-600 dark:text-rose-400 border-r border-gray-100 dark:border-gray-800">
                                    {{ $row['credit'] > 0 ? number_format($row['credit'], 0, ',', '.') : '-' }}
                                </td>

                                {{-- Saldo Kumulatif Debit --}}
                                <td
                                    class="px-4 py-2.5 text-right font-mono font-bold text-gray-900 dark:text-gray-100 border-r border-gray-100 dark:border-gray-800 bg-gray-50/50 dark:bg-gray-800/30">
                                    {{ $isDebitAcc ? number_format($row['current_balance'], 0, ',', '.') : '-' }}
                                </td>

                                {{-- Saldo Kumulatif Kredit --}}
                                <td
                                    class="px-4 py-2.5 text-right font-mono font-bold text-gray-900 dark:text-gray-100 bg-gray-50/50 dark:bg-gray-800/30">
                                    {{ !$isDebitAcc ? number_format($row['current_balance'], 0, ',', '.') : '-' }}
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="9" class="px-6 py-12 text-center text-gray-400 dark:text-gray-500">
                                    Tidak ada transaksi untuk akun ini pada periode yang dipilih.
                                </td>
                            </tr>
                        @endforelse
                    </tbody>

                    <tfoot>
                        @php
                            $grandTotalDebit = $openingDebit + $totalDebitMutation;
                            $grandTotalCredit = $openingCredit + $totalCreditMutation;
                        @endphp

                        {{-- BARIS 1: TOTAL MUTASI TRANSAKSI SAJA --}}
                        <tr
                            class="bg-gray-100/80 dark:bg-gray-800/80 border-t-2 border-gray-300 dark:border-gray-700 font-semibold text-xs text-gray-600 dark:text-gray-300">
                            <td colspan="5" class="px-4 py-2.5 text-right uppercase tracking-wider">
                                Total Mutasi Transaksi
                            </td>
                            <td
                                class="px-4 py-2.5 text-right font-mono text-blue-600 dark:text-blue-400 border-r border-gray-200 dark:border-gray-700">
                                {{ number_format($totalDebitMutation, 0, ',', '.') }}
                            </td>
                            <td
                                class="px-4 py-2.5 text-right font-mono text-rose-600 dark:text-rose-400 border-r border-gray-200 dark:border-gray-700">
                                {{ number_format($totalCreditMutation, 0, ',', '.') }}
                            </td>
                            <td colspan="2"
                                class="px-4 py-2.5 text-center text-gray-400 dark:text-gray-500 font-normal italic">
                                (Hanya Transaksi)
                            </td>
                        </tr>

                        {{-- BARIS 2: GRAND TOTAL (+ SALDO AWAL) --}}
                        <tr
                            class="bg-gray-200/60 dark:bg-gray-800 border-t border-gray-300 dark:border-gray-700 font-bold">
                            <td colspan="5"
                                class="px-4 py-3 text-right uppercase text-xs tracking-wider text-gray-800 dark:text-gray-100">
                                Total Akumulasi (+ Saldo Awal)
                            </td>
                            <td
                                class="px-4 py-3 text-right font-mono text-blue-700 dark:text-blue-300 border-r border-gray-200 dark:border-gray-700">
                                {{ number_format($grandTotalDebit, 0, ',', '.') }}
                            </td>
                            <td
                                class="px-4 py-3 text-right font-mono text-rose-700 dark:text-rose-300 border-r border-gray-200 dark:border-gray-700">
                                {{ number_format($grandTotalCredit, 0, ',', '.') }}
                            </td>
                            <td
                                class="px-4 py-3 text-right font-mono text-base text-emerald-600 dark:text-emerald-400 border-r border-gray-200 dark:border-gray-700">
                                {{ $isDebitAcc ? number_format(abs($endingBalance), 0, ',', '.') : '-' }}
                            </td>
                            <td class="px-4 py-3 text-right font-mono text-base text-emerald-600 dark:text-emerald-400">
                                {{ !$isDebitAcc ? number_format(abs($endingBalance), 0, ',', '.') : '-' }}
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    @endif

    {{-- SCRIPT AUTO SUBMIT FOR SUB PERIOD --}}
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
