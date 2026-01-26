@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Pengeluaran" />

    <div class="space-y-6">
        <x-core.basic-tables.user.expense-table :expenses="$expenses" />
    </div>
@endsection
