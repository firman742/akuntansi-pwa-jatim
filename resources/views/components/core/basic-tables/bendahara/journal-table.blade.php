@props(['journals'])

@php
    $currentKasId = null;
    $currentKasName = null;
    $totalDebit = 0;
    $totalCredit = 0;
@endphp

<div
    class="overflow-hidden rounded-2xl border border-gray-200 bg-white
           dark:border-white/[0.05] dark:bg-white/[0.03]">

    <div class="max-w-full overflow-x-auto">
        <table class="w-full">

            {{-- TABLE HEADER --}}
            <thead
                class="border-y border-gray-100 bg-gray-50
                       dark:border-white/[0.05] dark:bg-gray-900">
                <tr>
                    <th class="px-6 py-3 text-theme-xs font-medium text-gray-500 text-start">No</th>
                    <th class="px-6 py-3 text-theme-xs font-medium text-gray-500 text-start">Tanggal</th>
                    <th class="px-6 py-3 text-theme-xs font-medium text-gray-500 text-start">Nama Rekening</th>
                    <th class="px-6 py-3 text-theme-xs font-medium text-gray-500 text-start">Ket.</th>
                    <th class="px-6 py-3 text-theme-xs font-medium text-gray-500 text-start">Ref</th>
                    <th class="px-6 py-3 text-theme-xs font-medium text-gray-500 text-end">Debit</th>
                    <th class="px-6 py-3 text-theme-xs font-medium text-gray-500 text-end">Kredit</th>
                </tr>
            </thead>

            {{-- TABLE BODY --}}
            <tbody>
                @foreach ($journals as $journalIndex => $journal)
                    @foreach ($journal->details as $detail)
                        @php
                            $isKas = $detail->coa?->accountType->name === 'ASET';
                            $isCreditRow = $detail->credit > 0;
                        @endphp

                        {{-- SUBTOTAL SEBELUM PINDAH KAS --}}
                        @if ($isKas && $currentKasId && $currentKasId !== $detail->coa_id)
                            <tr class="bg-gray-50 font-semibold border-t dark:bg-gray-700 dark:text-gray-200">
                                <td colspan="5" class="px-6 py-3 text-end text-sm">
                                    TOTAL {{ $currentKasName }}
                                </td>
                                <td class="px-6 py-3 text-end text-sm">
                                    Rp{{ number_format($totalDebit, 0, ',', '.') }}
                                </td>
                                <td class="px-6 py-3 text-end text-sm">
                                    Rp{{ number_format($totalCredit, 0, ',', '.') }}
                                </td>
                            </tr>

                            @php
                                $totalDebit = 0;
                                $totalCredit = 0;
                            @endphp
                        @endif

                        {{-- HEADER KAS --}}
                        @if ($isKas && $currentKasId !== $detail->coa_id)
                            <tr class="bg-gray-100 font-bold dark:bg-gray-800">
                                <td colspan="7" class="px-6 py-3 text-center text-gray-700 dark:text-gray-300">
                                    {{ $detail->coa->name }} ({{ $detail->coa->code }})
                                </td>
                            </tr>

                            @php
                                $currentKasId = $detail->coa_id;
                                $currentKasName = $detail->coa->name;
                            @endphp
                        @endif

                        {{-- BARIS TRANSAKSI --}}
                        <tr
                            class="{{ $isCreditRow
                                ? 'border-b-2 border-gray-500 bg-gray-100 dark:bg-gray-800 dark:border-white/20'
                                : 'border-b border-gray-100 dark:border-white/[0.05]' }}
                        ">

                            {{-- NO --}}
                            <td class="px-6 py-3 text-sm text-gray-700 dark:text-gray-400">
                                @if (!$isCreditRow)
                                    {{ $journalIndex + 1 }}
                                @endif
                            </td>

                            {{-- TANGGAL --}}
                            <td class="px-6 py-3 text-sm text-gray-700 dark:text-gray-400">
                                {{ \Carbon\Carbon::parse($journal->journal_date)->translatedFormat('d M Y') }}
                            </td>

                            {{-- NAMA REKENING --}}
                            <td
                                class="px-6 py-3 text-sm text-gray-700 dark:text-gray-400
                                       {{ $isCreditRow ? 'pl-16 font-medium' : 'pl-6' }}">
                                {{ $detail->coa?->name }}
                            </td>

                            {{-- KETERANGAN --}}
                            <td class="px-6 py-3 text-sm text-gray-600 dark:text-gray-400">
                                {{ $detail->description ?? '-' }}
                            </td>

                            {{-- REF --}}
                            <td class="px-6 py-3 text-sm text-gray-600 dark:text-gray-400">
                                {{ $detail->coa?->code }}
                            </td>

                            {{-- DEBIT --}}
                            <td class="px-6 py-3 text-sm text-end text-gray-700 dark:text-gray-400">
                                @if ($detail->debit > 0)
                                    Rp{{ number_format($detail->debit, 0, ',', '.') }}
                                    @php $totalDebit += $detail->debit; @endphp
                                @endif
                            </td>

                            {{-- KREDIT --}}
                            <td class="px-6 py-3 text-sm text-end text-gray-700 dark:text-gray-400">
                                @if ($detail->credit > 0)
                                    Rp{{ number_format($detail->credit, 0, ',', '.') }}
                                    @php $totalCredit += $detail->credit; @endphp
                                @endif
                            </td>

                        </tr>
                    @endforeach
                @endforeach

                {{-- TOTAL KAS TERAKHIR --}}
                @if ($currentKasId)
                    <tr class="bg-gray-50 font-semibold border-t dark:bg-gray-700 dark:text-gray-200">
                        <td colspan="5" class="px-6 py-3 text-end text-sm">
                            TOTAL {{ $currentKasName }}
                        </td>
                        <td class="px-6 py-3 text-end text-sm">
                            Rp{{ number_format($totalDebit, 0, ',', '.') }}
                        </td>
                        <td class="px-6 py-3 text-end text-sm">
                            Rp{{ number_format($totalCredit, 0, ',', '.') }}
                        </td>
                    </tr>
                @endif
            </tbody>

        </table>
    </div>
</div>
