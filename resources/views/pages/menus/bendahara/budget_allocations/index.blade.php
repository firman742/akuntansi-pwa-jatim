@extends('layouts.app')

@section('title', 'Alokasi Dana Akun')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Alokasi Dana Akun" pageTitle="Kelola Alokasi Dana Akun"
        pageDescription="Monitoring dan kelola Alokasi Dana Akun berdasarkan periode" pageIcon="transaction" />

    {{-- TABLE --}}
    <div class="space-y-6">
        <x-core.basic-tables.core-table needFilter :filterColumns="1" resetUrl="{{ route('bendahara.budget-allocations.index') }}">
            {{-- SLOT search --}}
            <x-slot name="search">
                <x-form.input
                    id="searchId"
                    name="search"
                    value="{{ request('search') }}"
                    placeholder="Cari berdasarkan Akun atau kode COA..."
                    startIconSearch
                    endIconSearch
                />
            </x-slot>

            {{-- SLOT filter --}}
            <x-slot name="filters">
                <x-form.select 
                    id="filter_period" 
                    name="period_id" 
                    placeholder="Pilih Periode">
                    @foreach ($periods as $period)
                        <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                            {{ $period->name }}
                        </option>
                    @endforeach
                </x-form.select>

                <x-form.select 
                    id="filter_sub_period" 
                    name="sub_period_id" 
                    placeholder="Pilih Sub Periode">
                    <option value="">Semua</option>
                    @foreach ($subPeriods as $subPeriod)
                        <option value="{{ $subPeriod->id }}" @selected(request('sub_period_id') == $subPeriod->id)>
                            {{ $subPeriod->name }}
                        </option>
                    @endforeach
                </x-form.select>
            </x-slot>

            {{-- SLOT Action --}}
            <x-slot name="actions">
                <a href="{{ route('bendahara.budget-allocations.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Alokasikan Dana
                    </x-ui.button>
                </a>
            </x-slot>

            {{-- TABLE COMPONENT LU --}}
            <x-core.basic-tables.bendahara.budget-allocation-table :budgetAllocations="$budgetAllocations" :periods="$periods" :periodId="$periodId"
                :subPeriods="$subPeriods" :subPeriodId="$subPeriodId" />

        </x-core.basic-tables.core-table>
    </div>

    {{-- SCRIPT --}}
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
