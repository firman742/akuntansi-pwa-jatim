@extends('layouts.app')

@section('title', 'Penerimaan')

@section('content')
    <x-common.page-breadcrumb pageTitle="Penerimaan" />

    {{-- FILTER CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
        <form method="GET" class="flex flex-wrap items-end justify-between gap-5">

            <div class="flex flex-wrap items-end gap-5">
                {{-- Period --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">Periode</label>
                    <select name="period_id" id="filter_period"
                        class="w-48 rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
                        <option value="">Semua</option>
                        @foreach ($periods as $period)
                            <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                                {{ $period->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                {{-- Sub Periode --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                        Sub Periode
                    </label>

                    <select name="sub_period_id" id="filter_sub_period"
                        class="w-48 rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
                        <option value="">Semua</option>
                        @foreach ($subPeriods as $sub)
                            <option value="{{ $sub->id }}" @selected(request('sub_period_id') == $sub->id)>
                                {{ $sub->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                {{-- Action Buttons --}}
                <div class="flex gap-2">
                    <x-ui.button type="submit" variant="primary" class="rounded-xl px-6 shadow-md shadow-primary/20">
                        <span class="flex items-center gap-2">
                            <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                            </svg>
                            Tampilkan
                        </span>
                    </x-ui.button>

                    {{-- button reset --}}
                    <a href="{{ route('user.transactions.incomes.index') }}">
                        <x-ui.button variant="outline" class="rounded-xl px-6 shadow-md shadow-primary/20">
                            <span class="flex items-center gap-2">
                                Reset
                            </span>
                        </x-ui.button>
                    </a>
                </div>
            </div>

            {{-- CREATE GROUP --}}
            <div class="flex items-center gap-3">
                {{-- Create Manual --}}
                <a href="{{ route('user.transactions.incomes.create') }}">
                    <x-ui.button variant="danger" size="sm" class="rounded-xl px-4 flex items-center gap-2">
                        <svg class="h-4 w-4 stroke-current" viewBox="0 0 20 20" fill="none"
                            xmlns="http://www.w3.org/2000/svg">
                            <path d="M10 4.16699V15.8337" stroke="" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                            <path d="M4.16699 10H15.8337" stroke="" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                        </svg>
                        Tambah Penerimaan
                    </x-ui.button>
                </a>
            </div>
        </form>
    </div>
    
    <div class="space-y-6">
        <x-core.basic-tables.user.income-table :incomes="$incomes" />
    </div>
@endsection
