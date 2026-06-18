@extends('layouts.app')

@section('title', 'Master Data - Buat Akun COA Induk')

@section('content')
    <x-common.page-breadcrumb pageTitle="Buat Akun COA Induk" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                    <li class="text-red-500">{{ $error }}</li>
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

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

                {{-- LEFT SIDE --}}
                <div class="grid-row">

                    {{-- FORM CARD --}}
                    <x-common.component-card title="Buat Akun COA Induk">

                        <div class="space-y-5">

                            {{-- Nama Akun --}}
                            <div>
                                <x-form.input 
                                    id="name" 
                                    name="name" 
                                    label="Nama Akun COA"
                                    placeholder="Contoh: Kas, Bank, Pendapatan" 
                                    value="{{ old('name') }}" 
                                    required />
                            </div>

                            {{-- Tipe Akun --}}
                            <div>
                                <x-form.select 
                                    id="account_type_id" 
                                    name="account_type_id" 
                                    label="Tipe Akun" 
                                    placeholder="Pilih Tipe Akun" 
                                    required>
                                    @foreach ($accountTypes as $type)
                                        <option value="{{ $type->id }}" @selected(old('account_type_id') == $type->id)>
                                            {{ $type->name }}
                                        </option>
                                    @endforeach
                                </x-form.select>
                            </div>

                            {{-- Normal Balance --}}
                            <div>
                                <x-form.select 
                                    id="normal_balance" 
                                    name="normal_balance" 
                                    label="Normal Balance" 
                                    placeholder="Pilih Normal Balance" 
                                    required>
                                    @foreach ($normalBalances as $balance)
                                        <option value="{{ $balance }}" @selected(old('normal_balance') == $balance)
                                            class="dark:bg-white/[0.03] dark:text-white/90 dark:border-gray-700">
                                            {{ $balance }}
                                        </option>
                                    @endforeach
                                </x-form.select>
                            </div>

                            {{-- Deskripsi --}}
                            <div>
                                <x-form.text-area name="description" label="Deskripsi" placeholder="Masukkan deskripsi...." rows="3" />
                            </div>

                            {{-- Status --}}
                            <div>
                                <x-form.toggle-switch name="is_active" label="Aktifkan Akun COA" :value="true" additionalAttributes="Status penggunaan akun dalam transaksi" onText="Akun Aktif" offText="Akun Tidak Aktif" />
                            </div>
                        </div>
                    </x-common.component-card>
                </div>

                {{-- RIGHT SIDE --}}
                <div class="grid-row">

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
