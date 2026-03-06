@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Neraca Saldo Awal" />

    {{-- FILTER CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
        <form method="GET" class="flex flex-wrap items-end justify-between gap-5">

            <div class="flex flex-wrap items-end gap-5">
                {{-- Period --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">Periode</label>
                    <select name="period_id"
                        class="w-48 rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
                        @foreach ($periods as $p)
                            <option value="{{ $p->id }}" @selected($periodId == $p->id)>{{ $p->name }}</option>
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
                </div>
            </div>

            {{-- EXPORT GROUP --}}
            <div class="flex items-center gap-3">
                <a href="">
                    <x-ui.button variant="success" size="sm" class="rounded-xl px-4 flex items-center gap-2">
                        <svg class="h-4 w-4 stroke-current" viewBox="0 0 20 20" fill="none"
                            xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m6.75 12-3-3m0 0-3 3m3-3v6m-1.5-15H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z" />
                        </svg>
                        Import
                    </x-ui.button>
                </a>
                <a href="{{ route('bendahara.opening-balances.create') }}">
                    <x-ui.button variant="danger" size="sm" class="rounded-xl px-4 flex items-center gap-2">
                        <svg class="h-4 w-4 stroke-current" viewBox="0 0 20 20" fill="none"
                            xmlns="http://www.w3.org/2000/svg">
                            <path d="M10 4.16699V15.8337" stroke="" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                            <path d="M4.16699 10H15.8337" stroke="" stroke-width="1.5" stroke-linecap="round"
                                stroke-linejoin="round" />
                        </svg>
                        Tambah
                    </x-ui.button>
                </a>
            </div>
        </form>
    </div>

    <div class="space-y-6">
        <x-core.basic-tables.bendahara.opening-balance-table :openingBalances="$openingBalances" :periods="$periods" :periodId="$periodId" />
    </div>
@endsection
