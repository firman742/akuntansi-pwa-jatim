@extends('layouts.app')

@section('title', 'Detail Laporan Transaksi')

@section('content')
    <div class="max-w-6xl mx-auto space-y-4">
        <x-common.page-breadcrumb 
            pageTitle="Detail Laporan Transaksi" 
            defaultTitle="Detail Laporan Transaksi"
            pageDescription="Monitoring riwayat transaksi yang terjadi di sistem ini" pageIcon="report" parentTitle="Laporan Transaksi"
            :parentRoute="route('user.transactions.histories.index')" currentTitle="Detail" />

        {{-- BACK --}}
        <a href="{{ route('bendahara.reports.transactions.index') }}" class="mb-5">
            <x-ui.button variant="outline" size="sm" class="mb-5">
                ← Kembali
            </x-ui.button>
        </a>

        {{-- MAIN CARD --}}
        <div class="bg-white rounded-xl border p-6 space-y-6 pt-5 dark:bg-gray-800 dark:border-gray-700">

            {{-- HEADER --}}
            <div class="grid grid-cols-2 md:grid-cols-3 gap-6 text-sm">

                <div>
                    <div class="text-gray-500 dark:text-gray-400">No Transaksi</div>
                    <div class="font-semibold dark:text-gray-200">{{ $transaction->transaction_number }}</div>
                </div>

                <div>
                    <div class="text-gray-500 dark:text-gray-400">Tanggal</div>
                    <div class="font-semibold dark:text-gray-200">
                        {{ $transaction->transaction_date->format('d F Y') }}
                    </div>
                </div>

                <div>
                    <div class="text-gray-500 dark:text-gray-400">Periode</div>
                    <div class="font-semibold dark:text-gray-200">{{ $transaction->period->name }}</div>
                </div>

                {{-- ✅ SUB PERIOD --}}
                <div>
                    <div class="text-gray-500 dark:text-gray-400">Sub Periode</div>
                    <div class="font-semibold dark:text-gray-200">
                        {{ $transaction->subPeriod?->name ?? '-' }}
                    </div>
                </div>

                <div>
                    <div class="text-gray-500 dark:text-gray-400">Dibuat oleh</div>
                    <div class="font-semibold dark:text-gray-200">{{ $transaction->creator?->name }}</div>
                </div>

                {{-- STATUS --}}
                <div>
                    <div class="text-gray-500 dark:text-gray-400">Status</div>
                    <span
                        class="inline-block px-3 py-1 text-xs rounded-full
                    @if ($transaction->status === 'POSTED') 
                        bg-green-100 text-green-700 dark:bg-green-900 dark:text-green-700
                    @elseif($transaction->status === 'SUBMITTED')
                        bg-yellow-100 text-yellow-700 dark:bg-yellow-900 dark:text-yellow-700
                    @elseif($transaction->status === 'REVERSED') 
                        bg-red-100 text-red-700 dark:bg-red-900 dark:text-red-700
                    @else 
                        bg-gray-100 text-gray-700 dark:bg-gray-700 dark:text-gray-700 @endif
                ">
                        {{ $transaction->status }}
                    </span>
                </div>

                <div>
                    <div class="text-gray-500 dark:text-gray-400">Tipe</div>
                    <span
                        class="inline-block px-3 py-1 text-xs rounded-full
                    bg-blue-100 text-blue-700 dark:bg-blue-900 dark:text-blue-700">
                        Pengeluaran
                    </span>
                </div>

                <div>
                    <div class="text-gray-500 dark:text-gray-400">Total</div>
                    <div class="font-semibold text-lg dark:text-gray-200">
                        Rp {{ number_format($transaction->net_amount, 0, ',', '.') }}
                    </div>
                </div>

            </div>

            {{-- DESCRIPTION --}}
            @if ($transaction->description)
                <div>
                    <div class="text-gray-500 text-sm dark:text-gray-400">Keterangan</div>
                    <div class="text-sm dark:text-gray-300">{{ $transaction->description }}</div>
                </div>
            @endif

            <hr class="dark:border-gray-700">

            {{-- TRANSACTION LINES --}}
            <div class="border rounded-lg overflow-hidden dark:border-gray-700">
                <table class="min-w-full text-sm">
                    <thead class="bg-gray-50 dark:bg-gray-700">
                        <tr>
                            <th class="px-6 py-3 text-left text-gray-500 dark:text-gray-300">Akun</th>
                            <th class="px-6 py-3 text-left text-gray-500 dark:text-gray-300">Deskripsi</th>
                            <th class="px-6 py-3 text-right text-gray-500 dark:text-gray-300">Debit</th>
                            <th class="px-6 py-3 text-right text-gray-500 dark:text-gray-300">Kredit</th>
                        </tr>
                    </thead>

                    <tbody class="divide-y dark:divide-gray-700">
                        @foreach ($transaction->transactionLines as $line)
                            @php
                                $line->debit_amount =
                                    $line->position === App\Enums\NormalBalanceEnum::DEBIT ? $line->amount : 0;
                                $line->credit_amount =
                                    $line->position === App\Enums\NormalBalanceEnum::CREDIT ? $line->amount : 0;
                            @endphp
                            <tr class="dark:bg-gray-800">
                                <td class="px-6 py-4">
                                    <div class="font-medium dark:text-gray-200">
                                        {{ $line->chartOfAccount->code }}
                                    </div>
                                    <div class="text-xs text-gray-500 dark:text-gray-400">
                                        {{ $line->chartOfAccount->name }}
                                    </div>
                                </td>

                                <td class="px-6 py-4 dark:text-gray-300">
                                    {{ $line->description ?? '-' }}
                                </td>

                                <td class="px-6 py-4 text-right dark:text-gray-300">
                                    {{ $line->debit_amount > 0 ? number_format($line->debit_amount, 0, ',', '.') : '-' }}
                                </td>

                                <td class="px-6 py-4 text-right dark:text-gray-300">
                                    {{ $line->credit_amount > 0 ? number_format($line->credit_amount, 0, ',', '.') : '-' }}
                                </td>
                            </tr>
                        @endforeach
                    </tbody>

                    <tfoot class="bg-gray-50 dark:bg-gray-700">
                        <tr>
                            <td colspan="2" class="px-6 py-3 text-right font-semibold dark:text-gray-300">
                                Total
                            </td>
                            <td class="px-6 py-3 text-right font-semibold dark:text-gray-300">
                                Rp
                                {{ number_format($transaction->transactionLines->sum('debit_amount'), 0, ',', '.') }}
                            </td>
                            <td class="px-6 py-3 text-right font-semibold dark:text-gray-300">
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
            <div class="border rounded-lg p-4 space-y-3 dark:border-gray-700 dark:bg-gray-800">

                <div class="flex items-center justify-between">
                    <div class="text-sm font-medium text-gray-700 dark:text-gray-300">
                        Bukti Transaksi :
                    </div>

                    <span class="text-xs text-gray-400 dark:text-gray-500">
                        (Belum tersedia)
                    </span>
                </div>

                <div class="text-sm text-gray-500 italic dark:text-gray-400">
                    Data detail dari bukti transaksi seperti item, keterangan tambahan,
                    atau hasil ekstraksi (OCR) akan ditampilkan di sini.
                </div>

                {{-- Placeholder table --}}
                <div class="overflow-x-auto">
                    <table class="min-w-full text-sm border rounded-lg overflow-hidden dark:border-gray-700">
                        <thead class="bg-gray-50 dark:bg-gray-700">
                            <tr>
                                <th class="px-4 py-2 text-left text-gray-500 dark:text-gray-300">Item</th>
                                <th class="px-4 py-2 text-left text-gray-500 dark:text-gray-300">Deskripsi</th>
                                <th class="px-4 py-2 text-right text-gray-500 dark:text-gray-300">Jumlah</th>
                            </tr>
                        </thead>
                        <tbody class="dark:bg-gray-800">
                            <tr>
                                <td colspan="3" class="px-4 py-6 text-center text-gray-400 dark:text-gray-500">
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
