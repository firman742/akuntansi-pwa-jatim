@extends('layouts.app')

@section('title', 'Saldo Awal')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Saldo Awal" pageTitle="Penetapan Saldo Awal"
        pageDescription="Monitoring dan kelola saldo awal berdasarkan periode" pageIcon="money" />

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li class="text-danger-500">{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    {{-- TABLE --}}
    <div class="space-y-6">
        <x-core.basic-tables.core-table needFilter resetUrl="{{ route('bendahara.opening-balances.index') }}">
            {{-- SLOT search --}}
            <x-slot name="search">
                <x-form.input id="searchId" name="search" value="{{ request('search') }}"
                    placeholder="Cari berdasarkan Akun atau kode COA..." startIconSearch endIconSearch />
            </x-slot>

            {{-- SLOT filter --}}
            <x-slot name="filters">
                <x-form.select id="filter_period" name="period_id" label="Periode" placeholder="Pilih Periode">
                    @foreach ($periods as $period)
                        <option value="{{ $period->id }}" @selected($periodId == $period->id)>
                            {{ $period->name }}
                        </option>
                    @endforeach
                </x-form.select>

                <x-form.select id="filter_sub_period" name="sub_period_id" label="Sub Periode"
                    placeholder="Pilih Sub Periode">
                    @foreach ($subPeriods as $sub)
                        <option value="{{ $sub->id }}" @selected($subPeriodId == $sub->id)>
                            {{ $sub->name }}
                        </option>
                    @endforeach
                </x-form.select>
            </x-slot>

            {{-- SLOT actions --}}
            <x-slot name="actions">
                {{-- CREATE MANUAL --}}
                <a href="{{ route('bendahara.opening-balances.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Buat Saldo Awal
                    </x-ui.button>
                </a>
            </x-slot>

            <x-core.basic-tables.bendahara.opening-balance-table :openingBalances="$openingBalances" :periods="$periods" :periodId="$periodId"
                :subPeriods="$subPeriods" :subPeriodId="$subPeriodId" :selectedSubPeriodName="$selectedSubPeriodName" />

        </x-core.basic-tables.core-table>
    </div>

    {{-- SCRIPT --}}
    <script>
        const periodFilter = document.getElementById('filter_period');
        const subPeriodFilter = document.getElementById('filter_sub_period');
        const searchInput = document.getElementById('searchId');
        let timeout = null;

        // 1. Ketika Filter Periode Berubah
        periodFilter.addEventListener('change', function() {
            const urlParams = new URLSearchParams(window.location.search);

            if (this.value) {
                urlParams.set('period_id', this.value);
            } else {
                urlParams.delete('period_id');
            }

            // Reset sub_period_id jika periode utama diganti
            urlParams.delete('sub_period_id');

            window.location.search = urlParams.toString();
        });

        // 2. Ketika Filter Sub Periode Berubah
        subPeriodFilter.addEventListener('change', function() {
            const urlParams = new URLSearchParams(window.location.search);

            if (this.value) {
                urlParams.set('sub_period_id', this.value);
            } else {
                urlParams.delete('sub_period_id');
            }

            window.location.search = urlParams.toString();
        });

        // 3. Search Input dengan Debounce
        searchInput.addEventListener('input', function() {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                const urlParams = new URLSearchParams(window.location.search);

                if (this.value) {
                    urlParams.set('search', this.value);
                } else {
                    urlParams.delete('search');
                }

                window.location.search = urlParams.toString();
            }, 500);
        });
    </script>
@endsection
