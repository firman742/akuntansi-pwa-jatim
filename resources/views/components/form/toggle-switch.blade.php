@props([
    'id' => null,
    'name',
    'label' => null,
    'value' => true,
    'onText' => 'Aktif',
    'offText' => 'Nonaktif',
    'required' => false,
    'disabled' => false,
])

@php
    $checked = filter_var(old($name, $value), FILTER_VALIDATE_BOOLEAN);
@endphp

<div>
    @if ($label)
        <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">
            {{ $label }}

            @if ($required)
                <span class="text-error-500">*</span>
            @endif
        </label>
    @endif

    <div x-data="{
        switcherToggle: {{ $checked ? 'true' : 'false' }}
    }">
        {{-- agar selalu terkirim --}}
        <input type="hidden" name="{{ $name }}" value="0">

        <label for="{{ $id ?? $name }}"
            class="flex cursor-pointer items-center gap-3 text-sm font-medium text-gray-700 select-none dark:text-gray-400">
            <div class="relative">

                <input id="{{ $id ?? $name }}" type="checkbox" name="{{ $name }}" value="1" class="sr-only"
                    x-model="switcherToggle" @disabled($disabled)>

                <div class="block h-6 w-11 rounded-full transition-all duration-300"
                    :class="switcherToggle
                        ?
                        'bg-brand-500 dark:bg-brand-500' :
                        'bg-gray-200 dark:bg-white/10'">
                </div>

                <div class="shadow-theme-sm absolute top-0.5 left-0.5 h-5 w-5 rounded-full bg-white transition-transform duration-300 ease-linear"
                    :class="switcherToggle
                        ?
                        'translate-x-full' :
                        'translate-x-0'">
                </div>
            </div>

            <span
                x-text="switcherToggle
                    ? '{{ $onText }}'
                    : '{{ $offText }}'">
            </span>
        </label>

        @error($name)
            <p class="mt-1.5 text-theme-xs text-error-500">
                {{ $message }}
            </p>
        @enderror
    </div>
</div>
