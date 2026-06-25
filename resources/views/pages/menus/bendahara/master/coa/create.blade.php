@extends('layouts.app')

@section('title', 'Master Data - Buat Sub Akun COA')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Tambah Sub Akun COA " pageTitle="Tambah Sub Akun COA"
        pageDescription="Monitoring dan kelola Sub Akun COA yang terdaftar di sistem" pageIcon="book" parentTitle="Akun COA"
        :parentRoute="route('bendahara.master.coas.index')" currentTitle="Tambah Sub Akun" />

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

    <x-common.component-card title="Tambah Akun COA">
        <form method="POST" action="{{ route('bendahara.master.coas.store') }}">
            @csrf
            <div class="grid grid-cols-2 sm:grid-cols-1 gap-4" x-data="{
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
            }" 
            x-init="
                fetchCode();
                syncParentData();
                oldParentId = parentId;
            "
            x-effect="
                if (parentId !== oldParentId) {
                    fetchCode();
                    syncParentData();
                    oldParentId = parentId;
                }
            ">
                {{-- Parent Akun --}}
                <div class="col-span-2 sm:col-span-1">
                    <x-form.select id="parent_id" name="parent_id" xModel="parentId" label="Parent Akun COA"
                        placeholder="Pilih Tipe Akun" required>
                        @foreach ($parents as $parent)
                            <option value="{{ $parent->id }}" @selected(old('parent_id') == $parent->id)>
                                {{ $parent->code }} - {{ $parent->name }}
                            </option>
                        @endforeach
                    </x-form.select>
                    <p class="mt-1 text-xs text-amber-600">
                        Sub Akun wajib memiliki Akun COA Induk. Jika tidak ada, silakan buat Akun COA Induk terlebih dahulu.
                    </p>
                </div>

                {{-- Kode Akun Otomatis --}}
                <div class="col-span-2 sm:col-span-1">
                    <x-form.input id="code" name="code" xModel="code" label="Kode Akun (Otomatis)" readonly
                        disabled />

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
                <div class="col-span-2 sm:col-span-1">
                    <x-form.input id="name" name="name" xModel="name" label="Nama Akun COA" required />
                </div>

                {{-- Tipe Akun --}}
                <div class="col-span-2 sm:col-span-1">
                    <x-form.select id="accountTypeId" name="accountTypeId" xModel="accountTypeId" label="Tipe Akun"
                        placeholder="Pilih Tipe Akun" alpineDisabled="parentId">
                        @foreach ($accountTypes as $type)
                            <option value="{{ $type->id }}">
                                {{ $type->name }}
                            </option>
                        @endforeach
                    </x-form.select>

                    <input type="hidden" name="account_type_id" :value="accountTypeId">

                    <template x-if="parentId">
                        <p class="mt-1 text-xs text-yellow-600">
                            Mengikuti tipe akun parent.
                        </p>
                    </template>
                </div>

                {{-- Normal Balance --}}
                <div class="col-span-2 sm:col-span-1">
                    <x-form.select id="normalBalance" name="normalBalance" xModel="normalBalance" label="Normal Balance"
                        placeholder="Pilih Normal Balance" alpineDisabled="parentId">
                        @foreach ($normalBalances as $balance)
                            <option value="{{ $balance }}">
                                {{ $balance }}
                            </option>
                        @endforeach
                    </x-form.select>

                    <input type="hidden" name="normal_balance" :value="normalBalance">

                    <template x-if="parentId">
                        <p class="mt-1 text-xs text-yellow-600">
                            Mengikuti normal balance parent.
                        </p>
                    </template>
                </div>

                {{-- Aktif --}}
                <div class="col-span-1 sm:col-span-1">
                    <x-form.toggle-switch name="is_active" label="Aktifkan Akun COA" :value="true" onText="Akun Aktif"
                        offText="Akun Tidak Aktif" />
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
