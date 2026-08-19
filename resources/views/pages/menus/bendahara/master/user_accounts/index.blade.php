@extends('layouts.app')

@section('title', 'Master Data - Pengguna COA')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Penanggung Jawab Akun COA" pageTitle="Manajemen Penanggung Jawab Akun COA"
        pageDescription="Monitoring dan kelola pengguna yang bertanggung jawab pada setiap akun coa yang ada" pageIcon="book" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    <div class="space-y-6">
        {{-- KOMPONEN FILTER ACCORDION DINAMIS --}}
        <x-common.filter-accordion title="Pencarian Pengguna" :action="route('bendahara.master.account-users.index')" :resetUrl="route('bendahara.master.account-users.index')">
            {{-- BARIS 1: SEARCH BAR --}}
            <div>
                <x-form.input id="search" name="search" value="{{ request('search') }}"
                    placeholder="Cari Nama Pengguna..." startIconSearch
                    endIconSearch />
            </div>
        </x-common.filter-accordion>

        <x-core.basic-tables.core-table>
            <x-core.basic-tables.bendahara.user-account-table :users="$users" />
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
