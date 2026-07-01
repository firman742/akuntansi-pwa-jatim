@extends('layouts.app')

@section('title', 'Daftar Pengajuan COA')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Pengajuan Akun COA" pageTitle="Daftar Pengajuan akun COA"
        pageDescription="Monitoring dan kelola pengajuan akun COA yang terdaftar di sistem" pageIcon="request" />

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

    {{-- TABLE --}}
    <div class="space-y-6">
        <x-core.basic-tables.core-table>
            <x-slot name="actions">
                <a href="{{ route('user.requests.coas.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Ajukan COA Baru
                    </x-ui.button>
                </a>
            </x-slot>

            {{-- TABLE COMPONENT LU --}}
            <x-core.basic-tables.user.request-coa-table :requests="$requests" />

        </x-core.basic-tables.core-table>
    </div>
@endsection
