@extends('errors.layout')

@section('title')
    {{ $title ?? '403' }}
@endsection

@section('message')
    {{ $message ?? 'Anda tidak diizinkan mengakses halaman ini' }}
@endsection