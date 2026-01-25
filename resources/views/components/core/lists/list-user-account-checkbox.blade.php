@props([
    'coas' => collect(),
    'assignedCoaIds' => [],
])

@php
    // Group by Account Type
    $groupedCoas = $coas
        ->sortBy([
            ['level', 'asc'],
            ['order', 'asc'],
        ])
        ->groupBy(fn ($coa) => $coa->accountType->name ?? 'Lainnya');
@endphp

<div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
@foreach ($groupedCoas as $group => $items)

    @php
        // Index COA by parent_id
        $tree = $items->groupBy('parent_id');
    @endphp

    <div
        x-data="coaTree()"
        class="rounded-lg border border-gray-200 bg-white
               dark:border-gray-800 dark:bg-white/[0.03]">

        {{-- Group Title --}}
        <h2
            class="px-4 py-2 text-sm font-semibold text-gray-700
                   dark:text-gray-300 border-b dark:border-gray-800">
            {{ $group }}
        </h2>

        <ul class="px-2 py-2 space-y-1">
            @foreach ($tree[null] ?? [] as $parent)
                @include('components.core.lists.partials.coa-node', [
                    'coa' => $parent,
                    'tree' => $tree,
                    'assignedCoaIds' => $assignedCoaIds,
                ])
            @endforeach
        </ul>
    </div>
@endforeach
</div>

{{-- Alpine Logic --}}
<script>
function coaTree() {
    return {
        toggleParent(event) {
            const checked = event.target.checked;
            const wrapper = event.target.closest('[data-coa-node]');
            wrapper.querySelectorAll('input[type=checkbox]').forEach(cb => {
                cb.checked = checked;
            });
        }
    }
}
</script>
