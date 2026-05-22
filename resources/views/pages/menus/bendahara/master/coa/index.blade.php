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

    {{-- SEARCH --}}
    <div class="mb-4">
        <input type="text" id="coaSearch" placeholder="Cari COA (kode / nama)..."
            class="w-full rounded-lg border px-4 py-2 text-sm focus:ring-2 focus:ring-blue-400">
    </div>

    <x-core.basic-tables.core-table title="Daftar COA"
        description="Chart of Accounts dikelompokkan berdasarkan jenis akun.">

        <x-slot name="actions">
            <a href="{{ route('bendahara.master.coas.create') }}">
                <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                    + Tambah COA
                </x-ui.button>
            </a>
        </x-slot>

        {{-- GRID 3 COLUMN --}}
        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-2 gap-4">

            @foreach ($groupedByType as $type => $coas)
                @php
                    $slug = Str::slug($type);
                @endphp

                {{-- CARD TYPE --}}
                <div class="rounded-xl border bg-white shadow-sm flex flex-col h-fit">

                    {{-- HEADER --}}
                    <div class="flex items-center justify-between border-b bg-gray-50 px-4 py-3">
                        <h2 class="font-semibold text-gray-700 text-sm">
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
        document.getElementById('coaSearch').addEventListener('input', function(e) {
            const value = e.target.value.toLowerCase();

            document.querySelectorAll('.coa-node').forEach(node => {
                const match =
                    node.dataset.name.includes(value) ||
                    node.dataset.code.includes(value);

                node.style.display = match ? '' : 'none';

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
    </script>

@endsection
