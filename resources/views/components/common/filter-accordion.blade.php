@props([
    'title' => 'Filter & Pencarian Data',
    'action' => request()->url(),
    'resetUrl' => request()->url(),
    'filterKeys' => ['search'],
])

@php
    $hasActiveFilters = request()->hasAny($filterKeys);
    $activeFilterCount = collect(request()->only($filterKeys))
        ->filter(fn($val) => filled($val))
        ->count();
@endphp

<div x-data="{ openFilter: @js($hasActiveFilters) }"
    {{ $attributes->merge(['class' => 'rounded-3xl border border-gray-200 bg-white shadow-xs dark:border-gray-800 dark:bg-gray-900 overflow-hidden transition-all']) }}>

    {{-- ACCORDION HEADER / TRIGGER --}}
    <button type="button" @click="openFilter = !openFilter"
        class="w-full flex items-center justify-between p-5 text-left transition hover:bg-gray-50/80 dark:hover:bg-gray-800/50 cursor-pointer">
        <div class="flex items-center gap-3">
            <div
                class="flex h-9 w-9 items-center justify-center rounded-xl bg-gray-100 text-gray-600 dark:bg-gray-800 dark:text-gray-300">
                <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z" />
                </svg>
            </div>
            <div>
                <div class="flex items-center gap-2">
                    <h3 class="text-base font-semibold text-gray-900 dark:text-white">{{ $title }}</h3>
                    @if ($activeFilterCount > 0)
                        <span
                            class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold bg-emerald-50 text-emerald-700 border border-emerald-200 dark:bg-emerald-900/30 dark:text-emerald-400 dark:border-emerald-800">
                            {{ $activeFilterCount }} Filter Aktif
                        </span>
                    @endif
                </div>
                <p class="text-xs text-gray-500 dark:text-gray-400">
                    Klik untuk <span x-text="openFilter ? 'menyembunyikan' : 'menampilkan'"></span> parameter pencarian
                </p>
            </div>
        </div>

        <div class="flex items-center gap-2 text-gray-400">
            <span class="text-xs font-medium hidden sm:inline"
                x-text="openFilter ? 'Sembunyikan' : 'Buka Filter'"></span>
            <svg class="w-5 h-5 transform transition-transform duration-200" :class="{ 'rotate-180': openFilter }"
                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
            </svg>
        </div>
    </button>

    {{-- ACCORDION CONTENT FORM --}}
    <div x-show="openFilter" x-transition:enter="transition ease-out duration-200"
        x-transition:enter-start="opacity-0 -translate-y-2" x-transition:enter-end="opacity-100 translate-y-0"
        x-transition:leave="transition ease-in duration-150" x-transition:leave-start="opacity-100 translate-y-0"
        x-transition:leave-end="opacity-0 -translate-y-2"
        class="px-6 pb-6 pt-2 border-t border-gray-100 dark:border-gray-800">
        <form method="GET" action="{{ $action }}" class="space-y-4 pt-2">

            {{-- Slot untuk Input / Select / Datepicker --}}
            {{ $slot }}

            {{-- BARIS TOMBOL AKSI --}}
            <div class="flex items-center justify-end gap-3 pt-2">
                <a href="{{ $resetUrl }}">
                    <x-ui.button type="button" variant="outline" size="sm" class="rounded-xl px-4 py-2">
                        Reset Filter
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm"
                    class="rounded-xl px-6 py-2 shadow-sm font-medium">
                    <svg class="w-4 h-4 mr-1.5 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                    </svg>
                    Terapkan Filter
                </x-ui.button>
            </div>
        </form>
    </div>
</div>
