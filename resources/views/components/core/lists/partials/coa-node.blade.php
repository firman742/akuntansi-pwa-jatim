@php
    $hasChildren = $coa->children && $coa->children->count() > 0;
    $showAction = $showAction ?? false;
@endphp

<div id="coa-item-{{ $coa->id }}"
    class="coa-node border-l-2 border-gray-100 dark:border-gray-800 pl-3 py-1.5 transition-all my-1"
    style="margin-left: {{ $level * 16 }}px;" data-id="{{ $coa->id }}" data-parent="{{ $coa->parent_id }}"
    data-name="{{ strtolower($coa->name) }}" data-code="{{ strtolower($coa->code) }}">

    <div
        class="flex items-center justify-between rounded-2xl p-2.5 bg-gray-50/50 hover:bg-blue-50/50 dark:bg-gray-800/30 dark:hover:bg-blue-950/20 border border-gray-100 dark:border-gray-800 transition-colors">

        <div class="flex items-center gap-2.5">
            {{-- EXPAND/COLLAPSE ICON FOR PARENT NODE --}}
            @if ($hasChildren)
                <button type="button" onclick="toggleNode('{{ $coa->id }}', this)"
                    class="p-1 rounded-lg text-gray-400 hover:text-blue-600 dark:hover:text-blue-400 transition cursor-pointer">
                    <svg class="w-4 h-4 transform transition-transform duration-200 rotate-90" fill="none"
                        viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                    </svg>
                </button>
            @else
                <span class="w-6 text-center text-gray-300 dark:text-gray-600 text-xs">&bull;</span>
            @endif

            <div>
                <div class="flex items-center gap-2">
                    <span
                        class="font-mono font-bold text-xs text-blue-600 dark:text-blue-400 bg-blue-50 dark:bg-blue-900/40 px-2 py-0.5 rounded-md">
                        {{ $coa->code }}
                    </span>
                    <h4 class="text-xs font-semibold text-gray-800 dark:text-gray-200">
                        {{ $coa->name }}
                    </h4>
                </div>

                <p class="text-[10px] text-gray-400 mt-0.5">
                    Normal Balance: <span
                        class="font-semibold text-gray-600 dark:text-gray-300">{{ strtoupper($coa->normal_balance) }}</span>
                </p>
            </div>
        </div>

        <div class="flex items-center gap-2">
            {{-- STATUS BADGE --}}
            <span
                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-[10px] font-bold uppercase
                {{ $coa->is_active
                    ? 'bg-emerald-50 text-emerald-700 dark:bg-emerald-900/40 dark:text-emerald-300'
                    : 'bg-rose-50 text-rose-700 dark:bg-rose-900/40 dark:text-rose-300' }}">
                {{ $coa->is_active ? 'Aktif' : 'Non-Aktif' }}
            </span>

            {{-- ACTION BUTTONS (IF PERMITTED) --}}
            @if ($showAction)
                <a href="{{ route('bendahara.master.coas.edit', $coa->id) }}"
                    class="p-1.5 rounded-lg text-blue-600 hover:bg-blue-50 dark:text-blue-400 dark:hover:bg-blue-900/30"
                    title="Edit COA">
                    <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                    </svg>
                </a>
            @endif
        </div>
    </div>

    {{-- RECURSIVE CHILD NODES --}}
    @if ($hasChildren)
        <div id="node-{{ $coa->id }}" class="mt-1 space-y-1">
            @foreach ($coa->children as $child)
                @include('components.core.lists.partials.coa-node', [
                    'coa' => $child,
                    'level' => $level + 1,
                    'showAction' => $showAction,
                ])
            @endforeach
        </div>
    @endif
</div>
