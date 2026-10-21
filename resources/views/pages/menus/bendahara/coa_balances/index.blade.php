@extends('layouts.app')

@section('title', 'Saldo Akun')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Saldo Akun" pageTitle="Mutasi dan Posisi Saldo Akun"
        pageDescription="Monitoring dan kelola saldo akun berdasarkan periode" pageIcon="money" />

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
        <x-core.basic-tables.core-table needFilter resetUrl="{{ route('bendahara.coa-balances.index') }}">
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

                <x-form.select id="filter_coa" name="coa_id" label="Akun COA" placeholder="Pilih Akun COA">
                    @foreach ($coas as $coa)
                        <option value="{{ $coa->id }}" @selected($coaId == $coa->id)>
                            {{ $coa->code }} - {{ $coa->name }}
                        </option>
                    @endforeach
                </x-form.select>
            </x-slot>

            <x-core.basic-tables.bendahara.coa-balance-table :coaBalances="$coaBalances" :selectedSubPeriodName="$selectedSubPeriodName" />

        </x-core.basic-tables.core-table>
    </div>

    {{-- SCRIPT --}}
    <script>
        const periodFilter = document.getElementById('filter_period');
        const subPeriodFilter = document.getElementById('filter_sub_period');
        const coaFilter = document.getElementById('filter_coa');
        const searchInput = document.getElementById('searchId');
        let timeout = null;

        // 1. Filter Periode
        periodFilter.addEventListener('change', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (this.value) {
                urlParams.set('period_id', this.value);
            } else {
                urlParams.delete('period_id');
            }
            urlParams.delete('sub_period_id'); // Reset sub periode ketika periode utama berubah
            window.location.search = urlParams.toString();
        });

        // 2. Filter Sub Periode
        subPeriodFilter.addEventListener('change', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (this.value) {
                urlParams.set('sub_period_id', this.value);
            } else {
                urlParams.delete('sub_period_id');
            }
            window.location.search = urlParams.toString();
        });

        // 3. Filter COA
        coaFilter.addEventListener('change', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (this.value) {
                urlParams.set('coa_id', this.value);
            } else {
                urlParams.delete('coa_id');
            }
            window.location.search = urlParams.toString();
        });

        // 4. Search dengan Debounce
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
