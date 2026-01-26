{{-- @extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Jurnal Umum" />

    <div class="space-y-6">
        <x-core.basic-tables.bendahara.opening-balance-table :openingBalances="$openingBalances" :periods="$periods" :periodId="$periodId" />
    </div>
@endsection --}}


@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Jurnal Umum" />

    <x-core.basic-tables.bendahara.journal-table :journals="$journals" :periods="$periods" :periodId="$periodId" />

    {{-- <div x-data="journalTable()" class="space-y-6">
        <div class="flex items-center justify-between">
            <span class="text-sm text-gray-500">
                Periode: {{ $period->name }}
            </span>
        </div>

        <div class="overflow-hidden rounded-xl border border-gray-200 dark:border-gray-800">
            <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-800">
                <thead class="bg-gray-50 dark:bg-gray-900">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium">Tanggal</th>
                        <th class="px-6 py-3 text-left text-xs font-medium">No Jurnal</th>
                        <th class="px-6 py-3 text-left text-xs font-medium">Deskripsi</th>
                        <th class="px-6 py-3 text-right text-xs font-medium">Debit</th>
                        <th class="px-6 py-3 text-right text-xs font-medium">Kredit</th>
                        <th class="px-6 py-3 text-left text-xs font-medium">Aksi</th>
                    </tr>
                </thead>

                <tbody class="divide-y divide-gray-200 dark:divide-gray-800">
                    @foreach ($journals as $journal)
                        <tr>
                            <td class="px-6 py-3" x-text="formatDate('{{ $journal->journal_date }}')">
                            </td>

                            <td class="px-6 py-3 font-medium">
                                {{ $journal->journal_number }}
                            </td>

                            <td class="px-6 py-3">
                                {{ $journal->description ?? '-' }}
                            </td>

                            <td class="px-6 py-3 text-right">
                                <span class="font-medium">
                                    Rp {{ number_format($journal->total_debit, 0, ',', '.') }}
                                </span>
                            </td>

                            <td class="px-6 py-3 text-right">
                                <span class="font-medium">
                                    Rp {{ number_format($journal->total_credit, 0, ',', '.') }}
                                </span>
                            </td>

                            <td class="px-6 py-3">
                                <a href="{{ route('bendahara.journals.show', $journal) }}"
                                    class="text-primary-600 hover:underline text-sm">
                                    Detail
                                </a>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>

        {{ $journals->links() }}
    </div>

    <script>
        function journalTable() {
            return {
                formatDate(date) {
                    if (!date) return '-';
                    return new Date(date).toLocaleDateString('id-ID', {
                        day: '2-digit',
                        month: 'long',
                        year: 'numeric'
                    });
                }
            }
        }
    </script> --}}
@endsection
