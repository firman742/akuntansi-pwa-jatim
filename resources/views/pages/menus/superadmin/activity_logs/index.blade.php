@extends('layouts.app')

@section('title', 'Manajemen Log Aktivitas')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Manajemen Log Aktifitas" pageTitle="Manajemen Log Aktifitas"
        pageDescription="Monitoring dan kelola Log Aktifitas yang terdaftar di sistem" pageIcon="logs" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    <div class="space-y-6">

        <x-core.basic-tables.core-table>
            {{-- SLOT search --}}
            <x-slot name="search">
                <x-form.input id="searchId" name="search" value="{{ request('search') }}"
                    placeholder="Cari berdasarkan nama pengguna..." startIconSearch endIconSearch />
            </x-slot>

            <x-core.basic-tables.superadmin.log-activity-table :activityLogs="$activityLogs" />
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
