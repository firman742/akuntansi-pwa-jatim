@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Dashboard Bendahara" />

    <div class="space-y-6">

        {{-- Welcome Section --}}
        <div class="bg-white rounded-2xl shadow-sm p-6 border">
            <div class="flex justify-between items-center">
                <div>
                    <h1 class="text-2xl font-bold text-gray-800">
                        Selamat <span id="greeting"></span>,
                        {{ auth()->user()->name }} 👋
                    </h1>
                    <p class="text-gray-500 mt-2">
                        Selamat datang di sistem manajemen keuangan.
                        Pastikan seluruh transaksi tercatat dengan benar.
                    </p>
                </div>

                <div class="text-right">
                    <div id="date" class="text-gray-500"></div>
                    <div id="clock" class="text-3xl font-bold text-primary"></div>
                </div>
            </div>
        </div>

        {{-- Summary Cards --}}
        {{-- TODO: harapannya mendapatkan data realtime bukan sekedar hardcode --}}
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <div class="bg-white p-5 rounded-xl shadow-sm border">
                <p class="text-gray-500">Saldo Seluruh Kas Periode Sekarang</p>
                <h2 class="text-2xl font-bold">Rp 25.000.000</h2>
            </div>

            <div class="bg-white p-5 rounded-xl shadow-sm border">
                <p class="text-gray-500">Pemasukan Bulan Ini</p>
                <h2 class="text-2xl font-bold text-green-600">Rp 10.000.000</h2>
            </div>

            <div class="bg-white p-5 rounded-xl shadow-sm border">
                <p class="text-gray-500">Pengeluaran Bulan Ini</p>
                <h2 class="text-2xl font-bold text-red-600">Rp 6.500.000</h2>
            </div>

            <div class="bg-white p-5 rounded-xl shadow-sm border">
                <p class="text-gray-500">Saldo Bersih</p>
                <h2 class="text-2xl font-bold text-blue-500">Rp 3.500.000</h2>
            </div>
        </div>

        {{-- Accounting Flow Section --}}
        <div class="bg-white rounded-2xl shadow-sm p-6 border">
            <div class="mb-6">
                <h2 class="text-xl font-semibold text-gray-800">
                    Alur Sistem Akuntansi
                </h2>
                <p class="text-gray-500 mt-2">
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
                            Pengguna ATC dan Pengguna KLL mencatat transaksi berdasarkan akun
                            yang telah tersedia pada COA dengan status Draft atau Submitted.
                        </p>
                    </div>
                </div>

                {{-- Step 4 --}}
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-purple-50">
                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-blue-500 text-white font-bold">
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
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-indigo-50">
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
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-pink-50">
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
                <div class="flex items-start gap-4 p-4 rounded-xl border bg-orange-50">
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
            <div class="bg-white rounded-2xl shadow-sm p-6 border">
                <div class="flex items-center justify-between mb-4">
                    <h2 class="text-lg font-semibold text-gray-800">
                        Transaksi Terbaru
                    </h2>

                    <a href="" class="text-sm text-blue-500 hover:underline">
                        Lihat Semua
                    </a>
                </div>

                <div class="space-y-4">

                    @forelse ($recentTransactions ?? [] as $transaction)
                        <div class="flex items-start justify-between border-b pb-3">
                            <div>
                                <p class="font-medium text-gray-800">
                                    {{ $transaction->description }}
                                </p>

                                <p class="text-sm text-gray-500 mt-1">
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
                        <p class="text-gray-500 text-sm">
                            Belum ada transaksi terbaru.
                        </p>
                    @endforelse

                </div>
            </div>

            {{-- Jurnal Terbaru --}}
            <div class="bg-white rounded-2xl shadow-sm p-6 border">
                <div class="flex items-center justify-between mb-4">
                    <h2 class="text-lg font-semibold text-gray-800">
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
                                <p class="font-medium text-gray-800">
                                    {{ $journal->journal_number }}
                                </p>

                                <p class="text-sm text-gray-500 mt-1">
                                    {{ $journal->created_at->format('d M Y H:i') }}
                                </p>

                                <p class="text-xs text-gray-400 mt-1">
                                    Dibuat oleh:
                                    {{ $journal->postedBy->name ?? '-' }}
                                </p>
                            </div>

                            <div class="text-right">
                                @php
                                    $total_amount = $total_debit ?? $total_credit ?? 0;
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
                        <p class="text-gray-500 text-sm">
                            Belum ada jurnal terbaru.
                        </p>
                    @endforelse

                </div>
            </div>

        </div>
    </div>

    {{-- Script Jam --}}
    <script>
        function updateClock() {
            const now = new Date();

            document.getElementById('clock').innerHTML =
                now.toLocaleTimeString('id-ID');

            document.getElementById('date').innerHTML =
                now.toLocaleDateString('id-ID', {
                    weekday: 'long',
                    day: 'numeric',
                    month: 'long',
                    year: 'numeric'
                });

            const hour = now.getHours();
            let greeting = 'Pagi';

            if (hour >= 12 && hour < 15) greeting = 'Siang';
            else if (hour >= 15 && hour < 18) greeting = 'Sore';
            else if (hour >= 18) greeting = 'Malam';

            document.getElementById('greeting').innerHTML = greeting;
        }

        setInterval(updateClock, 1000);
        updateClock();
    </script>
@endsection
