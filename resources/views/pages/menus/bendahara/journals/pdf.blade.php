<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Jurnal Umum</title>
    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 11px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            border: 1px solid #444;
            padding: 6px;
        }

        th {
            background: #f0f0f0;
            text-align: center;
        }

        .right {
            text-align: right;
        }

        .center {
            text-align: center;
        }

        .subtotal {
            background: #eee;
            font-weight: bold;
        }

        .kas-header {
            background: #ddd;
            font-weight: bold;
            text-align: center;
        }

        .header-box {
            text-align: center;
            margin-bottom: 10px;
        }

        .meta {
            font-size: 11px;
        }
    </style>
</head>

<body>

    <div class="header-box">
        <h3 style="margin-bottom:4px;">JURNAL UMUM</h3>
        <div class="meta"><strong>Periode:</strong> {{ $meta['period_name'] ?? '-' }}</div>
        <div class="meta"><strong>Rentang Bulan:</strong> {{ $meta['month_label'] ?? '-' }}</div>
        <div class="meta"><strong>Institusi:</strong> {{ $meta['institution_name'] ?? '-' }}</div>
        <div class="meta"><strong>Dicetak oleh:</strong> {{ $meta['user_name'] ?? '-' }}</div>
        <div class="meta"><strong>Tanggal Cetak:</strong> {{ \Carbon\Carbon::now()->translatedFormat('d F Y H:i') }}
        </div>
    </div>

    @php
        $currentKasId = null;
        $currentKasName = null;
        $totalDebit = 0;
        $totalCredit = 0;
    @endphp

    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>Tanggal</th>
                <th>Nama Rekening</th>
                <th>Ket</th>
                <th>Ref</th>
                <th>Debit</th>
                <th>Kredit</th>
            </tr>
        </thead>
        <tbody>

            @foreach ($journals as $journalIndex => $journal)
                @foreach ($journal->details as $detail)
                    @php
                        $isKas = $detail->coa?->accountType->name === 'ASET';
                        $isCreditRow = $detail->credit > 0;
                    @endphp

                    {{-- SUBTOTAL --}}
                    @if ($isKas && $currentKasId && $currentKasId !== $detail->coa_id)
                        <tr class="subtotal">
                            <td colspan="5" class="right">TOTAL {{ $currentKasName }}</td>
                            <td class="right">{{ number_format($totalDebit, 0, ',', '.') }}</td>
                            <td class="right">{{ number_format($totalCredit, 0, ',', '.') }}</td>
                        </tr>
                        @php
                            $totalDebit = 0;
                            $totalCredit = 0;
                        @endphp
                    @endif

                    {{-- HEADER KAS --}}
                    @if ($isKas && $currentKasId !== $detail->coa_id)
                        <tr class="kas-header">
                            <td colspan="7">{{ $detail->coa->name }} ({{ $detail->coa->code }})</td>
                        </tr>
                        @php
                            $currentKasId = $detail->coa_id;
                            $currentKasName = $detail->coa->name;
                        @endphp
                    @endif

                    <tr>
                        <td class="center">{{ !$isCreditRow ? $journalIndex + 1 : '' }}</td>
                        <td class="center">{{ \Carbon\Carbon::parse($journal->journal_date)->format('d-m-Y') }}</td>
                        <td style="padding-left: {{ $isCreditRow ? '30px' : '6px' }};">
                            {{ $detail->coa?->name }}
                        </td>
                        <td>{{ $detail->description ?? '-' }}</td>
                        <td class="center">{{ $detail->coa?->code }}</td>
                        <td class="right">
                            @if ($detail->debit > 0)
                                {{ number_format($detail->debit, 0, ',', '.') }}
                                @php $totalDebit += $detail->debit; @endphp
                            @endif
                        </td>
                        <td class="right">
                            @if ($detail->credit > 0)
                                {{ number_format($detail->credit, 0, ',', '.') }}
                                @php $totalCredit += $detail->credit; @endphp
                            @endif
                        </td>
                    </tr>
                @endforeach
            @endforeach

            {{-- TOTAL TERAKHIR --}}
            @if ($currentKasId)
                <tr class="subtotal">
                    <td colspan="5" class="right">TOTAL {{ $currentKasName }}</td>
                    <td class="right">{{ number_format($totalDebit, 0, ',', '.') }}</td>
                    <td class="right">{{ number_format($totalCredit, 0, ',', '.') }}</td>
                </tr>
            @endif

        </tbody>
    </table>

</body>

</html>
