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
                        <li>{{ $error }}</li>
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

                        <button onclick="toggleGroup('{{ $slug }}')" class="text-xs text-blue-500 hover:underline">
                            Sembunyikan
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
        function toggleGroup(id) {
            const el = document.getElementById('group-' + id);
            if (!el) return;
            el.classList.toggle('hidden');
        }

        function toggleNode(id) {
            const el = document.getElementById('node-' + id);
            if (!el) return;
            el.classList.toggle('hidden');
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
