@extends('layouts.app')

@section('title', 'Daftar Transaksi Pengeluaran')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Daftar Transaksi Pengeluaran" pageTitle="Monitoring Daftar Transaksi Pengeluaran"
        pageDescription="Monitoring Daftar Transaksi Pengeluaran berdasarkan periode" pageIcon="transaction" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li class="text-dark-500">{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    <div class="space-y-6">
        <x-core.basic-tables.core-table needFilter resetUrl="{{ route('user.transactions.expenses.index') }}">
            {{-- SLOT search --}}
            <x-slot name="search">
                <x-form.input id="searchId" name="name" placeholder="Cari berdasarkan kode atau nama COA..." startIconSearch
                    endIconSearch />
            </x-slot>

            {{-- SLOT Filter --}}
            <x-slot name="filters">
                <x-form.select id="filter_period" name="period_id" placeholder="Pilih Periode">
                    @foreach ($periods as $period)
                        <option value="{{ $period->id }}" @selected(request('period_id') == $period->id)>
                            {{ $period->name }}
                        </option>
                    @endforeach
                </x-form.select>

                <x-form.select id="filter_sub_period" name="sub_period_id" placeholder="Pilih Sub Periode">
                    <option value="">Semua</option>
                    @foreach ($subPeriods as $subPeriod)
                        <option value="{{ $subPeriod->id }}" @selected(request('sub_period_id') == $subPeriod->id)>
                            {{ $subPeriod->name }}
                        </option>
                    @endforeach
                </x-form.select>

                <x-form.date-picker id="start_date" name="start_date" placeholder="Pilih Dari Tanggal"
                    defaultDate="{{ request('start_date') }}" />

                <x-form.date-picker id="end_date" name="end_date" placeholder="Pilih Sampai Tanggal"
                    defaultDate="{{ request('end_date') }}" />
            </x-slot>
            
            <x-slot name="actions">
                <div class="flex gap-3">
                    <a href="{{ route('user.transactions.expenses.create') }}">
                        <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                            + Buat Transaksi Pengeluaran Baru
                        </x-ui.button>
                    </a>
                </div>
            </x-slot>

            <x-core.basic-tables.user.expense-table :transactions="$transactions" />
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
