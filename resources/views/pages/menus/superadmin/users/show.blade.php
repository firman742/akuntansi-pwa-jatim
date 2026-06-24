@extends('layouts.app')

@section('title', 'Detail Pengguna')

@section('content')
    <x-common.page-breadcrumb 
        defaultTitle="Manajemn Pengguna" 
        pageTitle="Detail Pengguna"
        pageDescription="Monitoring dan kelola pengguna yang terdaftar di sistem" 
        pageIcon="user-profile" parentTitle="Manajemen Pengguna"
        :parentRoute="route('superadmin.users.index')" 
        currentTitle="Detail Pengguna" />

    <div class="rounded-2xl border border-gray-200 bg-white p-5 dark:border-gray-800 dark:bg-white/[0.03] lg:p-6">
        <div class="mb-5 flex items-center justify-between lg:mb-7">
            <h3 class="text-lg font-semibold text-gray-800 dark:text-white/90">
                Profile
            </h3>

            <a href="{{ route('superadmin.users.index') }}">
                <x-ui.button variant="outline" size="sm">
                    <x-slot:startIcon>
                        <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
                        </svg>
                    </x-slot:startIcon>
                    Kembali
                </x-ui.button>
            </a>
        </div>

        <x-core.user-profile.profile-card :user="$user" />
        <x-core.user-profile.personal-info-card :user="$user" />
    </div>
@endsection
