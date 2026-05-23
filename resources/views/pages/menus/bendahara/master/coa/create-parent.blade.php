@extends('layouts.app')

@section('title', 'Master Data - Buat Akun COA Induk')

@section('content')
    <x-common.page-breadcrumb pageTitle="Buat Akun COA Induk" />

    @if ($errors->any())
        <div class="mb-6">
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
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    <div x-data="{
        code: '-',
        level: 1,
        order: 1,
    
        async fetchCode() {
            try {
                const response = await fetch(
                    '{{ route('bendahara.master.coas.generate-code') }}'
                );
    
                if (!response.ok) {
                    throw new Error('Gagal mengambil kode');
                }
    
                const data = await response.json();
    
                this.code = data.code;
                this.level = data.level;
                this.order = data.order;
    
            } catch (error) {
                console.error(error);
    
                this.code = 'ERROR';
                this.level = 1;
                this.order = 1;
            }
        }
    }" x-init="fetchCode()">

        <form method="POST" action="{{ route('bendahara.master.coas.store') }}">
            @csrf

            {{-- Hidden parent kosong --}}
            <input type="hidden" name="parent_id" value="">

            {{-- Hidden auto generate --}}
            <input type="hidden" name="code" :value="code">
            <input type="hidden" name="level" :value="level">
            <input type="hidden" name="order" :value="order">

            <div class="grid grid-cols-1 xl:grid-cols-2 gap-6">

                {{-- LEFT SIDE --}}
                <div class="xl:col-span-2 space-y-6">

                    {{-- FORM CARD --}}
                    <x-common.component-card title="Buat Akun COA Induk">

                        <div class="space-y-5">

                            {{-- Nama Akun --}}
                            <div>
                                <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                                    Nama Akun COA
                                </label>

                                <input type="text" name="name" value="{{ old('name') }}"
                                    placeholder="Contoh: Kas, Bank, Pendapatan"
                                    class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-11 w-full rounded-lg border
                                    @error('name')
                                        border-error-300 focus:border-error-300
                                    @else
                                        border-gray-300
                                    @enderror
                                    bg-transparent px-4 py-2.5 text-sm text-gray-800 placeholder:text-gray-400 focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:text-white/90 dark:placeholder:text-white/30" />

                                @error('name')
                                    <p class="mt-1 text-sm text-error-500">
                                        {{ $message }}
                                    </p>
                                @enderror
                            </div>

                            {{-- Tipe Akun --}}
                            <div>
                                <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                                    Tipe Akun
                                </label>

                                <select name="account_type_id"
                                    class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:bg-gray-800 dark:text-white/90">
                                    <option value="">
                                        -- Pilih Tipe Akun --
                                    </option>

                                    @foreach ($accountTypes as $type)
                                        <option value="{{ $type->id }}" @selected(old('account_type_id') == $type->id)>
                                            {{ $type->name }}
                                        </option>
                                    @endforeach
                                </select>

                                @error('account_type_id')
                                    <p class="mt-1 text-sm text-error-500">
                                        {{ $message }}
                                    </p>
                                @enderror
                            </div>

                            {{-- Normal Balance --}}
                            <div>
                                <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                                    Normal Balance
                                </label>

                                <select name="normal_balance"
                                    class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:bg-gray-800 dark:text-white/90">
                                    @foreach ($normalBalances as $balance)
                                        <option value="{{ $balance }}" @selected(old('normal_balance') == $balance)
                                            class="dark:bg-white/[0.03] dark:text-white/90 dark:border-gray-700">
                                            {{ $balance }}
                                        </option>
                                    @endforeach
                                </select>

                                @error('normal_balance')
                                    <p class="mt-1 text-sm text-error-500">
                                        {{ $message }}
                                    </p>
                                @enderror
                            </div>

                            {{-- Deskripsi --}}
                            <div>
                                <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-300">
                                    Deskripsi
                                </label>

                                <textarea name="description" rows="2" placeholder="Tambahkan deskripsi akun jika diperlukan..."
                                    class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-3 text-sm text-gray-800 placeholder:text-gray-400 focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:text-white/90 dark:placeholder:text-white/30">{{ old('description') }}</textarea>
                            </div>

                            {{-- Status --}}
                            <div>
                                <label class="mb-3 block text-sm font-medium text-gray-700 dark:text-gray-300">
                                    Aktifkan Akun
                                </label>

                                <div x-data="{ active: true }">

                                    <input type="hidden" name="is_active" value="0">

                                    <label class="inline-flex cursor-pointer items-center gap-3">
                                        <div class="relative">
                                            <input type="checkbox" class="peer sr-only" x-model="active" name="is_active"
                                                value="1">
                                            <div class="h-6 w-11 rounded-full transition"
                                                :class="active ? 'bg-brand-500 dark:bg-brand-500' :
                                                    'bg-gray-200 dark:bg-white/10'">
                                            </div>

                                            <div class="absolute top-0.5 left-0.5 h-5 w-5 rounded-full bg-white transition-transform duration-300"
                                                :class="active ? 'translate-x-full' : 'translate-x-0'">
                                            </div>
                                        </div>

                                        <div>
                                            <p class="text-sm font-medium text-gray-700 dark:text-gray-300"
                                                x-text="active ? 'Akun Aktif' : 'Akun Nonaktif'">
                                            </p>

                                            <p class="text-xs text-gray-500">
                                                Status penggunaan akun dalam transaksi
                                            </p>
                                        </div>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </x-common.component-card>
                </div>

                {{-- RIGHT SIDE --}}
                <div class="space-y-6">

                    {{-- STRUCTURE CARD --}}
                    <x-common.component-card title="Struktur COA">

                        <div class="space-y-4">

                            <div
                                class="rounded-xl border border-gray-200 bg-gray-50 p-4 dark:border-gray-700 dark:bg-white/[0.03]">

                                <p class="mb-1 text-xs font-medium uppercase tracking-wide text-gray-500">
                                    Kode Akun
                                </p>

                                <div class="flex items-center justify-between">
                                    <h3 class="text-2xl font-bold tracking-wider text-brand-600 dark:text-brand-400"
                                        x-text="code">
                                    </h3>

                                    <span
                                        class="rounded-full bg-brand-100 px-2.5 py-1 text-xs font-medium text-brand-700 dark:bg-brand-500/10 dark:text-brand-400">
                                        AUTO
                                    </span>
                                </div>
                            </div>

                            <div class="grid grid-cols-2 gap-4">

                                <div class="rounded-xl border border-gray-200 p-4 dark:border-gray-700">

                                    <p class="mb-1 text-xs font-medium uppercase tracking-wide text-gray-500">
                                        Level
                                    </p>

                                    <h3 class="text-xl font-bold text-gray-800 dark:text-white" x-text="level">
                                    </h3>
                                </div>

                                <div class="rounded-xl border border-gray-200 p-4 dark:border-gray-700">

                                    <p class="mb-1 text-xs font-medium uppercase tracking-wide text-gray-500">
                                        Urutan
                                    </p>

                                    <h3 class="text-xl font-bold text-gray-800 dark:text-white" x-text="order">
                                    </h3>
                                </div>
                            </div>

                            <div
                                class="rounded-xl border border-emerald-200 bg-emerald-50 p-4 dark:border-emerald-500/20 dark:bg-emerald-500/10">

                                <div class="flex items-start gap-3">

                                    <div class="mt-0.5 text-emerald-700 dark:text-emerald-300">

                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                            viewBox="0 0 24 24" stroke="currentColor">

                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M13 16h-1v-4h-1m1-4h.01M21 12A9 9 0 113 12a9 9 0 0118 0z" />
                                        </svg>
                                    </div>

                                    <div>
                                        <h4 class="text-sm font-semibold text-emerald-700 dark:text-emerald-300">
                                            Parent Account
                                        </h4>

                                        <p class="mt-1 text-xs leading-relaxed text-emerald-700 dark:text-emerald-300">
                                            Akun ini akan menjadi root hierarchy
                                            dan dapat digunakan untuk membuat
                                            child account di bawahnya.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </x-common.component-card>

                    {{-- ACTION --}}
                    <div class="mt-8 flex items-center justify-end gap-3">

                        <a href="{{ route('bendahara.master.coas.index') }}">
                            <x-ui.button variant="outline" size="sm">
                                Kembali
                            </x-ui.button>
                        </a>

                        <x-ui.button type="submit" variant="primary" size="sm">

                            Simpan Parent COA
                        </x-ui.button>
                    </div>
                </div>


        </form>
    </div>
@endsection
