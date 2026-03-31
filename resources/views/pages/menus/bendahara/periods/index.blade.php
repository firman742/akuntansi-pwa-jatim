@extends('layouts.app')

@section('title', 'Periode')

@section('content')
    <x-common.page-breadcrumb pageTitle="Period" />

    <div class="space-y-6">
        <x-core.basic-tables.core-table title="Daftar Periode" description="Berikut adalah daftar periode yang tersedia.">
            <x-slot name="actions">
                <a href="{{ route('bendahara.periods.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Tambah Periode
                    </x-ui.button>
                </a>
            </x-slot>

            {{-- Table Component UI --}}
            <x-core.basic-tables.bendahara.period-table :periods="$periods" />
        </x-core.basic-tables.core-table>
    </div>
@endsection
