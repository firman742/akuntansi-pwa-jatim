@props(['groupedJournals'])

<div class="overflow-hidden border border-gray-200 bg-white shadow-sm">
    <div class="max-w-full overflow-x-auto">
        <table class="w-full border-collapse">
            {{-- TABLE HEADER --}}
            <thead
                class="px-6 py-3.5 border-t border-gray-100 border-y bg-gray-200 dark:border-white/[0.05] dark:bg-gray-900">
                <tr>
                    <th class="px-6 py-3 font-medium text-gray-600 sm:px-6 text-theme-sm dark:text-gray-400 text-center">
                        No</th>
                    <th class="px-6 py-3 font-medium text-gray-600 sm:px-6 text-theme-sm dark:text-gray-400 text-center">
                        Tanggal</th>
                    <th class="px-6 py-3 font-medium text-gray-600 sm:px-6 text-theme-sm dark:text-gray-400 text-left">
                        Nama Rekening / Akun</th>
                    <th class="px-6 py-3 font-medium text-gray-600 sm:px-6 text-theme-sm dark:text-gray-400 text-left">
                        Nama Pengguna</th>
                    <th class="px-6 py-3 font-medium text-gray-600 sm:px-6 text-theme-sm dark:text-gray-400 text-left">
                        Ref</th>
                    <th class="px-6 py-3 font-medium text-gray-600 sm:px-6 text-theme-sm dark:text-gray-400 text-left">
                        Keterangan</th>
                    <th class="px-6 py-3 font-medium text-gray-600 sm:px-6 text-theme-sm dark:text-gray-400 text-start">
                        Debit</th>
                    <th class="px-6 py-3 font-medium text-gray-600 sm:px-6 text-theme-sm dark:text-gray-400 text-start">
                        Kredit</th>
                </tr>
            </thead>

            <tbody class="text-sm">
                @forelse ($groupedJournals as $group)
                    {{-- HEADER GRUP KAS --}}
                    <tr class="bg-gray-400">
                        <td colspan="8"
                            class="px-6 py-3 text-center text-[11px] font-bold uppercase tracking-[0.2em] text-white">
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
                                class="{{ $index % 2 === 0 ? 'bg-gray-50 dark:bg-white/[0.02]' : 'bg-white dark:bg-white/[0.03]' }} border-b border-gray-100 transition hover:bg-gray-100 dark:border-white/[0.05]">
                                {{-- NO - Hanya muncul di baris pertama detail jurnal --}}
                                <td class="px-6 py-4 text-center text-gray-400 font-medium border-r border-gray-100">
                                    {{ $index === 0 ? $no++ : '' }}
                                </td>

                                {{-- TANGGAL --}}
                                <td class="px-6 py-4 text-center text-gray-600 border-r border-gray-100">
                                    {{ $index === 0 ? $journal->journal_date->format('d M Y') : '' }}
                                </td>

                                {{-- NAMA REKENING --}}
                                <td class="px-6 py-4 border-r border-gray-100 {{ $isCreditRow ? 'pl-14' : '' }}">
                                    <span
                                        class="{{ $isCreditRow ? 'text-gray-600 italic' : 'font-bold text-gray-800' }}">
                                        {{ $detail->chartOfAccount?->name }}
                                    </span>
                                </td>

                                {{-- NAMA Pengguna --}}
                                <td class="px-6 py-4 text-gray-500 border-r border-gray-100">
                                    {{ $index === 0 ? $journal->postedBy?->name : '' }}
                                </td>

                                {{-- REF --}}
                                <td
                                    class="px-6 py-4 text-center font-mono text-xs font-bold text-blue-500 border-r border-gray-100">
                                    {{ $detail->chartOfAccount?->code }}
                                </td>

                                {{-- KETERANGAN --}}
                                <td class="px-6 py-4 text-gray-500 text-xs border-r border-gray-100">
                                    {{ $detail->description ?? $journal->description }}
                                </td>

                                {{-- DEBIT --}}
                                <td class="px-6 py-4 text-right font-medium text-gray-700 border-r border-gray-100">
                                    @if ($detail->debit > 0)
                                        {{ number_format($detail->debit, 0, ',', '.') }}
                                        @php $subTotalDebit += $detail->debit @endphp
                                    @else
                                        <span class="text-gray-200">-</span>
                                    @endif
                                </td>

                                {{-- KREDIT --}}
                                <td class="px-6 py-4 text-right font-medium text-red-600">
                                    @if ($detail->credit > 0)
                                        {{ number_format($detail->credit, 0, ',', '.') }}
                                        @php $subTotalCredit += $detail->credit @endphp
                                    @else
                                        <span class="text-gray-200">-</span>
                                    @endif
                                </td>
                            </tr>
                        @endforeach
                    @endforeach

                    {{-- SUBTOTAL PER GRUP --}}
                    <tr class="bg-primary/[0.03] border-b-2 border-gray-200">
                        <td colspan="5"
                            class="px-6 py-4 text-right text-[10px] font-bold uppercase tracking-widest text-primary">
                            Subtotal {{ $group['account_info'] }}
                        </td>
                        <td
                            class="px-6 py-4 text-right font-black text-gray-900 border-r border-gray-100 bg-primary/[0.02]">
                            Rp{{ number_format($subTotalDebit, 0, ',', '.') }}
                        </td>
                        <td class="px-6 py-4 text-right font-black text-gray-900 bg-primary/[0.02]">
                            Rp{{ number_format($subTotalCredit, 0, ',', '.') }}
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="7" class="px-6 py-20 text-center text-gray-400">
                            <svg class="w-12 h-12 mx-auto mb-4 opacity-20" fill="none" stroke="currentColor"
                                viewBox="0 0 24 24">
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
