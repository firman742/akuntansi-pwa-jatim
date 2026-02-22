@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Buku Besar" />

    {{-- FILTER CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
        <form method="GET" class="flex flex-wrap items-end gap-5">
            <div class="flex flex-col gap-2">
                <label class="text-xs font-bold uppercase tracking-wider text-gray-500">Periode</label>
                <select name="period_id"
                    class="w-48 rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
                    @foreach ($periods as $p)
                        <option value="{{ $p->id }}" @selected($periodId == $p->id)>{{ $p->name }}</option>
                    @endforeach
                </select>
            </div>

            <div class="flex flex-col gap-2">
                <label class="text-xs font-bold uppercase tracking-wider text-gray-500">Akun</label>
                <select name="coa_id"
                    class="w-64 rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
                    <option value="">-- Pilih Akun --</option>
                    @foreach ($coas as $c)
                        <option value="{{ $c->id }}" @selected(optional($coa)->id === $c->id)>
                            {{ $c->code }} - {{ $c->name }}
                        </option>
                    @endforeach
                </select>
            </div>

            <div class="flex flex-col gap-2">
                <label class="text-xs font-bold uppercase tracking-wider text-gray-500">Bulan</label>
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

                @if ($coa)
                    <a
                        href="{{ route('bendahara.ledgers.export', ['period_id' => $periodId, 'coa_id' => $coa->id, 'month' => $month]) }}">
                        <x-ui.button variant="outline" type="button"
                            class="rounded-xl border-gray-300 bg-white hover:bg-gray-50">
                            Export
                        </x-ui.button>
                    </a>
                @endif
            </div>
        </form>
    </div>

    @if ($coa)
        <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">
            {{-- HEADER STATUS --}}
            <div
                class="flex flex-col justify-between border-b border-gray-100 bg-gray-50/50 p-6 sm:flex-row sm:items-center">
                <div class="flex items-center gap-4">
                    {{-- <div
                        class="flex h-12 w-12 items-center justify-center rounded-xl bg-primary text-white shadow-lg shadow-primary/30">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                        </svg>
                    </div> --}}
                    <div>
                        <h2 class="text-xl font-bold text-gray-800">{{ $coa->name }}</h2>
                        <p class="text-sm font-medium text-gray-500">Kode Akun: <span
                                class="text-primary">{{ $coa->code }}</span></p>
                    </div>
                </div>
                <div class="mt-4 text-right sm:mt-0">
                    <p class="text-xs font-bold uppercase tracking-widest text-gray-400">Total Saldo Akhir</p>
                    <p class="text-2xl font-black text-gray-900">Rp{{ number_format($endingBalance, 0, ',', '.') }}</p>
                </div>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full border-collapse">
                    <thead>
                        <tr class="bg-gray-50 text-[11px] font-bold uppercase tracking-wider text-gray-600">
                            <th rowspan="2" class="border-b border-r border-gray-200 px-4 py-4 text-center">Tanggal</th>
                            <th rowspan="2" class="border-b border-r border-gray-200 px-4 py-4 text-left">Keterangan</th>
                            <th rowspan="2" class="border-b border-r border-gray-200 px-4 py-4 text-center uppercase">Ref
                            </th>
                            <th rowspan="2" class="border-b border-r border-gray-200 px-4 py-4 text-right">Debit</th>
                            <th rowspan="2" class="border-b border-r border-gray-200 px-4 py-4 text-right text-red-500">
                                Kredit</th>
                            <th colspan="2" class="border-b border-gray-200 bg-gray-100/50 px-4 py-2 text-center">Saldo
                                Berjalan</th>
                        </tr>
                        <tr class="bg-gray-50 text-[10px] font-bold uppercase tracking-wider text-gray-500">
                            <th class="border-b border-r border-gray-200 px-4 py-2 text-right">Debit</th>
                            <th class="border-b px-4 py-2 text-right">Kredit</th>
                        </tr>
                    </thead>

                    <tbody class="text-sm">
                        {{-- SALDO AWAL --}}
                        <tr class="bg-blue-50/50 transition hover:bg-blue-50">
                            <td class="px-4 py-4 text-center font-medium text-gray-400 italic">Mulai</td>
                            <td class="px-4 py-4 font-bold text-blue-700">Saldo Awal Periode</td>
                            <td class="px-4 py-4 text-center text-gray-300">-</td>
                            <td class="px-4 py-4 text-right text-gray-300">-</td>
                            <td class="border-r px-4 py-4 text-right text-gray-300">-</td>
                            <td class="border-r px-4 py-4 text-right font-bold text-blue-900">
                                {{ $coa->normal_balance === 'DEBIT' ? number_format($openingBalance, 0, ',', '.') : '-' }}
                            </td>
                            <td class="px-4 py-4 text-right font-bold text-red-900">
                                {{ $coa->normal_balance === 'KREDIT' ? number_format($openingBalance, 0, ',', '.') : '-' }}
                            </td>
                        </tr>

                        {{-- DATA TRANSAKSI --}}
                        @forelse ($ledger as $row)
                            <tr class="group border-b border-gray-100 transition hover:bg-gray-50/80">
                                <td class="px-4 py-4 text-center text-gray-600">
                                    {{ $row['date']->format('d M Y') }}
                                </td>
                                <td class="px-4 py-4">
                                    <span
                                        class="block font-semibold text-gray-700 group-hover:text-primary transition">{{ $row['description'] }}</span>
                                    {{-- <span class="text-[10px] uppercase text-gray-400">Jurnal Umum</span> --}}
                                </td>
                                <td class="px-4 py-4 text-center font-mono text-xs font-bold text-blue-600">
                                    {{ $row['ref_code'] }}
                                </td>
                                <td class="px-4 py-4 text-right text-gray-700">
                                    {{ $row['debit'] > 0 ? number_format($row['debit'], 0, ',', '.') : '-' }}
                                </td>
                                <td class="border-r px-4 py-4 text-right text-red-600">
                                    {{ $row['credit'] > 0 ? number_format($row['credit'], 0, ',', '.') : '-' }}
                                </td>
                                <td class="border-r bg-gray-50/30 px-4 py-4 text-right font-bold text-gray-900">
                                    {{ $row['normal_balance'] === 'DEBIT' ? number_format($row['current_balance'], 0, ',', '.') : '-' }}
                                </td>
                                <td class="bg-gray-50/30 px-4 py-4 text-right font-bold text-gray-900">
                                    {{ $row['normal_balance'] === 'KREDIT' ? number_format($row['current_balance'], 0, ',', '.') : '-' }}
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="7" class="px-4 py-20 text-center">
                                    <div class="flex flex-col items-center">
                                        <div class="mb-2 rounded-full bg-gray-100 p-3 text-gray-400">
                                            <svg class="h-8 w-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
                                            </svg>
                                        </div>
                                        <p class="font-medium text-gray-500">Tidak ada transaksi ditemukan</p>
                                    </div>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>

                    {{-- FOOTER --}}
                    <tfoot>
                        <tr class="bg-gray-400 text-white">
                            <td colspan="5"
                                class="px-4 py-4 text-right text-[10px] font-bold uppercase tracking-widest text-gray-400">
                                Saldo Akhir Keseluruhan
                            </td>
                            <td class="border-r border-gray-700 px-4 py-4 text-right text-lg font-black">
                                {{ $coa->normal_balance === 'DEBIT' ? 'Rp' . number_format($endingBalance, 0, ',', '.') : '-' }}
                            </td>
                            <td class="px-4 py-4 text-right text-lg font-black">
                                {{ $coa->normal_balance === 'KREDIT' ? 'Rp' . number_format($endingBalance, 0, ',', '.') : '-' }}
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    @endif
@endsection
