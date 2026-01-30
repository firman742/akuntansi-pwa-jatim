@extends('layouts.app')

@section('content')
    <div class="max-w-6xl mx-auto">
        <a href="{{ route('bendahara.journals.index') }}">
            <x-ui.button variant="outline" size="sm" >
                <x-slot:startIcon>
                    <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
                    </svg>
                </x-slot:startIcon>
                Kembali
            </x-ui.button>
        </a>
        
        {{-- MAIN CARD --}}
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 space-y-6 mt-3">

            {{-- HEADER INFO --}}
            <div class="grid grid-cols-2 gap-6 text-sm">
                <div>
                    <div class="text-gray-500">No Jurnal</div>
                    <div class="font-semibold text-gray-900">
                        {{ $journal->journal_number }}
                    </div>
                </div>

                <div>
                    <div class="text-gray-500">Tanggal</div>
                    <div class="font-semibold text-gray-900">
                        {{ $journal->journal_date->format('d F Y') }}
                    </div>
                </div>

                <div>
                    <div class="text-gray-500">Diposting oleh</div>
                    <div class="font-semibold text-gray-900">
                        {{ $journal->postedBy?->name ?? '-' }}
                    </div>
                </div>

                <div>
                    <div class="text-gray-500">Sumber Transaksi</div>
                    <div class="font-semibold text-gray-900">
                        {{ $journal->transaction?->transaction_number ?? '-' }}
                    </div>
                </div>
            </div>

            <hr class="border-gray-200">

            {{-- TABLE CARD --}}
            <div class="rounded-lg border border-gray-200 overflow-hidden">
                <table class="min-w-full text-sm">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left font-semibold text-gray-600">
                                Akun
                            </th>
                            <th class="px-6 py-3 text-left font-semibold text-gray-600">
                                Deskripsi
                            </th>
                            <th class="px-6 py-3 text-right font-semibold text-gray-600">
                                Debit
                            </th>
                            <th class="px-6 py-3 text-right font-semibold text-gray-600">
                                Kredit
                            </th>
                        </tr>
                    </thead>

                    <tbody class="divide-y divide-gray-200">
                        @foreach ($journal->details as $detail)
                            <tr>
                                <td class="px-6 py-4">
                                    <div class="font-medium text-gray-900">
                                        {{ $detail->coa->code }}
                                    </div>
                                    <div class="text-xs text-gray-500">
                                        {{ $detail->coa->name }}
                                    </div>
                                </td>

                                <td class="px-6 py-4 text-gray-700">
                                    {{ $detail->description ?? '-' }}
                                </td>

                                <td class="px-6 py-4 text-right">
                                    {{ $detail->debit > 0
                                        ? number_format($detail->debit, 0, ',', '.')
                                        : '-' }}
                                </td>

                                <td class="px-6 py-4 text-right">
                                    {{ $detail->credit > 0
                                        ? number_format($detail->credit, 0, ',', '.')
                                        : '-' }}
                                </td>
                            </tr>
                        @endforeach
                    </tbody>

                    <tfoot class="bg-gray-50">
                        <tr>
                            <td colspan="2" class="px-6 py-4 text-right font-semibold">
                                Total
                            </td>
                            <td class="px-6 py-4 text-right font-semibold">
                                Rp {{ number_format($journal->total_debit, 0, ',', '.') }}
                            </td>
                            <td class="px-6 py-4 text-right font-semibold">
                                Rp {{ number_format($journal->total_credit, 0, ',', '.') }}
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>

        </div>
    </div>
@endsection
