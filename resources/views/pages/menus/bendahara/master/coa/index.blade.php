@extends('layouts.app')

@section('title', 'Master Data - COA')

@section('content')
    <x-common.page-breadcrumb pageTitle="Master Data - COA" />

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

    @php
        use Illuminate\Support\Str;
    @endphp


    <x-core.basic-tables.core-table title="Daftar COA" description="Chart of Accounts dikelompokkan berdasarkan jenis akun.">

        <x-slot name="actions">
            <a href="{{ route('bendahara.master.coas.create-parent') }}">
                <x-ui.button variant="outline" class="rounded-xl px-4 py-2">
                    + Buat Akun COA Induk
                </x-ui.button>
            </a>
            
            <a href="{{ route('bendahara.master.coas.create-child') }}">
                <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                    + Buat Akun Sub COA
                </x-ui.button>
            </a>
        </x-slot>

        {{-- GRID 1 COLUMN --}}
        <div class="grid grid-cols-1 md:grid-cols-1 xl:grid-cols-1 gap-3 p-3">
            {{-- SEARCH BAR --}}
            <div class="relative">
                {{-- ICON --}}
                <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4">
                    <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M21 21l-4.35-4.35m1.85-5.15a7 7 0 11-14 0 7 7 0 0114 0z" />
                    </svg>
                </div>

                {{-- INPUT --}}
                <input type="text" id="coaSearch" placeholder="Cari berdasarkan kode atau nama COA..."
                    class="dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90 dark:placeholder:text-white/30
                   h-11 w-full rounded-xl border border-gray-300 bg-white pl-12 pr-12
                   text-sm text-gray-800 shadow-theme-xs
                   focus:border-brand-300 focus:outline-none focus:ring-3 focus:ring-brand-500/10" />

                {{-- CLEAR BUTTON --}}
                <button type="button" id="clearSearch"
                    class="absolute inset-y-0 right-0 hidden items-center pr-4 text-gray-400 hover:text-red-500">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
        </div>

        {{-- GRID 2 COLUMN --}}
        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-2 gap-4 p-2">

            @foreach ($groupedByType as $type => $coas)
                @php
                    $slug = Str::slug($type);
                @endphp

                {{-- CARD TYPE --}}
                <div class="rounded-xl border bg-white shadow-sm flex flex-col h-fit dark:bg-white/[0.03] dark:border-gray-700 dark:text-white/90">

                    {{-- HEADER --}}
                    <div class="flex items-center justify-between border-b bg-gray-50 px-4 py-3 dark:bg-white/[0.03]">
                        <h2 class="font-semibold text-gray-700 dark:text-white/90 text-sm">
                            {{ $type }}
                        </h2>

                        <button onclick="toggleGroup('{{ $slug }}')" class="text-xs text-blue-500 hover:underline">
                            Collapse
                        </button>
                    </div>

                    {{-- BODY --}}
                    <div id="group-{{ $slug }}" class="p-3 space-y-2 max-h-[500px] overflow-auto">

                        @foreach ($coas->whereNull('parent_id') as $coa)
                            @include('components.core.lists.partials.coa-node', [
                                'coa' => $coa,
                                'level' => 0,
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
        const searchInput = document.getElementById('coaSearch');
        const clearButton = document.getElementById('clearSearch');

        searchInput.addEventListener('input', function(e) {
            const value = e.target.value.toLowerCase().trim();

            // Toggle clear button
            if (value.length > 0) {
                clearButton.classList.remove('hidden');
                clearButton.classList.add('flex');
            } else {
                clearButton.classList.add('hidden');
                clearButton.classList.remove('flex');
            }

            document.querySelectorAll('.coa-node').forEach(node => {
                const match =
                    node.dataset.name.includes(value) ||
                    node.dataset.code.includes(value);

                node.style.display = match ? '' : 'none';

                // Auto expand parent
                if (match) {
                    let parent = node.parentElement;

                    while (parent) {
                        if (parent.id && parent.id.startsWith('node-')) {
                            parent.classList.remove('hidden');
                        }

                        parent = parent.parentElement;
                    }
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
