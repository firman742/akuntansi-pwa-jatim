@extends('layouts.app')

@section('title', 'Periode')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Periode" pageTitle="Manajemen Periode"
        pageDescription="Monitoring dan kelola periode yang terdaftar di sistem" pageIcon="calendar" />

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
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    <div class="mb-6">
        <x-ui.alert variant="info" title="Aturan Pengelolaan Periode" :dismissible="false">

            <ul class="list-disc pl-5 space-y-1 text-blue-500">
                <li>Periode tidak dapat diubah jika sudah memiliki transaksi.</li>
                <li>Periode tidak dapat diubah jika terdapat transaksi pada sub periode.</li>
                <li>Periode tidak dapat diubah setelah tanggal berakhir terlewati.</li>
                <li>Periode hanya dapat ditutup setelah tanggal berakhir.</li>
                <li>Periode yang telah ditutup tidak dapat diubah kembali.</li>
            </ul>
        </x-ui.alert>
    </div>

    <div class="space-y-6">
        <x-core.basic-tables.core-table>
            {{-- SLOT search --}}
            <x-slot name="search">
                <x-form.input id="searchId" name="search" value="{{ request('search') }}"
                    placeholder="Cari berdasarkan nama dan deskripsi..." startIconSearch endIconSearch />
            </x-slot>

            {{-- SLOT Actions --}}
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
