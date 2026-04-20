@extends('layouts.app')

@section('title', 'Master Data - Edit Tipe Akun')

@section('content')
    <x-common.page-breadcrumb pageTitle="Edit Tipe Akun" />

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

    <x-common.component-card title="Edit Tipe Akun">
        <p class="mb-6 text-sm text-gray-600">

        </p>

        <form method="POST" action="{{ route('bendahara.master.account-types.update', $accountType->id) }}">
            @csrf
            @method('PUT')  
            <div class="grid grid-cols-1 md:grid-cols-1 gap-4">
                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Nama Tipe Akun
                    </label>
                    <input type="text" name="name" value="{{ old('name', $accountType->name) }}"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-11 w-full rounded-lg border @error('name') border-error-300 focus:border-error-300 @else border-gray-300 @enderror bg-transparent px-4 py-2.5 text-sm text-gray-800 placeholder:text-gray-400 focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30" />

                    @error('name')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Deskirpsi
                    </label>
                    <input type="text" name="description" value="{{ old('description', $accountType->description) }}"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-11 w-full rounded-lg border @error('description') border-error-300 focus:border-error-300 @else border-gray-300 @enderror bg-transparent px-4 py-2.5 text-sm text-gray-800 placeholder:text-gray-400 focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30" />
                    @error('description')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Aktifkan Tipe Akun
                    </label>

                    <div x-data="{ switcherToggle: {{ $accountType->is_active ? 'true' : 'false' }} }">
                        {{-- hidden input agar selalu terkirim --}}
                        <input type="hidden" name="is_active" value="0">

                        <label
                            class="flex cursor-pointer items-center gap-3 text-sm font-medium
                                   text-gray-700 select-none dark:text-gray-400">

                            <div class="relative">
                                <input type="checkbox" name="is_active" value="1" class="sr-only"
                                    x-model="switcherToggle" />

                                <div class="block h-6 w-11 rounded-full transition"
                                    :class="switcherToggle
                                        ?
                                        'bg-brand-500 dark:bg-brand-500' :
                                        'bg-gray-200 dark:bg-white/10'">
                                </div>

                                <div class="shadow-theme-sm absolute top-0.5 left-0.5 h-5 w-5
                                           rounded-full bg-white transition-transform duration-300"
                                    :class="switcherToggle ? 'translate-x-full' : 'translate-x-0'">
                                </div>
                            </div>

                            <span x-text="switcherToggle ? 'Aktif' : 'Nonaktif'"></span>
                        </label>
                    </div>
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
