@extends('layouts.app')

@section('title', 'Master Data - Edit Akun COA')

@section('content')
    <x-common.page-breadcrumb pageTitle="Edit Akun COA" />

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
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Parent Akun (Opsional)
                    </label>

                    <select name="parent_id" x-model="parentId" :disabled="isLocked"
                        class="h-11 w-full rounded-lg border px-4 py-2.5 text-sm
                    {{ $isLocked ? 'bg-gray-100 cursor-not-allowed opacity-60' : '' }}">

                        <option value="">-- Tidak Ada --</option>

                        @foreach ($parents as $parent)
                            <option value="{{ $parent->id }}" @selected(old('parent_id', $coa->parent_id) == $parent->id)>
                                {{ $parent->code }} - {{ $parent->name }}
                            </option>
                        @endforeach
                    </select>

                    @if ($isLocked)
                        <p class="mt-1 text-xs text-gray-500">
                            Parent tidak dapat diubah karena COA sudah digunakan.
                        </p>
                    @endif
                </div>

                {{-- CODE --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Kode Akun (Otomatis)
                    </label>

                    <input type="text" x-model="code" readonly
                        class="h-11 w-full rounded-lg border bg-gray-100 px-4 text-gray-700 cursor-not-allowed">

                    <input type="hidden" name="code" :value="code">
                    <input type="hidden" name="level" :value="level">
                    <input type="hidden" name="order" :value="order">

                    <div class="mt-1 text-xs text-gray-500">
                        Level: <span x-text="level"></span> • Order: <span x-text="order"></span>
                    </div>
                </div>

                {{-- NAME (editable always) --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Nama Akun COA
                    </label>

                    <input type="text" name="name" value="{{ old('name', $coa->name) }}"
                        class="h-11 w-full rounded-lg border px-4 py-2.5 text-sm focus:ring-2 focus:ring-blue-400">
                </div>

                {{-- ACCOUNT TYPE --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Tipe Akun
                    </label>

                    <select name="account_type_id" :disabled="isLocked"
                        class="h-11 w-full rounded-lg border px-4 py-2.5 text-sm
                    {{ $isLocked ? 'bg-gray-100 cursor-not-allowed opacity-60' : '' }}">

                        <option value="">-- Pilih Tipe Akun --</option>

                        @foreach ($accountTypes as $type)
                            <option value="{{ $type->id }}" @selected(old('account_type_id', $coa->account_type_id) == $type->id)>
                                {{ $type->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                {{-- NORMAL BALANCE --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Normal Balance
                    </label>

                    <select name="normal_balance" :disabled="isLocked"
                        class="h-11 w-full rounded-lg border px-4 py-2.5 text-sm
                    {{ $isLocked ? 'bg-gray-100 cursor-not-allowed opacity-60' : '' }}">

                        @foreach ($normalBalances as $balance)
                            <option value="{{ $balance->value }}" @selected(old('normal_balance', $coa->normal_balance) === $balance->value)>
                                {{ $balance->label() }}
                            </option>
                        @endforeach
                    </select>
                </div>

                {{-- DESCRIPTION --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Deskripsi
                    </label>

                    <textarea name="description" rows="4"
                        class="w-full rounded-lg border px-4 py-3 text-sm focus:ring-2 focus:ring-blue-400">{{ old('description', $coa->description) }}</textarea>
                </div>

                {{-- ACTIVE --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Status Aktif
                    </label>

                    <div x-data="{ toggle: {{ $coa->is_active ? 'true' : 'false' }} }">
                        <input type="hidden" name="is_active" value="0">

                        <label class="flex items-center gap-3 cursor-pointer select-none">

                            <div class="relative">
                                <input type="checkbox" name="is_active" value="1" class="sr-only" x-model="toggle">

                                <div class="h-6 w-11 rounded-full transition"
                                    :class="toggle ? 'bg-green-500' : 'bg-gray-300'"></div>

                                <div class="absolute top-0.5 left-0.5 h-5 w-5 bg-white rounded-full transition-transform"
                                    :class="toggle ? 'translate-x-full' : ''"></div>
                            </div>

                            <span class="text-sm text-gray-700" x-text="toggle ? 'Aktif' : 'Nonaktif'"></span>
                        </label>
                    </div>
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
