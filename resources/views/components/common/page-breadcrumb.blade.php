@props([
    'pageTitle' => 'Page',
    'pageDescription' => '',
    'pageIcon' => null,

    // breadcrumb level 2
    'defaultTitle' => null,
    'parentTitle' => null,
    'parentRoute' => null,

    // breadcrumb level 3
    'currentTitle' => null,
])

@php
    use App\Helpers\MenuHelper;
@endphp

<div class="mb-6 flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
    {{-- LEFT --}}
    <div class="flex items-start gap-4">
        @if ($pageIcon)
            <div
                class="flex h-12 w-12 items-center justify-center rounded-xl border border-brand-200 bg-brand-50 text-brand-500 dark:border-blue-400 dark:bg-gray-900 dark:text-brand-400">
                {!! MenuHelper::getIconSvg($pageIcon) !!}
            </div>
        @endif

        <div>
            <h1 class="text-xl font-semibold text-gray-800 dark:text-white/90">
                {{ $pageTitle }}
            </h1>

            @if ($pageDescription)
                <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
                    {{ $pageDescription }}
                </p>
            @endif
        </div>
    </div>

    {{-- RIGHT --}}
    <nav>
        <ol class="flex flex-wrap items-center gap-1.5 text-sm">
            {{-- HOME --}}
            <li>
                <a href="{{ route('home') }}"
                    class="inline-flex items-center gap-1.5 text-gray-500 transition hover:text-gray-800 dark:text-gray-400 dark:hover:text-gray-200">

                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor">

                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M3 10.25L12 3l9 7.25M5.25 9.5V20a1 1 0 001 1h3.5a1 1 0 001-1v-4.5a1 1 0 011-1h1.5a1 1 0 011 1V20a1 1 0 001 1h3.5a1 1 0 001-1V9.5" />

                    </svg>

                    <span>Home</span>

                </a>
            </li>

            @if ($parentTitle)
                <li class="text-gray-400">
                    /
                </li>
                <li>
                    <a href="{{ $parentRoute }}"
                        class="text-gray-500 transition hover:text-gray-800 dark:text-gray-400 dark:hover:text-gray-200">
                        {{ $parentTitle }}
                    </a>
                </li>
                @if ($currentTitle)
                    <li class="text-gray-400">
                        /
                    </li>
                    <li class="font-medium text-gray-800 dark:text-white/90">
                        {{ $currentTitle }}
                    </li>
                @endif
            @else
                <li class="text-gray-400">
                    /
                </li>

                <li class="font-medium text-gray-800 dark:text-white/90">
                    {{ $defaultTitle }}
                </li>
            @endif
        </ol>
    </nav>
</div>
