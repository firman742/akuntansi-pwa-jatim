@extends('layouts.app')

@section('title', 'Daftar Saldo COA Saya')

@section('content')
    <x-common.page-breadcrumb pageTitle="Daftar Saldo COA Saya" />

    @php
        $totalAllocated = $userAccountBalances->sum('allocated_balance');
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
        <div class="bg-white border border-gray-200 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90 shadow-sm rounded-2xl p-6">

            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">

                <div>
                    <h1 class="text-2xl font-bold text-gray-800 dark:text-white">
                        Saldo COA Saya
                    </h1>

                    <p class="text-sm text-gray-500 mt-2 max-w-2xl">
                        Halaman ini menampilkan seluruh saldo akun yang dialokasikan kepada Anda.
                        Anda dapat melihat total saldo, saldo terpakai, dan sisa saldo yang masih tersedia.
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

        {{-- SUMMARY --}}
        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-4">

            {{-- TOTAL ALOKASI --}}
            <div class="bg-white rounded-2xl border border-blue-100 border-gray-200 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90  shadow-sm p-5">

                <div class="flex items-start justify-between">

                    <div>
                        <p class="text-sm text-gray-500">
                            Total Saldo Dialokasikan
                        </p>

                        <h2 class="text-2xl font-bold text-blue-700 mt-2">
                            Rp {{ number_format($totalAllocated, 0, ',', '.') }}
                        </h2>
                    </div>

                    <div class="w-12 h-12 rounded-xl bg-blue-100 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-blue-700" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M12 8c-1.657 0-3 1.343-3 3s1.343 3 3 3 3-1.343 3-3-1.343-3-3-3z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M2 12h2m16 0h2m-10 8v2m0-20v2" />
                        </svg>
                    </div>

                </div>

            </div>

            {{-- TERPAKAI --}}
            <div class="bg-white rounded-2xl border border-red-100 border-gray-200 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90  shadow-sm p-5">

                <div class="flex items-start justify-between">

                    <div>
                        <p class="text-sm text-gray-500">
                            Total Saldo Terpakai
                        </p>

                        <h2 class="text-2xl font-bold text-red-600 mt-2">
                            Rp {{ number_format($totalUsed, 0, ',', '.') }}
                        </h2>
                    </div>

                    <div class="w-12 h-12 rounded-xl bg-red-100 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-red-600" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M17 9V7a5 5 0 00-10 0v2m-2 0h14l-1 11H6L5 9z" />
                        </svg>
                    </div>

                </div>

            </div>

            {{-- SISA --}}
            <div class="bg-white rounded-2xl border border-green-100  border-gray-200 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90  shadow-sm p-5">

                <div class="flex items-start justify-between">

                    <div>
                        <p class="text-sm text-gray-500">
                            Sisa Saldo
                        </p>

                        <h2 class="text-2xl font-bold text-green-700 mt-2">
                            Rp {{ number_format($totalRemaining, 0, ',', '.') }}
                        </h2>
                    </div>

                    <div class="w-12 h-12 rounded-xl bg-green-100 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-green-700" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                        </svg>
                    </div>

                </div>

            </div>

            {{-- AKTIF --}}
            <div class="bg-white rounded-2xl border border-yellow-100 border-gray-200 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90  shadow-sm p-5">

                <div class="flex items-start justify-between">

                    <div>
                        <p class="text-sm text-gray-500">
                            Saldo Aktif
                        </p>

                        <h2 class="text-2xl font-bold text-yellow-700 mt-2">
                            {{ $activeBalances }}
                        </h2>
                    </div>

                    <div class="w-12 h-12 rounded-xl bg-yellow-100 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-yellow-700" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-3-3v6" />
                        </svg>
                    </div>

                </div>

            </div>

        </div>

        {{-- TABLE --}}
        <div class="bg-white border border-gray-200 border-gray-200 dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90  rounded-2xl shadow-sm overflow-hidden">

            {{-- HEADER --}}
            <div class="px-6 py-5 border-b border-gray-100">

                <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">

                    <div>
                        <h2 class="text-lg font-bold text-gray-800 dark:text-white">
                            Detail Saldo Pengguna
                        </h2>

                        <p class="text-sm text-gray-500 mt-1">
                            Informasi detail saldo yang telah dialokasikan kepada pengguna.
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

                    <h3 class="text-lg font-semibold text-gray-700">
                        Belum Ada Saldo
                    </h3>

                    <p class="text-sm text-gray-500 mt-2">
                        Saat ini belum ada saldo yang dialokasikan kepada Anda.
                    </p>

                </div>
            @else
                <div class="overflow-x-auto">

                    <table class="w-full min-w-[1100px]">

                        <thead class="bg-gray-50">
                            <tr>

                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    COA
                                </th>

                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Sub Periode
                                </th>

                                <th
                                    class="px-6 py-4 text-right text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Dialokasikan
                                </th>

                                <th
                                    class="px-6 py-4 text-right text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Terpakai
                                </th>

                                <th
                                    class="px-6 py-4 text-right text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Sisa
                                </th>

                                <th
                                    class="px-6 py-4 text-center text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Progress
                                </th>

                                <th
                                    class="px-6 py-4 text-center text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Tanggal Alokasi
                                </th>

                                <th
                                    class="px-6 py-4 text-center text-xs font-semibold text-gray-500 uppercase whitespace-nowrap">
                                    Action
                                </th>
                            </tr>
                        </thead>

                        <tbody class="divide-y divide-gray-100">

                            @foreach ($userAccountBalances as $item)
                                @php
                                    $allocated = $item['allocated_balance'] ?? 0;
                                    $used = $item['used_balance'] ?? 0;

                                    $percentage = $allocated > 0 ? min(($used / $allocated) * 100, 100) : 0;
                                @endphp

                                <tr class="hover:bg-gray-50 transition">

                                    {{-- COA --}}
                                    <td class="px-6 py-5">

                                        <div class="flex flex-col">

                                            <span class="font-semibold text-gray-800">
                                                {{ $item['account_code'] }}
                                            </span>

                                            <span class="text-sm text-gray-600 mt-1">
                                                {{ $item['account_name'] }}
                                            </span>

                                        </div>

                                    </td>

                                    {{-- SUB PERIOD --}}
                                    <td class="px-6 py-5 whitespace-nowrap">

                                        @if ($item['sub_period'])
                                            <span
                                                class="inline-flex items-center px-3 py-1 rounded-full bg-blue-100 text-blue-700 text-xs font-semibold">
                                                {{ $item['sub_period'] }}
                                            </span>
                                        @else
                                            <span class="text-sm text-gray-400">
                                                -
                                            </span>
                                        @endif

                                    </td>

                                    {{-- ALOKASI --}}
                                    <td class="px-6 py-5 text-right whitespace-nowrap">

                                        <span class="font-semibold text-blue-700">
                                            Rp {{ number_format($item['allocated_balance'], 0, ',', '.') }}
                                        </span>

                                    </td>

                                    {{-- USED --}}
                                    <td class="px-6 py-5 text-right whitespace-nowrap">

                                        <span class="font-semibold text-orange-600">
                                            Rp {{ number_format($item['used_balance'], 0, ',', '.') }}
                                        </span>

                                    </td>

                                    {{-- REMAINING --}}
                                    <td class="px-6 py-5 text-right whitespace-nowrap">

                                        <span class="font-bold text-green-700">
                                            Rp {{ number_format($item['remaining_balance'], 0, ',', '.') }}
                                        </span>

                                    </td>

                                    {{-- PROGRESS --}}
                                    <td class="px-6 py-5 min-w-[180px]">

                                        <div class="space-y-2">

                                            <div class="w-full bg-gray-200 rounded-full h-2 overflow-hidden">
                                                <div class="bg-orange-500 h-2 rounded-full"
                                                    style="width: {{ $percentage }}%">
                                                </div>
                                            </div>

                                            <div class="text-xs text-gray-500 text-center">
                                                {{ number_format($percentage, 0) }}% digunakan
                                            </div>

                                        </div>

                                    </td>

                                    {{-- DATE --}}
                                    <td class="px-6 py-5 text-center whitespace-nowrap">

                                        @if ($item['allocated_at'])
                                            <div class="flex flex-col">
                                                <span class="text-sm font-medium text-gray-700">
                                                    {{ \Carbon\Carbon::parse($item['allocated_at'])->format('d M Y') }}
                                                </span>

                                                <span class="text-xs text-gray-500">
                                                    {{ \Carbon\Carbon::parse($item['allocated_at'])->format('H:i') }}
                                                </span>
                                            </div>
                                        @else
                                            <span class="text-gray-400 text-sm">
                                                -
                                            </span>
                                        @endif

                                    </td>

                                    {{-- ACTION --}}
                                    <td class="px-6 py-5 text-center whitespace-nowrap">

                                        <!-- Show -->
                                        <a href="{{ route('user.user-account-balances.show', $item['id']) }}"
                                            class="flex h-8 w-8 items-center justify-center rounded-md
                                                    text-green-600 hover:bg-green-50
                                                    dark:text-green-400 dark:hover:bg-green-500/10"
                                            title="Lihat Detail Saldo Pengguna">
                                            <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                                xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                fill="none" viewBox="0 0 24 24">
                                                <path stroke="currentColor" stroke-width="2"
                                                    d="M21 12c0 1.2-4.03 6-9 6s-9-4.8-9-6c0-1.2 4.03-6 9-6s9 4.8 9 6Z" />
                                                <path stroke="currentColor" stroke-width="2"
                                                    d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
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
