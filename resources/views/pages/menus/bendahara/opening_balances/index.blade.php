@extends('layouts.app')

@section('title', 'Saldo Awal')

@section('content')
    <x-common.page-breadcrumb pageTitle="Saldo Awal" />

    {{-- FILTER & ACTION CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
        <form method="GET" class="space-y-6">

            {{-- FILTER SECTION --}}
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5">

                {{-- PERIOD --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-semibold uppercase tracking-wide text-gray-500">
                        Periode
                    </label>
                    <select name="period_id" id="filter_period"
                        class="w-full rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm
                               focus:border-primary focus:bg-white focus:ring-primary transition">
                        <option value="">Semua</option>
                        @foreach ($periods as $period)
                            <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                                {{ $period->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                {{-- SUB PERIOD --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-semibold uppercase tracking-wide text-gray-500">
                        Sub Periode
                    </label>
                    <select name="sub_period_id" id="filter_sub_period"
                        class="w-full rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm
                               focus:border-primary focus:bg-white focus:ring-primary transition">
                        <option value="">Semua</option>
                        @foreach ($subPeriods as $sub)
                            <option value="{{ $sub->id }}" @selected(request('sub_period_id') == $sub->id)>
                                {{ $sub->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                {{-- FILTER ACTION --}}
                <div class="flex items-end gap-3 col-span-1 md:col-span-2 lg:col-span-2">
                    <x-ui.button type="submit" variant="primary"
                        class="flex-1 justify-center rounded-xl px-5 py-2.5 shadow-sm">
                        Tampilkan
                    </x-ui.button>

                    <a href="{{ route('bendahara.opening-balances.index') }}" class="flex-1">
                        <x-ui.button variant="outline" class="w-full justify-center rounded-xl px-5 py-2.5">
                            Reset
                        </x-ui.button>
                    </a>
                </div>
            </div>
        </form>
    </div>

    {{-- TABLE --}}
    <div class="space-y-6">
        <x-core.basic-tables.core-table title="Kelola Saldo Awal" description="Buat dan kelola saldo awal berdasarkan periode">
            <x-slot name="actions">

                <a href="{{ route('bendahara.opening-balances.create') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Manual
                    </x-ui.button>
                </a>

                {{-- <a href="{{ route('bendahara.opening-balances.create-bulk') }}">
                    <x-ui.button variant="outline" class="rounded-xl px-4 py-2">
                        + Multi Periode
                    </x-ui.button>
                </a> --}}

            </x-slot>

            {{-- TABLE COMPONENT LU --}}
            <x-core.basic-tables.bendahara.opening-balance-table :openingBalances="$openingBalances" :periods="$periods" :periodId="$periodId"
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
