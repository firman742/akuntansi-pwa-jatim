@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Buku Besar" />

    <form method="GET"
        class="mb-6 flex flex-wrap items-end gap-4
           rounded-xl border border-gray-200 bg-white p-4">

        {{-- Periode --}}
        <div class="flex flex-col gap-1">
            <label class="text-xs font-semibold text-gray-600">Periode</label>
            <select name="period_id" class="rounded-lg border border-gray-200 px-3 py-2 text-sm">
                @foreach ($periods as $p)
                    <option value="{{ $p->id }}" @selected($periodId == $p->id)>
                        {{ $p->name }}
                    </option>
                @endforeach
            </select>
        </div>

        {{-- COA --}}
        <div class="flex flex-col gap-1">
            <label class="text-xs font-semibold text-gray-600">Akun</label>
            <select name="coa_id" class="rounded-lg border border-gray-200 px-3 py-2 text-sm">
                <option value="">-- Pilih Akun --</option>
                @foreach ($coas as $c)
                    <option value="{{ $c->id }}" @selected(optional($coa)->id === $c->id)>
                        {{ $c->code }} - {{ $c->name }}
                    </option>
                @endforeach
            </select>
        </div>

        {{-- Bulan --}}
        <div class="flex flex-col gap-1">
            <label class="text-xs font-semibold text-gray-600">Bulan</label>
            <input type="month" name="month" value="{{ $month }}"
                class="rounded-lg border border-gray-200 px-3 py-2 text-sm">
        </div>

        {{-- ACTION --}}
        <div class="flex gap-2">
            <x-ui.button type="submit" variant="primary" size="sm">
                Tampilkan
            </x-ui.button>

            @if ($coa)
                <a
                    href="{{ route('bendahara.ledgers.export', [
                        'period_id' => $periodId,
                        'coa_id' => $coa->id,
                        'month' => $month,
                    ]) }}">
                    <x-ui.button variant="outline" size="sm">
                        Export
                    </x-ui.button>
                </a>
            @endif
        </div>
    </form>

    @if ($coa)
        <div class="rounded-2xl border border-gray-200 bg-white">
            <div class="p-4 font-semibold">
                Buku Besar: {{ $coa->code }} - {{ $coa->name }}
            </div>

            <div class="overflow-x-auto">
                <table class="w-full border-collapse text-sm">
                    <thead class="bg-gray-50 border-b">
                        <tr>
                            <th class="px-4 py-2 text-left">Tanggal</th>
                            <th class="px-4 py-2 text-left">Keterangan</th>
                            <th class="px-4 py-2 text-left">Ref</th>
                            <th class="px-4 py-2 text-right">Debit</th>
                            <th class="px-4 py-2 text-right">Kredit</th>
                            <th class="px-4 py-2 text-right">Saldo</th>
                        </tr>
                    </thead>

                    <tbody>
                        {{-- SALDO AWAL --}}
                        <tr class="bg-gray-100 font-semibold">
                            <td colspan="5" class="px-4 py-2 text-right">
                                Saldo Awal
                            </td>
                            <td class="px-4 py-2 text-right">
                                Rp{{ number_format($openingBalance, 0, ',', '.') }}
                            </td>
                        </tr>

                        {{-- TRANSAKSI --}}
                        @forelse ($ledger as $row)
                            <tr class="border-b {{ $row['is_credit'] ? 'border-b-2 border-gray-400' : '' }}">
                                <td class="px-4 py-2">
                                    {{ \Carbon\Carbon::parse($row['date'])->translatedFormat('d M Y') }}
                                </td>
                                <td class="px-4 py-2">
                                    {{ $row['description'] }}
                                </td>
                                <td class="px-4 py-2">
                                    {{ $row['ref'] }}
                                </td>
                                <td class="px-4 py-2 text-right">
                                    @if ($row['debit'] > 0)
                                        Rp{{ number_format($row['debit'], 0, ',', '.') }}
                                    @endif
                                </td>
                                <td class="px-4 py-2 text-right">
                                    @if ($row['credit'] > 0)
                                        Rp{{ number_format($row['credit'], 0, ',', '.') }}
                                    @endif
                                </td>
                                <td class="px-4 py-2 text-right font-medium">
                                    Rp{{ number_format($row['balance'], 0, ',', '.') }}
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="6" class="px-4 py-4 text-center text-gray-500">
                                    Tidak ada transaksi
                                </td>
                            </tr>
                        @endforelse

                        {{-- SALDO AKHIR --}}
                        <tr class="bg-gray-100 font-bold border-t-2">
                            <td colspan="5" class="px-4 py-2 text-right">
                                Saldo Akhir
                            </td>
                            <td class="px-4 py-2 text-right">
                                Rp{{ number_format($endingBalance, 0, ',', '.') }}
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    @endif
@endsection
