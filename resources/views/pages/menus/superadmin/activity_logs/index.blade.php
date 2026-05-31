@extends('layouts.app')

@section('title', 'Manajemen Log Aktivitas')

@section('content')
    <x-common.page-breadcrumb pageTitle="Manajemen Log Aktifitas" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif
    
    <div class="space-y-6">

        <x-core.basic-tables.core-table title="Daftar Aktifitas" description="Berikut adalah daftar segala aktifitas yang terjadi di sistem.">
            
            <x-core.basic-tables.superadmin.log-activity-table :activityLogs="$activityLogs" />
        </x-core.basic-tables.core-table>
    </div>
@endsection
