@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Period" />

    <div class="space-y-6">
        <x-core.basic-tables.bendahara.opening-balance-table :openingBalances="$openingBalances" :periods="$periods" :periodId="$periodId" />
    </div>
@endsection
