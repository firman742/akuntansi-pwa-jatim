@extends('layouts.app')

@section('title', 'Manajemen Pengguna')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Manajemen Pengguna" pageTitle="Manajemen Pengguna"
        pageDescription="Monitoring dan kelola pengguna yang terdaftar di sistem" pageIcon="user-profile" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1 dark:text-white">
                    @foreach ($errors->all() as $error)
                        <li class="text-danger-500">{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    <div class="space-y-6">

        <x-core.basic-tables.core-table>
            {{-- SLOT search --}}
            <x-slot name="search">
                <x-form.input id="coaSearch" name="search" value="{{ request('search') }}"
                    placeholder="Cari berdasarkan Akun atau kode COA..." startIconSearch endIconSearch />
            </x-slot>

            {{-- SLOT Actions --}}
            <x-slot name="actions">
                <a href="{{ route('superadmin.users.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Tambah Pengguna
                    </x-ui.button>
                </a>
            </x-slot>
            <x-core.basic-tables.superadmin.user-table :users="$users" />
        </x-core.basic-tables.core-table>
    </div>


    {{-- SCRIPT --}}
    <script>
        const searchInput = document.getElementById('coaSearch');
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
