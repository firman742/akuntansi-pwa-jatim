@props(['groupedJournals', 'journals', 'grandTotalDebit' => 0, 'grandTotalCredit' => 0])

<div class="overflow-hidden border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-900 shadow-sm rounded-xl">
    <div class="max-w-full overflow-x-auto">
        <table class="w-full text-xs md:text-sm border-collapse">
            {{-- TABLE HEADER --}}
            <thead
                class="bg-gray-100 dark:bg-gray-800/90 border-b border-gray-200 dark:border-gray-700 text-gray-700 dark:text-gray-300">
                <tr>
                    <th class="px-3 py-3.5 font-bold text-center w-12">No</th>
                    <th class="px-4 py-3.5 font-bold text-center w-28 whitespace-nowrap">Tanggal</th>
                    <th class="px-5 py-3.5 font-bold text-left min-w-[220px]">Nama Rekening / Akun</th>
                    <th class="px-4 py-3.5 font-bold text-left min-w-[180px]">Keterangan</th>
                    <th class="px-4 py-3.5 font-bold text-left w-36 whitespace-nowrap">Pembuat</th>
                    <th class="px-3 py-3.5 font-bold text-center w-24">Ref</th>
                    <th class="px-5 py-3.5 font-bold text-right w-36">Debit</th>
                    <th class="px-5 py-3.5 font-bold text-right w-36">Kredit</th>
                </tr>
            </thead>

            <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
                @forelse ($groupedJournals as $group)
                    @php
                        $groupCode = $group['account_code'];
                    @endphp

                    {{-- HEADER GRUP COA ASET --}}
                    <tr
                        class="bg-indigo-50/70 dark:bg-slate-800/80 font-bold border-y border-indigo-100 dark:border-slate-700">
                        <td colspan="2"
                            class="px-4 py-3 text-indigo-900 dark:text-indigo-300 text-xs font-mono tracking-wider">
                        </td>
                        <td
                            class="px-5 py-3 text-indigo-950 dark:text-indigo-200 font-extrabold uppercase tracking-wide text-sm">
                            {{ $group['account_name'] }}
                        </td>
                        <td colspan="2" class="px-4 py-3"></td>
                        <td class="px-3 py-3 text-center">
                            <span
                                class="inline-flex items-center px-2.5 py-0.5 rounded-md text-xs font-mono font-bold bg-indigo-100 text-indigo-800 dark:bg-indigo-950 dark:text-indigo-300 border border-indigo-200 dark:border-indigo-800">
                                {{ $groupCode }}
                            </span>
                        </td>
                        <td colspan="2" class="px-5 py-3"></td>
                    </tr>

                    @php
                        $subTotalDebit = 0;
                        $subTotalCredit = 0;
                        $entryNumber = 1;
                    @endphp

                    @foreach ($group['data'] as $journal)
                        @php
                            // 1. Cek apakah transaksi memiliki detail akun selain Aset (Non-Asset)
                            $hasNonAssetDetail = $journal->details->contains(function ($d) {
                                $coa = $d->chartOfAccount;
                                if (!$coa) {
                                    return false;
                                }

                                $typeName = strtoupper($coa->accountType->name ?? '');
                                $isAsset =
                                    str_contains($typeName, 'ASET') ||
                                    str_contains($typeName, 'ASSET') ||
                                    str_starts_with((string) $coa->code, '1');

                                return !$isAsset;
                            });

                            // 2. Cek apakah ada akun COA yang sama digunakan di posisi Debit dan Kredit
                            $debitCoas = $journal->details
                                ->filter(fn($d) => (float) $d->debit > 0)
                                ->pluck('chartOfAccount.code')
                                ->filter();

                            $creditCoas = $journal->details
                                ->filter(fn($d) => (float) $d->credit > 0)
                                ->pluck('chartOfAccount.code')
                                ->filter();

                            $hasSameAccountInDebitCredit = $debitCoas->intersect($creditCoas)->isNotEmpty();
                        @endphp

                        @foreach ($journal->details as $index => $detail)
                            @php
                                $isCreditRow = $detail->credit > 0;
                                $detailCoaCode = $detail->chartOfAccount?->code ?? '';

                                // LOGIKA REF:
                                // Tampilkan Ref untuk SEMUA baris jika:
                                // A. Transaksi mengandung akun Non-Aset
                                // B. Transaksi memiliki akun yang sama di Debit & Kredit
                                // C. Jika transaksi antar-Aset yang berbeda -> Sembunyikan HANYA jika kodenya sama dengan Header Grup
                                if ($detailCoaCode === '') {
                                    $showRef = '';
                                } elseif ($hasNonAssetDetail || $hasSameAccountInDebitCredit) {
                                    $showRef = $detailCoaCode;
                                } else {
                                    $showRef = $detailCoaCode !== $groupCode ? $detailCoaCode : '';
                                }
                            @endphp

                            <tr class="hover:bg-slate-50/80 dark:hover:bg-slate-800/50 transition-colors duration-150">
                                {{-- NO (Hanya di baris pertama entri jurnal) --}}
                                <td class="px-3 py-3 text-center text-gray-400 font-mono text-xs">
                                    {{ $index === 0 ? $entryNumber++ : '' }}
                                </td>

                                {{-- TANGGAL --}}
                                <td
                                    class="px-4 py-3 text-center text-gray-600 dark:text-gray-300 whitespace-nowrap text-xs">
                                    {{ $index === 0 && $journal->journal_date ? $journal->journal_date->format('d/m/Y') : '' }}
                                </td>

                                {{-- NAMA REKENING --}}
                                <td
                                    class="px-5 py-3 {{ $isCreditRow ? 'pl-10 text-gray-600 dark:text-gray-400 font-normal' : 'font-semibold text-gray-900 dark:text-gray-100' }}">
                                    {{ $detail->chartOfAccount?->name ?? '-' }}
                                </td>

                                {{-- KETERANGAN --}}
                                <td class="px-4 py-3 text-gray-500 dark:text-gray-400 text-xs leading-relaxed">
                                    {{ $detail->description ?? ($index === 0 ? $journal->description : '') }}
                                </td>

                                {{-- PEMBUAT (POSTED BY) --}}
                                <td class="px-4 py-3 whitespace-nowrap">
                                    @if ($index === 0)
                                        <div class="flex items-center gap-1.5">
                                            <div
                                                class="w-5 h-5 rounded-full bg-slate-200 dark:bg-slate-700 flex items-center justify-center text-[10px] font-bold text-slate-700 dark:text-slate-300">
                                                {{ strtoupper(substr($journal->postedBy->name ?? 'S', 0, 1)) }}
                                            </div>
                                            <span
                                                class="text-xs text-gray-600 dark:text-gray-300 font-medium truncate max-w-[110px]"
                                                title="{{ $journal->postedBy->name ?? 'System' }}">
                                                {{ $journal->postedBy->name ?? 'System' }}
                                            </span>
                                        </div>
                                    @endif
                                </td>

                                {{-- REF --}}
                                <td class="px-3 py-3 text-center font-mono text-xs font-semibold">
                                    @if ($showRef !== '')
                                        <span
                                            class="text-indigo-600 dark:text-indigo-400 bg-indigo-50 dark:bg-indigo-950/50 px-1.5 py-0.5 rounded border border-indigo-100 dark:border-indigo-900">
                                            {{ $showRef }}
                                        </span>
                                    @else
                                        <span class="text-gray-300 dark:text-gray-600">-</span>
                                    @endif
                                </td>

                                {{-- DEBIT --}}
                                <td
                                    class="px-5 py-3 text-right font-medium text-gray-800 dark:text-gray-200 whitespace-nowrap">
                                    @if ($detail->debit > 0)
                                        Rp{{ number_format($detail->debit, 0, ',', '.') }}
                                        @php $subTotalDebit += $detail->debit @endphp
                                    @else
                                        <span class="text-gray-300 dark:text-gray-700">-</span>
                                    @endif
                                </td>

                                {{-- KREDIT --}}
                                <td
                                    class="px-5 py-3 text-right font-medium text-gray-800 dark:text-gray-200 whitespace-nowrap">
                                    @if ($detail->credit > 0)
                                        Rp{{ number_format($detail->credit, 0, ',', '.') }}
                                        @php $subTotalCredit += $detail->credit @endphp
                                    @else
                                        <span class="text-gray-300 dark:text-gray-700">-</span>
                                    @endif
                                </td>
                            </tr>
                        @endforeach
                    @endforeach

                    {{-- SUBTOTAL PER GRUP COA ASET --}}
                    <tr
                        class="bg-slate-100/90 dark:bg-slate-800/90 font-bold border-b-2 border-slate-300 dark:border-slate-600">
                        <td colspan="6"
                            class="px-6 py-3 text-right uppercase tracking-wider text-xs text-gray-600 dark:text-gray-400">
                            Subtotal {{ $group['account_name'] }}
                        </td>
                        <td
                            class="px-5 py-3 text-right text-emerald-700 dark:text-emerald-400 whitespace-nowrap font-bold">
                            Rp{{ number_format($subTotalDebit, 0, ',', '.') }}
                        </td>
                        <td class="px-5 py-3 text-right text-rose-700 dark:text-rose-400 whitespace-nowrap font-bold">
                            Rp{{ number_format($subTotalCredit, 0, ',', '.') }}
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="8" class="px-6 py-16 text-center text-gray-500 dark:text-gray-400">
                            <div class="flex flex-col items-center justify-center space-y-2">
                                <svg class="w-10 h-10 text-gray-400" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                </svg>
                                <p class="font-semibold text-gray-700 dark:text-gray-300">Tidak ada data jurnal umum
                                    ditemukan</p>
                                <p class="text-xs text-gray-400">Coba ubah kata kunci pencarian atau sesuaikan rentang
                                    tanggal filter Anda.</p>
                            </div>
                        </td>
                    </tr>
                @endforelse
            </tbody>

            {{-- GRAND TOTAL KESELURUHAN --}}
            @if (count($groupedJournals) > 0)
                <tfoot
                    class="bg-slate-200 dark:bg-slate-800 font-black text-gray-900 dark:text-white border-t-2 border-slate-400 dark:border-slate-600">
                    <tr>
                        <td colspan="6" class="px-6 py-3.5 text-center uppercase tracking-wider text-xs md:text-sm">
                            GRAND TOTAL MUTASI JURNAL
                        </td>
                        <td
                            class="px-5 py-3.5 text-right text-emerald-700 dark:text-emerald-300 whitespace-nowrap text-sm">
                            Rp{{ number_format($grandTotalDebit, 0, ',', '.') }}
                        </td>
                        <td
                            class="px-5 py-3.5 text-right text-emerald-700 dark:text-emerald-300 whitespace-nowrap text-sm">
                            Rp{{ number_format($grandTotalCredit, 0, ',', '.') }}
                        </td>
                    </tr>
                </tfoot>
            @endif
        </table>
    </div>
</div>
