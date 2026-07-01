@extends('layouts.app')

@section('title', 'Jurnal Umum')

@section('styles')
    <link rel="stylesheet" href="{{ asset('build/assets/custom.css') }}">
@endsection


@section('content')
    <x-common.page-breadcrumb defaultTitle="Jurnal Umum" pageTitle="Monitoring Jurnal Umum"
        pageDescription="Monitoring jurnal umum berdasarkan periode" pageIcon="database" />
    
        {{-- TABLE --}}
    <x-core.basic-tables.core-table needFilter :filterColumns="1" resetUrl="{{ route('bendahara.reports.journal.index') }}">
        {{-- SLOT Search --}}
        <x-slot name="search">
            <x-form.input id="searchId" name="search" value="{{ request('search') }}"
                placeholder="Cari berdasarkan Akun atau kode COA..." startIconSearch endIconSearch />
        </x-slot>

        {{-- SLOT Filter --}}
        <x-slot name="filters">
            <x-form.select id="filter_period" name="period_id" placeholder="Pilih Periode">
                @foreach ($periods as $period)
                    <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                        {{ $period->name }}
                    </option>
                @endforeach
            </x-form.select>

            <x-form.select id="filter_sub_period" name="sub_period_id" placeholder="Pilih Sub Periode">
                <option value="">Semua</option>
                @foreach ($subPeriods as $subPeriod)
                    <option value="{{ $subPeriod->id }}" @selected(request('sub_period_id') == $subPeriod->id)>
                        {{ $subPeriod->name }}
                    </option>
                @endforeach
            </x-form.select>

            <x-form.date-picker id="start_date" name="start_date" placeholder="Pilih Dari Tanggal"
                defaultDate="{{ request('start_date') }}" />

            <x-form.date-picker id="end_date" name="end_date" placeholder="Pilih Sampai Tanggal"
                defaultDate="{{ request('end_date') }}" />
        </x-slot>

        <x-core.basic-tables.bendahara.journal-table :groupedJournals="$groupedJournals" :journals="$journals" />
    </x-core.basic-tables.core-table>


    <script>
        const periodFilter = document.getElementById('filter_period');
        const subPeriodFilter = document.getElementById('filter_sub_period');

        periodFilter.addEventListener('change', async function() {

            let periodId = this.value;

            subPeriodFilter.innerHTML = '<option>Loading...</option>';

            if (!periodId) {
                subPeriodFilter.innerHTML = '<option value="">Semua</option>';
                return;
            }

            const res = await fetch(`/bendahara/periods/${periodId}/sub-periods`);
            const data = await res.json();

            subPeriodFilter.innerHTML = '<option value="">Semua</option>';

            data.forEach(sub => {
                subPeriodFilter.innerHTML += `
                <option value="${sub.id}">${sub.name}</option>
            `;
            });
        });
    </script>
@endsection
