@extends('layouts.app')

@section('title', 'Detail Pengajuan COA')

@section('content')

    <x-common.page-breadcrumb pageTitle="Detail Pengajuan COA" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside">
                    @foreach ($errors->all() as $error)
                        <li class="text-red-500">{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    <div x-data="{
        approveModal: false,
        rejectModal: false
    }" class="space-y-6">

        {{-- HEADER --}}

        <div
            class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-white/[0.05] dark:bg-white/[0.03]">

            <div class="p-6">

                <div class="flex flex-col gap-6 lg:flex-row lg:items-start lg:justify-between">

                    {{-- INFORMASI UTAMA --}}
                    <div>

                        <div class="flex flex-wrap items-center gap-3">

                            <h1 class="text-3xl font-bold text-gray-900 dark:text-white">
                                {{ $coaRequest->proposed_name }}
                            </h1>

                            <span
                                class="rounded-lg bg-gray-100 px-3 py-1 text-sm font-medium
                dark:bg-gray-800 dark:text-gray-300">
                                {{ $coaRequest->proposed_code }}
                            </span>

                        </div>

                        <p class="mt-2 text-gray-500 dark:text-gray-400">
                            Pengajuan pembuatan akun COA baru
                        </p>

                    </div>

                    {{-- STATUS & ACTION --}}
                    <div class="flex flex-col items-start gap-3 lg:items-end">

                        @php
                            $coaRequest->status = strtoupper($coaRequest->status);

                            $statusClass = match ($coaRequest->status) {
                                'APPROVED'
                                    => 'bg-green-50 text-green-700 border border-green-500 dark:bg-green-500/15 dark:text-green-400 dark:border-green-500',
                                'REJECTED'
                                    => 'bg-red-50 text-red-700 border border-red-500 dark:bg-red-500/15 dark:text-red-400 dark:border-red-500',
                                default
                                    => 'bg-yellow-50 text-yellow-700 border border-yellow-500 dark:bg-yellow-500/15 dark:text-yellow-400 dark:border-yellow-500',
                            };
                        @endphp

                        <span class="inline-flex rounded-full px-4 py-2 text-sm font-semibold {{ $statusClass }}">
                            {{ $coaRequest->status }}
                        </span>

                        @if ($coaRequest->status === App\Enums\RequestStatus::PENDING->name)
                            <div class="flex flex-wrap gap-2">

                                <button type="button" @click="rejectModal = true"
                                    class="inline-flex items-center gap-2 rounded-lg bg-red-600 px-4 py-2 text-sm font-semibold text-white hover:bg-red-700">

                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">

                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M6 18L18 6M6 6l12 12" />

                                    </svg>

                                    Tolak

                                </button>

                                <button type="button" @click="approveModal = true"
                                    class="inline-flex items-center gap-2 rounded-lg bg-green-600 px-4 py-2 text-sm font-semibold text-white hover:bg-green-700">

                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">

                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M5 13l4 4L19 7" />

                                    </svg>

                                    Setujui

                                </button>

                            </div>
                        @endif

                    </div>

                </div>

            </div>

            {{-- SUMMARY --}}
            <div
                class="grid grid-cols-1 gap-4 border-t border-gray-200 p-6 md:grid-cols-2 lg:grid-cols-4 dark:border-white/[0.05]">

                <div class="rounded-xl bg-gray-50 p-4 dark:bg-gray-800">
                    <p class="text-xs uppercase tracking-wide text-gray-500">
                        Pengaju
                    </p>

                    <p class="mt-2 font-semibold text-gray-900 dark:text-white">
                        {{ $coaRequest->requester?->name ?? '-' }}
                    </p>
                </div>

                <div class="rounded-xl bg-gray-50 p-4 dark:bg-gray-800">
                    <p class="text-xs uppercase tracking-wide text-gray-500">
                        Tanggal Pengajuan
                    </p>

                    <p class="mt-2 font-semibold text-gray-900 dark:text-white">
                        {{ $coaRequest->created_at?->format('d M Y H:i') }}
                    </p>
                </div>

                <div class="rounded-xl bg-gray-50 p-4 dark:bg-gray-800">
                    <p class="text-xs uppercase tracking-wide text-gray-500">
                        Tipe Akun
                    </p>

                    <p class="mt-2 font-semibold text-gray-900 dark:text-white">
                        {{ $coaRequest->accountType?->name ?? '-' }}
                    </p>
                </div>

                <div class="rounded-xl bg-gray-50 p-4 dark:bg-gray-800">
                    <p class="text-xs uppercase tracking-wide text-gray-500">
                        Normal Balance
                    </p>

                    <p class="mt-2 font-semibold text-gray-900 dark:text-white">
                        {{ $coaRequest->normal_balance ?? '-' }}
                    </p>
                </div>

            </div>

        </div>

        {{-- DETAIL COA --}}

        <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-white/[0.05] dark:bg-white/[0.03]">

            <div class="border-b border-gray-200 px-6 py-4 dark:border-white/[0.05]">

                <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                    Detail COA Yang Diajukan
                </h3>

            </div>

            <div class="divide-y divide-gray-100 p-6 dark:divide-white/[0.05]">

                <div class="flex flex-col justify-between gap-2 py-4 md:flex-row">
                    <span class="text-gray-500">Nama COA</span>
                    <span class="font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->proposed_name }}
                    </span>
                </div>

                <div class="flex flex-col justify-between gap-2 py-4 md:flex-row">
                    <span class="text-gray-500">Kode COA</span>
                    <span class="font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->proposed_code }}
                    </span>
                </div>

                <div class="flex flex-col justify-between gap-2 py-4 md:flex-row">
                    <span class="text-gray-500">Parent COA</span>

                    <span class="font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->parentCoa?->code }}
                        -
                        {{ $coaRequest->parentCoa?->name ?? '-' }}
                    </span>
                </div>

                <div class="flex flex-col justify-between gap-2 py-4 md:flex-row">
                    <span class="text-gray-500">Sub Periode</span>

                    <span class="font-medium text-gray-900 dark:text-white">
                        {{ $coaRequest->subPeriod?->name ?? '-' }}
                    </span>
                </div>

            </div>

        </div>

        {{-- ALASAN PENGAJUAN --}}

        <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-white/[0.05] dark:bg-white/[0.03]">

            <div class="border-b border-gray-200 px-6 py-4 dark:border-white/[0.05]">

                <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                    Alasan Pengajuan
                </h3>

            </div>

            <div class="p-6">

                <div class="rounded-xl border border-blue-200 bg-blue-50 p-5 dark:border-blue-500/20 dark:bg-blue-500/10">

                    <p class="whitespace-pre-line text-blue-900 dark:text-blue-200">
                        {{ $coaRequest->description ?: 'Tidak ada alasan pengajuan.' }}
                    </p>

                </div>

            </div>
        </div>


        {{-- APPROVAL INFORMATION --}}
        <div
            class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-white/[0.05] dark:bg-white/[0.03]">

            <div class="border-b border-gray-200 px-6 py-4 dark:border-white/[0.05]">
                <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                    Informasi Persetujuan
                </h3>
            </div>

            <div class="space-y-6 p-6">

                {{-- STATUS --}}
                <div>
                    <label class="mb-2 block text-sm text-gray-500 dark:text-gray-400">
                        Status Request
                    </label>

                    <span @class([
                        'inline-flex rounded-full px-3 py-1 text-sm font-medium',
                        'bg-yellow-50 text-yellow-700 border border-yellow-500 dark:bg-yellow-500/15 dark:text-yellow-400 dark:border-yellow-500' => $coaRequest->status === 'PENDING',
                        'bg-green-50 text-green-700 border border-green-500 dark:bg-green-500/15 dark:text-green-400 dark:border-green-500' => $coaRequest->status === 'APPROVED',
                        'bg-red-50 text-red-700 border border-red-500 dark:bg-red-500/15 dark:text-red-400 dark:border-red-500' => $coaRequest->status === 'REJECTED',
                    ])>
                        {{ $coaRequest->status }}
                    </span>
                </div>

                {{-- APPROVAL / REJECTION DETAIL --}}
                <div class="grid grid-cols-1 gap-6 md:grid-cols-2">

                    <div>
                        <label class="text-sm text-gray-500 dark:text-gray-400">
                            Diproses Oleh
                        </label>

                        <p class="mt-1 font-medium text-gray-900 dark:text-white">
                            {{ $coaRequest->approver?->name ?? '-' }}
                        </p>
                    </div>

                    <div>
                        <label class="text-sm text-gray-500 dark:text-gray-400">
                            Tanggal Diproses
                        </label>

                        <p class="mt-1 font-medium text-gray-900 dark:text-white">
                            {{ $coaRequest->approved_at?->format('d M Y H:i') ?? ($coaRequest->rejected_at?->format('d M Y H:i') ?? '-') }}
                        </p>
                    </div>

                </div>

                {{-- APPROVED --}}
                @if ($coaRequest->status === 'APPROVED')
                    <div
                        class="rounded-xl border border-green-200 bg-green-50 p-4
                dark:border-green-500/20 dark:bg-green-500/10">

                        <h4 class="mb-2 font-medium text-green-700 dark:text-green-400">
                            Catatan Persetujuan
                        </h4>

                        <p class="text-sm text-green-800 dark:text-green-300">
                            {{ $coaRequest->approval_notes ?: 'Tidak ada catatan.' }}
                        </p>
                    </div>
                @endif

                {{-- REJECTED --}}
                @if ($coaRequest->status === 'REJECTED')
                    <div
                        class="rounded-xl border border-red-200 bg-red-50 p-4
                dark:border-red-500/20 dark:bg-red-500/10">

                        <h4 class="mb-2 font-medium text-red-700 dark:text-red-400">
                            Alasan Penolakan
                        </h4>

                        <p class="text-sm text-red-800 dark:text-red-300">
                            {{ $coaRequest->rejection_reason ?: 'Tidak ada alasan penolakan.' }}
                        </p>
                    </div>
                @endif

                {{-- PENDING --}}
                @if ($coaRequest->status === 'PENDING')
                    <div
                        class="rounded-xl border border-yellow-200 bg-yellow-50 p-4
                dark:border-yellow-500/20 dark:bg-yellow-500/10">

                        <p class="text-sm text-yellow-800 dark:text-yellow-300">
                            Permintaan COA masih menunggu proses persetujuan.
                        </p>
                    </div>
                @endif

            </div>
        </div>

        {{-- ACTION --}}
        <div class="flex justify-end">

            <a href="{{ route('bendahara.master.requests.coas.index') }}">
                <x-ui.button variant="outline">
                    Kembali
                </x-ui.button>
            </a>

        </div>

        @if ($coaRequest->status === App\Enums\RequestStatus::PENDING->name)
            <div x-show="approveModal" x-transition.opacity class="fixed inset-0 z-99999 overflow-y-auto  bg-black/60 p-4"
                style="display:none;">

                <div class="flex items-center justify-center ">
                    <div @click.away="approveModal = false" x-transition
                        class="w-full max-w-lg sm:max-w-xl lg:max-w-2xl overflow-hidden rounded-2xl bg-white border border-gray-100 shadow-2xl dark:bg-gray-900 dark:border-white">

                        {{-- Header --}}
                        <div class="border-b border-gray-200 px-6 py-5 dark:border-white">

                            <div class="flex items-center gap-3">

                                <div
                                    class="flex items-center justify-center rounded-full bg-amber-100 text-amber-600 dark:bg-amber-500/20 dark:text-amber-400">

                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">

                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 9v2m0 4h.01M12 3L2 21h20L12 3z" />
                                    </svg>

                                </div>

                                <div>

                                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                                        Konfirmasi Approval COA
                                    </h3>

                                    <p class="text-sm text-gray-500 dark:text-gray-400">
                                        Approval akan membuat akun COA baru secara permanen.
                                    </p>

                                </div>

                            </div>

                        </div>

                        {{-- Body --}}
                        <div class="space-y-5 p-6">
                            <div
                                class="rounded-xl border border-amber-200 bg-amber-50 p-4 dark:border-amber-500/20 dark:bg-amber-500/10">

                                <p class="text-sm text-amber-700 dark:text-amber-300">
                                    Pastikan seluruh informasi akun sudah sesuai sebelum melakukan approval.
                                </p>

                            </div>

                            <dl class="divide-y divide-gray-200 dark:divide-gray-800">

                                <div class="flex flex-col gap-1 py-3 sm:flex-row sm:justify-between">
                                    <dt class="text-sm text-gray-500">
                                        Nama COA Yang Diajukan
                                    </dt>

                                    <dd class="font-semibold text-gray-900 dark:text-white">
                                        {{ $coaRequest->proposed_name }}
                                    </dd>
                                </div>

                                <div class="flex flex-col gap-1 py-3 sm:flex-row sm:justify-between">
                                    <dt class="text-sm text-gray-500">
                                        Kode COA
                                    </dt>

                                    <dd class="font-semibold text-gray-900 dark:text-white">
                                        {{ $coaRequest->proposed_code }}
                                    </dd>
                                </div>

                                <div class="flex flex-col gap-1 py-3 sm:flex-row sm:justify-between">
                                    <dt class="text-sm text-gray-500">
                                        Parent COA
                                    </dt>

                                    <dd class="font-semibold text-gray-900 dark:text-white">
                                        {{ $coaRequest->parentCoa?->name ?? 'Root Account' }}
                                    </dd>
                                </div>

                                <div class="flex flex-col gap-1 py-3 sm:flex-row sm:justify-between">
                                    <dt class="text-sm text-gray-500">
                                        Tipe Akun
                                    </dt>

                                    <dd class="font-semibold text-gray-900 dark:text-white">
                                        {{ $coaRequest->accountType?->name }}
                                    </dd>
                                </div>

                                <div class="flex flex-col gap-1 py-3 sm:flex-row sm:justify-between">
                                    <dt class="text-sm text-gray-500">
                                        Normal Balance
                                    </dt>

                                    <dd class="font-semibold text-gray-900 dark:text-white">
                                        {{ $coaRequest->normal_balance }}
                                    </dd>
                                </div>

                            </dl>

                            <div class="grid grid-cols-1">
                                <x-form.text-area name="approval_notes" form="approve-form" label="Catatan Approval"
                                    placeholder="Contoh: COA telah diverifikasi dan sesuai kebutuhan operasional...."
                                    rows="4" required />
                            </div>

                        </div>

                        {{-- Footer --}}
                        <div class="flex justify-end gap-3 border-t border-gray-200 px-6 py-4 dark:border-gray-800">

                            <button type="button" @click="approveModal = false"
                                class="rounded-lg border border-gray-300 px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 dark:border-gray-700 dark:text-gray-300 dark:hover:bg-gray-800">

                                Batal

                            </button>

                            <form method="POST" id="approve-form"
                                action="{{ route('bendahara.master.requests.coas.approve', $coaRequest->id) }}">

                                @csrf

                                <button type="submit"
                                    class="rounded-lg bg-green-600 px-5 py-2 text-sm font-semibold text-white hover:bg-green-700">

                                    Ya, Approve COA

                                </button>

                            </form>

                        </div>

                    </div>
                </div>

            </div>
        @endif

        @if ($coaRequest->status === App\Enums\RequestStatus::PENDING->name)
            <div x-show="rejectModal" x-transition.opacity
                class="fixed inset-0 z-99999 flex items-center justify-center bg-black/60 p-4" style="display:none;">

                <div @click.away="rejectModal = false"
                    class="w-full max-w-lg sm:max-w-xl lg:max-w-2xl overflow-hidden rounded-2xl bg-white border border-gray-100 shadow-2xl dark:bg-gray-900 dark:border-white">

                    {{-- Header --}}
                    <div class="border-b border-gray-200 px-6 py-5 dark:border-white">

                        <div class="flex items-center gap-3">

                            <div
                                class="flex h-12 w-12 items-center justify-center rounded-full
                                bg-red-100 text-red-600
                                dark:bg-red-500/20 dark:text-red-400">

                                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor">

                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M6 18L18 6M6 6l12 12" />

                                </svg>

                            </div>

                            <div>

                                <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                                    Tolak Pengajuan COA
                                </h3>

                                <p class="text-sm text-gray-500 dark:text-gray-400">
                                    Berikan alasan penolakan pengajuan ini.
                                </p>

                            </div>

                        </div>

                    </div>

                    {{-- Body --}}
                    <form method="POST" action="{{ route('bendahara.master.requests.coas.reject', $coaRequest->id) }}">

                        @csrf

                        <div class="p-6">
                            <x-form.text-area name="rejection_reason" form="approve-form" label="Alasan Penolakan"
                                placeholder="Jelaskan alasan penolakan...." rows="4" required />
                        </div>

                        {{-- Footer --}}
                        <div class="flex justify-end gap-3 border-t border-gray-200 px-6 py-4 dark:border-gray-800">

                            <button type="button" @click="rejectModal = false"
                                class="rounded-lg border border-gray-300 px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 dark:border-gray-700 dark:text-gray-300 dark:hover:bg-gray-800">
                                Batal
                            </button>

                            <button type="submit"
                                class="rounded-lg bg-red-600 px-5 py-2 text-sm font-semibold text-white hover:bg-red-700">
                                Tolak Pengajuan
                            </button>

                        </div>

                    </form>

                </div>

            </div>
        @endif

    </div>

@endsection
