@extends('errors.layout')

@section('title')
    {{ $title ?? '405' }}
@endsection

@section('message')
    {{ $message ?? 'Method tidak diizinkan.' }}
@endsection