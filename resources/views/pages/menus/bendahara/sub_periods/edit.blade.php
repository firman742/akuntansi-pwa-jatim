@extends('layouts.app')

@section('title', 'Edit Sub Periode')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Edit Sub Periode " pageTitle="Edit Sub Periode"
        pageDescription="Monitoring dan kelola Sub Periode yang terdaftar di sistem" pageIcon="calendar"
        parentTitle="Sub Periode" :parentRoute="route('bendahara.sub-periods.index')" currentTitle="Edit" />

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

    @if ($isLocked)
        <div class="mb-6">
            <x-ui.alert variant="warning" title="Sub Periode Terkunci" :dismissible="false">

                @if ($hasTransaction)
                    <p>
                        Sub periode ini tidak dapat diubah karena sudah memiliki transaksi.
                    </p>
                @elseif($isExpired)
                    <p>
                        Sub periode ini tidak dapat diubah karena tanggal berakhir telah terlewati.
                    </p>
                @endif

            </x-ui.alert>
        </div>
    @endif

    <x-common.component-card title="Edit Sub Periode">

        <div x-data="{
            periodStart: '',
            periodEnd: '',
        
            init() {
                this.$nextTick(() => {
                    const select = document.getElementById('period_id');
        
                    if (!select) {
                        return;
                    }
        
                    const selected =
                        select.options[
                            select.selectedIndex
                        ];
        
                    this.periodStart =
                        selected.dataset.startDate || '';
        
                    this.periodEnd =
                        selected.dataset.endDate || '';
        
                    this.formatDate = (dateStr) => {
                        if (!dateStr) return '';
                        const options = {
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric'
                        };
                        return new Date(dateStr).toLocaleDateString('id-ID', options);
                    };
        
                    this.$dispatch(
                        'period-range', {
                            startDate: selected.dataset.startDate,
        
                            endDate: selected.dataset.endDate
                        }
                    );
                });
            }
        }" x-init="init()">

            <form method="POST" action="{{ route('bendahara.sub-periods.update', $subPeriod->id) }}">
                @csrf
                @method('PUT')

                <div class="grid grid-cols-1 md:grid-cols-1 gap-4">

                    <div class="grid grid-cols-2 ls:grid-cols-2 gap-4">

                        {{-- Periode --}}
                        <div class="grid-row">

                            <x-form.select id="period_id" name="period_id" label="Periode" required :value="$subPeriod->period_id"
                                x-on:change="
                                    const selected =
                                        $event.target.options[
                                            $event.target.selectedIndex
                                        ];

                                    periodStart =
                                        selected.dataset.startDate || '';

                                    periodEnd =
                                        selected.dataset.endDate || '';

                                    $dispatch(
                                        'period-range',
                                        {
                                            startDate:
                                                selected.dataset.startDate,

                                            endDate:
                                                selected.dataset.endDate
                                        }
                                    );
                                ">

                                @foreach ($periods as $period)
                                    <option value="{{ $period->id }}" data-start-date="{{ $period->start_date }}"
                                        data-end-date="{{ $period->end_date }}" @selected(old('period_id', $subPeriod->period_id) == $period->id)>
                                        {{ $period->name }}
                                    </option>
                                @endforeach

                            </x-form.select>

                            <p x-show="periodStart && periodEnd" class="mt-1 text-xs text-brand-500">

                                Tanggal yang diperbolehkan:

                                <span x-text="formatDate(periodStart)"></span>

                                s/d

                                <span x-text="formatDate(periodEnd)"></span>

                            </p>

                        </div>

                        {{-- Nama --}}
                        <div class="grid-row">
                            <x-form.input name="name" label="Nama Sub Periode" :value="old('name', $subPeriod->name)" required />
                        </div>

                        {{-- Tanggal Mulai --}}
                        <div class="grid-row">
                            <x-form.date-picker id="start_date" name="start_date" label="Tanggal Masuk"
                                placeholder="Tentukan Tanggal Mulai Sub Periode"
                                defaultDate="{{ old('start_date', $subPeriod->start_date) }}" />
                        </div>

                        {{-- Tanggal Akhir --}}
                        <div class="grid-row">
                            <x-form.date-picker id="end_date" name="end_date" label="Tanggal Akhir"
                                placeholder="Tentukan Tanggal Akhir Sub Periode"
                                defaultDate="{{ old('end_date', $subPeriod->end_date) }}" />
                        </div>

                    </div>

                    {{-- Deskripsi --}}
                    <div class="col-span-1 md:col-span-2">
                        <x-form.text-area name="description" label="Deskripsi" placeholder="Masukkan deskripsi...."
                            :value="old('description', $subPeriod->description)" rows="6" />
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

        </div>

    </x-common.component-card>
@endsection
