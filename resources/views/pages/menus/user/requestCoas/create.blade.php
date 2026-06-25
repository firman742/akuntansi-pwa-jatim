@extends('layouts.app')

@section('title', 'Ajukan COA Baru')

@section('content')
    <x-common.page-breadcrumb pageTitle="Ajukan COA Baru" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-inside list-disc space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>
                            <span class="text-gray-500 dark:text-gray-400">
                                {{ $error }}
                            </span>
                        </li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    <x-common.component-card title="Form Pengajuan COA">

        <form method="POST" action="{{ route('user.requests.coas.store') }}" x-data="{
            parentCoaId: '{{ old('parent_coa_id') }}',
            previewCode: '-',
            accountTypeId: '{{ old('account_type_id') }}',
            normalBalance: '{{ old('normal_balance') }}',
        
            async fetchPreviewCode() {
                try {
        
                    let url = '{{ route('user.requests.coas.generate-code') }}';
        
                    if (this.parentCoaId) {
                        url += '?parent_id=' + this.parentCoaId;
                    }
        
                    const response = await fetch(url);
        
                    if (!response.ok) {
                        return;
                    }
        
                    const data = await response.json();
        
                    this.previewCode = data.code;
        
                } catch (error) {
                    this.previewCode = '-';
                }
            },
        
            syncParentData() {
        
                if (!this.parentCoaId) {
                    return;
                }
        
                const option = document.querySelector(
                    `select[name='parent_coa_id'] option[value='${this.parentCoaId}']`
                );
        
                if (!option) {
                    return;
                }
        
                this.accountTypeId = option.dataset.accountType;
                this.normalBalance = option.dataset.normalBalance;
            }
        }" 
        x-init="
            fetchPreviewCode();
            syncParentData();
        "
        x-effect="
            fetchPreviewCode();
            syncParentData();
        ">

            @csrf

            <div class="grid grid-cols-1 gap-5">

                {{-- Parent COA --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Akun Induk (Opsional)
                    </label>

                    <select name="parent_coa_id" x-model="parentCoaId"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10
                        dark:focus:border-brand-800 h-11 w-full rounded-lg border border-gray-300
                        bg-transparent px-4 py-2.5 text-sm text-gray-800 focus:ring-3
                        focus:outline-hidden dark:border-gray-700 dark:text-white/90">

                        @foreach ($parents as $parent)
                            <option value="{{ $parent->id }}" data-account-type="{{ $parent->account_type_id }}"
                                data-normal-balance="{{ $parent->normal_balance }}" @selected(old('parent_coa_id') == $parent->id)>
                                {{ $parent->code }} - {{ $parent->name }}
                            </option>
                        @endforeach

                    </select>

                    @error('parent_coa_id')
                        <p class="mt-1 text-sm text-red-500">
                            {{ $message }}
                        </p>
                    @enderror
                </div>

                {{-- Preview Kode --}}
                {{-- <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Preview Kode COA
                    </label>

                    <input type="text" x-model="previewCode" readonly
                        class="dark:bg-dark-900 h-11 w-full cursor-not-allowed rounded-lg border
                        border-gray-300 bg-gray-100 px-4 py-2.5 text-sm text-gray-700
                        dark:border-gray-700 dark:bg-gray-800 dark:text-white/70">

                    <p class="mt-1 text-xs text-gray-500">
                        Kode final akan ditentukan kembali saat proses penyimpanan.
                    </p>
                </div> --}}

                {{-- Nama COA --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Nama COA Yang Diajukan
                    </label>

                    <input type="text" name="proposed_name" value="{{ old('proposed_name') }}"
                        placeholder="Contoh: Kas Kecil Operasional"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10
                        dark:focus:border-brand-800 h-11 w-full rounded-lg border
                        border-gray-300 bg-transparent px-4 py-2.5 text-sm
                        text-gray-800 placeholder:text-gray-400 focus:ring-3
                        focus:outline-hidden dark:border-gray-700 dark:text-white/90">

                    @error('proposed_name')
                        <p class="mt-1 text-sm text-red-500">
                            {{ $message }}
                        </p>
                    @enderror
                </div>

                {{-- Account Type --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Tipe Akun
                    </label>

                    <select name="account_type_id" x-model="accountTypeId"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10
                        dark:focus:border-brand-800 h-11 w-full rounded-lg border
                        border-gray-300 bg-gray-100 px-4 py-2.5 text-sm
                        text-gray-800 focus:ring-3 focus:outline-hidden
                        dark:border-gray-700 dark:text-white/90" disabled>

                        <option value="">
                            -- Pilih Tipe Akun --
                        </option>

                        @foreach ($accountTypes as $type)
                            <option value="{{ $type->id }}" @selected(old('account_type_id') == $type->id)>
                                {{ $type->name }}
                            </option>
                        @endforeach
                    </select>

                    <input type="hidden" name="account_type_id" :value="accountTypeId">

                    @error('account_type_id')
                        <p class="mt-1 text-sm text-red-500">
                            {{ $message }}
                        </p>
                    @enderror
                </div>

                {{-- Normal Balance --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Normal Balance
                    </label>

                    <select name="normal_balance" x-model="normalBalance"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10
                        dark:focus:border-brand-800 h-11 w-full rounded-lg border
                        border-gray-300 bg-gray-100 px-4 py-2.5 text-sm
                        text-gray-800 focus:ring-3 focus:outline-hidden
                        dark:border-gray-700 dark:text-white/90" disabled>

                        @foreach ($normalBalances as $balance)
                            <option value="{{ $balance }}" @selected(old('normal_balance') == $balance)>
                                {{ $balance }}
                            </option>
                        @endforeach

                    </select>

                    <input type="hidden" name="normal_balance" :value="normalBalance">

                    @error('normal_balance')
                        <p class="mt-1 text-sm text-red-500">
                            {{ $message }}
                        </p>
                    @enderror
                </div>

                {{-- Deskripsi --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Alasan / Deskripsi Pengajuan
                    </label>

                    <textarea name="description" rows="4" placeholder="Jelaskan alasan kebutuhan akun COA baru..."
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10
                        dark:focus:border-brand-800 w-full rounded-lg border
                        border-gray-300 bg-transparent px-4 py-3 text-sm
                        text-gray-800 placeholder:text-gray-400 focus:ring-3
                        focus:outline-hidden dark:border-gray-700 dark:text-white/90">{{ old('description') }}</textarea>

                    @error('description')
                        <p class="mt-1 text-sm text-red-500">
                            {{ $message }}
                        </p>
                    @enderror
                </div>

            </div>

            <div class="mt-8 flex justify-end gap-3">

                <a href="{{ route('user.requests.coas.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Ajukan COA
                </x-ui.button>

            </div>

        </form>

    </x-common.component-card>
@endsection
