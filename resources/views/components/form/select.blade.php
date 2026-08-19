@props([
    'id' => null,
    'name' => null,
    'label' => null,
    'placeholder' => 'Pilih Data',
    'value' => null,
    'xModel' => null,
    'required' => false,
    'disabled' => false,
    'alpineDisabled' => null,
])

@php
    $inputId = $id ?? $name;
    $hasError = $name && $errors->has($name);
    $selectedValue = old($name, $value);
@endphp

<div class="w-full">
    {{-- Label --}}
    @if ($label)
        <label for="{{ $inputId }}" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
            {{ $label }}
            @if ($required)
                <span class="text-error-500 dark:text-error-400">*</span>
            @endif
        </label>
    @endif

    {{-- Select Container --}}
    <div x-data="{ isOptionSelected: @json(filled($selectedValue)) }" class="relative">
        <select id="{{ $inputId }}" @if ($name) name="{{ $name }}" @endif
            @if ($xModel) x-model="{{ $xModel }}" @endif
            @if ($alpineDisabled) x-bind:disabled="{{ $alpineDisabled }}" @endif
            @disabled($disabled) @required($required) @change="isOptionSelected = $event.target.value !== ''"
            @class([
                // Layout & Base Styles
                'h-11 w-full appearance-none rounded-lg px-4 py-2.5 pr-10 text-sm shadow-theme-xs transition-all duration-150 ease-in-out',
                'focus:outline-none focus:ring-3',
                // Background & Text Default
                'bg-white text-gray-900 dark:bg-gray-900 dark:text-white/90',
                // Native Disabled State
                'disabled:bg-gray-100 disabled:text-gray-400 disabled:cursor-not-allowed dark:disabled:bg-gray-800 dark:disabled:text-gray-500',
                // Error State
                'border border-error-300 focus:border-error-300 focus:ring-error-500/10 dark:border-error-700 dark:focus:border-error-600' => $hasError,
                // Normal State
                'border border-gray-300 focus:border-brand-300 focus:ring-brand-500/10 dark:border-gray-700 dark:focus:border-brand-800' => !$hasError,
            ])
            @if ($alpineDisabled) :class="{
                    'bg-gray-100 dark:bg-gray-800 cursor-not-allowed': {{ $alpineDisabled }},
                    'bg-white dark:bg-gray-900': !{{ $alpineDisabled }}
                }" @endif
            {{ $attributes }}>
            @if ($placeholder)
                <option value="" class="text-gray-400 dark:bg-gray-900 dark:text-gray-400">
                    {{ $placeholder }}
                </option>
            @endif

            {{ $slot }}
        </select>

        {{-- Dropdown Chevron Icon --}}
        <span
            class="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-3.5 text-gray-500 dark:text-gray-400">
            <svg class="h-5 w-5 transition-transform duration-200" fill="none" viewBox="0 0 24 24"
                stroke="currentColor" stroke-width="1.5">
                <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
            </svg>
        </span>
    </div>

    {{-- Error Message --}}
    @if ($name)
        @error($name)
            <p class="mt-1.5 text-xs text-error-500 dark:text-error-400">
                {{ $message }}
            </p>
        @enderror
    @endif
</div>
