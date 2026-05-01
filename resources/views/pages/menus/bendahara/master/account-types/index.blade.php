@extends('layouts.app')

@section('title', 'Manajemen Tipe Akun')

@section('content')
    <x-common.page-breadcrumb pageTitle="Manajemen Tipe Akun" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

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

    <div class="space-y-6">
        <x-core.basic-tables.core-table title="Daftar Tipe Akun" description="Berikut adalah daftar tipe akun yang tersedia.">
            <x-slot name="actions">
                <a href="{{ route('bendahara.master.account-types.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Tambah Tipe Akun
                    </x-ui.button>
                </a>
            </x-slot>

            <x-core.basic-tables.bendahara.account-type-table :accountTypes="$accountTypes" />
        </x-core.basic-tables.core-table>
    </div>
@endsection
