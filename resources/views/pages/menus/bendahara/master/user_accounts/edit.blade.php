@extends('layouts.app')

@section('title', 'Master Data - Penghubung Akun COA ke Pengguna')

@section('content')
    <x-common.page-breadcrumb pageTitle="Penghubung Akun COA ke Pengguna" />

    {{-- Success Message --}}
    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    {{-- Error Message --}}
    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    <div
        class="rounded-2xl border border-gray-200 bg-white
               p-5 dark:border-gray-800 dark:bg-white/[0.03] lg:p-6">

        {{-- Header User --}}
        <div
            class="mb-6 rounded-xl border border-gray-200 bg-gray-50 px-5 py-4
                   dark:border-gray-800 dark:bg-white/[0.02]">

            <div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
                <div class="flex flex-col gap-1">
                    <h2 class="text-xl font-semibold text-gray-900 dark:text-white">
                        {{ $user->name }}
                    </h2>

                    <p class="text-sm text-gray-600 dark:text-gray-400">
                        {{ $user->email }}
                    </p>
                </div>

                <div class="flex flex-wrap items-center gap-2">

                    {{-- Debit --}}
                    <div
                        class="inline-flex min-w-[220px] items-center justify-center rounded-full
                               border border-blue-200 bg-blue-500 px-4 py-2
                               text-sm font-medium text-white
                               dark:border-blue-800 dark:bg-blue-500/15 dark:text-blue-300">

                        <span class="font-semibold">
                            {{ count($assignedDebitCoaIds) }}
                        </span>

                        <span class="ml-2">
                            Akun COA DEBIT Terhubung
                        </span>
                    </div>

                    {{-- Credit --}}
                    <div
                        class="inline-flex min-w-[220px] items-center justify-center rounded-full
                               border border-green-200 bg-green-500 px-4 py-2
                               text-sm font-medium text-white
                               dark:border-green-800 dark:bg-green-500/15 dark:text-green-300">

                        <span class="font-semibold">
                            {{ count($assignedCreditCoaIds) }}
                        </span>

                        <span class="ml-2">
                            Akun COA KREDIT Terhubung
                        </span>
                    </div>

                </div>
            </div>
        </div>

        {{-- Information Box --}}
        <div
            class="mb-6 rounded-xl border border-gray-200 bg-white pt-4 dark:border-white/[0.05] dark:bg-white/[0.03] px-5 py-4">

            <div class="space-y-2">
                <h3 class="text-sm font-semibold text-blue-800 dark:text-gray-400">
                    Informasi Sinkronisasi
                </h3>

                <ul class="list-disc list-inside space-y-1 text-sm text-blue-700 dark:text-blue-400">
                    <li>
                        Pilih akun COA yang dapat digunakan oleh pengguna ini.
                    </li>
                    <li>
                        Jika akun induk dipilih, seluruh akun turunannya akan ikut terpilih.
                    </li>
                    <li>
                        Sinkronisasi ulang akan mengganti seluruh relasi COA sebelumnya.
                    </li>
                </ul>
            </div>
        </div>

        {{-- Form --}}
        <div class="rounded-xl border border-gray-100 dark:border-gray-800">
            <form action="{{ route('bendahara.master.account-users.sync', $user->id) }}" method="POST">

                @csrf

                {{-- Content --}}
                <div class="p-4 sm:p-6">
                    <div class="mb-4">
                        <h3 class="text-base font-semibold text-gray-900 dark:text-white">
                            Daftar Chart of Accounts
                        </h3>

                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                            Pilih akun berdasarkan kategori yang tersedia.
                        </p>
                    </div>

                    <x-core.lists.list-user-account-checkbox :coas="$coas" :assignedCoaIds="$assignedCoaIds" />
                </div>

                {{-- Footer Action --}}
                <div
                    class="flex items-center justify-between gap-3 border-t
                           border-gray-100 px-4 py-4 dark:border-gray-800 sm:px-6">

                    <div class="text-sm text-gray-500 dark:text-gray-400">
                        Pastikan akun yang dipilih sudah sesuai.
                    </div>

                    <div class="flex gap-3">
                        <a href="{{ route('bendahara.master.account-users.index') }}">
                            <x-ui.button variant="outline" size="sm">
                                Batal
                            </x-ui.button>
                        </a>

                        <x-ui.button type="submit" size="sm">
                            Simpan Sinkronisasi
                        </x-ui.button>
                    </div>
                </div>
            </form>
        </div>
    </div>
@endsection
