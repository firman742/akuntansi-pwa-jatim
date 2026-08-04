@extends('layouts.app')

@section('title', 'Detail Transaksi Pengeluaran - ' . $transaction->transaction_number)

@section('content')
    <div class="space-y-6">
        {{-- BREADCRUMB & TOP ACTIONS --}}
        <x-common.page-breadcrumb pageTitle="Detail Transaksi Pengeluaran" defaultTitle="Detail Transaksi Pengeluaran"
            pageDescription="Rincian informasi lengkap, jurnal, dan lampiran transaksi pengeluaran" pageIcon="transaction"
            parentTitle="Transaksi Pengeluaran" :parentRoute="route('user.transactions.expenses.index')" currentTitle="{{ $transaction->transaction_number }}" />
        <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">

            {{-- ACTION BUTTONS --}}
            <div class="flex flex-wrap items-center gap-2.5">
                {{-- BACK --}}
                <a href="{{ route('user.transactions.expenses.index') }}">
                    <x-ui.button variant="outline" size="sm" class="rounded-xl">
                        <svg class="w-4 h-4 mr-1.5 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                        </svg>
                        Kembali
                    </x-ui.button>
                </a>

                @if ($transaction->status === \App\Enums\TransactionStatus::DRAFT)
                    {{-- EDIT --}}
                    <a href="{{ route('user.transactions.expenses.edit', $transaction) }}">
                        <x-ui.button variant="outline" size="sm"
                            class="rounded-xl border-amber-300 text-amber-700 hover:bg-amber-50 dark:border-amber-500/30 dark:text-amber-400">
                            <svg class="w-4 h-4 mr-1.5 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                            </svg>
                            Edit
                        </x-ui.button>
                    </a>

                    {{-- POSTING --}}
                    <form action="{{ route('user.transactions.expenses.post', $transaction) }}" method="POST"
                        onsubmit="return confirm('Apakah Anda yakin ingin memposting transaksi ini? Transaksi yang diposting tidak dapat diubah.')">
                        @csrf
                        <x-ui.button type="submit" variant="primary" size="sm"
                            class="rounded-xl bg-emerald-600 hover:bg-emerald-700">
                            <svg class="w-4 h-4 mr-1.5 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                            </svg>
                            Posting Transaksi
                        </x-ui.button>
                    </form>

                    {{-- BATALKAN --}}
                    <form action="{{ route('user.transactions.expenses.cancel', $transaction) }}" method="POST"
                        onsubmit="return confirm('Apakah Anda yakin ingin membatalkan transaksi ini?')">
                        @csrf
                        <x-ui.button type="submit" variant="danger" size="sm" class="rounded-xl">
                            <svg class="w-4 h-4 mr-1.5 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M6 18L18 6M6 6l12 12" />
                            </svg>
                            Batalkan
                        </x-ui.button>
                    </form>
                @endif
            </div>
        </div>

        {{-- ALERT MESSAGES --}}
        @if ($errors->any())
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        @endif

        @if (session('success'))
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        @endif

        {{-- HEADER SUMMARY BANNER --}}
        <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-xs dark:border-gray-800 dark:bg-gray-900">
            <div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
                <div class="flex items-center gap-4">
                    <div
                        class="flex h-14 w-14 items-center justify-center rounded-2xl bg-rose-50 text-rose-600 dark:bg-rose-500/10 dark:text-rose-400">
                        <svg class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
                        </svg>
                    </div>
                    <div>
                        <div class="flex items-center gap-3">
                            <h2 class="text-xl font-bold text-gray-900 dark:text-white">
                                {{ $transaction->transaction_number }}
                            </h2>

                            {{-- STATUS BADGE --}}
                            <span
                                class="inline-flex items-center rounded-full border px-3 py-0.5 text-xs font-semibold {{ $transaction->status->badgeClass() }}">
                                {{ $transaction->status->label() }}
                            </span>
                        </div>
                        <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">
                            Tanggal Transaksi: <span
                                class="font-medium text-gray-700 dark:text-gray-300">{{ $transaction->transaction_date->format('d F Y') }}</span>
                        </p>
                    </div>
                </div>

                {{-- TOTAL NOMINAL HIGHLIGHT --}}
                <div class="border-t border-gray-100 pt-3 dark:border-gray-800 md:border-t-0 md:pt-0 md:text-right">
                    <span class="text-xs font-medium uppercase tracking-wider text-gray-500 dark:text-gray-400">Total
                        Pengeluaran</span>
                    <p class="text-2xl font-black text-rose-600 dark:text-rose-400">
                        Rp {{ number_format($transaction->net_amount, 0, ',', '.') }}
                    </p>
                </div>
            </div>
        </div>

        {{-- MAIN CONTENT GRID (2 COLUMNS) --}}
        <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">

            {{-- LEFT COLUMN (2/3): INFORMASI UTAMA & RINCIAN JURNAL --}}
            <div class="lg:col-span-2 space-y-6">

                {{-- INFORMASI GENERAL CARD --}}
                <div
                    class="rounded-2xl border border-gray-200 bg-white p-6 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                    <h3
                        class="text-base font-semibold text-gray-900 dark:text-white mb-4 pb-3 border-b border-gray-100 dark:border-gray-800 flex items-center gap-2">
                        <svg class="w-5 h-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        Informasi Umum
                    </h3>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-y-4 gap-x-6 text-sm">
                        <div>
                            <span class="text-xs text-gray-500 dark:text-gray-400 block">Periode Anggaran</span>
                            <span class="font-medium text-gray-900 dark:text-white">{{ $transaction->period->name }}</span>
                        </div>

                        <div>
                            <span class="text-xs text-gray-500 dark:text-gray-400 block">Sub Periode</span>
                            <span
                                class="font-medium text-gray-900 dark:text-white">{{ $transaction->subPeriod?->name ?? '-' }}</span>
                        </div>

                        <div>
                            <span class="text-xs text-gray-500 dark:text-gray-400 block">Dibuat Oleh</span>
                            <span
                                class="font-medium text-gray-900 dark:text-white">{{ $transaction->creator?->name ?? '-' }}</span>
                        </div>

                        <div>
                            <span class="text-xs text-gray-500 dark:text-gray-400 block">Nomor Referensi</span>
                            <span
                                class="font-medium text-gray-900 dark:text-white">{{ $transaction->referencree_number ?? '-' }}</span>
                        </div>

                        <div class="sm:col-span-2">
                            <span class="text-xs text-gray-500 dark:text-gray-400 block">Keterangan / Deskripsi</span>
                            <p
                                class="mt-1 text-gray-700 dark:text-gray-300 leading-relaxed bg-gray-50 dark:bg-gray-800/50 p-3 rounded-xl border border-gray-100 dark:border-gray-800 text-xs sm:text-sm">
                                {{ $transaction->description ?: 'Tidak ada catatan tambahan.' }}
                            </p>
                        </div>
                    </div>
                </div>

                {{-- RINCIAN JURNAL / TRANSACTION LINES --}}
                <div
                    class="rounded-2xl border border-gray-200 bg-white p-6 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                    <h3
                        class="text-base font-semibold text-gray-900 dark:text-white mb-4 pb-3 border-b border-gray-100 dark:border-gray-800 flex items-center justify-between">
                        <span class="flex items-center gap-2">
                            <svg class="w-5 h-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                            </svg>
                            Rincian Jurnal & Posisi Akun
                        </span>
                        <span class="text-xs font-normal text-gray-500">({{ $transaction->transactionLines->count() }}
                            Entri)</span>
                    </h3>

                    <div class="overflow-x-auto rounded-xl border border-gray-200 dark:border-gray-800">
                        <table class="min-w-full text-left text-sm text-gray-600 dark:text-gray-400">
                            <thead
                                class="bg-gray-50 dark:bg-gray-800/60 text-xs uppercase font-semibold text-gray-500 dark:text-gray-400 border-b border-gray-200 dark:border-gray-800">
                                <tr>
                                    <th scope="col" class="px-4 py-3.5">Kode & Nama Akun (COA)</th>
                                    <th scope="col" class="px-4 py-3.5">Deskripsi Baris</th>
                                    <th scope="col" class="px-4 py-3.5 text-right">Debit</th>
                                    <th scope="col" class="px-4 py-3.5 text-right">Kredit</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                                @php
                                    $totalDebit = 0;
                                    $totalCredit = 0;
                                @endphp

                                @foreach ($transaction->transactionLines as $line)
                                    @php
                                        $isDebit = $line->position === \App\Enums\NormalBalanceEnum::DEBIT;
                                        $debitAmount = $isDebit ? $line->amount : 0;
                                        $creditAmount = !$isDebit ? $line->amount : 0;

                                        $totalDebit += $debitAmount;
                                        $totalCredit += $creditAmount;
                                    @endphp
                                    <tr class="hover:bg-gray-50/50 dark:hover:bg-gray-800/30">
                                        <td class="px-4 py-3.5">
                                            <div class="flex flex-col">
                                                <span
                                                    class="font-semibold text-gray-900 dark:text-white">{{ $line->chartOfAccount->code }}</span>
                                                <span
                                                    class="text-xs text-gray-500 dark:text-gray-400">{{ $line->chartOfAccount->name }}</span>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3.5 text-xs text-gray-700 dark:text-gray-300">
                                            {{ $line->description ?? '-' }}
                                        </td>
                                        <td
                                            class="px-4 py-3.5 text-right font-mono text-sm font-medium {{ $debitAmount > 0 ? 'text-gray-900 dark:text-white' : 'text-gray-400' }}">
                                            {{ $debitAmount > 0 ? 'Rp ' . number_format($debitAmount, 0, ',', '.') : '-' }}
                                        </td>
                                        <td
                                            class="px-4 py-3.5 text-right font-mono text-sm font-medium {{ $creditAmount > 0 ? 'text-gray-900 dark:text-white' : 'text-gray-400' }}">
                                            {{ $creditAmount > 0 ? 'Rp ' . number_format($creditAmount, 0, ',', '.') : '-' }}
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                            <tfoot
                                class="bg-gray-50 dark:bg-gray-800/80 font-bold border-t border-gray-200 dark:border-gray-800 text-gray-900 dark:text-white">
                                <tr>
                                    <td colspan="2" class="px-4 py-3.5 text-right text-xs uppercase tracking-wider">
                                        Total Seimbang:</td>
                                    <td class="px-4 py-3.5 text-right font-mono text-rose-600 dark:text-rose-400">
                                        Rp {{ number_format($totalDebit, 0, ',', '.') }}
                                    </td>
                                    <td class="px-4 py-3.5 text-right font-mono text-rose-600 dark:text-rose-400">
                                        Rp {{ number_format($totalCredit, 0, ',', '.') }}
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

            </div>

            {{-- RIGHT COLUMN (1/3): RINGKASAN NOMINAL & BUKTI TRANSAKSI --}}
            <div class="space-y-6">

                {{-- RINGKASAN FINANSIAL CARD --}}
                <div
                    class="rounded-2xl border border-gray-200 bg-white p-6 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                    <h3
                        class="text-base font-semibold text-gray-900 dark:text-white mb-4 pb-3 border-b border-gray-100 dark:border-gray-800 flex items-center gap-2">
                        <svg class="w-5 h-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 7h6m0 10v-3m-3 3h.01M9 17h.01M9 14h.01M12 14h.01M15 11h.01M12 11h.01M9 11h.01M7 21h10a2 2 0 002-2V5a2 2 0 00-2-2H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
                        </svg>
                        Ringkasan Nominal
                    </h3>

                    <div class="space-y-3 text-sm">
                        <div class="flex justify-between text-gray-600 dark:text-gray-400">
                            <span>Jumlah Kotor (Gross)</span>
                            <span class="font-medium text-gray-900 dark:text-white">
                                Rp {{ number_format($transaction->gross_amount ?? $transaction->net_amount, 0, ',', '.') }}
                            </span>
                        </div>

                        <div
                            class="border-t border-dashed border-gray-200 dark:border-gray-800 pt-3 flex justify-between items-center">
                            <span class="font-bold text-gray-900 dark:text-white">Total Bersih (Net)</span>
                            <span class="text-xl font-black text-rose-600 dark:text-rose-400">
                                Rp {{ number_format($transaction->net_amount, 0, ',', '.') }}
                            </span>
                        </div>
                    </div>
                </div>

                {{-- BUKTI TRANSAKSI / NOTA ATTACHMENT CARD --}}
                <div
                    class="rounded-2xl border border-gray-200 bg-white p-6 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                    <h3
                        class="text-base font-semibold text-gray-900 dark:text-white mb-4 pb-3 border-b border-gray-100 dark:border-gray-800 flex items-center justify-between">
                        <span class="flex items-center gap-2">
                            <svg class="w-5 h-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                            </svg>
                            Bukti Transaksi / Struk
                        </span>
                    </h3>

                    @php
                        $receiptUrl =
                            $transaction->receipt_url ??
                            ($transaction->hasMedia('receipts') ? $transaction->getFirstMediaUrl('receipts') : null);
                    @endphp

                    @if ($receiptUrl)
                        <div class="space-y-3">
                            <div
                                class="group relative overflow-hidden rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800">
                                <img src="{{ $receiptUrl }}" alt="Bukti Transaksi"
                                    class="w-full h-48 object-cover transition transform duration-300 group-hover:scale-105" />
                                <div
                                    class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition flex items-center justify-center gap-2">
                                    <a href="{{ $receiptUrl }}" target="_blank"
                                        class="p-2 bg-white rounded-lg shadow-sm text-gray-800 hover:bg-gray-100 transition"
                                        title="Buka Gambar">
                                        <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                                        </svg>
                                    </a>
                                </div>
                            </div>
                            <a href="{{ $receiptUrl }}" target="_blank"
                                class="block w-full text-center text-xs font-medium text-blue-600 dark:text-blue-400 hover:underline">
                                Lihat Ukuran Penuh (Tab Baru)
                            </a>
                        </div>
                    @else
                        <div
                            class="flex flex-col items-center justify-center py-8 px-4 border-2 border-dashed border-gray-200 dark:border-gray-800 rounded-xl bg-gray-50/50 dark:bg-gray-800/30 text-center">
                            <div class="rounded-full bg-gray-100 dark:bg-gray-800 p-3 mb-2 text-gray-400">
                                <svg class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                        d="M9 13h6m-3-3v6m5 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                </svg>
                            </div>
                            <p class="text-xs font-medium text-gray-600 dark:text-gray-400">Tidak ada lampiran bukti</p>
                            <p class="text-[11px] text-gray-400 dark:text-gray-500 mt-0.5">Berkas struk / nota belum
                                diunggah saat pembuatan transaksi.</p>
                        </div>
                    @endif
                </div>

            </div>
        </div>
    </div>
@endsection
