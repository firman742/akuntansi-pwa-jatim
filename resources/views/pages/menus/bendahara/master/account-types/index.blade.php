@extends('layouts.app')

@section('title', 'Manajemen Tipe Akun')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Tipe Akun" pageTitle="Manajemen Tipe Akun"
        pageDescription="Monitoring dan kelola Tipe Akun yang terdaftar di sistem" pageIcon="book" />

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
        {{-- KOMPONEN FILTER ACCORDION DINAMIS --}}
        <x-common.filter-accordion title="Pencarian Tipe Akun" :action="route('bendahara.master.account-types.index')" :resetUrl="route('bendahara.master.account-types.index')">
            {{-- BARIS 1: SEARCH BAR --}}
            <div>
                <x-form.input id="search" name="search" value="{{ request('search') }}"
                    placeholder="Cari Nama Tipe Akun..." startIconSearch
                    endIconSearch />
            </div>
        </x-common.filter-accordion>

        <x-core.basic-tables.core-table title="Daftar Tipe Akun"
            description="Berikut adalah daftar tipe akun yang tersedia.">

            {{-- SLOT Actions --}}
            <x-slot name="actions">
                <a href="{{ route('bendahara.master.account-types.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Tambah Tipe Akun
                    </x-ui.button>
                </a>
            </x-slot>

            <x-core.basic-tables.bendahara.account-type-table :accountTypes="$accountTypes" />
        </x-core.basic-tables.core-table>
    </div>

    {{-- SCRIPT --}}
    <script>
        const searchInput = document.getElementById('searchId');
        let timeout = null;

        searchInput.addEventListener('input', function() {
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
