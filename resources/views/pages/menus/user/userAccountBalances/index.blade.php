@extends('layouts.app')

@section('title', 'Daftar Saldo COA Saya')

@section('content')
    <x-common.page-breadcrumb pageTitle="Daftar Saldo COA Saya" />

    @php
        $totalAllocated = $userAccountBalances->sum('allocated_balance');
        $totalIncome = $userAccountBalances->sum('income_balance');
        $totalUsed = $userAccountBalances->sum('used_balance');
        $totalRemaining = $userAccountBalances->sum('remaining_balance');

        $activeBalances = $userAccountBalances
            ->filter(function ($item) {
                return $item['remaining_balance'] > 0;
            })
            ->count();
    @endphp

    <div class="space-y-6">

        {{-- HEADER --}}
        <div
            class="bg-white border border-gray-200 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90 shadow-sm rounded-2xl p-6">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
                <div>
                    <h1 class="text-2xl font-bold text-gray-800 dark:text-white">
                        Saldo COA Saya
                    </h1>
                    <p class="text-sm text-gray-500 mt-2 max-w-3xl">
                        Halaman ini menampilkan ringkasan posisi keuangan akun kas Anda.
                        <strong>Sisa Saldo</strong> dihitung dari formula:
                        <span
                            class="inline-block px-2 py-0.5 rounded bg-gray-100 dark:bg-gray-800 text-xs font-mono font-semibold text-gray-700 dark:text-gray-300 border border-gray-200 dark:border-gray-700">
                            (Alokasi Awal + Total Penerimaan) - Total Terpakai
                        </span>
                    </p>
                </div>

                <div class="flex items-center gap-3">
                    <div
                        class="px-5 py-4 rounded-2xl bg-primary-50 border border-primary-100 text-primary-700 min-w-[140px]">
                        <div class="text-xs uppercase font-semibold tracking-wide">
                            Total Akun
                        </div>
                        <div class="text-3xl font-bold mt-1 text-center">
                            {{ $userAccountBalances->count() }}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        {{-- SUMMARY CARDS (5 KOLOM) --}}
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4">

            {{-- 1. TOTAL ALOKASI AWAL --}}
            <div
                class="bg-white rounded-2xl border border-blue-100 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90 shadow-sm p-4 flex flex-col justify-between">
                <div class="flex items-start justify-between">
                    <div>
                        <p class="text-xs font-medium text-gray-500">Alokasi Awal (Pagu)</p>
                        <h2 class="text-xl font-bold text-blue-700 mt-1">
                            Rp {{ number_format($totalAllocated, 0, ',', '.') }}
                        </h2>
                    </div>
                    <div class="w-10 h-10 rounded-xl bg-blue-100 shrink-0 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-blue-700" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 8c-1.657 0-3 1.343-3 3s1.343 3 3 3 3-1.343 3-3-1.343-3-3-3z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M2 12h2m16 0h2m-10 8v2m0-20v2" />
                        </svg>
                    </div>
                </div>
                <p class="text-[11px] text-gray-400 mt-3 pt-2 border-t border-gray-100 dark:border-gray-800">
                    Anggaran awal dari Admin
                </p>
            </div>

            {{-- 2. TOTAL PENERIMAAN --}}
            <div
                class="bg-white rounded-2xl border border-emerald-100 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90 shadow-sm p-4 flex flex-col justify-between">
                <div class="flex items-start justify-between">
                    <div>
                        <p class="text-xs font-medium text-gray-500">Total Penerimaan</p>
                        <h2 class="text-xl font-bold text-emerald-600 mt-1">
                            Rp {{ number_format($totalIncome, 0, ',', '.') }}
                        </h2>
                    </div>
                    <div class="w-10 h-10 rounded-xl bg-emerald-100 shrink-0 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-emerald-600" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M7 11l5-5m0 0l5 5m-5-5v12" />
                        </svg>
                    </div>
                </div>
                <p class="text-[11px] text-gray-400 mt-3 pt-2 border-t border-gray-100 dark:border-gray-800">
                    Akumulasi dana masuk
                </p>
            </div>

            {{-- 3. TOTAL TERPAKAI --}}
            <div
                class="bg-white rounded-2xl border border-red-100 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90 shadow-sm p-4 flex flex-col justify-between">
                <div class="flex items-start justify-between">
                    <div>
                        <p class="text-xs font-medium text-gray-500">Total Terpakai</p>
                        <h2 class="text-xl font-bold text-red-600 mt-1">
                            Rp {{ number_format($totalUsed, 0, ',', '.') }}
                        </h2>
                    </div>
                    <div class="w-10 h-10 rounded-xl bg-red-100 shrink-0 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-red-600" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M17 13l-5 5m0 0l-5-5m5 5V6" />
                        </svg>
                    </div>
                </div>
                <p class="text-[11px] text-gray-400 mt-3 pt-2 border-t border-gray-100 dark:border-gray-800">
                    Akumulasi pengeluaran
                </p>
            </div>

            {{-- 4. SISA SALDO --}}
            <div
                class="bg-white rounded-2xl border border-teal-100 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90 shadow-sm p-4 flex flex-col justify-between">
                <div class="flex items-start justify-between">
                    <div>
                        <p class="text-xs font-medium text-gray-500">Sisa Saldo Tersedia</p>
                        <h2 class="text-xl font-bold text-teal-700 mt-1">
                            Rp {{ number_format($totalRemaining, 0, ',', '.') }}
                        </h2>
                    </div>
                    <div class="w-10 h-10 rounded-xl bg-teal-100 shrink-0 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-teal-700" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </div>
                </div>
                <p class="text-[11px] text-gray-400 mt-3 pt-2 border-t border-gray-100 dark:border-gray-800">
                    Sisa dana siap digunakan
                </p>
            </div>

            {{-- 5. SALDO AKTIF --}}
            <div
                class="bg-white rounded-2xl border border-yellow-100 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90 shadow-sm p-4 flex flex-col justify-between">
                <div class="flex items-start justify-between">
                    <div>
                        <p class="text-xs font-medium text-gray-500">Akun Kas Aktif</p>
                        <h2 class="text-xl font-bold text-yellow-700 mt-1">
                            {{ $activeBalances }} <span class="text-xs font-normal text-gray-400">Akun</span>
                        </h2>
                    </div>
                    <div class="w-10 h-10 rounded-xl bg-yellow-100 shrink-0 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-yellow-700" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-3-3v6" />
                        </svg>
                    </div>
                </div>
                <p class="text-[11px] text-gray-400 mt-3 pt-2 border-t border-gray-100 dark:border-gray-800">
                    Akun dengan saldo > 0
                </p>
            </div>

        </div>

        {{-- TABLE --}}
        <div
            class="bg-white border border-gray-200 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90 rounded-2xl shadow-sm overflow-hidden">

            <div class="px-6 py-5 border-b border-gray-100 dark:border-gray-800">
                <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
                    <div>
                        <h2 class="text-lg font-bold text-gray-800 dark:text-white">
                            Detail Saldo Pengguna
                        </h2>
                        <p class="text-sm text-gray-500 mt-1">
                            Rincian pergerakan saldo kas berdasarkan alokasi, penerimaan, dan pengeluaran.
                        </p>
                    </div>
                </div>
            </div>

            @if ($userAccountBalances->isEmpty())
                <div class="p-16 text-center">
                    <div class="flex justify-center mb-4">
                        <div class="w-20 h-20 rounded-full bg-gray-100 flex items-center justify-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 text-gray-400" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                    d="M9 14l2-2 4 4m0 0l-4-4m4 4V10" />
                            </svg>
                        </div>
                    </div>
                    <h3 class="text-lg font-semibold text-gray-700">Belum Ada Saldo</h3>
                    <p class="text-sm text-gray-500 mt-2">Saat ini belum ada saldo yang dialokasikan kepada Anda.</p>
                </div>
            @else
                <div class="overflow-x-auto">
                    <table class="w-full min-w-[1200px]">
                        <thead class="bg-gray-50 dark:bg-gray-800/50">
                            <tr>
                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    COA</th>
                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Sub Periode</th>
                                <th
                                    class="px-6 py-4 text-right text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Alokasi Awal</th>
                                <th
                                    class="px-6 py-4 text-right text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Penerimaan</th>
                                <th
                                    class="px-6 py-4 text-right text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Terpakai</th>
                                <th
                                    class="px-6 py-4 text-right text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Sisa Saldo</th>
                                <th
                                    class="px-6 py-4 text-center text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Penggunaan</th>
                                <th
                                    class="px-6 py-4 text-center text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Tgl Alokasi</th>
                                <th
                                    class="px-6 py-4 text-center text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Aksi</th>
                            </tr>
                        </thead>

                        <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                            @foreach ($userAccountBalances as $item)
                                @php
                                    $allocated = $item['allocated_balance'] ?? 0;
                                    $income = $item['income_balance'] ?? 0;
                                    $used = $item['used_balance'] ?? 0;

                                    $totalAvailable = $allocated + $income;
                                    $percentage = $totalAvailable > 0 ? min(($used / $totalAvailable) * 100, 100) : 0;
                                @endphp

                                <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/40 transition">

                                    {{-- COA --}}
                                    <td class="px-6 py-5">
                                        <div class="flex flex-col">
                                            <span class="font-semibold text-gray-800 dark:text-gray-200">
                                                {{ $item['account_code'] }}
                                            </span>
                                            <span class="text-xs text-gray-500 mt-0.5">
                                                {{ $item['account_name'] }}
                                            </span>
                                        </div>
                                    </td>

                                    {{-- SUB PERIODE --}}
                                    <td class="px-6 py-5 whitespace-nowrap">
                                        @if ($item['sub_period'])
                                            <span
                                                class="inline-flex items-center px-3 py-1 rounded-full bg-blue-100 text-blue-700 dark:bg-blue-900/40 dark:text-blue-300 text-xs font-semibold">
                                                {{ $item['sub_period'] }}
                                            </span>
                                        @else
                                            <span class="text-sm text-gray-400">-</span>
                                        @endif
                                    </td>

                                    {{-- ALOKASI AWAL --}}
                                    <td class="px-6 py-5 text-right whitespace-nowrap">
                                        <span class="font-medium text-blue-700 dark:text-blue-400">
                                            Rp {{ number_format($item['allocated_balance'], 0, ',', '.') }}
                                        </span>
                                    </td>

                                    {{-- PENERIMAAN --}}
                                    <td class="px-6 py-5 text-right whitespace-nowrap">
                                        <span class="font-medium text-emerald-600 dark:text-emerald-400">
                                            + Rp {{ number_format($item['income_balance'], 0, ',', '.') }}
                                        </span>
                                    </td>

                                    {{-- TERPAKAI --}}
                                    <td class="px-6 py-5 text-right whitespace-nowrap">
                                        <span class="font-medium text-red-600 dark:text-red-400">
                                            - Rp {{ number_format($item['used_balance'], 0, ',', '.') }}
                                        </span>
                                    </td>

                                    {{-- REMAINING --}}
                                    <td class="px-6 py-5 text-right whitespace-nowrap">
                                        <span class="font-bold text-teal-700 dark:text-teal-400">
                                            Rp {{ number_format($item['remaining_balance'], 0, ',', '.') }}
                                        </span>
                                    </td>

                                    {{-- PROGRESS --}}
                                    <td class="px-6 py-5 min-w-[160px]">
                                        <div class="space-y-1.5">
                                            <div
                                                class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2 overflow-hidden">
                                                <div class="h-2 rounded-full {{ $percentage >= 85 ? 'bg-red-500' : ($percentage >= 50 ? 'bg-amber-500' : 'bg-emerald-500') }}"
                                                    style="width: {{ $percentage }}%">
                                                </div>
                                            </div>
                                            <div class="text-[11px] text-gray-500 text-center">
                                                {{ number_format($percentage, 0) }}% terpakai
                                            </div>
                                        </div>
                                    </td>

                                    {{-- DATE --}}
                                    <td class="px-6 py-5 text-center whitespace-nowrap">
                                        @if ($item['allocated_at'])
                                            <div class="flex flex-col">
                                                <span class="text-xs font-medium text-gray-700 dark:text-gray-300">
                                                    {{ \Carbon\Carbon::parse($item['allocated_at'])->format('d M Y') }}
                                                </span>
                                                <span class="text-[10px] text-gray-400">
                                                    {{ \Carbon\Carbon::parse($item['allocated_at'])->format('H:i') }}
                                                </span>
                                            </div>
                                        @else
                                            <span class="text-gray-400 text-sm">-</span>
                                        @endif
                                    </td>

                                    {{-- ACTION --}}
                                    <td class="px-6 py-5 text-center whitespace-nowrap">
                                        <a href="{{ route('user.user-account-balances.show', $item['id']) }}"
                                            class="inline-flex h-8 w-8 items-center justify-center rounded-lg text-green-600 hover:bg-green-50 dark:text-green-400 dark:hover:bg-green-500/10 transition"
                                            title="Lihat Detail Saldo Pengguna">
                                            <svg class="w-5 h-5" aria-hidden="true" fill="none" viewBox="0 0 24 24"
                                                stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                    d="M2.458 12C3.732 7.943 7.523 5 12 5s8.268 2.943 9.542 7c-1.274 4.057-5.065 7-9.542 7S3.732 16.057 2.458 12z" />
                                            </svg>
                                        </a>
                                    </td>

                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            @endif

        </div>

    </div>
@endsection
