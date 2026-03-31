@extends('layouts.app')

@section('title', 'Manajemen Peran Dan Izin')

@section('content')
    <x-common.page-breadcrumb pageTitle="Manajemen Peran Dan izin" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif
    
    <div class="space-y-6">
        <x-core.basic-tables.core-table title="Daftar Peran" description="Berikut daftar peran dan izin">
            <x-slot name="actions">
                {{-- <a href="{{ route('superadmin.roles.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Tambah Perizinan
                    </x-ui.button>
                </a> --}}
            </x-slot>

            <x-core.basic-tables.superadmin.role-table :roles="$roles" />

        </x-core.basic-tables.core-table>
    </div>
@endsection
