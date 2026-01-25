@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Period" />

    <div class="space-y-6">
        <x-core.basic-tables.bendahara.period-table :periods="$periods" />
    </div>
@endsection
