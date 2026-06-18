@props([
    'id' => null,
    'name',
    'label' => null,
    'placeholder' => 'Pilih Data',
    'value' => null,
    'xModel' => null,
    'required' => false,
    'disabled' => false,
    'minDate' => null,
    'maxDate' => null,
    'alpineDisabled' => null,
])

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
        isOptionSelected: '{{ old($name, $value) }}' !== ''
    }" class="relative z-20 bg-transparent">
        <select 
            id="{{ $id ?? $name }}" 
            name="{{ $name }}"
            @if ($xModel) 
                x-model="{{ $xModel }}" 
            @endif 
            @disabled($disabled)
            @required($required) 
            
            @if ($alpineDisabled) 
                x-bind:disabled="{{ $alpineDisabled }}" 
            @endif
            @change="isOptionSelected = true"
            @if ($alpineDisabled) :class="{
                'bg-gray-100 dark:bg-gray-800 cursor-not-allowed': {{ $alpineDisabled }},
                'bg-transparent dark:bg-gray-900': !{{ $alpineDisabled }}
            }" @endif
                {{ $attributes->merge([
                    'class' =>
                        'h-11 w-full appearance-none rounded-lg px-4 py-2.5 pr-11 text-sm shadow-theme-xs focus:outline-hidden focus:ring-3 border dark:text-white/90 placeholder:text-gray-400 ' .
                        ($disabled ? 'bg-gray-100 dark:bg-gray-800 cursor-not-allowed ' : 'bg-transparent dark:bg-gray-900 ') .
                        ($errors->has($name)
                            ? 'border-error-300 focus:border-error-300 focus:ring-error-500/10 dark:border-error-700 dark:focus:border-error-800'
                            : 'border-gray-300 focus:border-brand-300 focus:ring-brand-500/10 dark:border-gray-700 dark:focus:border-brand-800'),
            ]) }}>
            <option value="" class="text-gray-700 dark:bg-gray-900 dark:text-gray-400">
                {{ $placeholder }}
            </option>

            {{ $slot }}
        </select>

        <span class="pointer-events-none absolute top-1/2 right-4 -translate-y-1/2 text-gray-700 dark:text-gray-400">
            <svg class="stroke-current" width="20" height="20" viewBox="0 0 20 20" fill="none">
                <path d="M4.79175 7.396L10.0001 12.6043L15.2084 7.396" stroke-width="1.5" stroke-linecap="round"
                    stroke-linejoin="round" />
            </svg>
        </span>
    </div>

    @error($name)
        <p class="mt-1.5 text-theme-xs text-error-500">
            {{ $message }}
        </p>
    @enderror
</div>
