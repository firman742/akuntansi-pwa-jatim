@extends('layouts.app')

@section('content')
<div class="max-w-6xl mx-auto space-y-4">

    {{-- BACK --}}
    <a href="{{ route('user.incomes.index') }}">
        <x-ui.button variant="outline" size="sm">
            ← Kembali
        </x-ui.button>
    </a>

    {{-- MAIN CARD --}}
    <div class="bg-white rounded-xl border p-6 space-y-6">

        {{-- HEADER --}}
        <div class="grid grid-cols-2 gap-6 text-sm">
            <div>
                <div class="text-gray-500">No Transaksi</div>
                <div class="font-semibold">{{ $transaction->transaction_number }}</div>
            </div>

            <div>
                <div class="text-gray-500">Tanggal</div>
                <div class="font-semibold">
                    {{ $transaction->transaction_date->format('d F Y') }}
                </div>
            </div>

            <div>
                <div class="text-gray-500">Periode</div>
                <div class="font-semibold">{{ $transaction->period->name }}</div>
            </div>

            <div>
                <div class="text-gray-500">Dibuat oleh</div>
                <div class="font-semibold">{{ $transaction->creator?->name }}</div>
            </div>

            <div>
                <div class="text-gray-500">Tipe</div>
                <span class="inline-block px-3 py-1 text-xs rounded-full
                    bg-blue-100 text-blue-700">
                    Penerimaan
                </span>
            </div>

            <div>
                <div class="text-gray-500">Total</div>
                <div class="font-semibold text-lg">
                    Rp {{ number_format($transaction->total_amount, 0, ',', '.') }}
                </div>
            </div>
        </div>

        <hr>

        {{-- TRANSACTION LINES --}}
        <div class="border rounded-lg overflow-hidden">
            <table class="min-w-full text-sm">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left">Akun</th>
                        <th class="px-6 py-3 text-left">Deskripsi</th>
                        <th class="px-6 py-3 text-right">Debit</th>
                        <th class="px-6 py-3 text-right">Kredit</th>
                    </tr>
                </thead>

                <tbody class="divide-y">
                    @foreach ($transaction->transactionLines as $line)
                        <tr>
                            <td class="px-6 py-4">
                                <div class="font-medium">
                                    {{ $line->chartOfAccount->code }}
                                </div>
                                <div class="text-xs text-gray-500">
                                    {{ $line->chartOfAccount->name }}
                                </div>
                            </td>

                            <td class="px-6 py-4">
                                {{ $line->description ?? '-' }}
                            </td>

                            <td class="px-6 py-4 text-right">
                                {{ $line->debit_amount > 0
                                    ? number_format($line->debit_amount, 0, ',', '.')
                                    : '-' }}
                            </td>

                            <td class="px-6 py-4 text-right">
                                {{ $line->credit_amount > 0
                                    ? number_format($line->credit_amount, 0, ',', '.')
                                    : '-' }}
                            </td>
                        </tr>
                    @endforeach
                </tbody>

                <tfoot class="bg-gray-50">
                    <tr>
                        <td colspan="2" class="px-6 py-3 text-right font-semibold">
                            Total
                        </td>
                        <td class="px-6 py-3 text-right font-semibold">
                            Rp {{ number_format(
                                $transaction->transactionLines->sum('debit_amount'),
                                0, ',', '.'
                            ) }}
                        </td>
                        <td class="px-6 py-3 text-right font-semibold">
                            Rp {{ number_format(
                                $transaction->transactionLines->sum('credit_amount'),
                                0, ',', '.'
                            ) }}
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>

        {{-- JOURNAL LINK --}}
        @if ($transaction->journal->count())
            <div class="text-sm text-gray-600">
                <span class="font-medium">Jurnal:</span>
                <a
                    href="{{ route('bendahara.journals.show', $transaction->journal->first()) }}"
                    class="text-blue-600 hover:underline">
                    {{ $transaction->journal->first()->journal_number }}
                </a>
            </div>
        @endif

    </div>
</div>
@endsection
