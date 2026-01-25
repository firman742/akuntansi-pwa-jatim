@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Manajemen Pengguna" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif
    
    <div class="space-y-6">
        <x-core.basic-tables.superadmin.user-table :users="$users" />
    </div>
@endsection
