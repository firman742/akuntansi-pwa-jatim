<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>@yield('code') - @yield('title')</title>

    @vite(['resources/css/app.css'])
</head>

<body
    class="relative flex min-h-screen items-center justify-center overflow-hidden bg-gray-500 px-6 dark:from-gray-950 dark:via-gray-900 dark:to-gray-950">

    {{-- BACKGROUND --}}
    {{-- <div class="absolute left-0 top-0 h-72 w-72 rounded-full bg-blue-400/20 blur-3xl"></div>

    <div class="absolute bottom-0 right-0 h-72 w-72 rounded-full bg-purple-400/20 blur-3xl"></div> --}}

    {{-- CARD --}}
    <div
        class="relative w-full max-w-xl overflow-hidden rounded-xl border border-gray-300 bg-white p-10 text-center shadow-lg backdrop-blur-xl dark:border-white/10 dark:bg-gray-900/70">

        {{-- ICON --}}
        <div
            class="mx-auto flex h-24 w-24 items-center justify-center py-5 bg-red-100 shadow-inner dark:bg-red-500/10">

            <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 text-red-500" fill="none" viewBox="0 0 24 24"
                stroke="currentColor">

                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.8"
                    d="M12 9v2m0 4h.01M5.07 19h13.86c1.54 0 2.5-1.67 1.73-3L13.73 4c-.77-1.33-2.69-1.33-3.46 0L3.34 16c-.77 1.33.19 3 1.73 3z" />
            </svg>
        </div>

        {{-- ERROR CODE --}}
        <h1 class="mt-8 text-7xl font-extrabold tracking-tight text-gray-900 dark:text-white">
            @yield('code')
        </h1>

        {{-- TITLE --}}
        <h2 class="mt-4 text-3xl font-bold text-gray-800 dark:text-white">
            @yield('title')
        </h2>

        {{-- MESSAGE --}}
        <p class="mx-auto mt-4 max-w-md text-base leading-relaxed text-gray-500 dark:text-gray-400">
            @yield('message')
        </p>

        {{-- ACTION --}}
        <div class="mt-10 flex flex-col items-center justify-center gap-4 sm:flex-row">

            <a href="{{ url()->previous() }}"
                class="inline-flex items-center justify-center rounded-2xl bg-blue-500 px-6 py-3 text-sm font-semibold text-white shadow-lg shadow-blue-500/30 transition-all duration-300 hover:-translate-y-0.5 hover:bg-blue-700">

                Kembali
            </a>

            <a href="{{ route('home') }}"
                class="inline-flex items-center justify-center rounded-2xl border border-gray-300 bg-white px-6 py-3 text-sm font-semibold text-gray-700 transition-all duration-300 hover:bg-gray-100 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-200 dark:hover:bg-gray-700">

                Dashboard
            </a>
        </div>

        {{-- FOOTER --}}
        <div class="mt-10 border-t border-gray-200 py-5 text-xs text-gray-400 dark:border-gray-800">
            © {{ date('Y') }} Sistem {{ config('app.name') }}. All rights reserved.
        </div>
    </div>

</body>

</html>
