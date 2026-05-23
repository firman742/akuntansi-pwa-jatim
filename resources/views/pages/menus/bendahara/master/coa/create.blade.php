@extends('layouts.app')

@section('title', 'Master Data - Buat Sub Akun COA')

@section('content')
    <x-common.page-breadcrumb pageTitle="Buat Sub Akun COA" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>
                            <span class="text-gray-500 dark:text-gray-400">{{ $error }}</span>
                        </li>
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

    <x-common.component-card title="Tambah Akun COA">
        <form method="POST" action="{{ route('bendahara.master.coas.store') }}">
            @csrf
            <div class="grid grid-cols-1 md:grid-cols-1 gap-4" x-data="{
                parentId: '{{ old('parent_id', $parents->first()?->id) }}',            
                code: '-',
                level: 1,
                order: 1,
            
                accountTypeId: '{{ old('account_type_id') }}',
                normalBalance: '{{ old('normal_balance', $normalBalances[0] ?? '') }}',
            
                oldParentId: null,
            
                parentsData: @js(
                    $parents->mapWithKeys(
                        fn($item) => [
                            $item->id => [
                                'account_type_id' => $item->account_type_id,
                                'normal_balance' => $item->normal_balance,
                            ],
                        ],
                    ),
                ),
            
                async fetchCode() {
                    try {
                        let url = '{{ route('bendahara.master.coas.generate-code') }}';
            
                        if (this.parentId) {
                            url += '?parent_id=' + this.parentId;
                        }
            
                        const response = await fetch(url);
            
                        if (!response.ok) {
                            throw new Error('Gagal mengambil kode');
                        }
            
                        const data = await response.json();
            
                        this.code = data.code;
                        this.level = data.level;
                        this.order = data.order;
            
                    } catch (error) {
                        console.error(error);
            
                        this.code = 'Error';
                        this.level = 1;
                        this.order = 1;
                    }
                },
            
                syncParentData() {
                    if (!this.parentId) {
                        return;
                    }
            
                    const parent = this.parentsData[this.parentId];
            
                    if (!parent) {
                        return;
                    }
            
                    this.accountTypeId = parent.account_type_id;
                    this.normalBalance = parent.normal_balance;
                }
            }" x-init="fetchCode();
            syncParentData();
            oldParentId = parentId;"
                x-effect="
                if (parentId !== oldParentId) {
                    fetchCode();
                    syncParentData();
                    oldParentId = parentId;
                }
            ">
                {{-- Parent Akun --}}
                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Akun Induk (Opsional)
                    </label>
                    <select name="parent_id" x-model="parentId"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-11 w-full rounded-lg border border-gray-300 bg-transparent px-4 py-2.5 text-sm text-gray-800 focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:bg-gray-900 dark:text-white/90">
                        @foreach ($parents as $parent)
                            <option value="{{ $parent->id }}" @selected(old('parent_id') == $parent->id)>
                                {{ $parent->code }} - {{ $parent->name }}
                            </option>
                        @endforeach
                    </select>
                    <p class="mt-1 text-xs text-amber-600">
                        Child account wajib memiliki parent account.
                    </p>
                </div>

                {{-- Kode Akun Otomatis --}}
                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Kode Akun (Otomatis)
                    </label>

                    <input type="text" x-model="code" readonly disabled
                        class="dark:bg-dark-900 shadow-theme-xs h-11 w-full rounded-lg border border-gray-300 bg-gray-100 px-4 py-2.5 text-sm text-gray-700 dark:border-gray-700 dark:bg-gray-800 dark:text-white/70 cursor-not-allowed" />

                    {{-- Hidden fields untuk backend --}}
                    <input type="hidden" name="code" :value="code">
                    <input type="hidden" name="level" :value="level">
                    <input type="hidden" name="order" :value="order">

                    {{-- Info level & order --}}
                    <div class="mt-1 text-gray-500 text-sm">
                        Level: <span x-text="level"></span> • Order: <span x-text="order"></span>
                    </div>
                </div>

                {{-- Nama Akun --}}
                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Nama Akun COA
                    </label>
                    <input type="text" name="name"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-11 w-full rounded-lg border @error('name') border-error-300 focus:border-error-300 @else border-gray-300 @enderror bg-transparent px-4 py-2.5 text-sm text-gray-800 placeholder:text-gray-400 focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:bg-gray-900 dark:text-white/90 dark:placeholder:text-white/30" />
                    @error('name')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                {{-- Tipe Akun --}}
                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Tipe Akun
                    </label>

                    <select x-model="accountTypeId" :readonly="parentId" :disabled="parentId"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-11 w-full rounded-lg border border-gray-300 bg-gray-100 px-4 py-2.5 text-sm text-gray-800 focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:bg-gray-900 dark:text-white/90">

                        <option value="">-- Pilih Tipe Akun --</option>

                        @foreach ($accountTypes as $type)
                            <option value="{{ $type->id }}">
                                {{ $type->name }}
                            </option>
                        @endforeach
                    </select>

                    <input type="hidden" name="account_type_id" :value="accountTypeId">

                    <template x-if="parentId">
                        <p class="mt-1 text-xs text-yellow-600">
                            Mengikuti tipe akun parent.
                        </p>
                    </template>
                </div>

                {{-- Normal Balance --}}
                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Normal Balance
                    </label>

                    <select x-model="normalBalance" :readonly="parentId" :disabled="parentId"
                        class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10 dark:focus:border-brand-800 h-11 w-full rounded-lg border border-gray-300 bg-gray-100 px-4 py-2.5 text-sm text-gray-800 focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:bg-gray-900 dark:text-white/90">

                        @foreach ($normalBalances as $balance)
                            <option value="{{ $balance }}">
                                {{ $balance }}
                            </option>
                        @endforeach
                    </select>

                    <input type="hidden" name="normal_balance" :value="normalBalance">

                    <template x-if="parentId">
                        <p class="mt-1 text-xs text-yellow-600">
                            Mengikuti normal balance parent.
                        </p>
                    </template>
                </div>

                {{-- Aktif --}}
                <div class="col-span-1 md:col-span-2">
                    <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                        Aktifkan Akun
                    </label>
                    <div x-data="{ switcherToggle: true }">
                        <input type="hidden" name="is_active" value="0">
                        <label
                            class="flex cursor-pointer items-center gap-3 text-sm font-medium text-gray-700 select-none dark:text-gray-400">
                            <div class="relative">
                                <input type="checkbox" name="is_active" value="1" class="sr-only"
                                    x-model="switcherToggle" />
                                <div class="block h-6 w-11 rounded-full transition"
                                    :class="switcherToggle ? 'bg-brand-500 dark:bg-brand-500' : 'bg-gray-200 dark:bg-white/10'">
                                </div>
                                <div class="shadow-theme-sm absolute top-0.5 left-0.5 h-5 w-5
                                    rounded-full bg-white transition-transform duration-300"
                                    :class="switcherToggle ? 'translate-x-full' : 'translate-x-0'"></div>
                            </div>
                            <span x-text="switcherToggle ? 'Aktif' : 'Nonaktif'"></span>
                        </label>
                    </div>
                </div>
            </div>

            {{-- Submit --}}
            <div class="mt-8 flex justify-end gap-3">
                <a href="{{ route('bendahara.master.coas.index') }}">
                    <x-ui.button variant="outline" size="sm">Kembali</x-ui.button>
                </a>
                <x-ui.button type="submit" variant="primary" size="sm">Buat Akun COA</x-ui.button>
            </div>
        </form>
    </x-common.component-card>
@endsection
