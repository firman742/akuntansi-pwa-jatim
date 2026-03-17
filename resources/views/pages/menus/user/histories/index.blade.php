@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Riwayat Transaksi" />

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
                        Dari
                    </label>
                    <x-form.date-picker id="start_date" name="start_date" placeholder="Dari tanggal"
                        defaultDate="{{ request('start_date') }}" />
                </div>

                {{-- END DATE --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                        Sampai
                    </label>
                    <x-form.date-picker id="end_date" name="end_date" placeholder="Sampai tanggal"
                        defaultDate="{{ request('end_date') }}" />
                </div>

                {{-- TYPE --}}
                <div class="flex flex-col gap-2">
                    <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                        Jenis Transaksi
                    </label>
                    <select name="transaction_type" id="filter_transaction_type"
                        class="w-full rounded-xl border-gray-200 bg-gray-50 px-4 py-2.5 text-sm transition focus:border-primary focus:bg-white focus:ring-primary">
                        <option value="">Semua</option>
                        <option value="INCOME" @selected(request('transaction_type') == 'INCOME')>Pemasukan</option>
                        <option value="EXPENSE" @selected(request('transaction_type') == 'EXPENSE')>Pengeluaran</option>
                    </select>
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

                    <a href="{{ route('user.histories.index') }}" class="w-full">
                        <x-ui.button variant="outline"
                            class="w-full justify-center rounded-xl px-6 shadow-md shadow-primary/20">
                            Reset
                        </x-ui.button>
                    </a>
                </div>

            </div>

        </form>
    </div>

    <div class="space-y-6">
        <x-core.basic-tables.user.history-table :transactions="$transactions" />
    </div>
@endsection
