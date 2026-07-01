@props(['groupedJournals', 'journals'])

<div class="overflow-hidden border border-gray-300 bg-white dark:border-gray-600 dark:bg-gray-900 shadow-sm rounded-lg">
    <div class="max-w-full overflow-x-auto">
        <table class="w-full">
            {{-- TABLE HEADER --}}
            <thead class="bg-gray-100 dark:bg-gray-800">
                <tr>
                    <th class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300 text-center">
                        No
                    </th>
                    <th class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300 text-center">
                        Tanggal
                    </th>
                    <th class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300 text-left">
                        Nama Rekening / Akun
                    </th>
                    <th class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300 text-left">
                        Nama Pengguna
                    </th>
                    <th class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300 text-left">
                        Ref
                    </th>
                    <th class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300 text-left">
                        Keterangan
                    </th>
                    <th class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300 text-right">
                        Debit
                    </th>
                    <th class="px-6 py-3 font-medium text-gray-700 dark:text-gray-300 text-right">
                        Kredit
                    </th>
                </tr>
            </thead>

            <tbody class="text-sm">
                @forelse ($groupedJournals as $group)
                    {{-- HEADER GRUP KAS --}}
                    <tr class="bg-gray-200 dark:bg-gray-700">
                        <td colspan="8"
                            class="px-6 py-3 text-center text-[11px] font-bold uppercase tracking-wide text-gray-800 dark:text-gray-200">
                            {{ $group['account_info'] }}
                        </td>
                    </tr>

                    @php
                        $subTotalDebit = 0;
                        $subTotalCredit = 0;
                        $no = 1;
                    @endphp

                    @foreach ($group['data'] as $journal)
                        @foreach ($journal->details as $index => $detail)
                            @php $isCreditRow = $detail->credit > 0; @endphp

                            <tr
                                class="{{ $index % 2 === 0 ? 'bg-gray-50 dark:bg-gray-800' : 'bg-white dark:bg-gray-900' }} border-b border-gray-200 dark:border-gray-700 hover:bg-gray-100 dark:hover:bg-gray-700 transition">
                                {{-- NO --}}
                                <td class="px-6 py-4 text-center text-gray-600 dark:text-gray-400 font-medium">
                                    {{ $index === 0 ? $no++ : '' }}
                                </td>

                                {{-- TANGGAL --}}
                                <td class="px-6 py-4 text-center text-gray-700 dark:text-gray-300">
                                    {{ $index === 0 ? $journal->journal_date->format('d M Y') : '' }}
                                </td>

                                {{-- NAMA REKENING --}}
                                <td class="px-6 py-4 {{ $isCreditRow ? 'pl-14' : '' }}">
                                    <span
                                        class="{{ $isCreditRow ? 'text-gray-600 dark:text-gray-400 italic' : 'font-bold text-gray-800 dark:text-gray-200' }}">
                                        {{ $detail->chartOfAccount?->name }}
                                    </span>
                                </td>

                                {{-- NAMA PENGGUNA --}}
                                <td class="px-6 py-4 text-gray-600 dark:text-gray-400">
                                    {{ $index === 0 ? $journal->postedBy?->name : '' }}
                                </td>

                                {{-- REF --}}
                                <td
                                    class="px-6 py-4 text-center font-mono text-xs font-bold text-blue-600 dark:text-blue-400">
                                    {{ $detail->chartOfAccount?->code }}
                                </td>

                                {{-- KETERANGAN --}}
                                <td class="px-6 py-4 text-gray-600 dark:text-gray-400 text-xs">
                                    {{ $detail->description ?? $journal->description }}
                                </td>

                                {{-- DEBIT --}}
                                <td class="px-6 py-4 text-right font-medium text-green-600 dark:text-green-400">
                                    @if ($detail->debit > 0)
                                        {{ number_format($detail->debit, 0, ',', '.') }}
                                        @php $subTotalDebit += $detail->debit @endphp
                                    @else
                                        <span class="text-gray-400 dark:text-gray-600">-</span>
                                    @endif
                                </td>

                                {{-- KREDIT --}}
                                <td class="px-6 py-4 text-right font-medium text-red-600 dark:text-red-400">
                                    @if ($detail->credit > 0)
                                        {{ number_format($detail->credit, 0, ',', '.') }}
                                        @php $subTotalCredit += $detail->credit @endphp
                                    @else
                                        <span class="text-gray-400 dark:text-gray-600">-</span>
                                    @endif
                                </td>
                            </tr>
                        @endforeach
                    @endforeach

                    {{-- SUBTOTAL PER GRUP --}}
                    <tr class="bg-gray-100 dark:bg-gray-800">
                        <td colspan="6"
                            class="px-6 py-4 text-right text-[10px] font-bold uppercase tracking-wide text-gray-700 dark:text-gray-300">
                            Subtotal {{ $group['account_info'] }}
                        </td>
                        <td class="px-6 py-4 text-right font-black text-gray-800 dark:text-gray-200">
                            Rp{{ number_format($subTotalDebit, 0, ',', '.') }}
                        </td>
                        <td class="px-6 py-4 text-right font-black text-gray-800 dark:text-gray-200">
                            Rp{{ number_format($subTotalCredit, 0, ',', '.') }}
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="8" class="px-6 py-20 text-center text-gray-500 dark:text-gray-400">
                            <svg class="w-12 h-12 mx-auto mb-4 opacity-20 dark:opacity-30" fill="none"
                                stroke="currentColor" viewBox="0 0 24 24">
                                <path
                                    d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                            </svg>
                            <p>Data jurnal tidak ditemukan untuk periode ini.</p>
                        </td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>
