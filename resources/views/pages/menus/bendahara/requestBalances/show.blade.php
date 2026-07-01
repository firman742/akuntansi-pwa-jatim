@extends('layouts.app')

@section('title', 'Detail Pengajuan Penambahan Saldo')

@section('content')

    <x-common.page-breadcrumb defaultTitle="Detail Pengajuan Penambahan Saldo " pageTitle="Detail Pengajuan Penambahan Saldo"
        pageDescription="Monitoring dan kelola penambahan saldo yang diajukan oleh pengguna" pageIcon="book"
        parentTitle="Pengajuan penambahan saldo" :parentRoute="route('bendahara.requests.balances.index')" currentTitle="Detail" />

    @php
        $balanceRequest->status = strtoupper($balanceRequest->status);
    @endphp

    <div x-data="{
        approveModal: false,
        rejectModal: false,
        selectedSourceCoa: '',
    
        sourceCoas: @js(
    $sourceCoas->map(
        fn($item) => [
            'id' => $item->id,
            'name' => $item->coa_name,
            'balance' => $item->current_balance,
        ],
    ),
),
    
        get selectedCoa() {
            return this.sourceCoas.find(
                item => item.id === this.selectedSourceCoa
            );
        }
    }" class="space-y-6">

        {{-- ACTION --}}
        <div class="flex justify-between">
            <div>
                <a href="{{ route('bendahara.requests.balances.index') }}">
                    <x-ui.button variant="outline">
                        Kembali
                    </x-ui.button>
                </a>

            </div>
            <div>
                @if ($balanceRequest->status === App\Enums\RequestStatus::PENDING->name)
                    <button type="button" @click="rejectModal = true"
                        class="inline-flex items-center gap-2 rounded-lg bg-red-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-red-600">

                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">

                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M6 18L18 6M6 6l12 12" />

                        </svg>

                        Reject

                    </button>

                    <button type="button" @click="approveModal = true"
                        class="inline-flex items-center gap-2 rounded-lg bg-green-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-green-600">

                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor">

                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />

                        </svg>

                        Approve

                    </button>
                @endif
            </div>

        </div>

        {{-- HEADER --}}
        <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-gray-900">

            <div class="border-b border-gray-200 px-6 py-5 dark:border-gray-800">

                <div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">

                    <div>
                        <h2 class="text-xl font-semibold text-gray-900 dark:text-white">
                            Pengajuan Penambahan Saldo
                        </h2>

                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                            ID Pengajuan :
                            {{ $balanceRequest->id }}
                        </p>
                    </div>

                    <div>
                        @php
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

        {{-- MODAL --}}
        @if ($balanceRequest->status === App\Enums\RequestStatus::PENDING->name)
            <div x-show="approveModal" x-transition.opacity class="fixed inset-0 z-99999 overflow-y-auto  bg-black/60 p-4"
                style="display:none;">

                <div class="flex items-center justify-center ">
                    <div @click.away="approveModal = false" x-transition
                        class="w-full max-w-lg sm:max-w-xl lg:max-w-2xl overflow-hidden rounded-2xl bg-white shadow-2xl dark:bg-gray-900">

                        {{-- HEADER --}}
                        <div class="border-b border-gray-200 px-6 py-5 dark:border-gray-800">
                            <div class="flex items-center gap-3">
                                <div
                                    class="flex h-12 w-12 items-center justify-center rounded-full bg-green-100 text-green-600 dark:bg-green-500/20 dark:text-green-400">

                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
                                        viewBox="0 0 24 24" stroke="currentColor">

                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M5 13l4 4L19 7" />

                                    </svg>

                                </div>

                                <div>

                                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                                        Approve Pengajuan Saldo
                                    </h3>

                                    <p class="text-sm text-gray-500 dark:text-gray-400">
                                        Pastikan seluruh data telah diverifikasi sebelum menyetujui pengajuan.
                                    </p>

                                </div>

                            </div>

                        </div>

                        {{-- BODY --}}
                        <div class="p-6 space-y-5">

                            {{-- ALERT --}}
                            <div
                                class="rounded-xl border border-amber-200 bg-amber-50 p-4 dark:border-amber-500/20 dark:bg-amber-500/10">

                                <p class="text-sm text-amber-700 dark:text-amber-300">
                                    Setelah approval dilakukan, saldo akan ditambahkan ke akun tujuan dan status pengajuan
                                    tidak
                                    dapat dikembalikan ke pending.
                                </p>

                            </div>

                            {{-- SUMMARY --}}
                            <div class="rounded-xl border border-gray-200 dark:border-gray-800">

                                <div class="border-b border-gray-200 px-4 py-3 dark:border-gray-800">

                                    <h4 class="font-semibold text-gray-900 dark:text-white">
                                        Ringkasan Pengajuan
                                    </h4>

                                </div>

                                <dl class="divide-y divide-gray-200 dark:divide-gray-800">

                                    <div class="flex flex-col gap-1 px-4 py-3 sm:flex-row sm:justify-between">

                                        <dt class="text-sm text-gray-500">
                                            Pemohon
                                        </dt>

                                        <dd class="font-semibold text-gray-900 dark:text-white">
                                            {{ $balanceRequest->requester?->name }}
                                        </dd>

                                    </div>

                                    <div class="flex flex-col gap-1 px-4 py-3 sm:flex-row sm:justify-between">

                                        <dt class="text-sm text-gray-500">
                                            Nominal Pengajuan
                                        </dt>

                                        <dd class="font-semibold text-green-600">
                                            Rp {{ number_format($balanceRequest->amount, 0, ',', '.') }}
                                        </dd>

                                    </div>

                                    <div class="flex flex-col gap-1 px-4 py-3 sm:flex-row sm:justify-between">

                                        <dt class="text-sm text-gray-500">
                                            Akun Tujuan
                                        </dt>

                                        <dd class="font-semibold text-gray-900 dark:text-white text-right">
                                            {{ $balanceRequest->userAccount?->coa?->code }}
                                            -
                                            {{ $balanceRequest->userAccount?->coa?->name }}
                                        </dd>

                                    </div>

                                    <div class="flex flex-col gap-1 px-4 py-3 sm:flex-row sm:justify-between">

                                        <dt class="text-sm text-gray-500">
                                            Akun Sumber Dana
                                        </dt>

                                        <dd class="font-semibold text-gray-900 dark:text-white text-right">
                                            @if ($balanceRequest->sourceCoa)
                                                {{ $balanceRequest->sourceCoa->code }}
                                                -
                                                {{ $balanceRequest->sourceCoa->name }}
                                            @else
                                                Belum dipilih
                                            @endif
                                        </dd>

                                    </div>

                                    <div class="flex flex-col gap-1 px-4 py-3 sm:flex-row sm:justify-between">

                                        <dt class="text-sm text-gray-500">
                                            Periode
                                        </dt>

                                        <dd class="font-semibold text-gray-900 dark:text-white">
                                            {{ $balanceRequest->period?->name }}
                                        </dd>

                                    </div>

                                    <div class="flex flex-col gap-1 px-4 py-3 sm:flex-row sm:justify-between">

                                        <dt class="text-sm text-gray-500">
                                            Sub Periode
                                        </dt>

                                        <dd class="font-semibold text-gray-900 dark:text-white">
                                            {{ $balanceRequest->subPeriod?->name }}
                                        </dd>

                                    </div>

                                    <div class="flex flex-col gap-1 px-4 py-3 sm:flex-row sm:justify-between">

                                        <dt class="text-sm text-gray-500">
                                            Tanggal Pengajuan
                                        </dt>

                                        <dd class="font-semibold text-gray-900 dark:text-white">
                                            {{ $balanceRequest->created_at?->format('d M Y H:i') }}
                                        </dd>

                                    </div>

                                </dl>

                            </div>

                            {{-- TUJUAN --}}
                            <div>

                                <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">

                                    Tujuan Penggunaan Dana

                                </label>

                                <div
                                    class="rounded-lg bg-gray-50 p-4 text-sm text-gray-700 dark:bg-gray-800 dark:text-gray-300">

                                    {{ $balanceRequest->purpose ?: '-' }}

                                </div>

                            </div>

                            {{-- CATATAN PEMOHON --}}
                            @if ($balanceRequest->note)
                                <div>

                                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">

                                        Catatan Pemohon

                                    </label>

                                    <div
                                        class="rounded-lg bg-gray-50 p-4 text-sm text-gray-700 dark:bg-gray-800 dark:text-gray-300">

                                        {{ $balanceRequest->note }}

                                    </div>

                                </div>
                            @endif

                            {{-- SOURCE COA --}}
                            <div>

                                <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">

                                    Sumber Dana <span class="text-red-500">*</span>

                                </label>

                                <select name="source_coa_id" form="approve-form" x-model="selectedSourceCoa" required
                                    class="w-full rounded-lg border border-gray-300 px-4 py-3 dark:border-gray-700 dark:bg-gray-800 dark:text-white">

                                    <option value="">
                                        Pilih Sumber Dana
                                    </option>

                                    <template x-for="coa in sourceCoas" :key="coa.id">

                                        <option :value="coa.id" x-text="coa.name">
                                        </option>

                                    </template>

                                </select>

                            </div>
                            <div x-show="selectedCoa" x-transition
                                class="rounded-lg border border-blue-200 bg-blue-50 p-4 dark:border-blue-500/20 dark:bg-blue-500/10">

                                <div class="space-y-3">

                                    <div class="flex justify-between">

                                        <span class="text-sm text-gray-600 dark:text-gray-300">
                                            Saldo Saat Ini
                                        </span>

                                        <span class="font-semibold text-gray-900 dark:text-white"
                                            x-text="'Rp ' + Number(selectedCoa?.balance ?? 0).toLocaleString('id-ID')">
                                        </span>

                                    </div>

                                    <div class="flex justify-between">

                                        <span class="text-sm text-gray-600 dark:text-gray-300">
                                            Nominal Pengajuan
                                        </span>

                                        <span class="font-semibold text-red-600">
                                            Rp {{ number_format($balanceRequest->amount, 0, ',', '.') }}
                                        </span>

                                    </div>

                                    <div class="border-t border-blue-200 pt-3 dark:border-blue-500/20">

                                        <div class="flex justify-between">

                                            <span class="font-medium text-gray-700 dark:text-gray-300">
                                                Sisa Saldo Setelah Approval
                                            </span>

                                            <span class="font-bold"
                                                :class="(selectedCoa?.balance ?? 0) >= {{ $balanceRequest->amount }}
                                                    ?
                                                    'text-green-600' :
                                                    'text-red-600'">

                                                <span
                                                    x-text="'Rp ' + Number(
                            (selectedCoa?.balance ?? 0) - {{ $balanceRequest->amount }}
                        ).toLocaleString('id-ID')">
                                                </span>

                                            </span>

                                        </div>

                                    </div>

                                    <div x-show="selectedCoa && selectedCoa.balance < {{ $balanceRequest->amount }}"
                                        class="rounded-lg bg-red-100 p-3 text-sm text-red-700 dark:bg-red-500/20 dark:text-red-300">

                                        Saldo sumber dana tidak mencukupi untuk melakukan approval.

                                    </div>

                                </div>

                            </div>

                            {{-- APPROVAL NOTES --}}
                            <div>

                                <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">

                                    Catatan Approval

                                </label>

                                <textarea name="approval_notes" form="approve-form" rows="4"
                                    placeholder="Contoh: Pengajuan telah diverifikasi dan disetujui."
                                    class="w-full rounded-lg border border-gray-300 px-4 py-3 dark:border-gray-700 dark:bg-gray-800 dark:text-white"></textarea>

                            </div>

                        </div>

                        {{-- FOOTER --}}
                        <div class="flex justify-end gap-3 border-t border-gray-200 px-6 py-4 dark:border-gray-800">

                            <button type="button" @click="approveModal = false"
                                class="rounded-lg border border-gray-300 px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-50 dark:border-gray-700 dark:text-gray-300 dark:hover:bg-gray-800">

                                Batal

                            </button>

                            <form id="approve-form" method="POST"
                                action="{{ route('bendahara.requests.balances.approve', $balanceRequest->id) }}">

                                @csrf

                                <button type="submit"
                                    class="rounded-lg bg-green-600 px-5 py-2 text-sm font-semibold text-white hover:bg-green-700">

                                    Approve Pengajuan

                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        @endif

        @if ($balanceRequest->status === App\Enums\RequestStatus::PENDING->name)
            <div x-show="rejectModal" x-transition.opacity
                class="fixed inset-0 z-99999 flex items-center justify-center bg-black/60 p-4" style="display:none;">

                <div @click.away="rejectModal = false"
                    class="w-full max-w-lg sm:max-w-xl lg:max-w-2xl overflow-hidden rounded-2xl bg-white shadow-2xl dark:bg-gray-900">

                    {{-- Header --}}
                    <div class="border-b border-gray-200 px-6 py-5 dark:border-gray-800">

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
                                    Tolak Pengajuan Saldo
                                </h3>

                                <p class="text-sm text-gray-500 dark:text-gray-400">
                                    Berikan alasan penolakan pengajuan ini.
                                </p>
                            </div>
                        </div>
                    </div>

                    {{-- Body --}}
                    <form method="POST" action="{{ route('bendahara.requests.balances.reject', $balanceRequest->id) }}">

                        @csrf

                        <div class="p-6">

                            <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">

                                Alasan Penolakan <span class="text-red-500">*</span>

                            </label>

                            <textarea name="rejection_reason" rows="5" required placeholder="Jelaskan alasan penolakan..."
                                class="w-full rounded-lg border border-gray-300 px-4 py-3
                    dark:border-gray-700 dark:bg-gray-800 dark:text-white"></textarea>

                        </div>

                        {{-- Footer --}}
                        <div class="flex justify-end gap-3 border-t border-gray-200 px-6 py-4 dark:border-gray-800">

                            <button type="button" @click="rejectModal = false"
                                class="rounded-lg border border-gray-300 px-4 py-2">

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
