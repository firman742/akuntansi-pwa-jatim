@extends('layouts.app')

@section('title', 'Tambah Sub Periode')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Sub Periode" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan" :dismissible="false">
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
                    <div class="grid-row">
                        <label class="block text-sm mb-2">Periode</label>

                        <select name="period_id" class="w-full border rounded-lg p-2">
                            <option value="">Pilih Periode</option>
                            @foreach ($periods as $period)
                                <option value="{{ $period->id }}">
                                    {{ $period->name }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <div class="grid-row">
                        <label class="block text-sm mb-2">Nama Sub Periode</label>

                        <input type="text" name="name" class="w-full border rounded-lg p-2"
                            placeholder="Masukkan nama sub periode">
                    </div>

                    <div class="grid-row">
                        <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                            Tanggal Masuk
                        </label>
                        <x-form.date-picker id="start_date" name="start_date" placeholder="Tentukan Tanggal Mulai Periode"
                            defaultDate="{{ now()->format('Y-m-d') }}" />
                    </div>
                    <div class="grid-row">
                        <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                            Tanggal Keluar
                        </label>
                        <x-form.date-picker id="end_date" name="end_date" placeholder="Tentukan Tanggal Mulai Periode"
                            defaultDate="{{ now()->format('Y-m-d') }}" />
                    </div>
                </div>
                
                <div class="col-span-1 md:col-span-2">
                    <label class="block text-sm mb-2">Deskripsi</label>
                    <textarea name="description" class="w-full border rounded-lg p-2" rows="3"></textarea>
                </div>

                <div class="col-span-1 md:col-span-2">
                    <label class="flex items-center gap-2">
                        <input type="checkbox" name="is_active" value="1">
                        Aktifkan Sub Periode
                    </label>
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
