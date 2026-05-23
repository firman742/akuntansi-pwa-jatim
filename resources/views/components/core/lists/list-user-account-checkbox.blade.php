@props([
    'coas' => collect(),
    'assignedCoaIds' => [],
])

@php
    // 1. Filter data COA berdasarkan normal_balance dari seeder Anda ("DEBIT" & "CREDIT")
    $debitCoas = $coas->filter(function ($coa) {
        return in_array(strtoupper(trim($coa->normal_balance)), ['DEBIT', 'DEBET', 'D']);
    });

    $kreditCoas = $coas->filter(function ($coa) {
        return in_array(strtoupper(trim($coa->normal_balance)), ['CREDIT', 'KREDIT', 'K']);
    });

    // 2. Kelompokkan sisi DEBIT berdasarkan Nama Tipe Akun (ASET, BEBAN)
    $groupedDebit = $debitCoas
        ->sortBy([['level', 'asc'], ['order', 'asc']])
        ->groupBy(fn($coa) => $coa->accountType->name ?? 'Lainnya (Debet)');

    // 3. Kelompokkan sisi KREDIT berdasarkan Nama Tipe Akun (KEWAJIBAN, EKUITAS, PENDAPATAN)
    $groupedKredit = $kreditCoas
        ->sortBy([['level', 'asc'], ['order', 'asc']])
        ->groupBy(fn($coa) => $coa->accountType->name ?? 'Lainnya (Kredit)');
@endphp

{{-- Grid Utama Kontainer: Membagi Layar Menjadi Kiri (Debet) & Kanan (Kredit) --}}
<div class="grid grid-cols-1 lg:grid-cols-2 gap-6" x-data="coaTree()">

    {{-- SISI KIRI: DEBET --}}
    <div class="space-y-4">
        <div class="flex items-center gap-2 pb-2 border-b-2 border-blue-500 dark:border-blue-400">
            <span class="flex h-3 w-3 rounded-full bg-blue-500"></span>
            <h3 class="text-base font-bold text-gray-900 dark:text-white uppercase tracking-wider">
                DEBET
            </h3>
        </div>

        @if ($groupedDebit->isEmpty())
            <p class="text-sm text-gray-500 italic">Tidak ada akun bersaldo normal Debet.</p>
        @endif

        <div class="space-y-4">
            @foreach ($groupedDebit as $group => $items)
                @php $tree = $items->groupBy('parent_id'); @endphp

                {{-- Card per Account Type --}}
                <div
                    class="rounded-xl border border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-white/[0.03] shadow-sm">
                    <h4 class="mb-3 text-xs font-bold uppercase tracking-wider text-blue-600 dark:text-blue-400">
                        {{ $group }}
                    </h4>
                    <ul class="space-y-1">
                        @foreach ($tree[null] ?? [] as $parent)
                            @include('components.core.lists.partials.user-coa-node', [
                                'coa' => $parent,
                                'tree' => $tree,
                                'assignedCoaIds' => $assignedCoaIds,
                                'level' => $parent->level ?? 1,
                            ])
                        @endforeach
                    </ul>
                </div>
            @endforeach
        </div>
    </div>

    {{-- SISI KANAN: KREDIT --}}
    <div class="space-y-4">
        <div class="flex items-center gap-2 pb-2 border-b-2 border-green-500 dark:border-green-400">
            <span class="flex h-3 w-3 rounded-full bg-green-500"></span>
            <h3 class="text-base font-bold text-gray-900 dark:text-white uppercase tracking-wider">
                KREDIT
            </h3>
        </div>

        @if ($groupedKredit->isEmpty())
            <p class="text-sm text-gray-500 italic">Tidak ada akun bersaldo normal Kredit.</p>
        @endif

        <div class="space-y-4">
            @foreach ($groupedKredit as $group => $items)
                @php $tree = $items->groupBy('parent_id'); @endphp

                {{-- Card per Account Type --}}
                <div
                    class="rounded-xl border border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-white/[0.03] shadow-sm">
                    <h4 class="mb-3 text-xs font-bold uppercase tracking-wider text-green-600 dark:text-green-400">
                        {{ $group }}
                    </h4>
                    <ul class="space-y-1">
                        @foreach ($tree[null] ?? [] as $parent)
                            @include('components.core.lists.partials.user-coa-node', [
                                'coa' => $parent,
                                'tree' => $tree,
                                'assignedCoaIds' => $assignedCoaIds,
                                'level' => $parent->level ?? 1,
                            ])
                        @endforeach
                    </ul>
                </div>
            @endforeach
        </div>
    </div>

</div>

<script>
    if (typeof coaTree !== 'function') {

        function coaTree() {
            return {

                toggleParent(event) {

                    const checked = event.target.checked;

                    const currentNode = event.target.closest('[data-coa-node]');

                    if (!currentNode) return;

                    let parentId = currentNode.dataset.parentId;

                    while (parentId) {

                        const parentNode = document.querySelector(
                            `[data-coa-id="${parentId}"]`
                        );

                        if (!parentNode) break;

                        const parentCheckbox = parentNode.querySelector(
                            'input[type="checkbox"]'
                        );

                        if (parentCheckbox) {
                            parentCheckbox.checked = checked;
                        }

                        parentId = parentNode.dataset.parentId;
                    }

                    // cleanup parent jika semua child uncheck
                    this.cleanupParents();
                },

                cleanupParents() {

                    document.querySelectorAll('[data-coa-node]').forEach(node => {

                        const nodeId = node.dataset.coaId;

                        const childNodes = document.querySelectorAll(
                            `[data-parent-id="${nodeId}"]`
                        );

                        if (childNodes.length === 0) return;

                        let hasCheckedChild = false;

                        childNodes.forEach(child => {

                            const cb = child.querySelector(
                                'input[type="checkbox"]'
                            );

                            if (cb && cb.checked) {
                                hasCheckedChild = true;
                            }
                        });

                        const parentCheckbox = node.querySelector(
                            'input[type="checkbox"]'
                        );

                        if (parentCheckbox) {
                            parentCheckbox.checked = hasCheckedChild;
                        }
                    });
                }
            }
        }
    }
</script>
