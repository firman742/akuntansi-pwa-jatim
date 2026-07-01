@extends('layouts.app')

@section('title', 'Daftar COA Saya')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Akun COA" pageTitle="Manajemen Daftar Akun COA Saya"
        pageDescription="Monitoring dan kelola akun coa yang terdaftar di sistem" pageIcon="money" />

    @if ($errors->any())
        <div class="mb-4">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li class="text-danger-500">{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    @if (session('success'))
        <div class="mb-4">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    @php
        use Illuminate\Support\Str;
    @endphp

    <x-core.basic-tables.core-table>
        {{-- SLOT search --}}
        <x-slot name="search">
            <x-form.input id="searchId" name="name" placeholder="Cari berdasarkan kode atau nama COA..." startIconSearch
                endIconSearch />
        </x-slot>


        <x-slot name="actions">
            <div class="flex gap-3">
                <a href="{{ route('user.requests.coas.index') }}">
                    <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                        + Ajukan COA Baru
                    </x-ui.button>
                </a>
            </div>
        </x-slot>

        {{-- GRID 2 COLUMN --}}
        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-2 gap-4 p-2">

            @foreach ($groupedByType as $type => $coas)
                @php
                    $slug = Str::slug($type);
                @endphp

                {{-- CARD TYPE --}}
                <div
                    class="rounded-xl border bg-white shadow-sm flex flex-col h-fit dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90">

                    {{-- HEADER --}}
                    <div class="flex items-center justify-between border-b bg-gray-50 px-4 py-3 dark:bg-white/[0.03]">
                        <h2 class="font-semibold text-gray-700 dark:text-white/90 text-sm">
                            {{ $type }}
                        </h2>

                        <button onclick="toggleGroup('{{ $slug }}', this)"
                            class="inline-flex items-center gap-1 text-xs text-blue-500 hover:text-blue-600 underline">

                            <span>Sembunyikan</span>

                            <svg xmlns="http://www.w3.org/2000/svg"
                                class="h-4 w-4 transition-transform duration-200 rotate-180" fill="none"
                                viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                            </svg>
                        </button>
                    </div>

                    {{-- BODY --}}
                    <div id="group-{{ $slug }}" class="p-3 space-y-2 max-h-[500px] overflow-auto">

                        @foreach ($coas->whereNull('parent_id') as $coa)
                            @include('components.core.lists.partials.coa-node', [
                                'coa' => $coa,
                                'level' => 0,
                                'showAction' => false
                            ])
                        @endforeach

                    </div>
                </div>
            @endforeach

        </div>

    </x-core.basic-tables.core-table>

    {{-- JS --}}
    <script>
        // TOGGLE GROUP
        function toggleGroup(id, button) {
            const el = document.getElementById('group-' + id);

            if (!el) return;

            el.classList.toggle('hidden');

            const text = button.querySelector('span');
            const icon = button.querySelector('svg');

            if (el.classList.contains('hidden')) {
                text.textContent = 'Tampilkan';
                icon.classList.remove('rotate-180');
            } else {
                text.textContent = 'Sembunyikan';
                icon.classList.add('rotate-180');
            }
        }

        // TOGGLE ALL GROUPS
        let allGroupsOpened = true;

        function toggleAllGroups(button) {

            const groups = document.querySelectorAll('[id^="group-"]');

            const text = button.querySelector('span');
            const icon = button.querySelector('svg');

            if (allGroupsOpened) {

                groups.forEach(group => {
                    group.classList.add('hidden');
                });

                document.querySelectorAll('[onclick^="toggleGroup"]').forEach(btn => {

                    const span = btn.querySelector('span');
                    const svg = btn.querySelector('svg');

                    if (span) span.textContent = 'Tampilkan';
                    if (svg) svg.classList.remove('rotate-180');
                });

                text.textContent = 'Tampilkan Semua';
                icon.classList.remove('rotate-180');

            } else {

                groups.forEach(group => {
                    group.classList.remove('hidden');
                });

                document.querySelectorAll('[onclick^="toggleGroup"]').forEach(btn => {

                    const span = btn.querySelector('span');
                    const svg = btn.querySelector('svg');

                    if (span) span.textContent = 'Sembunyikan';
                    if (svg) svg.classList.add('rotate-180');
                });

                text.textContent = 'Sembunyikan Semua';
                icon.classList.add('rotate-180');
            }

            allGroupsOpened = !allGroupsOpened;
        }

        // SEARCH
        const searchInput = document.getElementById('searchId');
        const clearButton = document.getElementById('clearSearch');

        searchInput.addEventListener('input', function(e) {
            const keyword = e.target.value.toLowerCase().trim();

            const nodes = document.querySelectorAll('.coa-node');

            // reset dulu
            nodes.forEach(node => {
                node.style.display = '';
            });

            if (!keyword) {
                return;
            }

            // sembunyikan semua
            nodes.forEach(node => {
                node.style.display = 'none';
            });

            // cari yang match
            nodes.forEach(node => {

                const match =
                    node.dataset.name.includes(keyword) ||
                    node.dataset.code.includes(keyword);

                if (!match) return;

                // tampilkan dirinya
                node.style.display = '';

                // tampilkan seluruh parent
                let parentId = node.dataset.parent;

                while (parentId) {

                    const parentNode = document.querySelector(
                        `[data-id="${parentId}"]`
                    );

                    if (!parentNode) break;

                    parentNode.style.display = '';

                    const childrenContainer = document.getElementById(
                        'node-' + parentId
                    );

                    if (childrenContainer) {
                        childrenContainer.classList.remove('hidden');
                    }

                    parentId = parentNode.dataset.parent;
                }
            });
        });

        // CLEAR SEARCH
        clearButton.addEventListener('click', function() {
            searchInput.value = '';
            clearButton.classList.add('hidden');
            clearButton.classList.remove('flex');

            document.querySelectorAll('.coa-node').forEach(node => {
                node.style.display = '';
            });

            searchInput.focus();
        });
    </script>

@endsection
