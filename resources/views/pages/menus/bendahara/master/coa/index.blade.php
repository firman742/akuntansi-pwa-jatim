@extends('layouts.app')

@section('title', 'Master Data COA - Bendahara')

@section('content')
    <div class="space-y-6">

        {{-- BREADCRUMB --}}
        <x-common.page-breadcrumb defaultTitle="Master COA" pageTitle="Manajemen Master Chart of Accounts"
            pageDescription="Pusat pengelolaan, pemetaan, dan pembuatan struktur Chart of Accounts sistem" pageIcon="book" />

        {{-- ALERTS --}}
        @if ($errors->any())
            <div class="mb-4">
                <x-ui.alert variant="error" title="Terjadi Kesalahan">
                    <ul class="list-disc list-inside space-y-1">
                        @foreach ($errors->all() as $error)
                            <li class="text-rose-500">{{ $error }}</li>
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

        @if (session('error'))
            <div class="mb-4">
                <x-ui.alert variant="error" title="Gagal" message="{{ session('error') }}" />
            </div>
        @endif

        {{-- KPI SUMMARY METRICS --}}
        <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
            {{-- TOTAL COA MASTER --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-wider text-gray-400">Total Akun Sistem</p>
                        <h3 class="mt-2 text-2xl font-black text-gray-900 dark:text-white font-mono tabular-nums">
                            {{ number_format($stats['total_coa'] ?? 0) }} <span
                                class="text-xs font-normal text-gray-400">COA</span>
                        </h3>
                    </div>
                    <div class="p-2.5 bg-blue-50 text-blue-600 rounded-2xl dark:bg-blue-900/30 dark:text-blue-400">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Master akun terdaftar</p>
            </div>

            {{-- AKUN AKTIF --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-wider text-emerald-600 dark:text-emerald-400">Akun
                            Aktif</p>
                        <h3 class="mt-2 text-2xl font-black text-emerald-600 dark:text-emerald-400 font-mono tabular-nums">
                            {{ number_format($stats['active_coa'] ?? 0) }} <span
                                class="text-xs font-normal text-gray-400">COA</span>
                        </h3>
                    </div>
                    <div
                        class="p-2.5 bg-emerald-50 text-emerald-600 rounded-2xl dark:bg-emerald-900/30 dark:text-emerald-400">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Dapat diijinkan pada entri</p>
            </div>

            {{-- AKUN NON-AKTIF --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-wider text-rose-600 dark:text-rose-400">Akun
                            Non-Aktif</p>
                        <h3 class="mt-2 text-2xl font-black text-rose-600 dark:text-rose-400 font-mono tabular-nums">
                            {{ number_format($stats['inactive_coa'] ?? 0) }} <span
                                class="text-xs font-normal text-gray-400">COA</span>
                        </h3>
                    </div>
                    <div class="p-2.5 bg-rose-50 text-rose-600 rounded-2xl dark:bg-rose-900/30 dark:text-rose-400">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Diarsipkan / Dibekukan</p>
            </div>

            {{-- TOTAL TIPE AKUN --}}
            <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-wider text-purple-600 dark:text-purple-400">Kategori
                            Tipe Akun</p>
                        <h3 class="mt-2 text-2xl font-black text-purple-600 dark:text-purple-400 font-mono tabular-nums">
                            {{ number_format($stats['total_types'] ?? 0) }} <span
                                class="text-xs font-normal text-gray-400">Kelompok</span>
                        </h3>
                    </div>
                    <div class="p-2.5 bg-purple-50 text-purple-600 rounded-2xl dark:bg-purple-900/30 dark:text-purple-400">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M7 7h.01M7 11h.01M7 15h.01M11 7h8M11 11h8M11 15h8" />
                        </svg>
                    </div>
                </div>
                <p class="mt-2 text-xs text-gray-500 dark:text-gray-400">Pengelompokan struktur COA</p>
            </div>
        </div>

        {{-- TOOLBAR: SEARCH & ACTIONS --}}
        <div class="rounded-3xl border border-gray-200 bg-white p-5 shadow-xs dark:border-gray-800 dark:bg-gray-900">
            <div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
                {{-- SEARCH INPUT --}}
                <div class="relative flex-1 max-w-md">
                    <x-form.input id="searchId" name="search" placeholder="Cari berdasarkan kode atau nama akun COA..."
                        startIconSearch />
                </div>

                {{-- ACTION BUTTONS FOR BENDAHARA --}}
                <div class="flex flex-wrap items-center gap-3 justify-end">
                    {{-- TOGGLE ALL GROUPS BUTTON --}}
                    <button id="toggleAllGroupsBtn" onclick="toggleAllGroups(this)"
                        class="inline-flex items-center gap-2 rounded-xl border border-gray-200 bg-gray-50 px-4 py-2.5 text-xs font-semibold text-gray-700 transition hover:bg-gray-100 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-200 dark:hover:bg-gray-700">
                        <span>Sembunyikan Semua Kategori</span>
                        <svg class="w-4 h-4 transform transition-transform duration-200 rotate-180" fill="none"
                            viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                        </svg>
                    </button>

                    {{-- CREATE PARENT COA --}}
                    <a href="{{ route('bendahara.master.coas.create-parent') }}">
                        <x-ui.button variant="outline" class="rounded-xl px-4 py-2.5 text-xs shadow-xs font-semibold">
                            + Buat COA Induk
                        </x-ui.button>
                    </a>

                    {{-- CREATE CHILD COA --}}
                    <a href="{{ route('bendahara.master.coas.create-child') }}">
                        <x-ui.button variant="primary" class="rounded-xl px-4 py-2.5 text-xs shadow-xs font-semibold">
                            + Buat Sub COA
                        </x-ui.button>
                    </a>
                </div>
            </div>
        </div>

        @php
            use Illuminate\Support\Str;
        @endphp

        {{-- GROUPED COA CARDS GRID --}}
        <div class="grid grid-cols-1 gap-6 xl:grid-cols-2">
            @forelse ($groupedByType as $type => $coas)
                @php
                    $slug = Str::slug($type);
                    $totalInGroup = $coas->count();
                    $activeInGroup = $coas->where('is_active', true)->count();
                @endphp

                <div
                    class="rounded-3xl border border-gray-200 bg-white shadow-xs dark:border-gray-800 dark:bg-gray-900 flex flex-col h-fit overflow-hidden">

                    {{-- CARD HEADER --}}
                    <div
                        class="flex items-center justify-between border-b border-gray-100 bg-gray-50/80 px-6 py-4 dark:border-gray-800 dark:bg-gray-800/40">
                        <div class="flex items-center gap-3">
                            <div
                                class="flex h-9 w-9 items-center justify-center rounded-xl bg-blue-100 text-blue-600 font-bold dark:bg-blue-900/40 dark:text-blue-400">
                                {{ strtoupper(substr($type, 0, 2)) }}
                            </div>
                            <div>
                                <h2 class="font-bold text-gray-900 dark:text-white text-sm">
                                    {{ $type }}
                                </h2>
                                <p class="text-[11px] text-gray-400">
                                    {{ $activeInGroup }} dari {{ $totalInGroup }} akun aktif
                                </p>
                            </div>
                        </div>

                        <div class="flex items-center gap-2">
                            <span
                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold bg-blue-50 text-blue-700 dark:bg-blue-900/30 dark:text-blue-300">
                                {{ $totalInGroup }} Akun
                            </span>

                            <button onclick="toggleGroup('{{ $slug }}', this)"
                                class="p-1.5 rounded-lg text-gray-400 hover:text-gray-600 hover:bg-gray-100 dark:hover:bg-gray-800 dark:hover:text-gray-200 transition"
                                title="Sembunyikan/Tampilkan">
                                <svg class="w-5 h-5 transform transition-transform duration-200 rotate-180" fill="none"
                                    viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M19 9l-7 7-7-7" />
                                </svg>
                            </button>
                        </div>
                    </div>

                    {{-- CARD BODY TREE --}}
                    <div id="group-{{ $slug }}" class="p-4 space-y-2 max-h-[550px] overflow-y-auto">
                        @forelse ($coas->whereNull('parent_id') as $coa)
                            @include('components.core.lists.partials.coa-node', [
                                'coa' => $coa,
                                'level' => 0,
                                'showAction' => true,
                            ])
                        @empty
                            <div class="p-6 text-center text-xs text-gray-400">
                                Tidak ada akun level teratas untuk kategori ini.
                            </div>
                        @endforelse
                    </div>

                </div>
            @empty
                <div
                    class="col-span-full rounded-3xl border border-gray-200 bg-white p-12 text-center text-gray-400 dark:border-gray-800 dark:bg-gray-900">
                    Belum ada data Master COA yang terdaftar pada sistem.
                </div>
            @endforelse
        </div>

    </div>

    {{-- JAVASCRIPT: INTERACTIVE TREE & SEARCH --}}
    <script>
        // TOGGLE SINGLE NODE
        function toggleNode(id, button) {
            const el = document.getElementById('node-' + id);
            if (!el) return;

            el.classList.toggle('hidden');
            const icon = button.querySelector('svg');
            if (icon) {
                icon.classList.toggle('rotate-90');
            }
        }

        // TOGGLE GROUP CATEGORY
        function toggleGroup(id, button) {
            const el = document.getElementById('group-' + id);
            if (!el) return;

            el.classList.toggle('hidden');
            const icon = button.querySelector('svg');
            if (icon) {
                icon.classList.toggle('rotate-180');
            }
        }

        // TOGGLE ALL GROUPS
        let allGroupsOpened = true;

        function toggleAllGroups(button) {
            const groups = document.querySelectorAll('[id^="group-"]');
            const textSpan = button.querySelector('span');
            const icon = button.querySelector('svg');

            if (allGroupsOpened) {
                groups.forEach(group => group.classList.add('hidden'));
                if (textSpan) textSpan.textContent = 'Tampilkan Semua Kategori';
                if (icon) icon.classList.remove('rotate-180');
            } else {
                groups.forEach(group => group.classList.remove('hidden'));
                if (textSpan) textSpan.textContent = 'Sembunyikan Semua Kategori';
                if (icon) icon.classList.add('rotate-180');
            }

            allGroupsOpened = !allGroupsOpened;
        }

        // REALTIME CLIENT-SIDE SEARCH
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchId');
            if (!searchInput) return;

            searchInput.addEventListener('input', function(e) {
                const keyword = e.target.value.toLowerCase().trim();
                const nodes = document.querySelectorAll('.coa-node');

                if (!keyword) {
                    nodes.forEach(node => node.style.display = '');
                    return;
                }

                // Sembunyikan semua node terlebih dahulu
                nodes.forEach(node => node.style.display = 'none');

                // Tampilkan node yang sesuai kata kunci beserta parent utamanya
                nodes.forEach(node => {
                    const name = node.dataset.name || '';
                    const code = node.dataset.code || '';

                    if (name.includes(keyword) || code.includes(keyword)) {
                        node.style.display = '';

                        // Buka parent container jika tersembunyi
                        let parentId = node.dataset.parent;
                        while (parentId) {
                            const parentNode = document.querySelector(`[data-id="${parentId}"]`);
                            if (!parentNode) break;

                            parentNode.style.display = '';
                            const childrenContainer = document.getElementById('node-' + parentId);
                            if (childrenContainer) {
                                childrenContainer.classList.remove('hidden');
                            }

                            parentId = parentNode.dataset.parent;
                        }
                    }
                });
            });
        });
    </script>
@endsection
