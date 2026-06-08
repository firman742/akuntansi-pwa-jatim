@extends('layouts.app')

@section('title', 'Daftar Pengajuan Penambahan Dana')

@section('content')
    <x-common.page-breadcrumb pageTitle="Daftar Pengajuan Penambahan Dana" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan" >
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    {{-- TABLE --}}
    <div class="space-y-6">
        <x-core.basic-tables.core-table title="Daftar Pengajuan Penambahan Dana" description="Daftar seluruh permintaan penambahan dana yang diajukan oleh pengguna.">
            {{-- TABLE COMPONENT LU --}}
            <x-core.basic-tables.bendahara.request-balance-table :requests="$requests" />

        </x-core.basic-tables.core-table>
    </div>
@endsection
