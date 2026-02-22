@props(['groupedJournals'])

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
            {{-- TABLE BODY --}}
            <tbody>
                @foreach ($groupedJournals as $group)
                    {{-- HEADER KAS --}}
                    <tr class="bg-gray-100 font-bold dark:bg-gray-800">
                        <td colspan="7" class="px-6 py-3 text-center text-gray-700 dark:text-gray-300">
                            {{ $group['account_info'] }}
                        </td>
                    </tr>

                    @php
                        $subTotalDebit = 0;
                        $subTotalCredit = 0;
                        $no = 1;
                    @endphp

                    @foreach ($group['data'] as $journal)
                        @foreach ($journal->details as $detail)
                            @php $isCreditRow = $detail->credit > 0; @endphp

                            <tr class="{{ $isCreditRow ? 'bg-gray-50/50' : 'border-t border-gray-100' }}">
                                {{-- NO --}}
                                <td class="px-6 py-3 text-sm text-gray-700">
                                    {{ !$isCreditRow ? $no++ : '' }}
                                </td>

                                {{-- TANGGAL --}}
                                <td class="px-6 py-3 text-sm text-gray-700">
                                    {{ $journal->journal_date->translatedFormat('d M Y') }}
                                </td>

                                {{-- NAMA REKENING --}}
                                <td class="px-6 py-3 text-sm {{ $isCreditRow ? 'pl-12' : '' }}">
                                    {{ $detail->coa?->name }}
                                </td>

                                {{-- KETERANGAN --}}
                                <td class="px-6 py-3 text-sm text-gray-600">
                                    {{ $detail->description ?? $journal->description }}
                                </td>

                                {{-- REF --}}
                                <td class="px-6 py-3 text-sm text-gray-600">
                                    {{ $detail->coa?->code }}
                                </td>

                                {{-- DEBIT --}}
                                <td class="px-6 py-3 text-sm text-end">
                                    @if ($detail->debit > 0)
                                        Rp{{ number_format($detail->debit, 0, ',', '.') }}
                                        @php $subTotalDebit += $detail->debit @endphp
                                    @endif
                                </td>

                                {{-- KREDIT --}}
                                <td class="px-6 py-3 text-sm text-end">
                                    @if ($detail->credit > 0)
                                        Rp{{ number_format($detail->credit, 0, ',', '.') }}
                                        @php $subTotalCredit += $detail->credit @endphp
                                    @endif
                                </td>
                            </tr>
                        @endforeach
                    @endforeach

                    {{-- SUBTOTAL PER KAS --}}
                    <tr class="bg-gray-50 font-semibold border-y-2 border-gray-200">
                        <td colspan="5" class="px-6 py-3 text-end text-sm">TOTAL {{ $group['account_info'] }}</td>
                        <td class="px-6 py-3 text-end text-sm">Rp{{ number_format($subTotalDebit, 0, ',', '.') }}</td>
                        <td class="px-6 py-3 text-end text-sm">Rp{{ number_format($subTotalCredit, 0, ',', '.') }}</td>
                    </tr>
                @endforeach
            </tbody>

        </table>
    </div>
</div>
