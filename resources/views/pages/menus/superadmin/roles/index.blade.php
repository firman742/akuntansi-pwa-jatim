@extends('layouts.app')

@section('title', 'Manajemen Peran Dan Izin')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Peran Dan izin" pageTitle="Manajemen Peran Dan izin"
        pageDescription="Monitoring dan kelola Peran Dan izin yang terdaftar di sistem" pageIcon="roles" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif
    
    <div class="space-y-6">
        <x-core.basic-tables.core-table>

            <x-core.basic-tables.superadmin.role-table :roles="$roles" />

        </x-core.basic-tables.core-table>
    </div>
@endsection
