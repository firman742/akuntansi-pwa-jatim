@props([
    'title',
])

@php
    use \Illuminate\Support\Str;

@endphp
<div
    x-show="activeTab === '{{ Str::slug($title) }}'"
    x-transition
    class="py-4"
>
    {{ $slot }}
</div>