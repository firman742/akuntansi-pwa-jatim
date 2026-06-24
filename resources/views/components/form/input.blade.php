@props([
    'id' => null,
    'name' => null,
    'form' => null,
    'label' => null,
    'colorLabel' => 'gray',
    'type' => 'text',
    'xModel' => null,
    'placeholder' => '',
    'value' => null,
    'required' => false,
    'readonly' => false,
    'disabled' => false,
    'startIconSearch' => false,
    'endIconSearch' => false,
])

<div>
    @if ($label)
        <label for="{{ $id ?? $name }}"
            class="mb-1.5 block text-sm font-medium text-{{ $colorLabel }}-700 dark:text-{{ $colorLabel }}-400">
            {{ $label }}

            @if ($required)
                <span class="text-error-500">*</span>
            @endif
        </label>
    @endif

    <div
        class="relative"
        x-data="{
            showPassword: false
        }"
    >
        @if ($startIconSearch)
            {{-- ICON --}}
            <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4">
                <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M21 21l-4.35-4.35m1.85-5.15a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
            </div>
        @endif

        @if ($type === 'password')
            <input id="{{ $id ?? $name }}" name="{{ $name }}" x-bind:type="showPassword ? 'text' : 'password'"
                value="{{ $value }}" placeholder="{{ $placeholder }}" {{ $xModel ? "x-model={$xModel}" : '' }}
                @if ($form) form="{{ $form }}" @endif @required($required) @readonly($readonly)
                @disabled($disabled)
                {{ $attributes->merge([
                    'class' => \Illuminate\Support\Arr::toCssClasses([
                        'w-full rounded-lg px-4 py-2.5 text-sm shadow-theme-xs focus:outline-hidden focus:ring-3 h-11 text-gray-800 placeholder:text-gray-400 dark:text-white/90 dark:placeholder:text-white/30 border',
                        'pl-12' => $startIconSearch,
                        'pr-12',
                        'border-error-300 focus:border-error-300 focus:ring-error-500/10 dark:border-error-700 dark:focus:border-error-800' => $errors->has(
                            $name,
                        ),
                        'border-gray-300 focus:border-brand-300 focus:ring-brand-500/10 dark:border-gray-700 dark:focus:border-brand-800' => !$errors->has(
                            $name,
                        ),
                        'bg-gray-100 dark:bg-gray-800 cursor-not-allowed' => $readonly || $disabled,
                        'bg-transparent dark:bg-gray-900' => !$readonly && !$disabled,
                    ]),
                ]) }} />
        @else
            <input id="{{ $id ?? $name }}" name="{{ $name }}" type="{{ $type }}"
                value="{{ $value }}" placeholder="{{ $placeholder }}" {{ $xModel ? "x-model={$xModel}" : '' }}
                @if ($form) form="{{ $form }}" @endif @required($required) @readonly($readonly)
                @disabled($disabled)
                {{ $attributes->merge([
                    'class' => \Illuminate\Support\Arr::toCssClasses([
                        'w-full rounded-lg px-4 py-2.5 text-sm shadow-theme-xs focus:outline-hidden focus:ring-3 h-11 text-gray-800 placeholder:text-gray-400 dark:text-white/90 dark:placeholder:text-white/30 border',
                
                        'pl-12' => $startIconSearch,
                        'pr-12' => $endIconSearch,
                
                        'border-error-300 focus:border-error-300 focus:ring-error-500/10 dark:border-error-700 dark:focus:border-error-800' => $errors->has(
                            $name,
                        ),
                
                        'border-gray-300 focus:border-brand-300 focus:ring-brand-500/10 dark:border-gray-700 dark:focus:border-brand-800' => !$errors->has(
                            $name,
                        ),
                        'bg-gray-100 dark:bg-gray-800 cursor-not-allowed' => $readonly || $disabled,
                        'bg-transparent dark:bg-gray-900' => !$readonly && !$disabled,
                    ]),
                ]) }}
                />

            @error($name)
            <span class="absolute top-1/2 right-3.5 -translate-y-1/2">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                        d="M2.58325 7.99967C2.58325 5.00813 5.00838 2.58301 7.99992 2.58301C10.9915 2.58301 13.4166 5.00813 13.4166 7.99967C13.4166 10.9912 10.9915 13.4163 7.99992 13.4163C5.00838 13.4163 2.58325 10.9912 2.58325 7.99967ZM7.99992 1.08301C4.17995 1.08301 1.08325 4.17971 1.08325 7.99967C1.08325 11.8196 4.17995 14.9163 7.99992 14.9163C11.8199 14.9163 14.9166 11.8196 14.9166 7.99967C14.9166 4.17971 11.8199 1.08301 7.99992 1.08301ZM7.09932 5.01639C7.09932 5.51345 7.50227 5.91639 7.99932 5.91639H7.99999C8.49705 5.91639 8.89999 5.51345 8.89999 5.01639C8.89999 4.51933 8.49705 4.11639 7.99999 4.11639H7.99932C7.50227 4.11639 7.09932 4.51933 7.09932 5.01639ZM7.99998 11.8306C7.58576 11.8306 7.24998 11.4948 7.24998 11.0806V7.29627C7.24998 6.88206 7.58576 6.54627 7.99998 6.54627C8.41419 6.54627 8.74998 6.88206 8.74998 7.29627V11.0806C8.74998 11.4948 8.41419 11.8306 7.99998 11.8306Z"
                        fill="#F04438" />
                </svg>
                </span>
            @enderror
        @endif

        {{-- PASSWORD TOGGLE --}}
        @if ($type === 'password')
            <button
                type="button"
                @click="showPassword = !showPassword"
                class="absolute inset-y-0 right-0 flex items-center pr-4 text-gray-400 hover:text-brand-500"
            >
                {{-- Eye --}}
                <svg
                    x-show="showPassword"
                    x-cloak
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-5 w-5"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                >
                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                    />

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M2.458 12C3.732 7.943 7.523 5 12 5s8.268 2.943 9.542 7c-1.274 4.057-5.065 7-9.542 7S3.732 16.057 2.458 12z"
                    />
                </svg>

                {{-- Eye Slash --}}
                <svg
                    x-show="!showPassword"
                    x-cloak
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-5 w-5"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                >
                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M3 3l18 18"
                    />

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M10.584 10.587a2 2 0 102.828 2.828"
                    />

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M9.88 5.09A9.77 9.77 0 0112 5c4.478 0 8.268 2.943 9.542 7a9.77 9.77 0 01-4.132 5.411"
                    />

                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M6.228 6.228A9.77 9.77 0 002.458 12c1.274 4.057 5.064 7 9.542 7a9.77 9.77 0 004.132-.911"
                    />
                </svg>
            </button>
        @endif

        

        @if ($endIconSearch)
            {{-- CLEAR BUTTON --}}
            <button type="button" id="clearSearch"
                class="absolute inset-y-0 right-0 hidden items-center pr-4 text-gray-400 hover:text-red-500">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
        @endif
    </div>

    @error($name)
        <p class="mt-1.5 text-theme-xs text-error-500">
            {{ $message }}
        </p>
    @enderror
</div>
