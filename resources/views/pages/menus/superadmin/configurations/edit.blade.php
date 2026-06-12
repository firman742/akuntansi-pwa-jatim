@extends('layouts.app')

@section('title', 'Edit Pengaturan Sistem')

@section('content')
    <x-common.page-breadcrumb pageTitle="Edit Pengaturan Sistem" />

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
                        <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                            Nama Aplikasi
                        </label>

                        <input type="text" name="app_name"
                            value="{{ old('app_name', $settings['APP_NAME']->value ?? '') }}"
                            class="dark:bg-dark-900 shadow-theme-xs h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:text-white dark:placeholder:text-gray-500 dark:focus:border-brand-800">
                    </div>

                    {{-- DESCRIPTION --}}
                    <div>
                        <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                            Deskripsi Aplikasi
                        </label>

                        <textarea rows="4" name="app_description"
                            class="dark:bg-dark-900 shadow-theme-xs w-full rounded-lg border border-gray-300 bg-transparent px-4 py-3 text-sm text-gray-800 placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:text-white dark:placeholder:text-gray-500 dark:focus:border-brand-800">{{ old('app_description', $settings['APP_DESCRIPTION']->value ?? '') }}</textarea>
                    </div>

                    {{-- TAGLINE --}}
                    <div>
                        <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                            Tagline
                        </label>

                        <input type="text" name="app_tagline"
                            value="{{ old('app_tagline', $settings['APP_TAGLINE']->value ?? '') }}"
                            class="dark:bg-dark-900 shadow-theme-xs h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 placeholder:text-gray-400 focus:border-brand-300 focus:outline-hidden focus:ring-3 focus:ring-brand-500/10 dark:border-gray-700 dark:text-white dark:placeholder:text-gray-500 dark:focus:border-brand-800">
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
                            Logo Aplikasi
                        </label>

                        <div
                            class="flex h-56 items-center justify-center rounded-xl border-2 border-dashed border-gray-300 bg-gray-50 dark:border-gray-600 dark:bg-gray-800">

                            @if ($settings['APP_LOGO']?->getFirstMediaUrl('configuration_app_logo'))
                                <img src="{{ $settings['APP_LOGO']->getFirstMediaUrl('configuration_app_logo') }}"
                                    class="max-h-40 max-w-full object-contain">
                            @else
                                <div class="text-center">
                                    <svg class="mx-auto h-10 w-10 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                            d="M3 16l4-4a3 3 0 014.243 0L15 15m-2-2l1-1a3 3 0 014.243 0L21 15" />
                                    </svg>

                                    <p class="mt-2 text-sm text-gray-500">
                                        Belum ada logo
                                    </p>
                                </div>
                            @endif
                        </div>

                        <input type="file" name="app_logo" accept="image/*"
                            class="mt-3 block w-full text-sm text-gray-500 file:mr-4 file:rounded-lg file:border-0 file:bg-brand-50 file:px-4 file:py-2 file:text-brand-700 hover:file:bg-brand-100 dark:text-gray-400 dark:file:bg-brand-900/30 dark:file:text-brand-400">
                    </div>

                    {{-- BACKGROUND LOGIN --}}
                    <div>
                        <label class="mb-3 block text-sm font-medium text-gray-700 dark:text-gray-300">
                            Background Login
                        </label>

                        <div
                            class="flex h-56 items-center justify-center overflow-hidden rounded-xl border-2 border-dashed border-gray-300 bg-gray-50 dark:border-gray-600 dark:bg-gray-800">

                            @if ($settings['APP_BACKGROUND_LOGIN']?->getFirstMediaUrl('configuration_app_background_login'))
                                <img src="{{ $settings['APP_BACKGROUND_LOGIN']->getFirstMediaUrl('configuration_app_background_login') }}"
                                    class="h-full w-full object-cover">
                            @else
                                <div class="text-center">
                                    <svg class="mx-auto h-10 w-10 text-gray-400" fill="none" stroke="currentColor"
                                        viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                            d="M3 16l4-4a3 3 0 014.243 0L15 15m-2-2l1-1a3 3 0 014.243 0L21 15" />
                                    </svg>

                                    <p class="mt-2 text-sm text-gray-500">
                                        Belum ada background
                                    </p>
                                </div>
                            @endif
                        </div>

                        <input type="file" name="app_background_login" accept="image/*"
                            class="mt-3 block w-full text-sm text-gray-500 file:mr-4 file:rounded-lg file:border-0 file:bg-brand-50 file:px-4 file:py-2 file:text-brand-700 hover:file:bg-brand-100 dark:text-gray-400 dark:file:bg-brand-900/30 dark:file:text-brand-400">
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
