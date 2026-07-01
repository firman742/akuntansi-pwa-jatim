@extends('layouts.app')

@section('title', 'Laporan Transaksi')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Laporan Transaksi" pageTitle="Monitoring Laporan Transaksi"
        pageDescription="Monitoring Laporan Transaksi berdasarkan periode" pageIcon="report" />

    {{-- FILTER CARD --}}
    <div class="mb-8 rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-white/[0.03] shadow-sm p-6">
        <form method="GET" class="space-y-6">

            {{-- ===================== --}}
            {{-- 1. CONTEXT (PERIOD - SUB - AKUN) --}}
            {{-- ===================== --}}
            <div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                    {{-- PERIOD --}}
                    <div class="flex flex-col gap-2">
                        <x-form.select id="filter_period" name="period_id" label="Periode" placeholder="Pilih Periode">
                            @foreach ($periods as $period)
                                <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                                    {{ $period->name }}
                                </option>
                            @endforeach
                        </x-form.select>
                    </div>

                    {{-- SUB PERIOD --}}
                    <div class="flex flex-col gap-2">
                        <x-form.select id="filter_sub_period" name="sub_period_id" label="Sub Periode"
                            placeholder="Pilih Sub Periode">
                            <option value="">Semua</option>
                            @foreach ($subPeriods as $subPeriod)
                                <option value="{{ $subPeriod->id }}" @selected(request('sub_period_id') == $subPeriod->id)>
                                    {{ $subPeriod->name }}
                                </option>
                            @endforeach
                        </x-form.select>
                    </div>

                    {{-- AKUN --}}
                    <div class="flex flex-col gap-2">
                        <x-form.select id="filter_transaction_type" name="transaction_type" label="Jenis Transaksi"
                            placeholder="Pilih Jenis Transaksi">
                            <option value="">Semua</option>
                            <option value="INCOME" @selected(request('transaction_type') == 'INCOME')>Pemasukan</option>
                            <option value="EXPENSE" @selected(request('transaction_type') == 'EXPENSE')>Pengeluaran</option>
                        </x-form.select>
                    </div>

                </div>
            </div>

            {{-- ===================== --}}
            {{-- 2. DATE RANGE --}}
            {{-- ===================== --}}
            <div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-5">

                    {{-- START DATE --}}
                    <div class="flex flex-col gap-2">
                        <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                            Dari Tanggal
                        </label>
                        <x-form.date-picker id="start_date" name="start_date" defaultDate="{{ request('start_date') }}" />
                    </div>

                    {{-- END DATE --}}
                    <div class="flex flex-col gap-2">
                        <label class="text-xs font-bold uppercase tracking-wider text-gray-500">
                            Sampai Tanggal
                        </label>
                        <x-form.date-picker id="end_date" name="end_date" defaultDate="{{ request('end_date') }}" />
                    </div>

                </div>
            </div>
            <div>
                <div class="grid grid-cols md:grid-cols-2 gap-5">
                    {{-- FILTER ACTION --}}
                    <div class="flex items-end gap-3 col-span-1 md:col-span-2 lg:col-span-2">
                        <x-ui.button type="submit" variant="primary"
                            class="flex-1 justify-center rounded-xl px-5 py-2.5 shadow-sm">
                            Tampilkan
                        </x-ui.button>

                        <a href="{{ route('user.transactions.histories.index') }}" class="flex-1">
                            <x-ui.button variant="outline" class="w-full justify-center rounded-xl px-5 py-2.5">
                                Reset
                            </x-ui.button>
                        </a>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div class="space-y-6">
        <x-core.basic-tables.core-table>
            <x-core.basic-tables.bendahara.transaction-table :transactions="$transactions" />
        </x-core.basic-tables.core-table>
    </div>

    {{-- SCRIPT: DEPENDENT SUB PERIOD --}}
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

            subPeriodFilter.innerHTML = '';

            data.forEach(sub => {
                subPeriodFilter.innerHTML += `<option value="${sub.id}">${sub.name}</option>`;
            });
        });
    </script>
@endsection
