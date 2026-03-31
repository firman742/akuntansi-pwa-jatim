@extends('layouts.app')

@section('title', 'Tambah Periode')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Periode" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan" :dismissible="false">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
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
                <div class="grid grid-cols-2 ls:grid-cols-2 gap-4">
                    <div class="grid-row">
                        <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                            Nama 
                        </label>
                        <input type="text" name="name" id="name" class="" placeholder="masukkan nama periode">
                    </div>
                    <div class="grid-row">
                        <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                            Deskripsi
                        </label>
                        <input type="text" name="description" id="description" class="" placeholder="masukkan deskripsi periode">
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
