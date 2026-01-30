@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Jurnal Umum" />

    <form method="GET"
        class="flex flex-wrap items-end justify-between gap-4 mb-6
           rounded-xl border border-gray-200 bg-white p-4">

        {{-- FILTER --}}
        <div class="flex flex-wrap items-end gap-4">
            {{-- Period --}}
            <div class="flex flex-col gap-1">
                <label class="text-xs font-semibold text-gray-600">
                    Periode
                </label>
                <select name="period_id"
                    class="rounded-lg border border-gray-200
                       px-3 py-2 text-sm
                       focus:border-blue-500 focus:ring-1 focus:ring-blue-500">
                    @foreach ($periods as $p)
                        <option value="{{ $p->id }}" @selected($periodId == $p->id)>
                            {{ $p->name }}
                        </option>
                    @endforeach
                </select>
            </div>

            {{-- Month --}}
            <div class="flex flex-col gap-1">
                <label class="text-xs font-semibold text-gray-600">
                    Bulan
                </label>
                <input type="month" name="month" value="{{ $month }}"
                    class="rounded-lg border border-gray-200
                       px-3 py-2 text-sm
                       focus:border-blue-500 focus:ring-1 focus:ring-blue-500">
            </div>

            {{-- Submit --}}
            <div class="flex gap-2">
                <x-ui.button type="submit" variant="primary" size="sm">
                    Tampilkan
                </x-ui.button>

                @if ($month)
                    <a href="{{ route('bendahara.journals.index', ['period_id' => $periodId]) }}">
                        <x-ui.button variant="outline" size="sm">
                            Reset
                        </x-ui.button>
                    </a>
                @endif
            </div>
        </div>

        {{-- EXPORT --}}
        <div class="flex gap-2">
            {{-- Excel --}}
            <a
                href="{{ route('bendahara.journals.export', [
                    'type' => 'excel',
                    'period_id' => $periodId,
                    'month' => $month,
                ]) }}">
                <x-ui.button variant="success" size="sm">
                    Export Excel
                </x-ui.button>
            </a>

            {{-- PDF --}}
            <a
                href="{{ route('bendahara.journals.export', [
                    'type' => 'pdf',
                    'period_id' => $periodId,
                    'month' => $month,
                ]) }}">
                <x-ui.button variant="danger" size="sm">
                    Export PDF
                </x-ui.button>
            </a>
        </div>
    </form>


    <x-core.basic-tables.bendahara.journal-table :journals="$journals" :periods="$periods" :periodId="$periodId" :month="$month" />
@endsection
