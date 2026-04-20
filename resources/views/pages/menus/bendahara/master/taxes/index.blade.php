@extends('layouts.app')

@section('title', 'Manajemen Pajak')

@section('content')
    <x-common.page-breadcrumb pageTitle="Manajemen Pajak" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    <div class="space-y-6">

        {{-- ================= CARD INFORMASI & INSTRUKSI ================= --}}
        <x-common.component-card title="Informasi & Instruksi">
            <div class="text-sm text-gray-600 space-y-3">

                <p>
                    Halaman ini digunakan untuk mengelola daftar pajak yang akan digunakan dalam transaksi keuangan.
                    Pajak yang dibuat akan membantu sistem menghitung potongan secara otomatis dan mencatat ke jurnal sesuai akun yang dipilih.
                </p>

                <div>
                    <p class="font-medium">Cara Penggunaan:</p>
                    <ul class="list-disc list-inside mt-1 space-y-1">
                        <li>Buat pajak terlebih dahulu jika sering digunakan (contoh: PPN 11%)</li>
                        <li>Pilih pajak saat melakukan transaksi untuk perhitungan otomatis</li>
                        <li>Anda juga dapat menginput pajak langsung saat transaksi tanpa membuat di sini</li>
                    </ul>
                </div>

                <div>
                    <p class="font-medium">Keterangan Akun:</p>
                    <ul class="list-disc list-inside mt-1 space-y-1">
                        <li><span class="font-medium">Pajak Dibayar Dimuka</span>: pajak yang sudah dibayar terlebih dahulu (aset)</li>
                        <li><span class="font-medium">Hutang Pajak</span>: pajak yang belum dibayar (kewajiban)</li>
                        <li><span class="font-medium">Beban Pajak</span>: pajak yang langsung dicatat sebagai biaya</li>
                    </ul>
                </div>

                <p class="text-xs text-gray-500">
                    Catatan: Pastikan akun (COA) yang dipilih sudah sesuai agar pencatatan jurnal otomatis berjalan dengan benar.
                </p>

            </div>
        </x-common.component-card>


        {{-- ================= CARD TABLE ================= --}}
        <x-core.basic-tables.core-table 
            title="Daftar Pajak" 
            description="Berikut adalah daftar pajak yang tersedia dan dapat digunakan saat transaksi."
        >
            <x-slot name="actions">
                <a href="{{ route('bendahara.master.taxes.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Tambah Pajak
                    </x-ui.button>
                </a>
            </x-slot>

            <x-core.basic-tables.bendahara.taxes-table :taxes="$taxes" />
        </x-core.basic-tables.core-table>
    </div>
@endsection