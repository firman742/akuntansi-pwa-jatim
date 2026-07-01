@extends('layouts.app')

@section('title', 'Dana Operasional Pengguna')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Dana Operasional Pengguna" pageTitle="Dana Operasional Pengguna"
        pageDescription="Mengalokasikan Dana Operasional kepada masing-masing pengguna" pageIcon="transaction" />

    {{-- TABLE --}}
    <div class="space-y-6">
        <x-core.basic-tables.core-table needFilter>

            {{-- SLOT search --}}
            <x-slot name="search">
                <x-form.input id="searchId" name="search" value="{{ request('search') }}"
                    placeholder="Cari berdasarkan Nama Pengguna..." startIconSearch endIconSearch />
            </x-slot>

            {{-- SLOT filter --}}
            <x-slot name="filters">
                <x-form.select id="filter_period" name="period_id" label="Periode" placeholder="Pilih Periode">
                    @foreach ($periods as $period)
                        <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                            {{ $period->name }}
                        </option>
                    @endforeach
                </x-form.select>

                <x-form.select id="filter_sub_period" name="sub_period_id" label="Sub Periode"
                    placeholder="Pilih Sub Periode">
                    @foreach ($subPeriods as $sub)
                        <option value="{{ $sub->id }}" @selected(request('sub_period_id') == $sub->id)>
                            {{ $sub->name }}
                        </option>
                    @endforeach
                </x-form.select>
            </x-slot>

            {{-- SLOT ACTION --}}
            <x-slot name="actions">
                <a href="{{ route('bendahara.user-account-balances.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Alokasikan Dana Ke Pengguna
                    </x-ui.button>
                </a>
            </x-slot>

            {{-- TABLE COMPONENT LU --}}
            <x-core.basic-tables.bendahara.user-account-balance-table :userAccountBalances="$userAccountBalances" :periods="$periods" :periodId="$periodId"
                :subPeriods="$subPeriods" :subPeriodId="$subPeriodId" />

        </x-core.basic-tables.core-table>
    </div>

    {{-- SCRIPT --}}
    <script>
        const periodFilter = document.getElementById('filter_period');
        const subPeriodFilter = document.getElementById('filter_sub_period');
        const searchInput = document.getElementById('searchId');
        let timeout = null;

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

        searchInput.addEventListener('input', function() {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                const searchValue = this.value;
                const urlParams = new URLSearchParams(window.location.search);

                if (searchValue) {
                    urlParams.set('search', searchValue);
                } else {
                    urlParams.delete('search');
                }

                window.location.search = urlParams.toString();
            }, 500);
        });
    </script>
@endsection
