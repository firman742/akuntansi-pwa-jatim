@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Dashboard User" />

    <div class="space-y-6">

        {{-- HEADER --}}
        <div class="rounded-3xl bg-gradient-to-r bg-blue-500 p-6 text-white shadow-lg dark:border-gray-800">

            <div class="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">

                <div>
                    <p class="text-sm text-white/80">
                        Dashboard Pengguna Akuntansi
                    </p>

                    <h1 class="mt-2 text-3xl font-bold">
                        Halo, {{ auth()->user()->name }} 👋
                    </h1>

                    <p class="mt-2 text-sm text-white/80">
                        Pantau transaksi dan aktivitas akun Anda secara realtime.
                    </p>
                </div>

                <div class="rounded-2xl border border-white/20 bg-white/10 px-5 py-4 text-center backdrop-blur-sm">

                    <p class="text-sm text-white/70">
                        Period Aktif
                    </p>

                    <h2 class="mt-2 text-xl font-bold">
                        {{ $activePeriod?->name ?? '-' }}
                    </h2>
                </div>

            </div>
        </div>

        {{-- FILTER --}}
        <div class="rounded-2xl border bg-white p-4 shadow-lg">

            <form method="GET">

                <div class="flex flex-col gap-4 md:flex-row md:items-end">

                    <div class="w-full md:w-80">

                        <label class="mb-2 block text-sm font-medium text-gray-700">
                            Filter Sub Period
                        </label>

                        <select name="sub_period_id" onchange="this.form.submit()"
                            class="w-full h-11 rounded-xl border border-gray-300 bg-white px-4 text-sm text-gray-700 shadow-theme-xs outline-none focus:border-brand-500 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-400">
                            <option value="">
                                Semua Sub Period
                            </option>

                            @foreach ($subPeriods as $subPeriod)
                                <option value="{{ $subPeriod->id }}"
                                    {{ $selectedSubPeriodId == $subPeriod->id ? 'selected' : '' }}>
                                    {{ $subPeriod->name }}
                                </option>
                            @endforeach

                        </select>

                    </div>

                </div>

            </form>

        </div>

        {{-- SUMMARY --}}
        <div class="grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-4">

            <div class="rounded-2xl border bg-white p-5 shadow-lg">
                <p class="text-sm text-gray-500">
                    Total Transaksi Saya
                </p>

                <h2 class="mt-2 text-3xl font-bold text-gray-800">
                    {{ $totalTransactions }}
                </h2>
            </div>

            <div class="rounded-2xl border bg-white p-5 shadow-lg">
                <p class="text-sm text-gray-500">
                    Pemasukan Saya
                </p>

                <h2 class="mt-2 text-3xl font-bold text-green-600">
                    Rp {{ number_format($totalIncome, 0, ',', '.') }}
                </h2>
            </div>

            <div class="rounded-2xl border bg-white p-5 shadow-lg">
                <p class="text-sm text-gray-500">
                    Pengeluaran Saya
                </p>

                <h2 class="mt-2 text-3xl font-bold text-red-600">
                    Rp {{ number_format($totalExpense, 0, ',', '.') }}
                </h2>
            </div>

            <div class="rounded-2xl border bg-white p-5 shadow-lg">
                <p class="text-sm text-gray-500">
                    Saldo Bersih
                </p>

                <h2 class="mt-2 text-3xl font-bold text-blue-600">
                    Rp {{ number_format($netBalance, 0, ',', '.') }}
                </h2>
            </div>

        </div>

        {{-- MAIN GRID --}}
        <div class="grid gap-6 lg:grid-cols-2">

            {{-- RECENT TRANSACTIONS --}}
            <div class="lg:col-span-2 rounded-2xl border bg-white p-6 shadow-lg">

                <div class="mb-5 flex items-center justify-between">
                    <h2 class="text-lg font-semibold text-gray-800">
                        Transaksi Terbaru
                    </h2>

                    <a href="{{ route('user.transactions.histories.index') }}" class="text-sm text-blue-500 hover:underline">
                        Lihat Semua
                    </a>
                </div>

                <div class="space-y-4">

                    @forelse ($recentTransactions as $transaction)
                        <div class="flex items-start justify-between rounded-xl border p-4">

                            <div>
                                <p class="font-semibold text-gray-800">
                                    {{ $transaction->description }}
                                </p>

                                <p class="mt-1 text-sm text-gray-500">
                                    {{ $transaction->transaction_date->format('d M Y') }}
                                </p>

                                <div class="mt-2 flex flex-wrap gap-2">

                                    @foreach ($transaction->transactionLines as $line)
                                        <span class="rounded-full bg-gray-100 px-2 py-1 text-xs text-gray-700">
                                            {{ $line->chartOfAccount->code ?? '-' }}
                                        </span>
                                    @endforeach

                                </div>
                            </div>

                            <div class="text-right">

                                <p class="font-bold text-gray-800">
                                    Rp {{ number_format($transaction->gross_amount, 0, ',', '.') }}
                                </p>

                                <span
                                    class="mt-2 inline-block rounded-full px-2 py-1 text-xs
                                    {{ $transaction->transaction_type->value === 'INCOME'
                                        ? 'bg-green-100 text-green-700'
                                        : 'bg-red-100 text-red-700' }}">

                                    {{ $transaction->transaction_type->label() }}

                                </span>

                            </div>

                        </div>

                    @empty

                        <div class="rounded-xl border border-dashed p-6 text-center text-gray-500">
                            Belum ada transaksi.
                        </div>
                    @endforelse

                </div>

            </div>

            {{-- MY COA --}}
            <div class="rounded-2xl border bg-white p-6 shadow-lg">

                <div class="mb-5">
                    <h2 class="text-lg font-semibold text-gray-800">
                        Akun COA Saya
                    </h2>

                    <p class="mt-1 text-sm text-gray-500">
                        Akun yang dapat digunakan.
                    </p>
                </div>

                <div class="space-y-3">

                    @forelse ($userCoas as $coa)
                        <div class="rounded-xl border p-4">

                            <div class="flex items-center justify-between">

                                <div>
                                    <p class="font-semibold text-gray-800">
                                        {{ $coa->code }}
                                    </p>

                                    <p class="text-sm text-gray-500">
                                        {{ $coa->name }}
                                    </p>
                                </div>

                                <span class="rounded-full bg-green-100 px-2 py-1 text-xs text-green-700">
                                    Active
                                </span>

                            </div>

                        </div>

                    @empty

                        <div class="rounded-xl border border-dashed p-6 text-center text-gray-500">
                            Tidak ada COA aktif.
                        </div>
                    @endforelse

                    <a href="" class="text-sm text-blue-500 hover:underline">
                        Lihat Semua
                    </a>
                </div>

            </div>

        </div>

    </div>
@endsection
