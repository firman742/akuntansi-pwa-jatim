@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Dashboard Pengguna Umum" />

    <div class="space-y-6">

        {{-- HERO --}}
        <div
            class="relative overflow-hidden rounded-3xl border border-gray-200 bg-white px-6 py-6 shadow-theme-sm dark:border-gray-800 dark:bg-white/[0.03]">

            <div
                class="absolute right-0 top-0 h-40 w-40 translate-x-10 -translate-y-10 rounded-full bg-blue-500/10 blur-3xl">
            </div>

            <div class="relative z-10 flex flex-col gap-6 xl:flex-row xl:items-center xl:justify-between">

                <div>
                    <span
                        class="inline-flex rounded-full bg-blue-50 px-3 py-1 text-xs font-medium text-blue-600 dark:bg-blue-500/10 dark:text-blue-400">
                        Dashboard Pengguna Umum
                    </span>

                    <h1 class="mt-4 text-3xl font-bold text-gray-800 dark:text-white/90">
                        Halo, {{ auth()->user()->name }} 👋
                    </h1>

                    <p class="mt-2 text-sm text-gray-500 dark:text-gray-400 max-w-2xl">
                        Pantau transaksi, akun COA, dan aktivitas keuangan Anda secara realtime.
                    </p>
                </div>

                <div class="flex flex-col gap-4">

                    {{-- PERIOD --}}
                    <div
                        class="rounded-2xl border border-gray-200 bg-gray-50 px-5 py-4 text-center shadow-sm dark:border-gray-800 dark:bg-white/[0.03]">

                        <p class="text-sm text-gray-500 dark:text-gray-400">
                            Periode Aktif
                        </p>

                        <h2 class="mt-1 text-xl font-bold text-gray-800 dark:text-white">
                            {{ $activePeriod?->name ?? '-' }}
                        </h2>
                    </div>

                    {{-- FILTER --}}
                    <form method="GET"
                        class="rounded-2xl border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-800 dark:bg-white/[0.03]">

                        <label class="mb-2 block text-xs font-medium text-gray-500 dark:text-gray-400">
                            Filter Sub Period
                        </label>

                        <select name="sub_period_id" onchange="this.form.submit()"
                            class="w-full h-11 rounded-xl border border-gray-300 bg-white px-4 text-sm text-gray-700 shadow-theme-xs outline-none transition focus:border-blue-500 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-400">

                            <option value="">Semua Sub Period</option>

                            @foreach ($subPeriods as $subPeriod)
                                <option value="{{ $subPeriod->id }}"
                                    {{ $selectedSubPeriodId == $subPeriod->id ? 'selected' : '' }}>
                                    {{ $subPeriod->name }}
                                </option>
                            @endforeach

                        </select>
                    </form>

                </div>
            </div>
        </div>

        {{-- SUMMARY --}}
        <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">

            {{-- CARD --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5 shadow-theme-sm dark:border-gray-800 dark:bg-white/[0.03]">
                <p class="text-sm text-gray-500 dark:text-gray-400">Total Transaksi</p>
                <h2 class="mt-2 text-2xl font-bold text-gray-800 dark:text-white">{{ $totalTransactions }}</h2>
            </div>

            {{-- CARD --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5 shadow-theme-sm dark:border-gray-800 dark:bg-white/[0.03]">
                <p class="text-sm text-gray-500 dark:text-gray-400">Pemasukan</p>
                <h2 class="mt-2 text-2xl font-bold text-green-600">
                    Rp {{ number_format($totalIncome, 0, ',', '.') }}
                </h2>
            </div>

            {{-- CARD --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5 shadow-theme-sm dark:border-gray-800 dark:bg-white/[0.03]">
                <p class="text-sm text-gray-500 dark:text-gray-400">Pengeluaran</p>
                <h2 class="mt-2 text-2xl font-bold text-red-600">
                    Rp {{ number_format($totalExpense, 0, ',', '.') }}
                </h2>
            </div>

            {{-- CARD --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5 shadow-theme-sm dark:border-gray-800 dark:bg-white/[0.03]">
                <p class="text-sm text-gray-500 dark:text-gray-400">Saldo Bersih</p>
                <h2 class="mt-2 text-2xl font-bold text-blue-600">
                    Rp {{ number_format($netBalance, 0, ',', '.') }}
                </h2>
            </div>

        </div>

        {{-- MAIN GRID --}}
        <div class="grid grid-cols-1 gap-6 xl:grid-cols-2">

            {{-- TRANSACTIONS --}}
            <div
                class="overflow-hidden rounded-3xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-white/[0.03]">

                <div class="flex items-center justify-between border-b border-gray-100 px-6 py-5 dark:border-gray-800">

                    <div>
                        <h2 class="text-lg font-bold text-gray-800 dark:text-white">
                            Transaksi Terbaru
                        </h2>
                        <p class="text-sm text-gray-500 dark:text-gray-400">
                            Aktivitas transaksi Anda
                        </p>
                    </div>

                    <a href="{{ route('user.transactions.histories.index') }}"
                        class="text-sm text-blue-500 hover:underline">
                        Lihat Semua
                    </a>
                </div>

                <div class="p-6 space-y-4">

                    @forelse ($recentTransactions as $transaction)
                        <div class="rounded-2xl border border-gray-200 p-4 dark:border-gray-800">

                            <div class="flex justify-between">

                                <div>
                                    <p class="font-semibold text-gray-800 dark:text-white">
                                        {{ $transaction->description }}
                                    </p>

                                    <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">
                                        {{ $transaction->transaction_date->format('d M Y') }}
                                    </p>
                                </div>

                                <div class="text-right">
                                    <p class="font-bold text-gray-800 dark:text-white">
                                        Rp {{ number_format($transaction->gross_amount, 0, ',', '.') }}
                                    </p>

                                    <span
                                        class="mt-2 inline-block rounded-full px-2 py-1 text-xs
                                        {{ $transaction->transaction_type->value === 'INCOME'
                                            ? 'bg-green-100 text-green-700 dark:bg-green-500/10 dark:text-green-400'
                                            : 'bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400' }}">
                                        {{ $transaction->transaction_type->label() }}
                                    </span>
                                </div>

                            </div>

                        </div>

                    @empty
                        <div class="text-center text-sm text-gray-500 dark:text-gray-400 py-10">
                            Belum ada transaksi.
                        </div>
                    @endforelse

                </div>
            </div>

            {{-- COA --}}
            <div
                class="overflow-hidden rounded-3xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-white/[0.03]">
                <div class="flex items-center justify-between border-b border-gray-100 px-6 py-5 dark:border-gray-800">

                    <div>
                        <h2 class="text-lg font-bold text-gray-800 dark:text-white">
                            Akun COA Saya
                        </h2>
                        <p class="text-sm text-gray-500 dark:text-gray-400">
                            Daftar akun yang dapat digunakan
                        </p>
                    </div>

                    <a href="{{ route('user.coas.index') }}"
                        class="text-sm text-blue-500 hover:underline">
                        Lihat Semua
                    </a>
                </div>

                <div class="p-6 space-y-3">

                    @forelse ($userCoas as $coa)
                        <div class="rounded-xl border border-gray-200 p-4 dark:border-gray-800">

                            <div class="flex items-center justify-between">

                                <div>
                                    <p class="font-semibold text-gray-800 dark:text-white">
                                        {{ $coa->code }}
                                    </p>

                                    <p class="text-sm text-gray-500 dark:text-gray-400">
                                        {{ $coa->name }} • {{ $coa->normal_balance }}
                                    </p>
                                </div>

                                <span
                                    class="text-xs rounded-full bg-green-100 px-2 py-1 text-green-700 dark:bg-green-500/10 dark:text-green-400">
                                    Active
                                </span>

                            </div>

                        </div>

                    @empty
                        <div class="text-center text-sm text-gray-500 dark:text-gray-400 py-10">
                            Tidak ada COA aktif.
                        </div>
                    @endforelse

                </div>
            </div>

        </div>

    </div>
@endsection
