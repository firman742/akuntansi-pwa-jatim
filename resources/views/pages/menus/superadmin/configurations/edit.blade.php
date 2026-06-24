@extends('layouts.app')

@section('title', 'Edit Pengaturan Sistem')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Pengaturan Sistem" pageTitle="Pengaturan Sistem"
        pageDescription="Monitoring dan kelola pengaturan sistem di sistem" pageIcon="system-config" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1 dark:text-white">
                    @foreach ($errors->all() as $error)
                        <li class="text-dark-500">{{ $error }}</li>
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

    <x-common.component-card title="Edit Pengaturan Sistem">

        <form action="{{ route('superadmin.configurations.update') }}" method="POST" enctype="multipart/form-data">

            @csrf
            {{-- @method('PUT') --}}

            {{-- INFORMASI APLIKASI --}}
            <div class="rounded-xl border border-gray-200 bg-white p-6 dark:border-gray-700 dark:bg-gray-900">

                <div class="mb-6">
                    <h3 class="text-lg font-semibold text-gray-800 dark:text-white">
                        Informasi Aplikasi
                    </h3>

                    <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                        Pengaturan umum aplikasi yang akan ditampilkan kepada pengguna.
                    </p>
                </div>

                <div class="space-y-5">

                    {{-- APP NAME --}}
                    <div>
                        <x-form.input id="app_name" name="app_name" label="Nama Aplikasi"
                            placeholder="Masukkan Nama Applikasi"
                            value="{{ old('app_name', $settings['APP_NAME']->value ?? '') }}" required />
                    </div>

                    {{-- DESCRIPTION --}}
                    <div>
                        <x-form.text-area name="app_description" label="Deskripsi Aplikasi"
                            placeholder="Masukkan deskripsi aplikasi...."
                            value="{{ old('app_description', $settings['APP_DESCRIPTION']->value ?? '') }}" rows="6"
                            required />
                    </div>

                    {{-- TAGLINE --}}
                    <div>
                        <x-form.input id="app_tagline" name="app_tagline" label="Tagline"
                            placeholder="Masukkan Tagline Aplikasi"
                            value="{{ old('app_tagline', $settings['APP_TAGLINE']->value ?? '') }}" required />
                    </div>

                </div>
            </div>

            {{-- BRANDING --}}
            <div class="mt-6 rounded-xl border border-gray-200 bg-white p-6 dark:border-gray-700 dark:bg-gray-900">

                <div class="mb-6">
                    <h3 class="text-lg font-semibold text-gray-800 dark:text-white">
                        Branding
                    </h3>

                    <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                        Kelola logo aplikasi dan tampilan halaman login.
                    </p>
                </div>

                <div class="grid gap-6 lg:grid-cols-2">

                    {{-- LOGO --}}
                    <div>
                        <label class="mb-3 block text-sm font-medium text-gray-700 dark:text-gray-300">
                            Logo Aplikasi <span class="text-xs text-gray-400">(Ukuran maksimal 2MB)</span>
                        </label>

                        <div x-data="{
                            preview: '{{ $settings['APP_LOGO']?->getFirstMediaUrl('configuration_app_logo') }}'
                        }">
                            <div
                                class="flex h-56 items-center justify-center rounded-xl border-2 border-dashed border-gray-300 overflow-hidden">

                                <template x-if="preview">
                                    <img :src="preview" class="max-h-40 max-w-full object-contain">
                                </template>

                                <template x-if="!preview">
                                    <div class="text-center">
                                        Belum ada logo
                                    </div>
                                </template>
                            </div>

                            <input type="file" name="app_logo" accept="image/jpeg,image/png,image/gif,image/svg+xml"
                            class="mt-3 focus:border-ring-brand-300 shadow-theme-xs focus:file:ring-brand-300 h-11 w-full overflow-hidden rounded-lg border border-gray-300 bg-transparent text-sm text-gray-500 transition-colors file:mr-5 file:border-collapse file:cursor-pointer file:rounded-l-lg file:border-0 file:border-r file:border-solid file:border-gray-200 file:bg-brand-50 file:py-3 file:pr-3 file:pl-3.5 file:text-sm file:text-gray-700 placeholder:text-gray-400 hover:file:bg-gray-100 focus:outline-hidden dark:border-gray-700 dark:bg-gray-900 dark:text-gray-400 dark:text-white/90 dark:file:border-gray-800 dark:file:bg-white/[0.03] dark:file:text-gray-400 dark:placeholder:text-gray-400"
                                @change="
                                    const file = $event.target.files[0];
                                    if(file){
                                        preview = URL.createObjectURL(file);
                                    }
                                ">
                        </div>
                    </div>

                    {{-- BACKGROUND LOGIN --}}
                    <div>
                        <label class="mb-3 block text-sm font-medium text-gray-700 dark:text-gray-300">
                            Background Login <span class="text-xs text-gray-400">(Ukuran maksimal 2MB)</span>
                        </label>

                        <div x-data="{
                            preview: '{{ $settings['APP_BACKGROUND_LOGIN']?->getFirstMediaUrl('configuration_app_background_login') }}'
                        }">
                            <div
                                class="flex h-56 items-center justify-center overflow-hidden rounded-xl border-2 border-dashed border-gray-300">

                                <template x-if="preview">
                                    <img :src="preview" class="h-full w-full object-cover">
                                </template>

                                <template x-if="!preview">
                                    <div class="text-center">
                                        Belum ada background
                                    </div>
                                </template>
                            </div>

                            <input type="file" name="app_background_login" accept="image/jpeg,image/png,image/gif,image/svg+xml"
                            class="mt-3 focus:border-ring-brand-300 shadow-theme-xs focus:file:ring-brand-300 h-11 w-full overflow-hidden rounded-lg border border-gray-300 bg-transparent text-sm text-gray-500 transition-colors file:mr-5 file:border-collapse file:cursor-pointer file:rounded-l-lg file:border-0 file:border-r file:border-solid file:border-gray-200 file:bg-brand-50 file:py-3 file:pr-3 file:pl-3.5 file:text-sm file:text-gray-700 placeholder:text-gray-400 hover:file:bg-gray-100 focus:outline-hidden dark:border-gray-700 dark:bg-gray-900 dark:text-gray-400 dark:text-white/90 dark:file:border-gray-800 dark:file:bg-white/[0.03] dark:file:text-gray-400 dark:placeholder:text-gray-400"
                                @change="
                                    const file = $event.target.files[0];
                                    if(file){
                                        preview = URL.createObjectURL(file);
                                    }
                                ">
                        </div>
                    </div>

                </div>
            </div>

            {{-- ACTION --}}
            <div
                class="mt-6 flex items-center justify-between rounded-xl border border-gray-200 bg-white p-4 dark:border-gray-700 dark:bg-gray-900">

                <p class="text-sm text-gray-500 dark:text-gray-400">
                    Pastikan semua perubahan telah diperiksa sebelum disimpan.
                </p>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Simpan Pengaturan
                </x-ui.button>

            </div>

        </form>

    </x-common.component-card>
@endsection
