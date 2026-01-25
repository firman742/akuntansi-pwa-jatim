@props(['permissions', 'role'])

<div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-4">
    @foreach ($permissions->groupBy('group') as $group => $items)
        <div
            class="rounded-lg border border-gray-200 bg-white
                    dark:border-gray-800 dark:bg-white/[0.03]">

            {{-- Group Title --}}
            <h2
                class="px-4 py-2 text-sm font-semibold text-gray-700
                       dark:text-gray-300 border-b dark:border-gray-800">
                {{ $group }}
            </h2>

            <ul class="flex flex-col divide-y dark:divide-gray-800">
                @foreach ($items as $permission)
                    @php
                        $isDefault = (bool) $permission->is_default;
                        $isChecked = $role->hasPermissionTo($permission->name);
                    @endphp

                    <li
                        class="px-4 py-3
                        {{ $isDefault ? 'bg-gray-50 dark:bg-gray-900/40' : '' }}">

                        <label class="flex items-start gap-3 cursor-pointer select-none">

                            {{-- Checkbox --}}
                            <input type="checkbox" name="permissions[]" value="{{ $permission->name }}"
                                class="mt-1 rounded border-gray-300 text-brand-500
                                       focus:ring-brand-500 disabled:opacity-60
                                       disabled:cursor-not-allowed"
                                {{ $isChecked ? 'checked' : '' }} {{ $isDefault ? 'disabled' : '' }}>

                            {{-- Text --}}
                            <div class="flex flex-col">
                                <span
                                    class="text-sm font-medium
                                    {{ $isDefault ? 'text-gray-900 dark:text-white' : 'text-gray-700 dark:text-gray-200' }}">
                                    {{ $permission->name }}

                                    @if ($isDefault)
                                        <span class="ml-2 text-xs font-semibold text-brand-500">
                                            Default
                                        </span>
                                    @endif
                                </span>

                                <span class="mt-0.5 text-xs text-gray-500 dark:text-gray-400">
                                    {{ $permission->description ?? 'Tidak ada deskripsi' }}
                                </span>
                            </div>
                        </label>

                        {{-- Hidden input agar default tetap terkirim --}}
                        @if ($isDefault && $isChecked)
                            <input type="hidden" name="permissions[]" value="{{ $permission->name }}">
                        @endif
                    </li>
                @endforeach
            </ul>
        </div>
    @endforeach
</div>
