@extends('layouts.app')

@section('title', 'Detail Aktivitas')

@section('content')
    <div class="space-y-6">

        {{-- HEADER SUMMARY --}}
        <div
            class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm
                dark:border-white/[0.05] dark:bg-white/[0.03]">

            <div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">

                <div class="space-y-1">
                    <h2 class="text-lg font-semibold text-gray-800 dark:text-gray-100">
                        Detail Aktivitas
                    </h2>

                    <p class="text-sm text-gray-500 dark:text-gray-400">
                        Log aktivitas sistem secara lengkap dan terstruktur
                    </p>
                </div>

                <div class="flex items-center gap-3">
                    <a href="{{ route('superadmin.activity-logs.index') }}"
                        class="inline-flex items-center gap-2 px-5 py-3 text-lg font-medium
                        rounded-lg border border-gray-500 bg-white text-gray-700
                        hover:bg-gray-50 hover:text-gray-900
                        dark:border-white/[0.05] dark:bg-white/[0.03] dark:text-gray-300
                        dark:hover:bg-white/[0.06] transition">

                        <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                        </svg>

                        Kembali
                    </a>



                </div>
            </div>

            <div class="mt-4 text-sm text-gray-500 dark:text-gray-400">
                {{ $activityLog->created_at->format('d M Y, H:i') }}
            </div>

            <div class="mt-5">
                {{-- ACTION BADGE --}}
                <span class="px-3 py-1 text-xs font-semibold rounded-full
            @class([
                'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-300' =>
                    $activityLog->action === 'create',
                'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-300' =>
                    $activityLog->action === 'update',
                'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300' =>
                    $activityLog->action === 'delete',
            ])">
                    {{ $activityLog->action }}
                </span>

                {{-- MODULE --}}
                <span
                    class="px-3 py-1 text-xs rounded-full
                     bg-gray-100 text-gray-700
                     dark:bg-white/10 dark:text-gray-300">
                    {{ $activityLog->module }}
                </span>
            </div>
        </div>


        {{-- INFO GRID --}}
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

            {{-- USER --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5
                    dark:border-white/[0.05] dark:bg-white/[0.03]">
                <p class="text-xs text-gray-500 dark:text-gray-400">Pengguna</p>
                <p class="mt-1 font-semibold text-gray-800 dark:text-gray-100">
                    {{ $activityLog->user->name ?? '-' }}
                </p>
                <p class="text-sm text-gray-500">
                    {{ $activityLog->user->email ?? '-' }}
                </p>
            </div>

            {{-- IP --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5
                    dark:border-white/[0.05] dark:bg-white/[0.03]">
                <p class="text-xs text-gray-500 dark:text-gray-400">Alamat IP</p>
                <p class="mt-1 font-semibold text-gray-800 dark:text-gray-100">
                    {{ $activityLog->ip_address ?? '-' }}
                </p>
            </div>

            {{-- SUBJECT --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5
                    dark:border-white/[0.05] dark:bg-white/[0.03]">
                <p class="text-xs text-gray-500 dark:text-gray-400">Data Terkait</p>
                <p class="mt-1 font-semibold text-gray-800 dark:text-gray-100">
                    {{ class_basename($activityLog->subject_type) ?? '-' }}
                </p>
                <p class="text-sm text-gray-500">
                    ID: {{ $activityLog->subject_id ?? '-' }}
                </p>
            </div>

        </div>


        {{-- DESCRIPTION --}}
        @if ($activityLog->description)
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5
                dark:border-white/[0.05] dark:bg-white/[0.03]">

                <p class="text-xs text-gray-500 dark:text-gray-400 mb-2">Deskripsi</p>

                <p class="text-sm text-gray-700 dark:text-gray-200 leading-relaxed">
                    {{ $activityLog->description }}
                </p>

            </div>
        @endif


        {{-- DATA CHANGES --}}
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

            {{-- OLD VALUES --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5
                    dark:border-white/[0.05] dark:bg-white/[0.03]">

                <h3 class="text-sm font-semibold text-red-600 dark:text-red-400 mb-3">
                    Data Sebelum (Old Values)
                </h3>

                <pre class="text-xs bg-gray-50 dark:bg-black/20 p-3 rounded-lg overflow-auto text-gray-700 dark:text-gray-300">
{{ json_encode($activityLog->old_values, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) ?: '-' }}
            </pre>
            </div>

            {{-- NEW VALUES --}}
            <div
                class="rounded-2xl border border-gray-200 bg-white p-5
                    dark:border-white/[0.05] dark:bg-white/[0.03]">

                <h3 class="text-sm font-semibold text-green-600 dark:text-green-400 mb-3">
                    Data Sesudah (New Values)
                </h3>

                <pre class="text-xs bg-gray-50 dark:bg-black/20 p-3 rounded-lg overflow-auto text-gray-700 dark:text-gray-300">
{{ json_encode($activityLog->new_values, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) ?: '-' }}
            </pre>
            </div>

        </div>

    </div>
@endsection
