@extends('layouts.app')

@section('title', 'Sub Periode')

@section('content')
    <x-common.page-breadcrumb pageTitle="Sub Periode" />
    
    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan" >
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    {{-- Info --}}
    <div class="mb-6">
        <x-ui.alert variant="info" title="Aturan Pengelolaan Sub Periode" :dismissible="false">
            <ul class="list-disc pl-5 space-y-1 text-sm text-blue-500">
                <li>Sub periode dapat diubah atau dihapus hanya jika belum memiliki transaksi.</li>
                <li>Sub periode tidak dapat diubah atau dihapus setelah tanggal berakhir terlewati.</li>
                <li>Sub periode yang sudah memiliki transaksi dianggap terkunci untuk menjaga konsistensi data keuangan.</li>
            </ul>
        </x-ui.alert>
    </div>


    {{-- FILTER & ACTION CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-white/[0.03] p-6 shadow-sm">
        <form method="GET" class="space-y-6">

            {{-- FILTER SECTION --}}
            <div class="grid grid-cols-1 md:grid-cols-1 lg:grid-cols-1 gap-5">

                {{-- PERIOD --}}
                <div class="flex flex-col gap-2">
                    <x-form.select name="period_id" label="Periode" placeholder="Pilih Periode">
                        @foreach ($periods as $period)
                            <option value="{{ $period->id }}" @selected(old('period_id') == $period->id)
                                class="text-gray-700 dark:bg-gray-900 dark:text-gray-400">
                                {{ $period->name }}
                            </option>
                        @endforeach
                    </x-form.select>
                </div>

                {{-- FILTER ACTION --}}
                <div class="flex items-end gap-3 col-span-1 md:col-span-2 lg:col-span-2">
                    <x-ui.button type="submit" variant="primary"
                        class="flex-1 justify-center rounded-xl px-5 py-2.5 shadow-sm">
                        Tampilkan
                    </x-ui.button>

                    <a href="{{ route('bendahara.sub-periods.index') }}" class="flex-1">
                        <x-ui.button variant="outline" class="w-full justify-center rounded-xl px-5 py-2.5">
                            Reset
                        </x-ui.button>
                    </a>
                </div>
            </div>
        </form>
    </div>

    <div class="space-y-6">
        <x-core.basic-tables.core-table title="Daftar Sub Periode"
            description="Berikut adalah daftar sub periode yang tersedia.">
            <x-slot name="actions">
                <a href="{{ route('bendahara.sub-periods.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Tambah Sub Periode
                    </x-ui.button>
                </a>
            </x-slot>

            <x-core.basic-tables.bendahara.sub-period-table :sub_periods="$sub_periods" :periods="$periods" />
        </x-core.basic-tables.core-table>
    </div>
@endsection
