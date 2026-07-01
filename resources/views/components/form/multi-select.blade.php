@props([
    'id' => null,
    'name' => null,
    'label' => null,
    'placeholder' => 'Pilih Data',
    'options' => [],
    'optionValue' => 'id',
    'optionLabel' => 'name',
    'selected' => [],
    'required' => false,
    'disabled' => false,
])

@php

    $selected = old($name, $selected);

    if (!is_array($selected)) {
        $selected = $selected ? [$selected] : [];
    }

    $formattedOptions = collect($options)
        ->map(function ($item) use ($optionValue, $optionLabel) {
            // Collection berisi string
            if (is_string($item)) {
                return [
                    'id' => $item,
                    'name' => $item,
                ];
            }

            // Collection berisi array
            if (is_array($item)) {
                return [
                    'id' => $item[$optionValue],
                    'name' => $item[$optionLabel],
                ];
            }

            // Collection berisi object / model
            return [
                'id' => data_get($item, $optionValue),
                'name' => data_get($item, $optionLabel),
            ];
        })
        ->values();
@endphp

<div>
    @if ($label)
        <label for="{{ $id ?? $name }}" class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-400">

            {{ $label }}

            @if ($required)
                <span class="text-error-500">*</span>
            @endif
        </label>
    @endif

    <div x-data="{
        open: false,
    
        selected: @js($selected),
    
        options: @js($formattedOptions),
    
        toggleOption(id) {
    
            id = id.toString();
    
            if (this.selected.includes(id)) {
                this.selected = this.selected.filter(i => i != id);
            } else {
                this.selected.push(id);
            }
    
        },
    
        isSelected(id) {
            return this.selected.includes(id.toString());
        },
    
        optionName(id) {
            const option = this.options.find(o => o.id.toString() == id.toString());
    
            return option ? option.name : '';
        }
    }" class="relative" @click.away="open=false">

        {{-- Hidden Input --}}
        <template x-for="id in selected" :key="id">
            <input type="hidden" name="{{ $name }}[]" :value="id">
        </template>

        {{-- Select --}}
        <div @click="if(!{{ $disabled ? 'true' : 'false' }}) open=!open"
            class="flex min-h-11 cursor-pointer gap-2 rounded-lg border border-gray-300 bg-white px-3 py-2 shadow-sm transition hover:border-brand-300 focus-within:ring-2 focus-within:ring-brand-500/20 dark:border-gray-700 dark:bg-gray-900"
            @class([
                'opacity-60 cursor-not-allowed bg-gray-100 dark:bg-gray-800' => $disabled,
                'border-error-300 focus-within:ring-error-500/20' => $errors->has($name),
            ])>

            <div class="flex flex-1 flex-wrap items-center gap-2">

                <template x-if="selected.length==0">
                    <span class="text-sm text-gray-400">
                        {{ $placeholder }}
                    </span>
                </template>

                <template x-for="id in selected" :key="id">

                    <div
                        class="flex items-center rounded-full bg-brand-50 px-2.5 py-1 text-sm text-brand-700 dark:bg-brand-500/10 dark:text-brand-300">

                        <span x-text="optionName(id)"></span>

                        <button type="button" @click.stop="toggleOption(id)" class="ml-2">

                            <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">

                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M6 18L18 6M6 6l12 12" />

                            </svg>

                        </button>

                    </div>

                </template>

            </div>

            <svg class="mt-1 h-5 w-5 shrink-0 text-gray-500 transition" :class="open ? 'rotate-180' : ''" fill="none"
                stroke="currentColor" viewBox="0 0 24 24">

                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />

            </svg>

        </div>

        {{-- Dropdown --}}
        <div x-show="open" x-transition
            class="absolute z-50 mt-2 max-h-64 w-full overflow-auto rounded-xl border border-gray-200 bg-white shadow-lg dark:border-gray-700 dark:bg-gray-900">

            <template x-for="option in options" :key="option.id">

                <div @click="toggleOption(option.id)"
                    class="flex cursor-pointer items-center justify-between px-4 py-3 text-sm transition hover:bg-gray-100 dark:hover:bg-gray-800">

                    <span class="text-gray-700 dark:text-gray-200" x-text="option.name">
                    </span>

                    <svg x-show="isSelected(option.id)" class="h-5 w-5 text-brand-600" fill="none"
                        stroke="currentColor" viewBox="0 0 24 24">

                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />

                    </svg>

                </div>

            </template>

        </div>

    </div>

    @error($name)
        <p class="mt-1.5 text-xs text-error-500">
            {{ $message }}
        </p>
    @enderror

</div>
