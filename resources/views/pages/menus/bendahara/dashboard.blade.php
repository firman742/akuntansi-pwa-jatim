@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Dashboard Bendahara" />

    <div class="space-y-6">
        {{-- GREETING --}}
        <div
            class="overflow-hidden rounded-3xl border border-gray-200 bg-gradient-to-r bg-blue-500 p-6 text-white shadow-lg dark:border-gray-800">

            <div class="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">

                <div>
                    <h1 class="mt-2 text-2xl font-bold">
                        Selamat Datang, {{ auth()->user()->name }}👋
                    </h1>
                    <p class="mt-1 text-sm text-white/70">
                        Selamat datang di sistem manajemen keuangan.
                        Pastikan seluruh transaksi tercatat dengan benar.
                    </p>
                </div>

                {{-- CLOCK --}}
                <div class="rounded-2xl text-center border border-white/20 bg-white/10 px-3 py-2 backdrop-blur-sm">

                    <h2 id="clock" class="mt-2 text-4xl font-bold tracking-wider">
                        00:00:00
                    </h2>

                    <p class="mt-1 text-sm text-white/70">
                        <span id="date-now"></span>
                    </p>
                </div>
            </div>
        </div>

        {{-- FILTER --}}
        <form method="GET">
            <div
                class="flex flex-col gap-4 rounded-2xl border shadow-lg border-gray-200 bg-white p-5 dark:border-gray-800 dark:bg-white/[0.03] xl:flex-row xl:items-center xl:justify-between">

                <div>
                    <h2 class="text-2xl font-bold text-gray-800 dark:text-white/90">
                        Dashboard Bendahara Akuntansi
                    </h2>

                    <p class="mt-1 text-sm text-gray-500 dark:text-white-90">
                        Monitor aktivitas akuntansi secara realtime.
                    </p>
                </div>

                <div class="flex flex-col gap-3 sm:flex-row">
                    <select name="sub_period_id" onchange="this.form.submit()"
                        class="h-11 rounded-xl border border-gray-300 bg-white px-4 text-sm text-gray-700 shadow-theme-xs outline-none focus:border-brand-500 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-400">
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


                {{-- <div>
                  <p class="text-sm text-gray-500 dark:text-white-90">
                      Period Aktif:
                      <span class="font-semibold text-gray-700">
                          {{ $activePeriod?->name ?? '-' }}
                      </span>
                  </p>
              </div> --}}
            </div>
        </form>

        {{-- Summary Cards --}}
        {{-- TODO: harapannya mendapatkan data realtime bukan sekedar hardcode --}}
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <div class="bg-white p-5 rounded-xl shadow-lg border dark:bg-white/[0.03] dark:text-white-90 dark:border-gray-800">
                <p class="text-gray-500 dark:text-white-90">Saldo Seluruh Kas Periode Sekarang</p>
                <h2 class="text-2xl font-bold">
                    Rp {{ number_format($totalCashBalance, 0, ',', '.') }}
                </h2>
            </div>

            <div class="bg-white p-5 rounded-xl shadow-lg border dark:bg-white/[0.03] dark:text-white-90 dark:border-gray-800">
                <p class="text-gray-500 dark:text-white-90">Pemasukan Bulan Ini</p>
                <h2 class="text-2xl font-bold text-green-600">
                    Rp {{ number_format($totalIncome, 0, ',', '.') }}
                </h2>
            </div>

            <div class="bg-white p-5 rounded-xl shadow-lg border dark:bg-white/[0.03] dark:text-white-90 dark:border-gray-800">
                <p class="text-gray-500 dark:text-white-90">Pengeluaran Bulan Ini</p>
                <h2 class="text-2xl font-bold text-red-600">
                    Rp {{ number_format($totalExpense, 0, ',', '.') }}
                </h2>
            </div>

            <div class="bg-white p-5 rounded-xl shadow-lg border dark:bg-white/[0.03] dark:text-white-90 dark:border-gray-800">
                <p class="text-gray-500 dark:text-white-90">Saldo Bersih</p>
                <h2 class="text-2xl font-bold text-blue-500">
                    Rp {{ number_format($netBalance, 0, ',', '.') }}
                </h2>
            </div>
        </div>

        {{-- Accounting Flow Section --}}
        <div class="bg-white rounded-2xl shadow-lg p-6 border dark:bg-white/[0.03] dark:text-white-90 dark:border-gray-800">
            <div class="mb-6">
                <h2 class="text-xl font-semibold text-gray-800 dark:text-white">
                    Alur Sistem Akuntansi
                </h2>
                <p class="text-gray-500 dark:text-white-90 mt-2">
                    Berikut adalah alur utama penggunaan sistem akuntansi berdasarkan
                    pembagian tugas dan proses pencatatan transaksi.
                </p>
            </div>

            <div class="space-y-4">

                {{-- Step 1 --}}
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-blue-50">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-blue-500 text-white font-bold">
                        1
                    </div>
                    <div>
                        <h3 class="font-semibold">Setup Awal Sistem</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Superadmin membuat akun pengguna (Bendahara, Pengguna Umum),
                            mengatur hak akses menu, batasan akun per role,
                            dan mengaktifkan modul akuntansi.
                        </p>
                    </div>
                </div>

                {{-- Step 2 --}}
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-green-50">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-blue-500 text-white font-bold">
                        2
                    </div>
                    <div>
                        <h3 class="font-semibold">Setup Chart of Accounts (COA)</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Bendahara membuat akun-akun akuntansi seperti Kas, Bank,
                            Pendapatan, Beban, Piutang, dan Hutang sebagai fondasi pencatatan.
                        </p>
                    </div>
                </div>

                {{-- Step 3 --}}
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-yellow-50">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-blue-500 text-white font-bold">
                        3
                    </div>
                    <div>
                        <h3 class="font-semibold">Pencatatan Transaksi</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Pengguna umum mencatat transaksi berdasarkan akun
                            yang telah tersedia pada COA dengan status Draft atau Submitted.
                        </p>
                    </div>
                </div>

                {{-- Step 4 --}}
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-red-50">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-blue-500 dark text-white font-bold">
                        4
                    </div>
                    <div>
                        <h3 class="font-semibold">Validasi Transaksi</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Sistem memvalidasi keseimbangan transaksi
                            (Debit = Kredit), status akun aktif,
                            dan memastikan periode masih terbuka.
                        </p>
                    </div>
                </div>

                {{-- Step 5 --}}
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-blue-50">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-blue-500 text-white font-bold">
                        5
                    </div>
                    <div>
                        <h3 class="font-semibold">Posting ke Jurnal Umum</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Setelah valid, transaksi diposting ke jurnal umum
                            secara otomatis oleh sistem.
                        </p>
                    </div>
                </div>

                {{-- Step 6 --}}
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-green-50">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-blue-500 text-white font-bold">
                        6
                    </div>
                    <div>
                        <h3 class="font-semibold">Pembentukan Buku Besar</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Sistem mengelompokkan jurnal berdasarkan akun
                            dan menghitung saldo awal, mutasi, dan saldo akhir.
                        </p>
                    </div>
                </div>

                {{-- Step 7 --}}
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-yellow-50">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-blue-500 text-white font-bold">
                        7
                    </div>
                    <div>
                        <h3 class="font-semibold">Neraca Saldo</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Sistem menghasilkan neraca saldo per periode
                            untuk memastikan total debit dan kredit tetap seimbang.
                        </p>
                    </div>
                </div>

                {{-- Step 8 --}}
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-red-50">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-blue-500 text-white font-bold">
                        8
                    </div>
                    <div>
                        <h3 class="font-semibold">Penutupan Periode</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Bendahara menutup periode akuntansi untuk mengunci data
                            dan membuka periode baru.
                        </p>
                    </div>
                </div>

            </div>
        </div>

        {{-- Recent Activities --}}
        <div class="grid lg:grid-cols-2 gap-6">

            {{-- Transaksi Terbaru --}}
            <div class="bg-white rounded-2xl shadow-lg p-6 border dark:bg-white/[0.03] dark:text-white-90 dark:border-gray-800">
                <div class="flex items-center justify-between mb-4">
                    <h2 class="text-lg font-semibold text-gray-800 dark:text-white">
                        Transaksi Terbaru
                    </h2>

                    {{-- TODO: Belum ada halaman getall transactionnya --}}
                    {{-- <a href="" class="text-sm text-blue-500 hover:underline">
                        Lihat Semua
                    </a> --}}
                </div>

                <div class="space-y-4">

                    @forelse ($recentTransactions ?? [] as $transaction)
                        <div class="flex items-start justify-between border-b pb-3">
                            <div>
                                <p class="font-medium text-gray-800 dark:text-white">
                                    {{ $transaction->description }}
                                </p>

                                <p class="text-sm text-gray-500 dark:text-white-90 mt-1">
                                    {{ $transaction->transaction_date->format('d M Y') }}
                                </p>

                                <p class="text-xs text-gray-400 mt-1">
                                    Input oleh:
                                    {{ $transaction->creator->name ?? '-' }}
                                </p>
                            </div>

                            <div class="text-right">
                                <p class="font-semibold">
                                    Rp {{ number_format($transaction->gross_amount, 0, ',', '.') }}
                                </p>

                                <span
                                    class="text-xs px-2 py-1 rounded-full
                            {{ $transaction->transaction_type === $transferType ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700' }}">
                                    {{ $transaction->transaction_type }}
                                </span>
                            </div>
                        </div>
                    @empty
                        <p class="text-gray-500 dark:text-white-90 text-sm">
                            Belum ada transaksi terbaru.
                        </p>
                    @endforelse

                </div>
            </div>

            {{-- Jurnal Terbaru --}}
            <div class="bg-white rounded-2xl shadow-lg p-6 border dark:bg-white/[0.03] dark:text-white-90 dark:border-gray-800">
                <div class="flex items-center justify-between mb-4">
                    <h2 class="text-lg font-semibold text-gray-800 dark:text-white">
                        Jurnal Terbaru
                    </h2>

                    <a href="{{ route('bendahara.reports.journal.index') }}" class="text-sm text-blue-500 hover:underline">
                        Lihat Semua
                    </a>
                </div>

                <div class="space-y-4">

                    @forelse ($recentJournals ?? [] as $journal)
                        <div class="flex items-start justify-between border-b pb-3">
                            <div>
                                <p class="font-medium text-gray-800 dark:text-white">
                                    {{ $journal->journal_number }}
                                </p>

                                <p class="text-sm text-gray-500 dark:text-white-90 mt-1">
                                    {{ $journal->created_at->format('d M Y H:i') }}
                                </p>

                                <p class="text-xs text-gray-400 mt-1">
                                    Dibuat oleh:
                                    {{ $journal->postedBy->name ?? '-' }}
                                </p>
                            </div>

                            <div class="text-right">
                                @php
                                    $total_amount = $total_debit ?? ($total_credit ?? 0);
                                @endphp
                                <p class="font-semibold">
                                    Rp {{ number_format($total_amount, 0, ',', '.') }}
                                </p>

                                <span class="text-xs px-2 py-1 rounded-full bg-blue-100 text-blue-700">
                                    Posted
                                </span>
                            </div>
                        </div>
                    @empty
                        <p class="text-gray-500 dark:text-white-90 text-sm">
                            Belum ada jurnal terbaru.
                        </p>
                    @endforelse

                </div>
            </div>

        </div>
    </div>

    {{-- CLOCK SCRIPT --}}
    @push('scripts')
        <script>
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
