@props([
    'resetUrl' => null,
    'needFilter' => false,
])

<div class="rounded-2xl border border-gray-200 bg-white dark:border-gray-800 dark:bg-white/[0.03] shadow-sm">

    {{-- HEADER --}}
    <div
        class="px-6 py-6 border-b border-gray-200 
                flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">


        {{-- SEARCH BAR & FILTER SLOT --}}
        <div class="flex flex-wrap items-center gap-2">
            <div class="flex w-full flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">
                <div class="flex w-full flex-wrap gap-2 lg:w-auto">
                    {{-- SEARCH BAR --}}
                    <div>
                        {{ $search ?? '' }}
                    </div>

                    {{-- FILTER DROPDOWN --}}
                    @if ($needFilter)
                        <div class="relative" x-data="{ open: false }">

                            <x-ui.button type="button" variant="outline" @click="open = !open"
                                class="rounded-xl px-4 py-2">

                                <svg class="stroke-current fill-white dark:fill-gray-800" width="20" height="20"
                                    viewBox="0 0 20 20" fill="none">

                                    <path d="M2.29004 5.90393H17.7067" stroke-width="1.5" stroke-linecap="round"
                                        stroke-linejoin="round" />

                                    <path d="M17.7075 14.0961H2.29085" stroke-width="1.5" stroke-linecap="round"
                                        stroke-linejoin="round" />

                                    <path
                                        d="M12.0826 3.33331C13.5024 3.33331 14.6534 4.48431 14.6534 5.90414C14.6534 7.32398 13.5024 8.47498 12.0826 8.47498C10.6627 8.47498 9.51172 7.32398 9.51172 5.90415C9.51172 4.48432 10.6627 3.33331 12.0826 3.33331Z"
                                        stroke-width="1.5" />

                                    <path
                                        d="M7.91745 11.525C6.49762 11.525 5.34662 12.676 5.34662 14.0959C5.34661 15.5157 6.49762 16.6667 7.91745 16.6667C9.33728 16.6667 10.4883 15.5157 10.4883 14.0959C10.4883 12.676 9.33728 11.525 7.91745 11.525Z"
                                        stroke-width="1.5" />
                                </svg>

                                Filter
                            </x-ui.button>

                            {{-- FILTER PANEL --}}
                            <div x-show="open" x-cloak x-transition:enter="transition ease-out duration-200"
                                x-transition:enter-start="opacity-0 scale-95"
                                x-transition:enter-end="opacity-100 scale-100"
                                x-transition:leave="transition ease-in duration-150"
                                x-transition:leave-start="opacity-100 scale-100"
                                x-transition:leave-end="opacity-0 scale-95" @click.outside="open = false"
                                class="
                                    absolute
                                    top-full
                                    mt-3
                                    z-50

                                    left-0
                                    w-[calc(100vw-2rem)]

                                    sm:left-auto
                                    sm:right-0
                                    sm:w-[420px]

                                    rounded-2xl
                                    border
                                    border-gray-200
                                    bg-white
                                    shadow-2xl

                                    dark:border-gray-700
                                    dark:bg-gray-900/95
                                ">

                                <form method="GET" class="p-5">
                                    <div class="space-y-4">
                                        {{ $filters ?? '' }}
                                    </div>

                                    <div class="mt-5 flex gap-2">

                                        <x-ui.button type="submit" variant="primary" class="flex-1 justify-center">
                                            Tampilkan
                                        </x-ui.button>

                                        <a href="{{ $resetUrl }}" class="flex-1">

                                            <x-ui.button variant="outline" class="w-full justify-center">
                                                Reset
                                            </x-ui.button>

                                        </a>

                                    </div>

                                </form>
                            </div>
                        </div>
                    @endif

                    
                </div>
            </div>

        </div>

        {{-- ACTION BUTTONS --}}
        <div class="flex items-center gap-2">
            {{ $actions ?? '' }}
        </div>

    </div>

    {{-- CONTENT --}}
    <div class="w-full overflow-x-auto min-w-0">
        {{ $slot }}
    </div>

</div>
