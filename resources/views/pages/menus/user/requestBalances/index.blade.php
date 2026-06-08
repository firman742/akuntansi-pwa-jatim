@extends('layouts.app')

@section('title', 'Daftar Pengajuan Penambahan Dana')

@section('content')
    <x-common.page-breadcrumb pageTitle="Daftar Pengajuan Penambahan Dana" />

    {{-- TABLE --}}
    <div class="space-y-6">
        <x-core.basic-tables.core-table title="Daftar Pengajuan Penambahan Dana" description="Daftar seluruh permintaan penambahan dana yang diajukan oleh pengguna.">
            <x-slot name="actions">

                <a href="{{ route('user.requests.balances.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Ajukan Dana Baru
                    </x-ui.button>
                </a>
            </x-slot>

            {{-- TABLE COMPONENT LU --}}
            <x-core.basic-tables.user.request-balance-table :requests="$requests" />

        </x-core.basic-tables.core-table>
    </div>
@endsection
