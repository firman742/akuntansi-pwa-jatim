@extends('layouts.app')

@section('title', 'Tambah Sub Periode')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Sub Periode" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    <x-common.component-card title="Tambah Sub Periode">

        <form method="POST" action="{{ route('bendahara.sub-periods.store') }}">
            @csrf

            <div class="grid grid-cols-1 md:grid-cols-1 gap-4">

                <div class="grid grid-cols-2 ls:grid-cols-2 gap-4">

                    {{-- Period --}}
                    <div class="grid-row">
                        <label class="block text-sm mb-2">
                            Periode
                        </label>

                        <select name="period_id"
                            class="w-full border rounded-lg p-2 @error('period_id') border-red-500 @enderror" required>
                            <option value="">Pilih Periode</option>

                            @foreach ($periods as $period)
                                <option value="{{ $period->id }}" @selected(old('period_id') == $period->id)>
                                    {{ $period->name }}
                                </option>
                            @endforeach
                        </select>

                        @error('period_id')
                            <p class="mt-1 text-sm text-red-500">
                                {{ $message }}
                            </p>
                        @enderror
                    </div>

                    {{-- Name --}}
                    <div class="grid-row">
                        <label class="block text-sm mb-2">
                            Nama Sub Periode
                        </label>

                        <input type="text" name="name" value="{{ old('name') }}"
                            class="w-full border rounded-lg p-2 @error('name') border-red-500 @enderror"
                            placeholder="Masukkan nama sub periode" required>

                        @error('name')
                            <p class="mt-1 text-sm text-red-500">
                                {{ $message }}
                            </p>
                        @enderror
                    </div>

                    {{-- Start Date --}}
                    <div class="grid-row">
                        <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                            Tanggal Masuk
                        </label>

                        <x-form.date-picker id="start_date" name="start_date" placeholder="Tentukan Tanggal Mulai Periode"
                            defaultDate="{{ old('start_date', now()->format('Y-m-d')) }}" />
                    </div>

                    {{-- End Date --}}
                    <div class="grid-row">
                        <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                            Tanggal Keluar
                        </label>

                        <x-form.date-picker id="end_date" name="end_date" placeholder="Tentukan Tanggal Akhir Periode"
                            defaultDate="{{ old('end_date', now()->format('Y-m-d')) }}" />
                    </div>

                </div>

                {{-- Description --}}
                <div class="col-span-1 md:col-span-2">
                    <label class="block text-sm mb-2">
                        Deskripsi
                    </label>

                    <textarea name="description" rows="3"
                        class="w-full border rounded-lg p-2 @error('description') border-red-500 @enderror">{{ old('description') }}</textarea>

                    @error('description')
                        <p class="mt-1 text-sm text-red-500">
                            {{ $message }}
                        </p>
                    @enderror
                </div>

                {{-- Is Active --}}
                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Aktifkan Sub Periode
                    </label>

                    <div x-data="{ switcherToggle: {{ old('is_active', 1) ? 'true' : 'false' }} }">

                        {{-- hidden input agar selalu terkirim --}}
                        <input type="hidden" name="is_active" value="0">

                        <label
                            class="flex cursor-pointer items-center gap-3 text-sm font-medium
                                   text-gray-700 select-none dark:text-gray-400">
                            <div class="relative">
                                <input type="checkbox" name="is_active" value="1" class="sr-only"
                                    x-model="switcherToggle" @checked(old('is_active', 1)) />

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

                        @error('is_active')
                            <p class="mt-1 text-sm text-red-500">
                                {{ $message }}
                            </p>
                        @enderror
                    </div>
                </div>

            </div>

            <div class="mt-6 flex justify-end gap-3">

                <a href="{{ route('bendahara.sub-periods.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Simpan
                </x-ui.button>

            </div>

        </form>

    </x-common.component-card>
@endsection
