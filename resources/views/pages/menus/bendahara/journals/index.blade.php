@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Jurnal Umum" />

    {{-- FILTER CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
        <form method="GET">

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-5">

                {{-- PERIOD --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                        Periode
                    </label>
                    <select name="period_id" id="filter_period"
                        class="w-full rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
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
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                        Sub Periode
                    </label>
                    <select name="sub_period_id" id="filter_sub_period"
                        class="w-full rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
                        <option value="">Semua</option>
                        @foreach ($subPeriods as $sub)
                            <option value="{{ $sub->id }}" @selected(request('sub_period_id') == $sub->id)>
                                {{ $sub->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                {{-- START DATE --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                        Dari Tanggal
                    </label>
                    <x-form.date-picker id="start_date" name="start_date" placeholder="Dari tanggal"
                        defaultDate="{{ request('start_date') }}" />
                </div>

                {{-- END DATE --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                        Sampai Tanggal
                    </label>
                    <x-form.date-picker id="end_date" name="end_date" placeholder="Sampai tanggal"
                        defaultDate="{{ request('end_date') }}" />
                </div>

                {{-- ACTION --}}
                <div class="flex items-end gap-2">
                    <x-ui.button type="submit" variant="primary"
                        class="w-full justify-center rounded-xl px-6 shadow-md shadow-primary/20">
                        <span class="flex items-center gap-2">
                            <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                            </svg>
                            Tampilkan
                        </span>
                    </x-ui.button>

                    <a href="{{ route('bendahara.journals.index') }}" class="w-full">
                        <x-ui.button variant="outline"
                            class="w-full justify-center rounded-xl px-6 shadow-md shadow-primary/20">
                            Reset
                        </x-ui.button>
                    </a>
                </div>

                {{-- EXPORT GROUP --}}
                <div class="flex items-center gap-3">
                    {{-- <a href="" class="w-full">
                        <x-ui.button variant="success" class="w-full justify-center rounded-xl px-6 shadow-md shadow-primary/20">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path
                                    d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                            </svg>
                            Excel
                        </x-ui.button>
                    </a>
                    <a href="" class="w-full">
                        <x-ui.button variant="danger" class="w-full justify-center rounded-xl px-6 shadow-md shadow-primary/20">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path
                                    d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                            </svg>
                            PDF
                        </x-ui.button>
                    </a> --}}
                </div>
            </div>
        </form>
    </div>

    <x-core.basic-tables.bendahara.journal-table :groupedJournals="$groupedJournals" />


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

            const res = await fetch(`/bendahara/periode/${periodId}/sub-periods`);
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
