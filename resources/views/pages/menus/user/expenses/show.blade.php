@extends('layouts.app')

@section('content')
    <div class="max-w-6xl mx-auto space-y-4">

        {{-- BACK --}}
        <a href="{{ route('user.expenses.index') }}" class="mb-5">
            <x-ui.button variant="outline" size="sm" class="mb-5">
                ← Kembali
            </x-ui.button>
        </a>

        {{-- MAIN CARD --}}
        <div class="bg-white rounded-xl border p-6 space-y-6 pt-5">

            {{-- HEADER --}}
            <div class="grid grid-cols-2 md:grid-cols-3 gap-6 text-sm">

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
                    <div class="text-gray-500">Sub Periode</div>
                    <div class="font-semibold">
                        {{ $transaction->subPeriod?->name ?? '-' }}
                    </div>
                </div>

                <div>
                    <div class="text-gray-500">Dibuat oleh</div>
                    <div class="font-semibold">{{ $transaction->creator?->name }}</div>
                </div>

                {{-- STATUS --}}
                <div>
                    <div class="text-gray-500">Status</div>
                    <span
                        class="inline-block px-3 py-1 text-xs rounded-full
                    @if ($transaction->status === 'POSTED') bg-green-100 text-green-700
                    @elseif($transaction->status === 'SUBMITTED') bg-yellow-100 text-yellow-700
                    @elseif($transaction->status === 'REVERSED') bg-red-100 text-red-700
                    @else bg-gray-100 text-gray-700 @endif
                ">
                        {{ $transaction->status }}
                    </span>
                </div>

                <div>
                    <div class="text-gray-500">Tipe</div>
                    <span class="inline-block px-3 py-1 text-xs rounded-full
                    bg-red-100 text-red-700">
                        Pengeluaran
                    </span>
                </div>

                <div>
                    <div class="text-gray-500">Total</div>
                    <div class="font-semibold text-lg">
                        Rp {{ number_format($transaction->total_amount, 0, ',', '.') }}
                    </div>
                </div>

            </div>

            {{-- DESCRIPTION --}}
            @if ($transaction->description)
                <div>
                    <div class="text-gray-500 text-sm">Keterangan</div>
                    <div class="text-sm">{{ $transaction->description }}</div>
                </div>
            @endif

            <hr>

            {{-- TRANSACTION LINES --}}
            <div class="border rounded-lg overflow-hidden">
                <table class="min-w-full text-sm">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left">Akun</th>
                            <th class="px-6 py-3 text-left">Deskripsi</th>

                            <th class="px-6 py-3 text-right">
                                Debit
                                <div class="text-[10px] text-gray-400">(Beban)</div>
                            </th>

                            <th class="px-6 py-3 text-right">
                                Kredit
                                <div class="text-[10px] text-gray-400">(Kas/Bank)</div>
                            </th>
                        </tr>
                    </thead>

                    <tbody class="divide-y">
                        @foreach ($transaction->transactionLines as $line)
                            @php
                                $isDebit = $line->debit_amount > 0;
                                $isCredit = $line->credit_amount > 0;
                            @endphp

                            <tr
                                class="
                            {{ $isDebit ? 'bg-green-50/40' : '' }}
                            {{ $isCredit ? 'bg-red-50/40' : '' }}
                        ">
                                <td class="px-6 py-4">
                                    <div class="font-medium">
                                        {{ $line->chartOfAccount->code }}
                                    </div>

                                    <div class="text-xs text-gray-500">
                                        {{ $line->chartOfAccount->name }}

                                        @if ($isDebit)
                                            <span class="ml-2 text-green-600">(Beban)</span>
                                        @endif

                                        @if ($isCredit)
                                            <span class="ml-2 text-red-600">(Kas Keluar)</span>
                                        @endif
                                    </div>
                                </td>

                                <td class="px-6 py-4">
                                    {{ $line->description ?? '-' }}
                                </td>

                                {{-- DEBIT --}}
                                <td class="px-6 py-4 text-right">
                                    @if ($isDebit)
                                        <span class="font-medium text-green-700">
                                            Rp {{ number_format($line->debit_amount, 0, ',', '.') }}
                                        </span>
                                    @else
                                        <span class="text-gray-400">-</span>
                                    @endif
                                </td>

                                {{-- CREDIT --}}
                                <td class="px-6 py-4 text-right">
                                    @if ($isCredit)
                                        <span class="font-medium text-red-700">
                                            Rp {{ number_format($line->credit_amount, 0, ',', '.') }}
                                        </span>
                                    @else
                                        <span class="text-gray-400">-</span>
                                    @endif
                                </td>
                            </tr>
                        @endforeach
                    </tbody>

                    <tfoot class="bg-gray-50">
                        <tr>
                            <td colspan="2" class="px-6 py-3 text-right font-semibold">
                                Total
                            </td>

                            <td class="px-6 py-3 text-right font-semibold text-green-700">
                                Rp
                                {{ number_format($transaction->transactionLines->sum('debit_amount'), 0, ',', '.') }}
                            </td>

                            <td class="px-6 py-3 text-right font-semibold text-red-700">
                                Rp
                                {{ number_format($transaction->transactionLines->sum('credit_amount'), 0, ',', '.') }}
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>

            {{-- ========================================= --}}
            {{-- RECEIPT CONTENT (PLACEHOLDER) --}}
            {{-- ========================================= --}}
            <div class="border rounded-lg p-4 space-y-3">

                <div class="flex items-center justify-between">
                    <div class="text-sm font-medium text-gray-700">
                        Bukti Transaksi :
                    </div>

                    <span class="text-xs text-gray-400">
                        (Belum tersedia)
                    </span>
                </div>

                <div class="text-sm text-gray-500 italic">
                    Data detail dari bukti transaksi seperti item, keterangan tambahan,
                    atau hasil ekstraksi (OCR) akan ditampilkan di sini.
                </div>

                <div class="overflow-x-auto">
                    <table class="min-w-full text-sm border rounded-lg overflow-hidden">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-4 py-2 text-left">Item</th>
                                <th class="px-4 py-2 text-left">Deskripsi</th>
                                <th class="px-4 py-2 text-right">Jumlah</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="3" class="px-4 py-6 text-center text-gray-400">
                                    Belum ada data
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>
    </div>
@endsection
