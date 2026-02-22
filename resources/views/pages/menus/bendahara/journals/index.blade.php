@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Jurnal Umum" />

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

                {{-- Month --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">Bulan</label>
                    <input type="month" name="month" value="{{ $month }}"
                        class="rounded-xl border-gray-200 bg-gray-50 px-4 py-2 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
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

                    @if ($month)
                        <a href="{{ route('bendahara.journals.index', ['period_id' => $periodId]) }}">
                            <x-ui.button variant="outline" type="button"
                                class="rounded-xl border-gray-300 bg-white hover:bg-gray-50">
                                Reset
                            </x-ui.button>
                        </a>
                    @endif
                </div>
            </div>

            {{-- EXPORT GROUP --}}
            <div class="flex items-center gap-3">
                <a
                    href="{{ route('bendahara.journals.export', ['type' => 'excel', 'period_id' => $periodId, 'month' => $month]) }}">
                    <x-ui.button variant="success" size="sm" class="rounded-xl px-4 flex items-center gap-2">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path
                                d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                        Excel
                    </x-ui.button>
                </a>
                <a
                    href="{{ route('bendahara.journals.export', ['type' => 'pdf', 'period_id' => $periodId, 'month' => $month]) }}">
                    <x-ui.button variant="danger" size="sm" class="rounded-xl px-4 flex items-center gap-2">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path
                                d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                        PDF
                    </x-ui.button>
                </a>
            </div>
        </form>
    </div>

    <x-core.basic-tables.bendahara.journal-table :groupedJournals="$groupedJournals" />
@endsection
