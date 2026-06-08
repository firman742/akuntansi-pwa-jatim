@extends('errors.layout')

@section('title', {{ $title ?? '404' }})
@section('message', {{ $message ?? 'Halaman yang Anda cari tidak ditemukan.' }})