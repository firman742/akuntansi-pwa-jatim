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
        <x-ui.alert variant="info" title="Aturan Pengelolaan Sub Periode">
            <ul class="list-disc pl-5 space-y-1 text-sm text-blue-500">
                <li>Sub periode dapat diubah atau dihapus hanya jika belum memiliki transaksi.</li>
                <li>Sub periode tidak dapat diubah atau dihapus setelah tanggal berakhir terlewati.</li>
                <li>Sub periode yang sudah memiliki transaksi dianggap terkunci untuk menjaga konsistensi data keuangan.
                </li>
            </ul>
        </x-ui.alert>
    </div>

    <div class="space-y-6">
        {{-- FILTER ACCORDION DINAMIS --}}
        <x-common.filter-accordion 
            title="Filter & Pencarian Sub Periode" 
            :action="route('bendahara.sub-periods.index')" 
            :resetUrl="route('bendahara.sub-periods.index')"
            :filterKeys="['search', 'period_id']"
        >
            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                {{-- BARIS 1: SEARCH BAR --}}
                <div class="sm:col-span-2">
                    <x-form.input id="search" name="search" value="{{ request('search') }}"
                        placeholder="Cari berdasarkan nama atau deskripsi sub-periode..." startIconSearch
                        endIconSearch />
                </div>

                {{-- BARIS 2: FILTER PERIODE UTAMA --}}
                <div>
                    <x-form.select id="filter_period" name="period_id" placeholder="Semua Periode">
                        <option value="">Semua Periode Utama</option>
                        @foreach ($periods as $period)
                            <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                                {{ $period->name }}
                            </option>
                        @endforeach
                    </x-form.select>
                </div>
            </div>
        </x-common.filter-accordion>

        <x-core.basic-tables.core-table>
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