</div>

<!-- Pagination -->
<div class="px-6 py-4 border-t border-gray-200 dark:border-white/[0.05]">
    <div class="flex items-center justify-between">

        {{-- Previous --}}
        @if ($journals->onFirstPage())
            <button disabled
                class="opacity-50 cursor-not-allowed flex items-center gap-2 rounded-lg border border-gray-300 bg-white px-3 py-3 text-theme-sm font-medium text-gray-700 shadow-theme-xs dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                        d="M2.58301 9.99868C2.58272 10.1909 2.65588 10.3833 2.80249 10.53L7.79915 15.5301C8.09194 15.8231 8.56682 15.8233 8.85981 15.5305C9.15281 15.2377 9.15297 14.7629 8.86018 14.4699L5.14009 10.7472L16.6675 10.7472C17.0817 10.7472 17.4175 10.4114 17.4175 9.99715C17.4175 9.58294 17.0817 9.24715 16.6675 9.24715L5.14554 9.24715L8.86017 5.53016C9.15297 5.23717 9.15282 4.7623 8.85983 4.4695C8.56684 4.1767 8.09197 4.17685 7.79917 4.46984L2.84167 9.43049C2.68321 9.568 2.58301 9.77087 2.58301 9.99715C2.58301 9.99766 2.58301 9.99817 2.58301 9.99868Z"
                        fill="currentColor" />
                </svg>
                <span class="hidden sm:inline">Previous</span>
            </button>
        @else
            <a href="{{ $journals->previousPageUrl() }}"
                class="flex items-center gap-2 rounded-lg border border-gray-300 bg-white px-3 py-3 text-theme-sm font-medium text-gray-700 shadow-theme-xs hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                        d="M2.58301 9.99868C2.58272 10.1909 2.65588 10.3833 2.80249 10.53L7.79915 15.5301C8.09194 15.8231 8.56682 15.8233 8.85981 15.5305C9.15281 15.2377 9.15297 14.7629 8.86018 14.4699L5.14009 10.7472L16.6675 10.7472C17.0817 10.7472 17.4175 10.4114 17.4175 9.99715C17.4175 9.58294 17.0817 9.24715 16.6675 9.24715L5.14554 9.24715L8.86017 5.53016C9.15297 5.23717 9.15282 4.7623 8.85983 4.4695C8.56684 4.1767 8.09197 4.17685 7.79917 4.46984L2.84167 9.43049C2.68321 9.568 2.58301 9.77087 2.58301 9.99715C2.58301 9.99766 2.58301 9.99817 2.58301 9.99868Z"
                        fill="currentColor" />
                </svg>
                <span class="hidden sm:inline">Previous</span>
            </a>
        @endif

        {{-- Mobile --}}
        <span class="block text-sm font-medium text-gray-700 dark:text-gray-400 sm:hidden">
            Page {{ $journals->currentPage() }}
            of
            {{ $journals->lastPage() }}
        </span>

        {{-- Desktop --}}
        <ul class="hidden items-center gap-0.5 sm:flex">

            @php
                $current = $journals->currentPage();
                $last = $journals->lastPage();

                $start = max(1, $current - 2);
                $end = min($last, $current + 2);

                if ($current <= 3) {
                    $end = min($last, 5);
                }

                if ($current >= $last - 2) {
                    $start = max(1, $last - 4);
                }
            @endphp

            @for ($page = $start; $page <= $end; $page++)
                <li>
                    @if ($page == $current)
                        <span
                            class="flex h-10 w-10 items-center justify-center rounded-lg bg-blue-500 text-white text-theme-sm font-medium">
                            {{ $page }}
                        </span>
                    @else
                        <a href="{{ $journals->url($page) }}"
                            class="flex h-10 w-10 items-center justify-center rounded-lg text-theme-sm font-medium text-gray-700 hover:bg-green-500/10 hover:text-blue-500 dark:text-gray-400 dark:hover:text-blue-500">
                            {{ $page }}
                        </a>
                    @endif
                </li>
            @endfor

        </ul>

        {{-- Next --}}
        @if ($journals->hasMorePages())
            <a href="{{ $journals->nextPageUrl() }}"
                class="flex items-center gap-2 rounded-lg border border-gray-300 bg-white px-3 py-3 text-theme-sm font-medium text-gray-700 shadow-theme-xs hover:bg-gray-50 hover:text-gray-800 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400">
                <span class="hidden sm:inline">Next</span>
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                        d="M17.4175 9.9986C17.4178 10.1909 17.3446 10.3832 17.198 10.53L12.2013 15.5301C11.9085 15.8231 11.4337 15.8233 11.1407 15.5305C10.8477 15.2377 10.8475 14.7629 11.1403 14.4699L14.8604 10.7472L3.33301 10.7472C2.91879 10.7472 2.58301 10.4114 2.58301 9.99715C2.58301 9.58294 2.91879 9.24715 3.33301 9.24715L14.8549 9.24715L11.1403 5.53016C10.8475 5.23717 10.8477 4.7623 11.1407 4.4695C11.4336 4.1767 11.9085 4.17685 12.2013 4.46984L17.1588 9.43049C17.3173 9.568 17.4175 9.77087 17.4175 9.99715C17.4175 9.99763 17.4175 9.99812 17.4175 9.9986Z"
                        fill="currentColor" />
                </svg>
            </a>
        @else
            <button disabled
                class="opacity-50 cursor-not-allowed flex items-center gap-2 rounded-lg border border-gray-300 bg-white px-3 py-3 text-theme-sm font-medium text-gray-700 shadow-theme-xs dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400">
                <span class="hidden sm:inline">Next</span>
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd"
                        d="M17.4175 9.9986C17.4178 10.1909 17.3446 10.3832 17.198 10.53L12.2013 15.5301C11.9085 15.8231 11.4337 15.8233 11.1407 15.5305C10.8477 15.2377 10.8475 14.7629 11.1403 14.4699L14.8604 10.7472L3.33301 10.7472C2.91879 10.7472 2.58301 10.4114 2.58301 9.99715C2.58301 9.58294 2.91879 9.24715 3.33301 9.24715L14.8549 9.24715L11.1403 5.53016C10.8475 5.23717 10.8477 4.7623 11.1407 4.4695C11.4336 4.1767 11.9085 4.17685 12.2013 4.46984L17.1588 9.43049C17.3173 9.568 17.4175 9.77087 17.4175 9.99715C17.4175 9.99763 17.4175 9.99812 17.4175 9.9986Z"
                        fill="currentColor" />
                </svg>
            </button>
        @endif

    </div>

    {{-- Info --}}
    <div class="mt-4 text-sm text-gray-500">
        Menampilkan
        <span class="font-medium">{{ $journals->firstItem() }}</span>
        -
        <span class="font-medium">{{ $journals->lastItem() }}</span>
        dari
        <span class="font-medium">{{ $journals->total() }}</span>
        data
    </div>
</div>
