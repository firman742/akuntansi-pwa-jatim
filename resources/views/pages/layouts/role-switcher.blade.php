@php
    use App\Enums\RoleEnum;

    $user = auth()->user();

    $roles = $user->getRoleNames();

    $hasBendahara = $roles->contains(RoleEnum::BENDAHARA->value);
    $hasAccounting = $roles->contains(RoleEnum::USER->value);

    $isBendahara = request()->is('bendahara*');
    $isAccounting = request()->is('user*');
@endphp

@if ($hasBendahara && $hasAccounting)

    <div x-show="$store.sidebar.isExpanded || $store.sidebar.isHovered || $store.sidebar.isMobileOpen" x-transition
        class="mt-auto border-t border-gray-200 pt-5 dark:border-gray-800">

        {{-- Heading --}}
        <div class="mb-4">
            <p class="text-xs font-semibold uppercase tracking-wider text-gray-500">
                Workspace
            </p>
        </div>

        {{-- Active Workspace --}}
        <div class="rounded-xl border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-900">

            <div class="flex items-start gap-3">

                {{-- Icon --}}
                <div
                    class="flex h-10 w-10 items-center justify-center rounded-lg bg-blue-50 text-blue-600 dark:bg-blue-500/10">

                    @if ($isBendahara)
                        {!! \App\Helpers\MenuHelper::getIconSvg('wallet') !!}
                    @else
                        {!! \App\Helpers\MenuHelper::getIconSvg('ledger') !!}
                    @endif

                </div>

                {{-- Content --}}
                <div class="min-w-0 flex-1">

                    <div class="flex items-center justify-between">

                        <h4 class="text-sm font-semibold text-gray-900 dark:text-white">
                            {{ $isBendahara ? 'Bendahara' : 'Accounting User' }}
                        </h4>

                        <span
                            class="rounded-full bg-green-100 px-2.5 py-1 text-[11px] font-medium text-green-700 dark:bg-green-500/10 dark:text-green-400">
                            Active
                        </span>

                    </div>

                    <p class="mt-2 mb-4 text-xs text-gray-500">
                        Workspace yang sedang digunakan.
                    </p>

                </div>
            </div>

            {{-- Divider --}}
            <div class="py-2 border-t border-gray-200 dark:border-gray-700"></div>

            {{-- Switch Button --}}
            @if ($isBendahara)
                <a href="{{ url('/user/dashboard') }}"
                    class="flex h-11 items-center justify-between rounded-lg border border-gray-300 bg-white px-4 text-sm font-medium text-gray-700 transition-all duration-200 hover:border-blue-500 hover:bg-blue-50 hover:text-blue-600 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 dark:hover:border-blue-500 dark:hover:bg-blue-500/10">

                    <span class="flex items-center gap-2">

                        {!! \App\Helpers\MenuHelper::getIconSvg('ledger') !!}

                        <span>Switch to Accounting</span>

                    </span>

                    <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">

                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7" />

                    </svg>

                </a>
            @elseif($isAccounting)
                <a href="{{ url('/bendahara/dashboard') }}"
                    class="flex h-11 items-center justify-between rounded-lg border border-gray-300 bg-white px-4 text-sm font-medium text-gray-700 transition-all duration-200 hover:border-blue-500 hover:bg-blue-50 hover:text-blue-600 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 dark:hover:border-blue-500 dark:hover:bg-blue-500/10">

                    <span class="flex items-center gap-2">

                        {!! \App\Helpers\MenuHelper::getIconSvg('wallet') !!}

                        <span>Switch to Bendahara</span>

                    </span>

                    <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">

                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7" />

                    </svg>

                </a>
            @endif

        </div>

    </div>

@endif
