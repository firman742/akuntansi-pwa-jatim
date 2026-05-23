@extends('layouts.app')

@section('title', 'Detail Peran')

@section('content')
    <x-common.page-breadcrumb pageTitle="Detail Peran" />
    <div class="rounded-2xl border border-gray-200 bg-white p-5 dark:border-gray-800 dark:bg-white/[0.03] lg:p-6">
        <div class="mb-5 flex flex-wrap items-center justify-between gap-3 lg:mb-7">
            <h3 class="text-lg font-semibold text-gray-800 dark:text-white/90">
                Peran : {{ $role->name }}
            </h3>

            <div class="flex items-center gap-2">
                {{-- <a href="#" >
                    <x-ui.button size="sm">
                        <x-slot:startIcon>
                            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
                            </svg>
                        </x-slot:startIcon>
                        Buat Izin Baru
                    </x-ui.button>
                </a> --}}
            </div>
        </div>



        <div class="p-4 border-t border-gray-100 dark:border-gray-800 sm:p-6">
            <div class="space-y-6">
                <form action="{{ route('superadmin.roles.update', $role->id) }}" method="POST">
                    @csrf
                    @method('PUT')

                    <x-core.lists.list-role-checkbox :permissions="$permissions" :role="$role" />

                    <div class="mt-6 flex justify-end gap-3">
                        <a href="{{ route('superadmin.roles.index') }}">
                            <x-ui.button variant="outline" size="sm">Batal</x-ui.button>
                        </a>

                        <x-ui.button type="submit" size="sm">
                            Simpan Perubahan
                        </x-ui.button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
