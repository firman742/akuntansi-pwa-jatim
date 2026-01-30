@extends('layouts.app')

@section('content')
<x-common.page-breadcrumb pageTitle="Neraca Saldo" />

<form method="GET"
    class="mb-6 flex flex-wrap items-end gap-4
           rounded-xl border border-gray-200 bg-white p-4">

    {{-- Periode --}}
    <div class="flex flex-col gap-1">
        <label class="text-xs font-semibold text-gray-600">Periode</label>
        <select name="period_id"
            class="rounded-lg border border-gray-200 px-3 py-2 text-sm">
            @foreach ($periods as $p)
                <option value="{{ $p->id }}" @selected($periodId == $p->id)>
                    {{ $p->name }}
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

    <x-ui.button type="submit" variant="primary" size="sm">
        Tampilkan
    </x-ui.button>
</form>

<div class="rounded-2xl border border-gray-200 bg-white">
    <div class="overflow-x-auto">
        <table class="w-full border-collapse">
            <thead class="bg-gray-50 border-b">
                <tr>
                    <th class="px-4 py-3 text-left text-xs">Kode</th>
                    <th class="px-4 py-3 text-left text-xs">Nama Akun</th>
                    <th class="px-4 py-3 text-right text-xs">Debit</th>
                    <th class="px-4 py-3 text-right text-xs">Kredit</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($trialBalance as $row)
                    <tr class="border-b">
                        <td class="px-4 py-2 text-sm">{{ $row['code'] }}</td>
                        <td class="px-4 py-2 text-sm">{{ $row['name'] }}</td>
                        <td class="px-4 py-2 text-right text-sm">
                            {{ $row['debit'] ? number_format($row['debit'], 0, ',', '.') : '-' }}
                        </td>
                        <td class="px-4 py-2 text-right text-sm">
                            {{ $row['credit'] ? number_format($row['credit'], 0, ',', '.') : '-' }}
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="4" class="px-4 py-6 text-center text-sm text-gray-500">
                            Tidak ada data
                        </td>
                    </tr>
                @endforelse
            </tbody>

            <tfoot class="bg-gray-100 font-semibold">
                <tr>
                    <td colspan="2" class="px-4 py-3 text-right">
                        TOTAL
                    </td>
                    <td class="px-4 py-3 text-right">
                        {{ number_format($totalDebit, 0, ',', '.') }}
                    </td>
                    <td class="px-4 py-3 text-right">
                        {{ number_format($totalCredit, 0, ',', '.') }}
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>
</div>
@endsection
