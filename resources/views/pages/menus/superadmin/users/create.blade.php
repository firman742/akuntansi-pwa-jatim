@extends('layouts.app')

@section('title', 'Tambah Pengguna')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Tambah Pengguna " pageTitle="Tambah Pengguna"
        pageDescription="Monitoring dan kelola pengguna yang terdaftar di sistem" pageIcon="user-profile"
        parentTitle="Pengguna" :parentRoute="route('superadmin.users.index')" currentTitle="Tambah" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1 dark:text-white">
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

    <x-common.component-card title="Tambah Pengguna">
        <form method="POST" action="{{ route('superadmin.users.store') }}">
            @csrf
            <div class="grid grid-cols-2 sm:grid-cols-1 gap-4">
                <div class="col-span-2 sm:col-span-1">
                    <x-form.input id="name" name="name" label="Nama Pengguna" placeholder="Masukkan Nama Pengguna"
                        value="{{ old('name') }}" required />
                </div>

                <div class="col-span-2 sm:col-span-1">
                    <x-form.input id="no_telp" name="no_telp" type="number" label="No Telpon"
                        placeholder="Masukkan No Telpon" value="{{ old('no_telp') }}" />
                </div>

                <div class="col-span-2 sm:col-span-1">
                    <x-form.input id="email" name="email" type="email" label="Email" placeholder="Masukkan Email"
                        value="{{ old('email') }}" required />
                </div>

                <div class="col-span-2 sm:col-span-1">
                    <x-form.input id="address" name="address" label="Alamat" placeholder="Masukkan Alamat"
                        value="{{ old('address') }}" />
                </div>

                <div class="col-span-2">
                    <x-form.multi-select
                        id="role"
                        name="role"
                        label="Peran"
                        :options="$roles"
                        placeholder="Pilih Peran"
                        required
                    />
                </div>

                <div class="col-span-2 sm:col-span-1">
                    <x-form.input 
                        id="password" 
                        name="password" 
                        label="Password" 
                        type="password"
                        placeholder="Masukkan Password"
                        value="{{ old('password') }}" 
                        required />
                </div>

                <div class="col-span-2 sm:col-span-1">
                    <x-form.input 
                        id="password_confirmation" 
                        name="password_confirmation" 
                        type="password"
                        label="Konfirmasi Password" 
                        placeholder="Masukkan Konfirmasi Password"
                        value="{{ old('password_confirmation') }}" 
                        required />
                </div>
            </div>

            <div class="mt-8 flex justify-end gap-3">
                <a href="{{ route('superadmin.users.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Buat Pengguna
                </x-ui.button>
            </div>

        </form>
    </x-common.component-card>
@endsection
