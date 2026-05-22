@php
    $hasChildren = isset($tree[$coa->id]);
    // Mengecilkan perkalian indentasi agar pas di layout 2 kolom (kiri-kanan)
    $indent = (($coa->level ?? 1) - 1) * 12;
@endphp

<li data-coa-node class="py-1 {{ $coa->level > 1 ? 'border-l border-gray-100 dark:border-gray-800' : '' }}"
    style="padding-left: {{ $indent }}px;">

    <label
        class="flex items-start gap-2.5 cursor-pointer select-none py-0.5 rounded hover:bg-gray-50 dark:hover:bg-white/[0.02] px-1 transition-colors">
        <input type="checkbox" name="coa_ids[]" value="{{ $coa->id }}"
            class="mt-0.5 h-4 w-4 rounded border-gray-300 text-brand-500 focus:ring-brand-500 dark:border-gray-700 dark:bg-gray-800"
            @checked(in_array($coa->id, $assignedCoaIds)) @if ($hasChildren) @change="toggleParent" @endif>

        <span
            class="text-sm leading-tight px-2 {{ $hasChildren ? 'font-semibold text-gray-900 dark:text-white' : 'text-gray-600 dark:text-gray-300' }}">
            <span class="font-mono text-xs opacity-70"> [{{ $coa->code }}]</span> {{ $coa->name }}
        </span>
    </label>

    @if ($hasChildren)
        <ul class="mt-1 space-y-1">
            @foreach ($tree[$coa->id] as $child)
                @include('components.core.lists.partials.user-coa-node', [
                    'coa' => $child,
                    'tree' => $tree,
                    'assignedCoaIds' => $assignedCoaIds,
                ])
            @endforeach
        </ul>
    @endif
</li>
