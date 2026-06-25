@extends('layouts.app')

@section('title', 'Tambah Periode')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Tambah Periode " pageTitle="Tambah Periode"
        pageDescription="Monitoring dan kelola Periode yang terdaftar di sistem" pageIcon="calendar"
        parentTitle="Periode" :parentRoute="route('bendahara.periods.index')" currentTitle="Tambah" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li class="text-red-500">{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif


    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    <x-common.component-card title="Tambah Periode">
        <form method="POST" action="{{ route('bendahara.periods.store') }}">
            @csrf
            <div class="grid grid-cols-1 md:grid-cols-1 gap-4">
                <div class="col-span-1 md:col-span-2">
                    <x-form.input id="name" name="name" label="Nama Periode" placeholder="Masukkan Nama Periode"
                        value="{{ old('name') }}" required />
                </div>

                {{-- Description --}}
                <div class="col-span-1 md:col-span-2">
                    <x-form.text-area name="description" label="Deskripsi" placeholder="Masukkan deskripsi periode...."
                        rows="6" required />
                </div>

                <div class="grid grid-cols-2 ls:grid-cols-2 gap-4">
                    <div class="grid-row">
                        <x-form.date-picker id="start_date" name="start_date" label="Tanggal Masuk"
                            placeholder="Tentukan Tanggal Mulai Periode" defaultDate="{{ old('start_date') }}" />
                    </div>
                    <div class="grid-row">
                        <x-form.date-picker id="end_date" name="end_date" label="Tanggal Akhir"
                            placeholder="Tentukan Tanggal Akhir Periode" defaultDate="{{ old('end_date') }}" />
                    </div>
                </div>
            </div>

            <div class="mt-8 flex justify-end gap-3">
                <a href="{{ route('bendahara.periods.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Buat Periode
                </x-ui.button>
            </div>
        </form>
    </x-common.component-card>
@endsection
