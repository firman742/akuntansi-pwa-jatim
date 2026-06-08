@extends('errors.layout')

@section('title')
    {{ $title ?? '500' }}
@endsection

@section('message')
    {{ $message ?? 'Server gagal terhubung' }}
@endsection