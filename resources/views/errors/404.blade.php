@extends('errors.layout')

@section('title')
    {{ $title ?? '404' }}
@endsection

@section('message')
    {{ $message ?? 'Halaman tidak ditemukan' }}
@endsection