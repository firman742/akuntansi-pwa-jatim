@extends('errors.layout')

@section('content')
<div class="max-w-xl mx-auto text-center py-10">

    <h1 class="text-2xl font-bold text-red-600">
        {{ $title }}
    </h1>

    <p class="mt-4 text-gray-600">
        {{ $message }}
    </p>

    <a href="{{ url()->previous() }}"
       class="mt-6 inline-block px-4 py-2 bg-blue-600 text-white rounded">
        Kembali
    </a>

</div>
@endsection