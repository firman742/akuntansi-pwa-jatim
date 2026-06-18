@extends('layouts.app')

@section('title', 'Master Data - Edit Tipe Akun')

@section('content')
    <x-common.page-breadcrumb pageTitle="Edit Tipe Akun" />

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

    <x-common.component-card title="Edit Tipe Akun">
        <form method="POST" action="{{ route('bendahara.master.account-types.update', $accountType->id) }}">
            @csrf
            @method('PUT')  
            <div class="grid grid-cols-1 md:grid-cols-1 gap-4">
                <div class="col-span-1 md:col-span-2">
                    <x-form.input name="name" label="Nama Tipe Akun" :value="old('name', $accountType->name)" required />
                </div>

                <div class="col-span-1 md:col-span-2">
                    <x-form.text-area name="description" label="Deskripsi Tipe Akun" placeholder="Masukkan deskripsi...."
                            :value="old('description', $accountType->description)" rows="6" />
                </div>

                <div class="col-span-1 md:col-span-2">
                    <x-form.toggle-switch name="is_active" label="Aktifkan Tipe Akun" :value="old('is_active', $accountType->is_active)" />
                </div>
            </div>

            <div class="mt-8 flex justify-end gap-3">
                <a href="{{ route('bendahara.master.account-types.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Perbarui Tipe Akun
                </x-ui.button>
            </div>

        </form>
    </x-common.component-card>
@endsection
