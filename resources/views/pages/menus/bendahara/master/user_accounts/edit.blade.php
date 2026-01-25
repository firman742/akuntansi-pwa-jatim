@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Assign COA ke Pengguna" />

    <div class="rounded-2xl border border-gray-200 bg-white p-5 dark:border-gray-800 dark:bg-white/[0.03] lg:p-6">
        <div class="mb-6 rounded-xl border border-gray-200 bg-gray-50 px-5 py-4
           dark:border-gray-800 dark:bg-white/[0.02]">

            <div class="flex flex-col gap-1">
                <h2 class="text-xl font-semibold text-gray-900 dark:text-white">
                    {{ $user->name }}
                </h2>

                <p class="text-sm text-gray-600 dark:text-gray-400">
                    {{ $user->email }}
                </p>
            </div>
        </div>




        <div class="p-4 border-t border-gray-100 dark:border-gray-800 sm:p-6">
            <div class="space-y-6">
                <form action="{{ route('bendahara.master.account-user.sync', $user->id) }}" method="POST">
                    @csrf

                    <x-core.lists.list-user-account-checkbox :coas="$coas" :assignedCoaIds="$assignedCoaIds" />

                    <div class="mt-6 flex justify-end gap-3">
                        <a href="{{ route('bendahara.master.account-user.index') }}">
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
