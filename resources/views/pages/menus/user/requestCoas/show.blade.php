@extends('layouts.app')

@section('title', 'Detail Pengajuan COA')

@section('content')

<x-common.page-breadcrumb defaultTitle="Detail Pengajuan Akun COA " pageTitle="Detail Pengajuan Akun COA"
pageDescription="Monitoring Detail pengajuan akun COA" pageIcon="book"
parentTitle="Pengajuan Akun COA" :parentRoute="route('user.requests.coas.index')" currentTitle="Detail" />

    <div class="space-y-6">

        {{-- HEADER --}}
        <div
            class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm
            dark:border-white/[0.05] dark:bg-white/[0.03]">

            <div class="border-b border-gray-200 p-6
                dark:border-white/[0.05]">

                <div class="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">

                    <div>
                        <p class="text-sm text-gray-500 dark:text-gray-400">
                            Kode Pengajuan
                        </p>

                        <h2 class="mt-1 text-2xl font-bold text-gray-900 dark:text-white">
                            {{ $coaRequest->proposed_code ?? 'Belum Ada' }}
                        </h2>

                        <p class="mt-2 text-gray-600 dark:text-gray-400">
                            {{ $coaRequest->proposed_name }}
                        </p>
                    </div>

                    <div>

                        @php
                        $coaRequest->status = strtoupper($coaRequest->status);
                            $statusClass = match ($coaRequest->status) {
                                'APPROVED' => 'bg-green-100 text-green-700 dark:bg-green-500/15 dark:text-green-400',
                                'REJECTED' => 'bg-red-100 text-red-700 dark:bg-red-500/15 dark:text-red-400',
                                default => 'bg-yellow-100 text-yellow-700 dark:bg-yellow-500/15 dark:text-yellow-400',
                            };
                        @endphp

                        <span class="inline-flex rounded-full px-4 py-2 text-sm font-semibold {{ $statusClass }}">
                            {{ $coaRequest->status }}
                        </span>

                    </div>

                </div>

            </div>

            <div class="grid grid-cols-1 gap-6 p-6 md:grid-cols-4">

                <div>
                    <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">
                        Pengaju
                    </p>

                    <p class="mt-1 font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->requester?->name }}
                    </p>
                </div>

                <div>
                    <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">
                        Tanggal Pengajuan
                    </p>

                    <p class="mt-1 font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->created_at?->format('d M Y H:i') }}
                    </p>
                </div>

                <div>
                    <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">
                        Tipe Akun
                    </p>

                    <p class="mt-1 font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->accountType?->name }}
                    </p>
                </div>

                <div>
                    <p class="text-xs uppercase tracking-wide text-gray-500 dark:text-gray-400">
                        Normal Balance
                    </p>

                    <p class="mt-1 font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->normal_balance }}
                    </p>
                </div>

            </div>

        </div>

        {{-- INFORMASI COA --}}
        <div
            class="rounded-2xl border border-gray-200 bg-white shadow-sm
            dark:border-white/[0.05] dark:bg-white/[0.03]">

            <div class="border-b border-gray-200 px-6 py-4
                dark:border-white/[0.05]">

                <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                    Informasi COA
                </h3>

            </div>

            <div class="grid grid-cols-1 gap-6 p-6 md:grid-cols-2">

                <div>
                    <label class="text-sm text-gray-500 dark:text-gray-400">
                        Nama COA Yang Diajukan
                    </label>

                    <p class="mt-1 font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->proposed_name }}
                    </p>
                </div>

                <div>
                    <label class="text-sm text-gray-500 dark:text-gray-400">
                        Kode COA
                    </label>

                    <p class="mt-1 font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->proposed_code }}
                    </p>
                </div>

                <div>
                    <label class="text-sm text-gray-500 dark:text-gray-400">
                        Parent COA
                    </label>

                    <p class="mt-1 font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->parentCoa?->code }}
                        -
                        {{ $coaRequest->parentCoa?->name ?? '-' }}
                    </p>
                </div>

                <div>
                    <label class="text-sm text-gray-500 dark:text-gray-400">
                        Sub Periode
                    </label>

                    <p class="mt-1 font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->subPeriod?->name ?? '-' }}
                    </p>
                </div>

            </div>

        </div>

        {{-- DESKRIPSI --}}
        <div
            class="rounded-2xl border border-gray-200 bg-white shadow-sm
            dark:border-white/[0.05] dark:bg-white/[0.03]">

            <div class="border-b border-gray-200 px-6 py-4
                dark:border-white/[0.05]">

                <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                    Alasan Pengajuan
                </h3>

            </div>

            <div class="p-6">

                <p class="whitespace-pre-line text-gray-700 dark:text-gray-300">
                    {{ $coaRequest->description ?: '-' }}
                </p>

            </div>

        </div>

        {{-- APPROVAL --}}
        <div
            class="rounded-2xl border border-gray-200 bg-white shadow-sm
            dark:border-white/[0.05] dark:bg-white/[0.03]">

            <div class="border-b border-gray-200 px-6 py-4
                dark:border-white/[0.05]">

                <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                    Informasi Persetujuan
                </h3>

            </div>

            <div class="grid grid-cols-1 gap-6 p-6 md:grid-cols-2">

                <div>
                    <label class="text-sm text-gray-500 dark:text-gray-400">
                        Approver
                    </label>

                    <p class="mt-1 font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->approver?->name ?? '-' }}
                    </p>
                </div>

                <div>
                    <label class="text-sm text-gray-500 dark:text-gray-400">
                        Tanggal Approval
                    </label>

                    <p class="mt-1 font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->approved_at?->format('d M Y H:i') ?? '-' }}
                    </p>
                </div>

                <div>
                    <label class="text-sm text-gray-500 dark:text-gray-400">
                        Catatan Approval
                    </label>

                    <p class="mt-1 text-gray-900 dark:text-white">
                        {{ $coaRequest->approval_notes ?? '-' }}
                    </p>
                </div>

                <div>
                    <label class="text-sm text-gray-500 dark:text-gray-400">
                        Alasan Penolakan
                    </label>

                    <p class="mt-1 text-gray-900 dark:text-white">
                        {{ $coaRequest->rejection_reason ?? '-' }}
                    </p>
                </div>

            </div>

        </div>

        {{-- ACTION --}}
        <div class="flex justify-end">

            <a href="{{ route('user.requests.coas.index') }}">
                <x-ui.button variant="outline">
                    Kembali
                </x-ui.button>
            </a>

        </div>

    </div>

@endsection
