@extends('layouts.app')

@section('title', 'Manajemen Bunga')

@section('content')
    <x-common.page-breadcrumb pageTitle="Manajemen Bunga" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    <div class="space-y-6">

        {{-- ================= CARD INFORMASI & INSTRUKSI ================= --}}
        <x-common.component-card title="Informasi & Instruksi">
            <div class="text-sm text-gray-600 space-y-3">
                
            </div>
        </x-common.component-card>


        {{-- ================= CARD TABLE ================= --}}
        <x-core.basic-tables.core-table 
            title="Daftar Bunga" 
            description="Berikut adalah daftar bunga yang tersedia dan dapat digunakan saat transaksi."
        >
            <x-slot name="actions">
                <a href="{{ route('bendahara.master.interests.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Tambah Bunga
                    </x-ui.button>
                </a>
            </x-slot>

            <x-core.basic-tables.bendahara.interest-table :interests="$interests" />
        </x-core.basic-tables.core-table>
    </div>
@endsection