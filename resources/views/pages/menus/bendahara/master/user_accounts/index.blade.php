@extends('layouts.app')

@section('title', 'Master Data - Pengguna COA')

@section('content')
    <x-common.page-breadcrumb pageTitle="Master Data - Pengguna COA" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    <div class="space-y-6">
        <x-core.basic-tables.core-table title="Daftar Pengguna COA" description="Berikut adalah daftar pengguna COA yang tersedia.">
            <x-slot name="actions">
               
            </x-slot>

            <x-core.basic-tables.bendahara.user-account-table :users="$users" />
        </x-core.basic-tables.core-table>
    </div>
@endsection
