@extends('layouts.app')

@section('title', 'Detail Saldo Pengguna')

@section('content')
    <x-common.page-breadcrumb pageTitle="Detail Saldo Pengguna" />

    @php
        $allocated = $userAccountBalance->allocated_balance ?? 0;
        $used = $userAccountBalance->used_balance ?? 0;
        $remaining = $userAccountBalance->remaining_balance ?? 0;

        $percentage = $allocated > 0 ? min(100, round(($used / $allocated) * 100)) : 0;
    @endphp

    <div class="space-y-6">

        {{-- Header --}}
        <div class="bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 p-6 shadow-sm">

            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">

                <div>
                    <h1 class="text-xl font-bold text-gray-900 dark:text-white">
                        Detail Saldo Pengguna
                    </h1>

                    <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                        Informasi saldo yang dialokasikan kepada pengguna.
                    </p>
                </div>

                <a href="{{ route('user.user-account-balances.index') }}"
                    class="inline-flex items-center justify-center px-4 py-2 rounded-lg border border-gray-300 dark:border-gray-600 text-sm font-medium text-gray-700 dark:text-gray-200 hover:bg-gray-50 dark:hover:bg-gray-700 transition">

                    Kembali
                </a>

            </div>
        </div>

        {{-- Statistik --}}
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl p-6 shadow-sm">

                <p class="text-sm text-gray-500 dark:text-gray-400">
                    Saldo Dialokasikan
                </p>

                <h3 class="mt-2 text-2xl font-bold text-gray-900 dark:text-white">
                    Rp {{ number_format($allocated, 0, ',', '.') }}
                </h3>

            </div>

            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl p-6 shadow-sm">

                <p class="text-sm text-gray-500 dark:text-gray-400">
                    Saldo Terpakai
                </p>

                <h3 class="mt-2 text-2xl font-bold text-red-600 dark:text-red-400">
                    Rp {{ number_format($used, 0, ',', '.') }}
                </h3>

            </div>

            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl p-6 shadow-sm">

                <p class="text-sm text-gray-500 dark:text-gray-400">
                    Saldo Tersisa
                </p>

                <h3 class="mt-2 text-2xl font-bold text-green-600 dark:text-green-400">
                    Rp {{ number_format($remaining, 0, ',', '.') }}
                </h3>

            </div>

        </div>

        {{-- Detail --}}
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

            {{-- Informasi Akun --}}
            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl shadow-sm">

                <div class="px-6 py-4 border-b border-gray-200 dark:border-gray-700">

                    <h2 class="font-semibold text-gray-900 dark:text-white">
                        Informasi Akun
                    </h2>

                </div>

                <div class="p-6 space-y-5">

                    <div>
                        <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">
                            Kode Akun
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $userAccountBalance->coaBalance->chartOfAccount->code }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">
                            Nama Akun
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $userAccountBalance->coaBalance->chartOfAccount->name }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">
                            Sub Periode
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $userAccountBalance->subPeriod?->name ?? '-' }}
                        </p>
                    </div>

                </div>

            </div>

            {{-- Informasi Alokasi --}}
            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl shadow-sm">

                <div class="px-6 py-4 border-b border-gray-200 dark:border-gray-700">

                    <h2 class="font-semibold text-gray-900 dark:text-white">
                        Informasi Alokasi
                    </h2>

                </div>

                <div class="p-6 space-y-5">

                    <div>
                        <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">
                            Dialokasikan Oleh
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $userAccountBalance->allocatedBy?->name ?? '-' }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">
                            Tanggal Alokasi
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ optional($userAccountBalance->allocated_at)->format('d M Y H:i') ?? '-' }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">
                            ID Saldo
                        </p>

                        <p class="font-mono text-sm text-gray-900 dark:text-white break-all">
                            {{ $userAccountBalance->id }}
                        </p>
                    </div>

                </div>

            </div>

        </div>

        {{-- Progress --}}
        <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl shadow-sm">

            <div class="px-6 py-4 border-b border-gray-200 dark:border-gray-700">

                <h2 class="font-semibold text-gray-900 dark:text-white">
                    Progress Penggunaan Saldo
                </h2>

            </div>

            <div class="p-6">

                <div class="flex justify-between mb-2">

                    <span class="text-sm text-gray-600 dark:text-gray-400">
                        Persentase Penggunaan
                    </span>

                    <span class="text-sm font-semibold text-gray-900 dark:text-white">
                        {{ $percentage }}%
                    </span>

                </div>

                <div class="w-full h-4 bg-gray-200 dark:bg-gray-700 rounded-full overflow-hidden">

                    <div class="h-full bg-red-500 rounded-full transition-all duration-500"
                        style="width: {{ $percentage }}%">
                    </div>

                </div>

                <div class="mt-4 grid grid-cols-2 gap-4 text-sm">

                    <div>
                        <span class="text-gray-500 dark:text-gray-400">
                            Digunakan
                        </span>

                        <p class="font-semibold text-red-600 dark:text-red-400">
                            Rp {{ number_format($used, 0, ',', '.') }}
                        </p>
                    </div>

                    <div>
                        <span class="text-gray-500 dark:text-gray-400">
                            Tersedia
                        </span>

                        <p class="font-semibold text-green-600 dark:text-green-400">
                            Rp {{ number_format($remaining, 0, ',', '.') }}
                        </p>
                    </div>

                </div>

            </div>

        </div>

    </div>
@endsection
