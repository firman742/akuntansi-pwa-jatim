@extends('layouts.app')

@section('title', 'Daftar Pengajuan COA')

@section('content')
    <x-common.page-breadcrumb pageTitle="Daftar Pengajuan COA" />

    {{-- TABLE --}}
    <div class="space-y-6">
        <x-core.basic-tables.core-table title="Daftar Pengajuan COA" description="Daftar seluruh coa yang diajukan oleh pengguna.">
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
