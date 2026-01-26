@extends('layouts.app')

@section('content')
<x-common.page-breadcrumb pageTitle="Riwayat Transaksi" />

<div class="space-y-6">
    <x-core.basic-tables.user.history-table :transactions="$transactions" />
</div>
@endsection
