@extends('layouts.app')

@section('title', 'Beranda Bendahara')

@section('content')
    <x-common.page-breadcrumb pageTitle="Beranda Bendahara" pageDescription="Monitoring Dan Kelola Alur Utama Akuntansi"
        pageIcon="dashboard" />

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

    <div class="space-y-6">
        {{-- HERO --}}
        <div
            class="relative overflow-hidden rounded-2xl border border-gray-200 bg-white px-6 py-6 shadow-theme-sm dark:border-gray-800 dark:bg-white/[0.03]">

            <div
                class="absolute right-0 top-0 h-40 w-40 translate-x-10 -translate-y-10 rounded-full bg-brand-500/10 blur-3xl">
            </div>

            <div class="relative z-10 flex flex-col gap-6 xl:flex-row xl:items-center xl:justify-between">

                <div>
                    <span
                        class="inline-flex rounded-full bg-blue-50 px-3 py-1 text-sm font-medium text-brand-600 dark:bg-brand-500/10 dark:text-brand-400">
                        Beranda Bendahara
                    </span>

                    <h1 class="mt-4 text-3xl font-bold text-gray-800 dark:text-white/90">
                        Selamat Datang, {{ auth()->user()->name }} 👋
                    </h1>

                    <p class="mt-2 max-w-2xl text-sm text-gray-500 dark:text-gray-400">
                        Monitor seluruh aktivitas keuangan, transaksi, jurnal,
                        dan kondisi sistem akuntansi secara realtime.
                    </p>
                </div>

                <div class="flex flex-col gap-4">

                    {{-- CLOCK --}}
                    <div
                        class="rounded-2xl border border-gray-200 bg-gray-50 px-5 py-4 text-center dark:border-gray-800 dark:bg-white/[0.03]">

                        <p class="text-sm text-gray-500 dark:text-gray-400">
                            Waktu Saat Ini
                        </p>

                        <h2 id="clock" class="mt-1 text-3xl font-bold tracking-wider text-gray-800 dark:text-white">
                            00:00:00
                        </h2>

                        <p id="date-now" class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                        </p>
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

        @if ($closingReminder)
            <div x-data="countdown('{{ $closingReminder->end_date->format('Y-m-d') }} 23:59:59')" x-init="start()"
                class="overflow-hidden rounded-2xl border
            {{ $closingStatus == 'expired'
                ? 'border-red-200 bg-red-50 dark:border-red-800/50 dark:bg-red-900/10'
                : ($closingStatus == 'today'
                    ? 'border-amber-200 bg-amber-50 dark:border-amber-800/50 dark:bg-amber-900/10'
                    : 'border-blue-200 bg-blue-50 dark:border-blue-800/50 dark:bg-blue-900/10') }}">

                {{-- HEADER --}}
                <div class="border-b border-black/5 px-6 py-5 dark:border-white/10">
                    <div class="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">

                        <div>

                            <div
                                class="inline-flex items-center gap-2 rounded-full px-3 py-1 text-xs font-semibold
                        {{ $closingStatus == 'expired'
                            ? 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300'
                            : ($closingStatus == 'today'
                                ? 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-300'
                                : 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-300') }}">

                                @switch($closingStatus)
                                    @case('expired')
                                        🔴 Penutupan Sub Periode Tertunda
                                    @break

                                    @case('today')
                                        🟠 Hari Terakhir Sub Periode
                                    @break

                                    @default
                                        🔵 Reminder Penutupan Sub Periode
                                @endswitch

                            </div>

                            <h2 class="mt-4 text-2xl font-bold text-gray-900 dark:text-white">
                                {{ $closingReminder->name }}
                            </h2>

                            <p class="mt-2 text-sm text-gray-600 dark:text-gray-400">
                                Sub periode ini berakhir pada
                                <span class="font-semibold">
                                    {{ $closingReminder->end_date->translatedFormat('d F Y') }}
                                </span>.
                            </p>

                        </div>

                        {{-- COUNTDOWN --}}
                        <div
                            class="rounded-xl border border-white/60 bg-white/70 px-6 py-4 text-center shadow-sm dark:border-white/10 dark:bg-gray-900/40">

                            <p class="text-xs uppercase tracking-wide text-gray-500">
                                Countdown
                            </p>

                            <h3 x-text="timer" class="mt-2 text-2xl font-bold tracking-wide text-gray-900 dark:text-white">
                            </h3>

                        </div>

                    </div>
                </div>

                {{-- CONTENT --}}
                <div class="grid gap-6 p-6 lg:grid-cols-2">

                    {{-- CHECKLIST --}}
                    <div>

                        <h3 class="text-base font-semibold text-gray-900 dark:text-white">
                            Checklist Sebelum Penutupan
                        </h3>

                        <p class="mt-1 text-sm text-gray-500">
                            Pastikan seluruh aktivitas akuntansi pada sub periode ini telah selesai.
                        </p>

                        <div class="mt-5 space-y-3">

                            @foreach ($closingChecks as $check)
                                <div
                                    class="flex items-start gap-3 rounded-lg border border-gray-200 bg-white p-3 dark:border-gray-700 dark:bg-gray-800">

                                    <div
                                        class="mt-0.5 flex h-6 w-6 items-center justify-center rounded-full {{ $check['passed'] ? 'bg-green-100 text-green-600' : 'bg-red-100 text-red-600' }}">

                                        {{ $check['passed'] ? '✓' : '✕' }}

                                    </div>

                                    <p
                                        class="text-sm {{ $check['passed'] ? 'text-gray-700 dark:text-gray-300' : 'font-medium text-red-600 dark:text-red-400' }}">

                                        {{ $check['label'] }}

                                    </p>

                                </div>
                            @endforeach

                        </div>

                    </div>

                    {{-- WARNING --}}
                    <div>

                        <div
                            class="rounded-xl border border-amber-200 bg-amber-50 p-5 dark:border-amber-800 dark:bg-amber-900/20">

                            <div class="flex items-start gap-3">

                                <div class="text-xl">

                                    ⚠️

                                </div>

                                <div>

                                    <h3 class="font-semibold text-amber-800 dark:text-amber-300">
                                        Perhatian
                                    </h3>

                                    <p class="mt-2 text-sm leading-6 text-amber-700 dark:text-amber-200">

                                        Setelah sub periode ditutup, seluruh transaksi pada sub periode ini
                                        akan dikunci sehingga pengguna tidak dapat lagi:

                                    </p>

                                    <ul class="mt-3 list-disc space-y-2 pl-5 text-sm text-amber-700 dark:text-amber-200">

                                        <li>Menambah transaksi baru.</li>

                                        <li>Mengubah transaksi yang sudah ada.</li>

                                        <li>Menghapus transaksi.</li>

                                        <li>Mengubah jurnal yang telah diposting.</li>

                                    </ul>

                                </div>

                            </div>

                        </div>

                        {{-- BUTTON --}}
                        <div class="mt-6 flex flex-wrap justify-end gap-3">
                            <a href="{{ route('bendahara.sub-periods.index') }}">
                                <x-ui.button variant="danger">
                                    🔒 Tutup Sub Periode
                                </x-ui.button>
                            </a>

                        </div>

                    </div>

                </div>
            </div>
        @endif

        {{-- SUMMARY CARDS --}}
        <div class="grid grid-cols-1 gap-4 sm:grid-cols-3 xl:grid-cols-3">

            {{-- CARD --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5 shadow-theme-sm dark:border-gray-800 dark:bg-white/[0.03]">

                <div class="flex items-center justify-between">

                    <div>
                        <span class="text-lg text-gray-500 dark:text-gray-400">
                            Saldo Kas
                        </span>

                        <h4 class="mt-2 text-2xl font-bold text-gray-800 dark:text-white/90">
                            Rp {{ number_format($totalCashBalance, 0, ',', '.') }}
                        </h4>
                    </div>
                </div>
            </div>

            {{-- CARD --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5 shadow-theme-sm dark:border-gray-800 dark:bg-white/[0.03]">

                <div class="flex items-center justify-between">

                    <div>
                        <span class="text-lg text-gray-500 dark:text-gray-400">
                            Penerimaan
                        </span>

                        <h4 class="mt-2 text-2xl font-bold text-green-600">
                            Rp {{ number_format($totalIncome, 0, ',', '.') }}
                        </h4>
                    </div>
                </div>
            </div>

            {{-- CARD --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5 shadow-theme-sm dark:border-gray-800 dark:bg-white/[0.03]">

                <div class="flex items-center justify-between">

                    <div>
                        <span class="text-lg text-gray-500 dark:text-gray-400">
                            Pengeluaran
                        </span>

                        <h4 class="mt-2 text-2xl font-bold text-red-600">
                            Rp {{ number_format($totalExpense, 0, ',', '.') }}
                        </h4>
                    </div>
                </div>
            </div>
        </div>

        {{-- ACCOUNTING FLOW --}}
        <div
            class="overflow-hidden rounded-3xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-white/[0.03]">

            {{-- HEADER --}}
            <div class="border-b border-gray-100 px-6 py-5 dark:border-gray-800">

                <div class="flex flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">

                    <div>
                        <h2 class="text-xl font-bold text-gray-800 dark:text-white">
                            Alur Sistem Akuntansi
                        </h2>

                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                            Ringkasan workflow utama sistem akuntansi.
                        </p>
                    </div>

                    <span
                        class="inline-flex w-fit rounded-full bg-brand-50 px-4 py-2 text-xs font-medium text-brand-600 dark:bg-brand-500/10 dark:text-brand-400">

                        8 Tahapan Workflow

                    </span>

                </div>

            </div>

            {{-- FLOW GRID CONNECTED --}}
            <div class="relative p-6">

                @php
                    $flows = [
                        [
                            'title' => 'Setup Sistem',
                            'desc' => 'Role & permission',
                            'icon' => '⚙️',
                            'bg' => 'bg-blue-500',
                        ],
                        ['title' => 'Setup COA', 'desc' => 'Pembuatan akun', 'icon' => '📚', 'bg' => 'bg-blue-500'],
                        [
                            'title' => 'Input Transaksi',
                            'desc' => 'Pencatatan transaksi',
                            'icon' => '💳',
                            'bg' => 'bg-blue-500',
                        ],
                        ['title' => 'Validasi', 'desc' => 'Cek debit kredit', 'icon' => '✅', 'bg' => 'bg-blue-500'],
                        [
                            'title' => 'Posting Jurnal',
                            'desc' => 'Posting otomatis',
                            'icon' => '📘',
                            'bg' => 'bg-blue-500',
                        ],
                        ['title' => 'Buku Besar', 'desc' => 'Rekap saldo akun', 'icon' => '📊', 'bg' => 'bg-blue-500'],
                        [
                            'title' => 'Neraca Saldo',
                            'desc' => 'Balance checking',
                            'icon' => '⚖️',
                            'bg' => 'bg-blue-500',
                        ],
                        ['title' => 'Closing', 'desc' => 'Tutup periode', 'icon' => '🔒', 'bg' => 'bg-blue-500'],
                    ];
                @endphp

                {{-- CONNECTOR LINES (desktop only) --}}
                <div class="hidden xl:block absolute inset-x-6 top-14 h-px bg-gray-200 dark:bg-gray-800"></div>
                <div class="hidden xl:block absolute inset-x-6 top-1/2 h-px bg-gray-200 dark:bg-gray-800"></div>

                <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4 relative">

                    @foreach ($flows as $index => $flow)
                        <div class="relative">

                            {{-- vertical connector --}}
                            <div class="hidden xl:block absolute -left-2 top-10 h-6 w-px bg-gray-200 dark:bg-gray-800">
                            </div>

                            <div
                                class="group relative rounded-2xl border border-gray-200 bg-white p-4 shadow-sm transition hover:-translate-y-1 hover:shadow-lg dark:border-gray-800 dark:bg-white/[0.03]">

                                {{-- STEP NODE --}}
                                <div class="flex items-center justify-between">

                                    <div
                                        class="flex h-10 w-10 items-center justify-center rounded-xl {{ $flow['bg'] }} text-white text-sm font-bold shadow">

                                        {{ $index + 1 }}

                                    </div>

                                    <span class="text-[11px] font-medium text-gray-400 dark:text-gray-500">

                                        Step {{ $index + 1 }}

                                    </span>

                                </div>

                                {{-- CONTENT --}}
                                <div class="mt-3">

                                    <div class="flex items-center gap-2">
                                        <span class="text-lg">{{ $flow['icon'] }}</span>

                                        <h3 class="text-sm font-semibold text-gray-800 dark:text-white">
                                            {{ $flow['title'] }}
                                        </h3>
                                    </div>

                                    <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
                                        {{ $flow['desc'] }}
                                    </p>

                                </div>

                            </div>
                        </div>
                    @endforeach

                </div>
            </div>

        </div>

        {{-- RECENT ACTIVITIES --}}
        <div class="grid grid-cols-1 gap-6 xl:grid-cols-2">

            {{-- TRANSACTION TABLE --}}
            <div
                class="overflow-hidden rounded-3xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-white/[0.03]">

                {{-- HEADER --}}
                <div class="flex items-center justify-between border-b border-gray-100 px-6 py-5 dark:border-gray-800">

                    <div>

                        <h2 class="text-xl font-bold text-gray-800 dark:text-white">
                            Transaksi Terbaru
                        </h2>

                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                            Aktivitas transaksi terbaru pengguna sistem.
                        </p>

                    </div>


                    {{-- button lihat lainnya --}}
                    <a href="{{ route('bendahara.reports.transactions.index') }}"
                        class="text-sm text-blue-500 hover:underline">
                        Lihat Semua
                    </a>

                </div>

                {{-- TABLE --}}
                <div class="overflow-x-auto">

                    <table class="min-w-full">

                        <thead class="border-b border-gray-100 bg-gray-50 dark:border-gray-800 dark:bg-white/[0.02]">

                            <tr>

                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                                    Transaksi
                                </th>

                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                                    Tanggal
                                </th>

                                <th
                                    class="px-6 py-4 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                                    Nominal
                                </th>

                            </tr>

                        </thead>

                        <tbody class="divide-y divide-gray-100 dark:divide-gray-800">

                            @forelse ($recentTransactions ?? [] as $transaction)
                                <tr class="transition hover:bg-gray-50 dark:hover:bg-white/[0.02]">

                                    {{-- TRANSACTION --}}
                                    <td class="px-6 py-5">

                                        <div class="flex items-start gap-4">

                                            <div
                                                class="flex h-11 w-11 items-center justify-center rounded-2xl bg-blue-100 text-brand-600 dark:bg-brand-500/10 dark:text-brand-400">

                                                💳

                                            </div>

                                            <div>

                                                <p class="font-semibold text-gray-800 dark:text-white">

                                                    {{ $transaction->description }}

                                                </p>

                                                <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">

                                                    Input oleh:
                                                    {{ $transaction->creator->name ?? '-' }}

                                                </p>

                                            </div>

                                        </div>

                                    </td>

                                    {{-- DATE --}}
                                    <td class="px-6 py-5 text-sm text-gray-500 dark:text-gray-400">

                                        {{ $transaction->transaction_date->format('d M Y') }}

                                    </td>

                                    {{-- AMOUNT --}}
                                    <td class="px-6 py-5 text-right">

                                        <p class="font-bold text-gray-800 dark:text-white">

                                            Rp {{ number_format($transaction->gross_amount, 0, ',', '.') }}

                                        </p>

                                        <span
                                            class="mt-2 inline-flex rounded-full px-3 py-1 text-xs font-medium
                                {{ $transaction->transaction_type === $transferType
                                    ? 'bg-green-100 text-green-700 dark:bg-green-500/10 dark:text-green-400'
                                    : 'bg-yellow-100 text-yellow-700 dark:bg-yellow-500/10 dark:text-yellow-400' }}">

                                            {{ $transaction->transaction_type }}

                                        </span>

                                    </td>

                                </tr>

                            @empty

                                <tr>

                                    <td colspan="3"
                                        class="px-6 py-10 text-center text-sm text-gray-500 dark:text-gray-400">

                                        Belum ada transaksi terbaru.

                                    </td>

                                </tr>
                            @endforelse

                        </tbody>

                    </table>

                </div>

            </div>

            {{-- JOURNAL TABLE --}}
            <div
                class="overflow-hidden rounded-3xl border border-gray-200 bg-white shadow-sm dark:border-gray-800 dark:bg-white/[0.03]">

                {{-- HEADER --}}
                <div class="flex items-center justify-between border-b border-gray-100 px-6 py-5 dark:border-gray-800">

                    <div>

                        <h2 class="text-xl font-bold text-gray-800 dark:text-white">
                            Jurnal Terbaru
                        </h2>

                        <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                            Daftar jurnal yang berhasil diposting.
                        </p>

                    </div>

                    {{-- button lihat lainnya --}}
                    <a href="{{ route('bendahara.reports.journal.index') }}"
                        class="text-sm text-blue-500 hover:underline">
                        Lihat Semua
                    </a>

                </div>

                {{-- TABLE --}}
                <div class="overflow-x-auto">

                    <table class="min-w-full">

                        <thead class="border-b border-gray-100 bg-gray-50 dark:border-gray-800 dark:bg-white/[0.02]">

                            <tr>

                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                                    Jurnal
                                </th>

                                <th
                                    class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                                    Tanggal
                                </th>

                                <th
                                    class="px-6 py-4 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                                    Status
                                </th>

                            </tr>

                        </thead>

                        <tbody class="divide-y divide-gray-100 dark:divide-gray-800">

                            @forelse ($recentJournals ?? [] as $journal)
                                <tr class="transition hover:bg-gray-50 dark:hover:bg-white/[0.02]">

                                    {{-- JOURNAL --}}
                                    <td class="px-6 py-5">

                                        <div class="flex items-start gap-4">

                                            <div
                                                class="flex h-11 w-11 items-center justify-center rounded-2xl bg-indigo-100 text-indigo-600 dark:bg-indigo-500/10 dark:text-indigo-400">

                                                📘

                                            </div>

                                            <div>

                                                <p class="font-semibold text-gray-800 dark:text-white">

                                                    {{ $journal->journal_number }}

                                                </p>

                                                <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">

                                                    Dibuat oleh:
                                                    {{ $journal->postedBy->name ?? '-' }}

                                                </p>

                                            </div>

                                        </div>

                                    </td>

                                    {{-- DATE --}}
                                    <td class="px-6 py-5 text-sm text-gray-500 dark:text-gray-400">

                                        {{ $journal->created_at->format('d M Y H:i') }}

                                    </td>

                                    {{-- STATUS --}}
                                    <td class="px-6 py-5 text-right">

                                        <span
                                            class="inline-flex rounded-full bg-blue-100 px-3 py-1 text-xs font-medium text-blue-700 dark:bg-blue-500/10 dark:text-blue-400">

                                            Posted

                                        </span>

                                    </td>

                                </tr>

                            @empty

                                <tr>

                                    <td colspan="3"
                                        class="px-6 py-10 text-center text-sm text-gray-500 dark:text-gray-400">

                                        Belum ada jurnal terbaru.

                                    </td>

                                </tr>
                            @endforelse

                        </tbody>

                    </table>

                </div>
            </div>
        </div>
    </div>

    {{-- CLOCK SCRIPT --}}
    @push('scripts')
        <script>
            function countdown(endDate) {

                return {

                    timer: '',

                    start() {

                        this.update();

                        setInterval(() => {

                            this.update();

                        }, 1000);

                    },

                    update() {

                        const end = new Date(endDate);

                        const now = new Date();

                        let diff = end - now;

                        let passed = false;

                        if (diff < 0) {

                            passed = true;

                            diff = Math.abs(diff);

                        }

                        const days = Math.floor(diff / (1000 * 60 * 60 * 24));

                        const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));

                        const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));

                        const seconds = Math.floor((diff % (1000 * 60)) / 1000);

                        this.timer =
                            (passed ? '+' : '') +
                            `${days} Hari ${hours} Jam ${minutes} Menit ${seconds} Detik`;

                    }

                }

            };

            function updateClock() {
                const now = new Date();

                const time = now.toLocaleTimeString('id-ID');
                const date = now.toLocaleDateString('id-ID', {
                    weekday: 'long',
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                });

                document.getElementById('clock').innerHTML = time;
                document.getElementById('date-now').innerHTML = date;
            }

            setInterval(updateClock, 1000);
            updateClock();
        </script>
    @endpush
@endsection
