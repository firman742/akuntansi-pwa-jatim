@props([
    // DETAIL
    'detailUrl' => null,
    'canDetail' => 'true',
    'detailTooltip' => 'Lihat Detail Data',

    // CLOSE
    'closeUrl' => null,
    'canClose' => 'true',
    'closeLockReason' => 'null',
    'closeTooltip' => 'Tutup Siklus Data',
    'closeConfirm' => 'Apakah Anda yakin ingin MENUTUP data ini?',

    // EDIT
    'editUrl' => null,
    'canEdit' => 'true',
    'editLockReason' => 'null',
    'editTooltip' => 'Edit Data',

    // DELETE
    'destroyUrl' => null,
    'canDelete' => 'true',
    'deleteLockReason' => 'null',
    'deleteTooltip' => 'Hapus Data Permanen',
    'deleteConfirm' => 'Yakin ingin MENGHAPUS data ini? Data yang dihapus tidak dapat dikembalikan.',
])

<div
    {{ $attributes->merge(['class' => 'inline-flex items-center justify-center gap-1.5 rounded-2xl border border-gray-200/80 bg-gray-50/60 p-1 shadow-2xs dark:border-gray-800 dark:bg-gray-800/40']) }}>

    {{-- 1. DETAIL --}}
    @if ($detailUrl)
        <div class="relative inline-block group/tooltip">
            <a :href="{{ $canDetail }} ? {{ $detailUrl }} : '#'" :aria-disabled="!({{ $canDetail }})"
                @click="if (!({{ $canDetail }})) $event.preventDefault()"
                :class="{{ $canDetail }}
                    ?
                    'bg-sky-50 text-sky-700 border border-sky-200/80 hover:bg-sky-600 hover:text-white active:scale-95 dark:bg-sky-950/40 dark:text-sky-400 dark:border-sky-900/50 dark:hover:bg-sky-600 dark:hover:text-white cursor-pointer' :
                    'cursor-not-allowed bg-gray-200/60 text-gray-400 border border-gray-200/60 dark:bg-gray-800 dark:text-gray-600 dark:border-gray-700 pointer-events-none'"
                class="inline-flex items-center gap-1 rounded-xl px-2.5 py-1.5 text-xs font-semibold transition-all duration-150 select-none">
                <svg class="h-3.5 w-3.5 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                    <path stroke-linecap="round" stroke-linejoin="round"
                        d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                </svg>
                <span>Detail</span>
            </a>

            {{-- TOOLTIP --}}
            <div
                class="pointer-events-none absolute bottom-full left-1/2 z-50 mb-2 hidden w-max max-w-[220px] -translate-x-1/2 rounded-xl bg-gray-900 px-3 py-1.5 text-center text-[11px] font-medium text-white shadow-xl group-hover/tooltip:block dark:bg-gray-100 dark:text-gray-900">
                <span>{{ $detailTooltip }}</span>
                <span
                    class="absolute left-1/2 top-full -translate-x-1/2 border-x-4 border-t-4 border-x-transparent border-t-gray-900 dark:border-t-gray-100"></span>
            </div>
        </div>
    @endif

    {{-- 2. CLOSE --}}
    @if ($closeUrl)
        <div class="relative inline-block group/tooltip">
            <form :action="{{ $canClose }} ? {{ $closeUrl }} : '#'" method="POST"
                @submit.prevent="
                    if (!({{ $canClose }})) return;
                    if (confirm(@js($closeConfirm))) {
                        $el.submit();
                    }
                ">
                @csrf
                @method('PATCH')

                <button type="submit" :disabled="!({{ $canClose }})"
                    :class="{{ $canClose }}
                        ?
                        'bg-amber-400 text-white hover:bg-amber-600 active:scale-95 dark:bg-amber-600 dark:hover:bg-amber-500 cursor-pointer' :
                        'cursor-not-allowed bg-gray-200/60 text-gray-400 dark:bg-gray-800 dark:text-gray-600 pointer-events-none'"
                    class="inline-flex items-center gap-1 rounded-xl px-2.5 py-1.5 text-xs font-semibold shadow-2xs transition-all duration-150 select-none">
                    <svg class="h-3.5 w-3.5 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                        stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                    </svg>
                    <span>Tutup</span>
                </button>
            </form>

            {{-- TOOLTIP --}}
            <div
                class="pointer-events-none absolute bottom-full left-1/2 z-50 mb-2 hidden w-max max-w-[220px] -translate-x-1/2 rounded-xl bg-gray-900 px-3 py-2 text-center text-[11px] font-medium text-white shadow-xl group-hover/tooltip:block dark:bg-gray-100 dark:text-gray-900">
                <span x-text="{{ $closeLockReason }} || @js($closeTooltip)"></span>
                <span
                    class="absolute left-1/2 top-full -translate-x-1/2 border-x-4 border-t-4 border-x-transparent border-t-gray-900 dark:border-t-gray-100"></span>
            </div>
        </div>
    @endif

    {{-- 3. EDIT --}}
    @if ($editUrl)
        <div class="relative inline-block group/tooltip">
            <a :href="{{ $canEdit }} ? {{ $editUrl }} : '#'" :aria-disabled="!({{ $canEdit }})"
                @click="if (!({{ $canEdit }})) $event.preventDefault()"
                :class="{{ $canEdit }}
                    ?
                    'bg-blue-500 text-white hover:bg-blue-600 active:scale-95 dark:bg-blue-600 dark:hover:bg-blue-500 cursor-pointer' :
                    'cursor-not-allowed bg-gray-200/60 text-gray-400 border border-gray-200/60 dark:bg-gray-800 dark:text-gray-600 dark:border-gray-700 pointer-events-none'"
                class="inline-flex items-center gap-1 rounded-xl px-2.5 py-1.5 text-xs font-semibold shadow-2xs transition-all duration-150 select-none">
                <svg class="h-3.5 w-3.5 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                    stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round"
                        d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5" />
                    <path stroke-linecap="round" stroke-linejoin="round"
                        d="M18.5 2.5a2.121 2.121 0 013 3L12 15l-4 1 1-4 9.5-9.5z" />
                </svg>
                <span>Edit</span>
            </a>

            {{-- TOOLTIP --}}
            <div
                class="pointer-events-none absolute bottom-full left-1/2 z-50 mb-2 hidden w-max max-w-[220px] -translate-x-1/2 rounded-xl bg-gray-900 px-3 py-2 text-center text-[11px] font-medium text-white shadow-xl group-hover/tooltip:block dark:bg-gray-100 dark:text-gray-900">
                <span x-text="{{ $editLockReason }} || @js($editTooltip)"></span>
                <span
                    class="absolute left-1/2 top-full -translate-x-1/2 border-x-4 border-t-4 border-x-transparent border-t-gray-900 dark:border-t-gray-100"></span>
            </div>
        </div>
    @endif

    {{-- 4. DELETE --}}
    @if ($destroyUrl)
        <div class="relative inline-block group/tooltip">
            <form :action="{{ $canDelete }} ? {{ $destroyUrl }} : '#'" method="POST"
                @submit.prevent="
                    if (!({{ $canDelete }})) return;
                    if (confirm(@js($deleteConfirm))) {
                        $el.submit();
                    }
                ">
                @csrf
                @method('DELETE')

                <button type="submit" :disabled="!({{ $canDelete }})"
                    :class="{{ $canDelete }}
                        ?
                        'bg-rose-50 text-rose-700 border border-rose-200/80 hover:bg-rose-600 hover:text-white active:scale-95 dark:bg-rose-950/40 dark:text-rose-400 dark:border-rose-900/50 dark:hover:bg-rose-600 dark:hover:text-white cursor-pointer' :
                        'cursor-not-allowed bg-gray-200/60 text-gray-400 border border-gray-200/60 dark:bg-gray-800 dark:text-gray-600 dark:border-gray-700 pointer-events-none'"
                    class="inline-flex items-center gap-1 rounded-xl px-2.5 py-1.5 text-xs font-semibold transition-all duration-150 select-none">
                    <svg class="h-3.5 w-3.5 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                        stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7" />
                        <path stroke-linecap="round" stroke-linejoin="round" d="M10 11v6M14 11v6" />
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M9 7V4a1 1 0 011-1h4a1 1 0 011 1v3M4 7h16" />
                    </svg>
                    <span>Hapus</span>
                </button>
            </form>

            {{-- TOOLTIP --}}
            <div
                class="pointer-events-none absolute bottom-full left-1/2 z-50 mb-2 hidden w-max max-w-[220px] -translate-x-1/2 rounded-xl bg-gray-900 px-3 py-2 text-center text-[11px] font-medium text-white shadow-xl group-hover/tooltip:block dark:bg-gray-100 dark:text-gray-900">
                <span x-text="{{ $deleteLockReason }} || @js($deleteTooltip)"></span>
                <span
                    class="absolute left-1/2 top-full -translate-x-1/2 border-x-4 border-t-4 border-x-transparent border-t-gray-900 dark:border-t-gray-100"></span>
            </div>
        </div>
    @endif

</div>
