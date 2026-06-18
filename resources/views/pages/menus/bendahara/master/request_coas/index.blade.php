@extends('layouts.app')

@section('title', 'Daftar Pengajuan COA')

@section('content')
    <x-common.page-breadcrumb pageTitle="Daftar Pengajuan COA" />

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
                        <li class="text-danger-500">{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    <div class="space-y-6">
        <x-core.basic-tables.core-table title="Daftar Pengajuan COA" description="Berikut adalah daftar pengajuan coa yang tersedia.">

            <x-core.basic-tables.bendahara.request-coa-table :requests="$requests" />
        </x-core.basic-tables.core-table>
    </div>
@endsection
