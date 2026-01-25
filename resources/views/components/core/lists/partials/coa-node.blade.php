@php
    $hasChildren = isset($tree[$coa->id]);
    $indent = ($coa->level ?? 1) * 4;
@endphp

<li
    data-coa-node
    class=" py-1
           {{ $coa->level > 1 ? 'border-l border-gray-200 dark:border-gray-700' : '' }}" style="margin-left: {{ $indent }}px;">

    <label class="flex items-start gap-3 cursor-pointer select-none">
        <input
            type="checkbox"
            name="coa_ids[]"
            value="{{ $coa->id }}"
            class="mt-1 rounded border-gray-300 text-brand-500 focus:ring-brand-500"
            @checked(in_array($coa->id, $assignedCoaIds))
            @if ($hasChildren)
                @change="toggleParent"
            @endif
        >

        <span
            class="
                text-sm
                {{ $hasChildren ? 'font-semibold text-gray-900 dark:text-white' : 'text-gray-700 dark:text-gray-300' }}
            ">
            {{ $coa->code }} — {{ $coa->name }}
        </span>
    </label>

    @if ($hasChildren)
        <ul class="mt-1 space-y-1">
            @foreach ($tree[$coa->id] as $child)
                @include('components.core.lists.partials.coa-node', [
                    'coa' => $child,
                    'tree' => $tree,
                    'assignedCoaIds' => $assignedCoaIds,
                ])
            @endforeach
        </ul>
    @endif
</li>
