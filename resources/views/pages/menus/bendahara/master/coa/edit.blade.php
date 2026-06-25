@extends('layouts.app')

@section('title', 'Master Data - Edit Akun COA')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Edit Akun COA " pageTitle="Edit Akun COA"
        pageDescription="Monitoring dan kelola Akun COA yang terdaftar di sistem" pageIcon="book" parentTitle="Akun COA"
        :parentRoute="route('bendahara.master.coas.index')" currentTitle="Edit" />

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

    @if ($isLocked)
        <div class="mb-6 rounded-lg border border-yellow-300 bg-yellow-50 px-4 py-3 text-sm text-yellow-800">
            Akun ini hanya dapat diedit nama dan deskripsinya saja!
        </div>
    @endif

    <x-common.component-card title="Edit Akun COA">

        <form method="POST" action="{{ route('bendahara.master.coas.update', $coa->id) }}">
            @csrf
            @method('PUT')

            <div class="grid grid-cols-1 gap-4" x-data="{
                isLocked: {{ $isLocked ? 'true' : 'false' }},
                parentId: '{{ old('parent_id', $coa->parent_id) }}',
                code: '{{ $coa->code }}',
                level: {{ old('level', $coa->level) }},
                order: {{ old('order', $coa->order) }},
                oldParentId: '{{ old('parent_id', $coa->parent_id) }}',
                accountTypeId: '{{ old('account_type_id', $coa->account_type_id) }}',
                normalBalance: '{{ old('normal_balance', $coa->normal_balance) }}',
            
                async fetchCode() {
                    if (this.isLocked) return;
            
                    try {
                        let url = '{{ route('bendahara.master.coas.generate-code') }}';
            
                        if (this.parentId) {
                            url += '?parent_id=' + this.parentId;
                        }
            
                        const response = await fetch(url);
                        const data = await response.json();
            
                        this.code = data.code;
                        this.level = data.level;
                        this.order = data.order;
            
                    } catch (e) {
                        console.error(e);
                    }
                }
            }"
                x-effect="
                if (!isLocked && parentId !== oldParentId) {
                    fetchCode();
                    oldParentId = parentId;
                }
            ">

                {{-- PARENT --}}
                <div>
                    <x-form.select id="parent_id" name="parent_id" xModel="parentId" label="Parent Akun (Opsional)"
                        placeholder="Pilih AKun Parent" alpineDisabled="isLocked">
                        @foreach ($parents as $parent)
                            <option value="{{ $parent->id }}" @selected(old('parent_id', $coa->parent_id) == $parent->id)>
                                {{ $parent->code }} - {{ $parent->name }}
                            </option>
                        @endforeach
                    </x-form.select>

                    @if ($isLocked)
                        <p class="mt-1 text-xs text-gray-500">
                            Parent tidak dapat diubah karena COA sudah digunakan.
                        </p>
                    @endif
                </div>

                {{-- CODE --}}
                <div>
                    <x-form.input id="code" name="code" xModel="code" label="Kode Akun (Otomatis)" readonly
                        disabled />

                    <input type="hidden" name="code" :value="code">
                    <input type="hidden" name="level" :value="level">
                    <input type="hidden" name="order" :value="order">

                    <div class="mt-1 text-xs text-gray-500">
                        Level: <span x-text="level"></span> • Order: <span x-text="order"></span>
                    </div>
                </div>

                {{-- NAME (editable always) --}}
                <div>
                    <x-form.input id="name" name="name" xModel="name" type="text" value="{{ $coa->name }}"
                        label="Nama Akun COA" required />
                </div>

                {{-- ACCOUNT TYPE --}}
                <div>
                    <x-form.select id="account_type_id" name="account_type_id" xModel="accountTypeId" label="Tipe Akun"
                        placeholder="Pilih Tipe Akun" alpineDisabled="isLocked">
                        @foreach ($accountTypes as $type)
                            <option value="{{ $type->id }}" @selected(old('account_type_id', $coa->account_type_id) == $type->id)>
                                {{ $type->name }}
                            </option>
                        @endforeach
                    </x-form.select>
                    <input type="hidden" name="account_type_id" x-model="accountTypeId">
                </div>

                {{-- NORMAL BALANCE --}}
                <div>
                    <x-form.select id="normal_balance" name="normal_balance" xModel="normalBalance" label="Normal Balance"
                        placeholder="Pilih Normal Balance" alpineDisabled="isLocked">
                        @foreach ($normalBalances as $balance)
                            <option value="{{ $balance->value }}" @selected(old('normal_balance', $coa->normal_balance) === $balance->value)>
                                {{ $balance->label() }}
                            </option>
                        @endforeach
                    </x-form.select>
                    <input type="hidden" name="normal_balance" x-model="normalBalance">
                </div>

                {{-- DESCRIPTION --}}
                <div>
                    <x-form.text-area name="description" label="Deskripsi" placeholder="Masukkan deskripsi...."
                        value="{{ $coa->description }}" rows="4" />
                </div>

                {{-- ACTIVE --}}
                <div>
                    <x-form.toggle-switch name="is_active" label="Status Aktif" :value="true" />
                </div>
            </div>

            {{-- ACTION --}}
            <div class="mt-8 flex justify-end gap-3">
                <a href="{{ route('bendahara.master.coas.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Update COA
                </x-ui.button>
            </div>

        </form>

    </x-common.component-card>
@endsection
