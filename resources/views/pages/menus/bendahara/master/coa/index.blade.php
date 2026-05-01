@extends('layouts.app')

@section('title', 'Master Data - COA')

@section('content')
<x-common.page-breadcrumb pageTitle="Master Data - COA" />


    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan" >
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif
@php
    // Group COA by parent_id
    $grouped = $chartOfAccounts->groupBy('parent_id');

    // Tailwind border colors per level
    $levelColors = [
        'border-blue-400',
        'border-green-400',
        'border-yellow-400',
        'border-purple-400',
        'border-pink-400',
        'border-red-400',
    ];

    /**
     * Recursive render function
     */
    $renderTree = function ($parentId = null, $level = 0) use (&$renderTree, $grouped, $levelColors) {
        if (!isset($grouped[$parentId])) {
            return;
        }

        foreach ($grouped[$parentId] as $coa) {
            // Border color per level
            $color = $levelColors[$level % count($levelColors)];
@endphp

<div class="relative mt-2" style="margin-left: {{ $level * 1 }}rem;">
    <div class="flex items-start gap-3 pl-{{ 4 + $level * 2 }} border-l-4 {{ $color }}">
        <div class="w-full rounded-lg border p-3
            {{ $level == 0 ? 'bg-gray-100 shadow-md' : ($level == 1 ? 'bg-gray-50 shadow-sm' : 'bg-white') }}">
            
            <div class="flex justify-between items-start gap-4">
                <div>
                    <p class="text-sm font-semibold text-gray-800">
                        {{ $coa->code }} — {{ $coa->name }}
                    </p>
                    <p class="text-xs text-gray-500">
                        {{ $coa->accountType?->name ?? '-' }}
                        • Normal Balance: {{ strtoupper($coa->normal_balance) }}
                    </p>
                </div>

                <div class="flex items-center gap-2">
                    {{-- Status --}}
                    <span class="text-xs px-2 py-1 rounded-full
                        {{ $coa->is_active ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700' }}">
                        {{ $coa->is_active ? 'Active' : 'Inactive' }}
                    </span>

                    {{-- Edit --}}
                    <a href="{{ route('bendahara.master.coas.edit', $coa->id) }}" class="flex h-8 w-8 items-center justify-center rounded-md text-blue-600 hover:bg-blue-50 dark:text-blue-400 dark:hover:bg-blue-500/10" title="Edit akun coa">
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

                        <button type="submit" class="flex h-8 w-8 items-center justify-center rounded-md text-red-600 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-500/10" title="hapus akun coa">
                            <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                                                    stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0 1 16.138 21H7.862
                                                    a2 2 0 0 1-1.995-1.858L5 7m5 4v6m4-6v6
                                                    m1-10V4a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v3M4 7h16" />
                                                </svg>
                        </button>
                    </form>
                </div>
            </div>

            @if ($coa->description)
                <p class="text-xs text-gray-600 mt-2">
                    {{ $coa->description }}
                </p>
            @endif
        </div>
    </div>

    {{-- Children --}}
    <div class="mt-2">
        @php
            $renderTree($coa->id, $level + 1);
        @endphp
    </div>
</div>

@php
        }
    };
@endphp

<div class="space-y-6">
    <x-core.basic-tables.core-table title="Daftar COA" description="Berikut adalah daftar Chart of Accounts (COA) yang tersedia.">
        <x-slot name="actions">
            <a href="{{ route('bendahara.master.coas.create') }}">
                <x-ui.button variant="primary" class="rounded-xl px-4 py-2">
                    + Tambah COA
                </x-ui.button>
            </a>
        </x-slot>

        {{-- Table Component UI --}}
        {{-- Karena ini tree, kita render manual di bawah --}}
        <div class="border-gray-200 bg-white pt-4 dark:border-white/[0.05] dark:bg-white/[0.03] p-6 rounded-xl border">
            {{-- Render root --}}
            @php
                $renderTree(null, 0);
            @endphp
        </div>

    </x-core.basic-tables.core-table>
</div>
@endsection
