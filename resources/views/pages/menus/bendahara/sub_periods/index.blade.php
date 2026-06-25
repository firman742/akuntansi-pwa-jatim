@extends('layouts.app')

@section('title', 'Sub Periode')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Sub Periode" pageTitle="Manajemen Sub Periode"
        pageDescription="Monitoring dan kelola Sub Periode yang terdaftar di sistem" pageIcon="calendar" />

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

    {{-- Info --}}
    <div class="mb-6">
        <x-ui.alert variant="info" title="Aturan Pengelolaan Sub Periode" :dismissible="false">
            <ul class="list-disc pl-5 space-y-1 text-sm text-blue-500">
                <li>Sub periode dapat diubah atau dihapus hanya jika belum memiliki transaksi.</li>
                <li>Sub periode tidak dapat diubah atau dihapus setelah tanggal berakhir terlewati.</li>
                <li>Sub periode yang sudah memiliki transaksi dianggap terkunci untuk menjaga konsistensi data keuangan.
                </li>
            </ul>
        </x-ui.alert>
    </div>

    <div class="space-y-6">
        <x-core.basic-tables.core-table needFilter>
            {{-- SLOT search --}}
            <x-slot name="search">
                <x-form.input id="searchId" name="search" value="{{ request('search') }}"
                    placeholder="Cari berdasarkan Akun atau kode COA..." startIconSearch endIconSearch />
            </x-slot>
        
            {{-- SLOT FILTER --}}
            <x-slot name="filters">
                <x-form.select 
                    id="filter_period" 
                    name="period_id" 
                    label="Periode" 
                    placeholder="Pilih Periode">
                    @foreach ($periods as $period)
                        <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                            {{ $period->name }}
                        </option>
                    @endforeach
                </x-form.select>
            </x-slot>

            {{-- SLOT Actions --}}
            <x-slot name="actions">
                <a href="{{ route('bendahara.sub-periods.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Tambah Sub Periode
                    </x-ui.button>
                </a>
            </x-slot>

            <x-core.basic-tables.bendahara.sub-period-table :sub_periods="$sub_periods" :periods="$periods" />
        </x-core.basic-tables.core-table>
    </div>

    {{-- SCRIPT --}}
    <script>
        const searchInput = document.getElementById('searchId');
        let timeout = null;

        searchInput.addEventListener('input', function () {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                const searchValue = this.value;
                const urlParams = new URLSearchParams(window.location.search);

                if (searchValue) {
                    urlParams.set('search', searchValue);
                } else {
                    urlParams.delete('search');
                }

                window.location.search = urlParams.toString();
            }, 500);
        });
    </script>
@endsection
