@php
    $hasChildren = $coa->children->count() > 0;
@endphp

<div
    id="coa-item-{{ $coa->id }}"
    class="coa-node border-l pl-3 py-1 ml-{{ $level * 4 }}"
    data-id="{{ $coa->id }}"
    data-parent="{{ $coa->parent_id }}"
    data-name="{{ strtolower($coa->name) }}"
    data-code="{{ strtolower($coa->code) }}">

    <div class="flex items-center justify-between rounded-md px-2 py-1 hover:bg-gray-50 dark:hover:bg-white/[0.07]">

        <div class="flex items-center gap-2">

            @if ($hasChildren)
                <button onclick="toggleNode('{{ $coa->id }}')" class="text-xs text-gray-500 dark:text-white/90">
                    ▸
                </button>
            @endif

            <div>
                <div class="text-sm font-medium text-gray-800 dark:text-white/90">
                    {{ $coa->code }} - {{ $coa->name }}
                </div>

                <div class="text-xs text-gray-500 dark:text-white/90">
                    {{ strtoupper($coa->normal_balance) }}
                </div>
            </div>

        </div>

        <div class="flex items-center gap-2">

            <span
                class="inline-flex w-[120px] justify-center rounded-full px-2 py-0.5 text-theme-xs font-medium
                {{ $coa->is_active ? 
                    'bg-green-50 text-green-700 border border-green-500 dark:bg-green-500/15 dark:text-green-500 dark:border-green-500' : 
                    'bg-red-50 text-red-700 border border-red-500 dark:bg-red-500/15 dark:text-red-500 dark:border-red-' }}">
                {{ $coa->is_active ? 'Active' : 'Inactive' }}
            </span>

            {{-- EDIT --}}
            <a href="{{ route('bendahara.master.coas.edit', $coa->id) }}"
                class="flex h-8 w-8 items-center justify-center rounded-md text-blue-500 hover:bg-green-50 dark:text-blue-400 dark:hover:bg-green-500/10"
                title="Edit akun coa">
                <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                </svg>
            </a>

            {{-- Delete --}}
            <form action="{{ route('bendahara.master.coas.destroy', $coa->id) }}" method="POST"
                onsubmit="return confirm('Yakin ingin menghapus COA ini?')" class="inline-flex">
                @csrf
                @method('DELETE')

                <button type="submit"
                    class="flex h-8 w-8 items-center justify-center rounded-md text-red-600 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-500/10"
                    title="hapus akun coa">
                    <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0 1 16.138 21H7.862
                                                    a2 2 0 0 1-1.995-1.858L5 7m5 4v6m4-6v6
                                                    m1-10V4a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v3M4 7h16" />
                    </svg>
                </button>
            </form>

        </div>
    </div>

    @if ($hasChildren)
        <div id="node-{{ $coa->id }}" class="ml-4 mt-1 space-y-1">
            @foreach ($coa->children as $child)
                @include('components.core.lists.partials.coa-node', [
                    'coa' => $child,
                    'level' => $level + 1,
                ])
            @endforeach
        </div>
    @endif
</div>
