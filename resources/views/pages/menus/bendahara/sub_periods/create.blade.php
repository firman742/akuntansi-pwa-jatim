@extends('layouts.app')

@section('title', 'Tambah Sub Periode')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Sub Periode" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside">
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

    <x-common.component-card title="Tambah Sub Periode">

        <form method="POST" action="{{ route('bendahara.sub-periods.store') }}">
            @csrf
            <div class="grid grid-cols-1 md:grid-cols-1 gap-4">
                <div class="grid grid-cols-2 ls:grid-cols-2 gap-4">
                    {{-- Period --}}
                    <div class="grid-row">
                        <x-form.select id="period_id" name="period_id" label="Periode" placeholder="Pilih Periode" required
                            x-on:change="
                                const selected =
                                    $event.target.options[
                                        $event.target.selectedIndex
                                    ];

                                $dispatch(
                                    'period-range',
                                    {
                                        startDate:
                                            selected.dataset.startDate,

                                        endDate:
                                            selected.dataset.endDate
                                    }
                                );
                                // Update local state to show allowed date range
                                periodStart = selected.dataset.startDate || '';
                                periodEnd = selected.dataset.endDate || '';
                            ">
                            @foreach ($periods as $period)
                                <option 
                                    value="{{ $period->id }}" 
                                    data-start-date="{{ $period->start_date }}"
                                    data-end-date="{{ $period->end_date }}" 
                                    @selected(old('period_id') == $period->id)>
                                    {{ $period->name }}
                                </option>
                            @endforeach
                        </x-form.select>
                        <div x-data="{ periodStart: '', periodEnd: '' }">
                            <p x-show="periodStart && periodEnd" class="mt-1 text-xs text-brand-500">
                                Tanggal yang diperbolehkan:
                                <span x-text="periodStart"></span>
                                s/d
                                <span x-text="periodEnd"></span>
                            </p>

                        </div>
                    </div>

                    {{-- Name --}}
                    <div class="grid-row">
                        <x-form.input 
                            id="name" 
                            name="name" 
                            label="Nama Sub Periode"
                            placeholder="Masukkan Nama Sub Periode" 
                            value="{{ old('name') }}" 
                            required />
                    </div>

                    {{-- Start Date --}}
                    <div class="grid-row">
                        <x-form.date-picker 
                            id="start_date" 
                            name="start_date" 
                            label="Tanggal Masuk"
                            placeholder="Tentukan Tanggal Mulai Sub Periode" 
                            defaultDate="{{ old('start_date') }}" />
                    </div>

                    {{-- End Date --}}
                    <div class="grid-row">
                        <x-form.date-picker 
                            id="end_date" 
                            name="end_date" 
                            label="Tanggal Akhir"
                            placeholder="Tentukan Tanggal Akhir Sub Periode" 
                            defaultDate="{{ old('end_date') }}" />
                    </div>
                </div>

                {{-- Description --}}
                <div class="col-span-1 md:col-span-2">
                    <x-form.text-area name="description" label="Deskripsi" placeholder="Masukkan deskripsi...."
                        rows="6" />
                </div>

                {{-- Is Active --}}
                <div class="col-span-1 md:col-span-2">
                    <x-form.toggle-switch name="is_active" label="Aktifkan Sub Periode" :value="true" />
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
