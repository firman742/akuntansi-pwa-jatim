@props([
    'id' => null,
    'name' => null,
    'label' => null,
    'placeholder' => '',
    'form' => null,
    'value' => null,
    'rows' => 6,
    'required' => false,
    'readonly' => false,
    'disabled' => false,
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

    <div class="relative">
        <textarea id="{{ $id ?? $name }}" name="{{ $name }}" rows="{{ $rows }}" placeholder="{{ $placeholder }}" @if ($form) form="{{ $form }}" @endif
            @required($required) @readonly($readonly) @disabled($disabled)
            {{ $attributes->merge([
                'class' =>
                    'w-full rounded-lg bg-transparent px-4 py-2.5 text-sm shadow-theme-xs focus:outline-hidden focus:ring-3 text-gray-800 placeholder:text-gray-400 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30 border ' .
                    ($errors->has($name)
                        ? 'border-error-300 focus:border-error-300 focus:ring-error-500/10 dark:border-error-700 dark:focus:border-error-800'
                        : 'border-gray-300 focus:border-brand-300 focus:ring-brand-500/10 dark:border-gray-700 dark:focus:border-brand-800'),
            ]) }}>{{ old($name, $value) }}</textarea>

        @error($name)
            <span class="absolute top-4 right-3.5">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                        d="M2.58325 7.99967C2.58325 5.00813 5.00838 2.58301 7.99992 2.58301C10.9915 2.58301 13.4166 5.00813 13.4166 7.99967C13.4166 10.9912 10.9915 13.4163 7.99992 13.4163C5.00838 13.4163 2.58325 10.9912 2.58325 7.99967ZM7.99992 1.08301C4.17995 1.08301 1.08325 4.17971 1.08325 7.99967C1.08325 11.8196 4.17995 14.9163 7.99992 14.9163C11.8199 14.9163 14.9166 11.8196 14.9166 7.99967C14.9166 4.17971 11.8199 1.08301 7.99992 1.08301ZM7.09932 5.01639C7.09932 5.51345 7.50227 5.91639 7.99932 5.91639H7.99999C8.49705 5.91639 8.89999 5.51345 8.89999 5.01639C8.89999 4.51933 8.49705 4.11639 7.99999 4.11639H7.99932C7.50227 4.11639 7.09932 4.51933 7.09932 5.01639ZM7.99998 11.8306C7.58576 11.8306 7.24998 11.4948 7.24998 11.0806V7.29627C7.24998 6.88206 7.58576 6.54627 7.99998 6.54627C8.41419 6.54627 8.74998 6.88206 8.74998 7.29627V11.0806C8.74998 11.4948 8.41419 11.8306 7.99998 11.8306Z"
                        fill="#F04438" />
                </svg>
            </span>
        @enderror
    </div>

    @error($name)
        <p class="mt-1.5 text-theme-xs text-error-500">
            {{ $message }}
        </p>
    @enderror
</div>
