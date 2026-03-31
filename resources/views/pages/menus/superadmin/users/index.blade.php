@extends('layouts.app')

@section('title', 'Manajemen Pengguna')

@section('content')
    <x-common.page-breadcrumb pageTitle="Manajemen Pengguna" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif
    
    <div class="space-y-6">

        <x-core.basic-tables.core-table title="Daftar Pengguna" description="Berikut adalah daftar pengguna yang terdaftar di sistem.">
            <x-slot name="actions">
                <a href="{{ route('superadmin.users.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Tambah Pengguna
                    </x-ui.button>
                </a>
            </x-slot>
            <x-core.basic-tables.superadmin.user-table :users="$users" />
        </x-core.basic-tables.core-table>
    </div>
@endsection
