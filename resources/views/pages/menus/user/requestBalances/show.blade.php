@extends('layouts.app')

@section('title', 'Detail Pengajuan Penambahan Saldo')

@section('content')

    <x-common.page-breadcrumb pageTitle="Detail Pengajuan Penambahan Saldo" />

    <div class="space-y-6">


        {{-- HEADER --}}
        <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-gray-900">

            <div class="border-b border-gray-200 px-6 py-5 dark:border-gray-800">

                <div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">

                    <div>
                        <h2 class="text-xl font-semibold text-gray-900 dark:text-white">
                            Pengajuan Penambahan Saldo
                        </h2>

                        {{-- <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                            ID Pengajuan :
                            {{ $balanceRequest->id }}
                        </p> --}}
                    </div>

                    <div>
                        @php
                            $balanceRequest->status = strtoupper($balanceRequest->status);
                            $statusColor = match ($balanceRequest->status) {
                                'approved' => 'bg-green-100 text-green-700 dark:bg-green-500/20 dark:text-green-400',
                                'rejected' => 'bg-red-100 text-red-700 dark:bg-red-500/20 dark:text-red-400',
                                default => 'bg-yellow-100 text-yellow-700 dark:bg-yellow-500/20 dark:text-yellow-400',
                            };
                        @endphp

                        <span class="inline-flex rounded-full px-4 py-2 text-sm font-semibold {{ $statusColor }}">
                            {{ ucfirst($balanceRequest->status) }}
                        </span>
                    </div>

                </div>
            </div>

            {{-- NOMINAL --}}
            <div class="px-6 py-8">

                <p class="text-sm font-medium text-gray-500 dark:text-gray-400">
                    Nominal Pengajuan
                </p>

                <h1 class="mt-2 text-4xl font-bold text-brand-600 dark:text-brand-400">
                    Rp {{ number_format($balanceRequest->amount, 0, ',', '.') }}
                </h1>

            </div>

        </div>

        {{-- INFORMASI UTAMA --}}
        <div class="grid grid-cols-1 gap-6 lg:grid-cols-2">

            <div class="rounded-2xl border border-gray-200 bg-white p-6 dark:border-gray-800 dark:bg-gray-900">

                <h3 class="mb-5 text-lg font-semibold text-gray-900 dark:text-white">
                    Informasi Pengajuan
                </h3>

                <div class="space-y-4">

                    <div>
                        <p class="text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Pemohon
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $balanceRequest->requester->name }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Akun Tujuan
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $balanceRequest->userAccount?->coa?->code }}
                            -
                            {{ $balanceRequest->userAccount?->coa?->name }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Periode
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $balanceRequest->period?->name }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Sub Periode
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $balanceRequest->subPeriod?->name }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Dibuat Pada
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $balanceRequest->created_at?->format('d M Y H:i') }}
                        </p>
                    </div>

                </div>

            </div>

            <div class="rounded-2xl border border-gray-200 bg-white p-6 dark:border-gray-800 dark:bg-gray-900">

                <h3 class="mb-5 text-lg font-semibold text-gray-900 dark:text-white">
                    Informasi Persetujuan
                </h3>

                <div class="space-y-4">

                    <div>
                        <p class="text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Disetujui Oleh
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $balanceRequest->approver?->name ?? '-' }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Tanggal Persetujuan
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $balanceRequest->approved_at?->format('d M Y H:i') ?? '-' }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Sumber Dana
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $balanceRequest->sourceCoa?->code ?? '-' }}
                            -
                            {{ $balanceRequest->sourceCoa?->name ?? '-' }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Catatan Persetujuan
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $balanceRequest->approval_notes ?? '-' }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Tanggal Penolakan
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $balanceRequest->rejected_at?->format('d M Y H:i') ?? '-' }}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs uppercase tracking-wider text-gray-500 dark:text-gray-400">
                            Alasan Penolakan
                        </p>

                        <p class="font-medium text-gray-900 dark:text-white">
                            {{ $balanceRequest->rejection_reason ?? '-' }}
                        </p>
                    </div>

                </div>

            </div>

        </div>

        {{-- TUJUAN --}}
        <div class="rounded-2xl border border-gray-200 bg-white p-6 dark:border-gray-800 dark:bg-gray-900">

            <h3 class="mb-4 text-lg font-semibold text-gray-900 dark:text-white">
                Tujuan Penggunaan Dana
            </h3>

            <div class="rounded-xl bg-gray-50 p-4 text-gray-700 dark:bg-gray-800 dark:text-gray-300">
                {{ $balanceRequest->purpose }}
            </div>

        </div>

        {{-- CATATAN --}}
        @if ($balanceRequest->note)
            <div class="rounded-2xl border border-gray-200 bg-white p-6 dark:border-gray-800 dark:bg-gray-900">

                <h3 class="mb-4 text-lg font-semibold text-gray-900 dark:text-white">
                    Catatan Tambahan
                </h3>

                <div class="rounded-xl bg-gray-50 p-4 text-gray-700 dark:bg-gray-800 dark:text-gray-300">
                    {{ $balanceRequest->note }}
                </div>

            </div>
        @endif

        
        {{-- ACTION --}}
        <div class="flex justify-end">
            <a href="{{ route('user.requests.balances.index') }}">
                <x-ui.button variant="outline">
                    Kembali
                </x-ui.button>
            </a>
        </div>
    </div>

@endsection