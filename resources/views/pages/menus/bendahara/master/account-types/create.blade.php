@extends('layouts.app')

@section('title', 'Master Data - Tambah Tipe Akun')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Tipe Akun" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan" >
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

    <x-common.component-card title="Tambah Tipe Akun">
        <form method="POST" action="{{ route('bendahara.master.account-types.store') }}">
            @csrf
            <div class="grid grid-cols-1 md:grid-cols-1 gap-4">
                <div class="col-span-1 md:col-span-2">
                    {{-- Name --}}
                    <x-form.input 
                        id="name" 
                        name="name" 
                        label="Nama Tipe Akun"
                        placeholder="Masukkan Nama Tipe Akun" 
                        value="{{ old('name') }}" 
                        required />
                </div>

                <div class="col-span-1 md:col-span-2">
                    <x-form.text-area name="description" label="Deskripsi" placeholder="Masukkan deskripsi...."
                        rows="6" />
                </div>

                <div class="col-span-1 md:col-span-2">
                    <x-form.toggle-switch name="is_active" label="Aktifkan Tipe Akun" :value="true" />
                </div>
            </div>

            <div class="mt-8 flex justify-end gap-3">
                <a href="{{ route('bendahara.master.account-types.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Buat Tipe Akun
                </x-ui.button>
            </div>

        </form>
    </x-common.component-card>
@endsection
