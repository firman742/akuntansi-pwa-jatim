@extends('errors.layout')

@section('title')
    {{ $title ?? '401' }}
@endsection

@section('message')
    {{ $message ?? 'Anda diharuskan login untuk mengakses halaman ini.' }}
@endsection