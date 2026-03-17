@extends('layouts.app')

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

        <form method="POST" action="{{ route('bendahara.sub-periode.store') }}">
            @csrf

            <div class="grid grid-cols-2 gap-4">

                <div>
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

                <div>
                    <label class="block text-sm mb-2">Nama Sub Periode</label>
                    <input type="text" name="name" class="w-full border rounded-lg p-2"
                        placeholder="Masukkan nama sub periode">
                </div>

                <div>
                    <label class="block text-sm mb-2">Tanggal Mulai</label>
                    <input type="date" name="start_date" class="w-full border rounded-lg p-2">
                </div>

                <div>
                    <label class="block text-sm mb-2">Tanggal Selesai</label>
                    <input type="date" name="end_date" class="w-full border rounded-lg p-2">
                </div>

                <div class="col-span-2">
                    <label class="block text-sm mb-2">Deskripsi</label>
                    <textarea name="description" class="w-full border rounded-lg p-2" rows="3"></textarea>
                </div>

                <div class="col-span-2">
                    <label class="flex items-center gap-2">
                        <input type="checkbox" name="is_active" value="1">
                        Aktifkan Sub Periode
                    </label>
                </div>

            </div>

            <div class="mt-6 flex justify-end gap-3">

                <a href="{{ route('bendahara.sub-periode.index') }}">
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
