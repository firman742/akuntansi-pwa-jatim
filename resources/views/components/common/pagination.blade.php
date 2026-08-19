@props([
    'totalItems' => 'tableRowData.length',
    'currentPage' => 'currentPage',
    'totalPages' => 'totalPages',
    'startIndex' => 'startIndex',
    'endIndex' => 'endIndex',
    'displayedPages' => 'displayedPages',
    'prevPage' => 'prevPage()',
    'nextPage' => 'nextPage()',
    'goToPage' => 'goToPage',
    'itemLabel' => 'data',
])

<div
    {{ $attributes->merge(['class' => 'flex flex-col items-center justify-between gap-4 border-t border-gray-100 bg-gray-50/50 px-6 py-4 sm:flex-row dark:border-gray-800 dark:bg-gray-800/30']) }}>
    {{-- INFORMASI ENTRI --}}
    <p class="text-xs text-gray-500 dark:text-gray-400">
        Menampilkan <span class="font-semibold text-gray-900 dark:text-white" x-text="{{ $startIndex }}"></span>
        sampai <span class="font-semibold text-gray-900 dark:text-white" x-text="{{ $endIndex }}"></span>
        dari <span class="font-semibold text-gray-900 dark:text-white" x-text="{{ $totalItems }}"></span>
        {{ $itemLabel }}
    </p>

    {{-- KONTROL TOMBOL NAVIGASI --}}
    <div class="flex items-center gap-2">
        {{-- TOMBOL SEBELUMNYA --}}
        <button type="button" @click="{{ $prevPage }}" :disabled="{{ $currentPage }} === 1"
            :class="{{ $currentPage }} === 1 ? 'opacity-40 cursor-not-allowed' :
                'hover:bg-gray-100 dark:hover:bg-gray-800 hover:text-gray-900 dark:hover:text-white'"
            class="inline-flex items-center gap-1.5 rounded-xl border border-gray-200/80 bg-white px-3 py-2 text-xs font-medium text-gray-600 shadow-2xs dark:border-gray-800 dark:bg-gray-900 dark:text-gray-300 transition-colors">
            <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
            <span>Sebelumnya</span>
        </button>

        {{-- ANGKA HALAMAN --}}
        <div class="hidden sm:flex items-center gap-1">
            <template x-for="page in {{ $displayedPages }}" :key="page">
                <div>
                    <button type="button" x-show="page !== '...'" @click="{{ $goToPage }}(page)"
                        :class="{{ $currentPage }} === page ?
                            'bg-blue-600 text-white font-bold shadow-xs' :
                            'text-gray-600 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-800 dark:hover:text-white'"
                        class="h-8 w-8 rounded-lg text-xs transition-all flex items-center justify-center"
                        x-text="page">
                    </button>
                    <span x-show="page === '...'" class="px-1 text-xs text-gray-400">...</span>
                </div>
            </template>
        </div>

        {{-- TOMBOL BERIKUTNYA --}}
        <button type="button" @click="{{ $nextPage }}" :disabled="{{ $currentPage }} === {{ $totalPages }}"
            :class="{{ $currentPage }} === {{ $totalPages }} ? 'opacity-40 cursor-not-allowed' :
                'hover:bg-gray-100 dark:hover:bg-gray-800 hover:text-gray-900 dark:hover:text-white'"
            class="inline-flex items-center gap-1.5 rounded-xl border border-gray-200/80 bg-white px-3 py-2 text-xs font-medium text-gray-600 shadow-2xs dark:border-gray-800 dark:bg-gray-900 dark:text-gray-300 transition-colors">
            <span>Berikutnya</span>
            <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
        </button>
    </div>
</div>
