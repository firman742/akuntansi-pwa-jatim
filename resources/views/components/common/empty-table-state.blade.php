@props([
    'title' => 'Data Tidak Ditemukan',
    'description' => 'Belum ada data yang tersedia atau hasil pencarian tidak cocok.',
    'colspan' => null,
])

<tr x-data="{ autoColspan: {{ $colspan ?? 'null' }} }"
    x-init="if (!autoColspan) { autoColspan = $el.closest('table')?.querySelectorAll('thead th')?.length || 1; }">
    <td :colspan="autoColspan" class="px-6 py-12 text-center">
        <div class="mx-auto flex max-w-sm flex-col items-center justify-center text-center">
            {{-- IKON --}}
            <div class="mb-3 flex h-12 w-12 items-center justify-center rounded-2xl bg-gray-100 text-gray-400 dark:bg-gray-800 dark:text-gray-500">
                @if (isset($icon))
                    {{ $icon }}
                @else
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M9 12h6m-6 4h6M7 4h10a2 2 0 012 2v12a2 2 0 01-2 2H7a2 2 0 01-2-2V6a2 2 0 012-2z" />
                    </svg>
                @endif
            </div>

            {{-- JUDUL & DESKRIPSI --}}
            <h5 class="text-sm font-semibold text-gray-900 dark:text-white">
                {{ $title }}
            </h5>
            @if ($description)
                <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
                    {{ $description }}
                </p>
            @endif
        </div>
    </td>
</tr>