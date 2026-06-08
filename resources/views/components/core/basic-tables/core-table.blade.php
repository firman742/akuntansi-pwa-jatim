@props([
    'title' => null,
    'description' => null,
])

<div class="rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-white/[0.03] shadow-sm overflow-hidden">

    {{-- HEADER --}}
    <div
        class="px-6 py-6 border-b border-gray-200 
                flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">

        {{-- TITLE --}}
        <div>
            @if ($title)
                <h2 class="text-xl font-semibold text-gray-800 dark:text-white/90">
                    {{ $title }}
                </h2>
            @endif

            @if ($description)
                <p class="text-sm text-gray-500 mt-1">
                    {{ $description }}
                </p>
            @endif
        </div>
        
        {{-- SEARCH BAR --}}
        <div class="flex items-center gap-2">
            {{ $search ?? '' }}
        </div>

        {{-- ACTION SLOT --}}
        <div class="flex flex-wrap items-center gap-2">
            {{ $actions ?? '' }}
        </div>

    </div>

    {{-- CONTENT --}}
    <div class="w-full overflow-x-auto min-w-0">
        {{ $slot }}
    </div>

</div>
