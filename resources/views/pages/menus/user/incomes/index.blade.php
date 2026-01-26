@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Penerimaan" />

    <div class="space-y-6">
        <x-core.basic-tables.user.income-table :incomes="$incomes" />
    </div>
@endsection
