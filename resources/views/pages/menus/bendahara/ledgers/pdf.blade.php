<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <title>Laporan Buku Besar - {{ $coa->code ?? '' }} {{ $coa->name ?? '' }}</title>
    <style>
        @page {
            margin: 12mm 10mm 15mm 10mm;
            size: a4 landscape;
        }

        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            font-size: 9pt;
            color: #111827;
            line-height: 1.3;
        }

        /* HEADER / KOP LAPORAN */
        .kop-container {
            width: 100%;
            border-bottom: 2px solid #111827;
            padding-bottom: 8px;
            margin-bottom: 12px;
        }

        .kop-table {
            width: 100%;
            border-collapse: collapse;
        }

        .kop-title {
            text-align: center;
        }

        .kop-title h1 {
            font-size: 14pt;
            font-weight: bold;
            text-transform: uppercase;
            margin: 0;
            color: #111827;
        }

        .kop-title h2 {
            font-size: 11pt;
            font-weight: bold;
            text-transform: uppercase;
            margin: 2px 0 0 0;
            color: #374151;
        }

        .kop-title p {
            font-size: 8pt;
            margin: 2px 0 0 0;
            color: #6b7280;
        }

        /* METADATA INFORMASI AKUN */
        .info-table {
            width: 100%;
            margin-bottom: 10px;
            border-collapse: collapse;
            font-size: 8.5pt;
        }

        .info-table td {
            padding: 3px 0;
            vertical-align: top;
        }

        .badge {
            display: inline-block;
            padding: 2px 6px;
            font-weight: bold;
            background-color: #f3f4f6;
            border: 1px solid #d1d5db;
            border-radius: 3px;
        }

        /* TABEL UTAMA LEDGER */
        .ledger-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 8pt;
            margin-bottom: 15px;
        }

        .ledger-table th,
        .ledger-table td {
            border: 1px solid #d1d5db;
            padding: 5px 6px;
            vertical-align: middle;
        }

        .ledger-table th {
            background-color: #f3f4f6;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 7.5pt;
            color: #374151;
            text-align: center;
        }

        .ledger-table td.text-center {
            text-align: center;
        }

        .ledger-table td.text-right {
            text-align: right;
        }

        .ledger-table td.text-left {
            text-align: left;
        }

        .ledger-table .font-mono {
            font-family: 'Courier New', Courier, monospace;
        }

        .bg-opening {
            background-color: #f0f9ff;
            font-weight: bold;
        }

        .bg-footer-1 {
            background-color: #f9fafb;
            font-weight: bold;
        }

        .bg-footer-2 {
            background-color: #f3f4f6;
            font-weight: bold;
        }

        /* TANDA TANGAN FOOTER */
        .signature-container {
            width: 100%;
            margin-top: 25px;
            page-break-inside: avoid;
        }

        .signature-table {
            width: 100%;
            border-collapse: collapse;
        }

        .signature-table td {
            width: 50%;
            text-align: center;
            vertical-align: top;
            padding: 0 20px;
        }

        .signature-title {
            font-size: 9pt;
            font-weight: bold;
            margin-bottom: 60px;
        }

        .signature-name {
            font-size: 9.5pt;
            font-weight: bold;
            text-decoration: underline;
            margin: 0;
        }
    </style>
</head>

<body>

    {{-- KOP LAPORAN --}}
    <div class="kop-container">
        <table class="kop-table">
            <tr>
                <td class="kop-title">
                    <h1>PIMPINAN WILAYAH 'AISYIYAH JAWA TIMUR</h1>
                    <h2>LAPORAN BUKU BESAR (GENERAL LEDGER)</h2>
                    <p>
                        Periode: {{ $selectedPeriod->name ?? '-' }}
                        @if ($selectedSubPeriod)
                            | Sub Periode: {{ $selectedSubPeriod->name }}
                        @endif
                        @if ($startDate && $endDate)
                            | Tanggal: {{ \Carbon\Carbon::parse($startDate)->format('d/m/Y') }} -
                            {{ \Carbon\Carbon::parse($endDate)->format('d/m/Y') }}
                        @endif
                    </p>
                </td>
            </tr>
        </table>
    </div>

    @php
        $normalBalStr = is_object($coa->normal_balance) ? $coa->normal_balance->value : $coa->normal_balance;
        $isDebitAcc = strtoupper($normalBalStr) === 'DEBIT';
    @endphp

    {{-- INFORMASI AKUN & RINGKASAN METRIK --}}
    <table class="info-table">
        <tr>
            <td style="width: 50%;">
                <strong>Kode Akun:</strong> <span class="badge">{{ $coa->code }}</span><br>
                <strong>Nama Akun:</strong> <span
                    style="font-size: 10pt; font-weight: bold;">{{ strtoupper($coa->name) }}</span><br>
                <strong>Saldo Normal:</strong> {{ strtoupper($normalBalStr) }}
            </td>
            <td style="width: 50%; text-align: right;">
                <strong>Saldo Awal:</strong> Rp{{ number_format(abs($openingBalance), 0, ',', '.') }}<br>
                <strong>Total Mutasi (D / K):</strong> Rp{{ number_format($totalDebitMutation, 0, ',', '.') }} /
                Rp{{ number_format($totalCreditMutation, 0, ',', '.') }}<br>
                <strong>Saldo Akhir:</strong> <span
                    style="font-size: 10pt; font-weight: bold; color: #059669;">Rp{{ number_format(abs($endingBalance), 0, ',', '.') }}</span>
            </td>
        </tr>
    </table>

    {{-- TABEL UTAMA LEDGER --}}
    <table class="ledger-table">
        <thead>
            <tr>
                <th rowspan="2" style="width: 70px;">Tanggal</th>
                <th rowspan="2">Keterangan</th>
                <th rowspan="2" style="width: 180px;">Akun Lawan</th>
                <th rowspan="2" style="width: 70px;">Kode</th>
                <th rowspan="2" style="width: 90px;">Posting Oleh</th>
                <th rowspan="2" style="width: 95px;">Debit (Rp)</th>
                <th rowspan="2" style="width: 95px;">Kredit (Rp)</th>
                <th colspan="2">Saldo Kumulatif (Rp)</th>
            </tr>
            <tr>
                <th style="width: 95px;">Saldo Debit</th>
                <th style="width: 95px;">Saldo Kredit</th>
            </tr>
        </thead>
        <tbody>
            {{-- BARIS SALDO AWAL --}}
            <tr class="bg-opening">
                <td class="text-center font-mono">{{ $openingBalanceDate }}</td>
                <td>Saldo Awal Periode</td>
                <td class="text-center">-</td>
                <td class="text-center">-</td>
                <td class="text-left">{{ $openingBalanceCreatedBy }}</td>
                <td class="text-right font-mono">
                    {{ $openingDebit > 0 ? number_format($openingDebit, 0, ',', '.') : '-' }}</td>
                <td class="text-right font-mono">
                    {{ $openingCredit > 0 ? number_format($openingCredit, 0, ',', '.') : '-' }}</td>
                <td class="text-right font-mono">
                    {{ $isDebitAcc ? number_format(abs($openingBalance), 0, ',', '.') : '-' }}</td>
                <td class="text-right font-mono">
                    {{ !$isDebitAcc ? number_format(abs($openingBalance), 0, ',', '.') : '-' }}</td>
            </tr>

            {{-- BARIS TRANSAKSI --}}
            @forelse ($ledger as $row)
                <tr>
                    <td class="text-center font-mono">{{ $row['date']->format('d/m/Y') }}</td>
                    <td class="text-left">{{ $row['description'] }}</td>
                    <td class="text-left">{{ $row['opposing_account_name'] }}</td>
                    <td class="text-center font-mono">{{ $row['opposing_account_code'] }}</td>
                    <td class="text-left">{{ $row['posted_by'] }}</td>
                    <td class="text-right font-mono">
                        {{ $row['debit'] > 0 ? number_format($row['debit'], 0, ',', '.') : '-' }}</td>
                    <td class="text-right font-mono">
                        {{ $row['credit'] > 0 ? number_format($row['credit'], 0, ',', '.') : '-' }}</td>
                    <td class="text-right font-mono font-bold">
                        {{ $isDebitAcc ? number_format($row['current_balance'], 0, ',', '.') : '-' }}</td>
                    <td class="text-right font-mono font-bold">
                        {{ !$isDebitAcc ? number_format($row['current_balance'], 0, ',', '.') : '-' }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="9" class="text-center" style="padding: 20px; color: #9ca3af;">
                        Tidak ada transaksi untuk akun ini pada periode yang dipilih.
                    </td>
                </tr>
            @endforelse
        </tbody>
        <tfoot>
            @php
                $grandTotalDebit = $openingDebit + $totalDebitMutation;
                $grandTotalCredit = $openingCredit + $totalCreditMutation;
            @endphp

            {{-- TOTAL MUTASI TRANSAKSI --}}
            <tr class="bg-footer-1">
                <td colspan="5" class="text-right" style="text-transform: uppercase;">Total Mutasi Transaksi</td>
                <td class="text-right font-mono">{{ number_format($totalDebitMutation, 0, ',', '.') }}</td>
                <td class="text-right font-mono">{{ number_format($totalCreditMutation, 0, ',', '.') }}</td>
                <td colspan="2" class="text-center" style="color: #6b7280; font-style: italic;">(Hanya Transaksi)
                </td>
            </tr>

            {{-- GRAND TOTAL (+ SALDO AWAL) --}}
            <tr class="bg-footer-2">
                <td colspan="5" class="text-right" style="text-transform: uppercase;">Total Akumulasi (+ Saldo Awal)
                </td>
                <td class="text-right font-mono">{{ number_format($grandTotalDebit, 0, ',', '.') }}</td>
                <td class="text-right font-mono">{{ number_format($grandTotalCredit, 0, ',', '.') }}</td>
                <td class="text-right font-mono" style="font-size: 8.5pt;">
                    {{ $isDebitAcc ? number_format(abs($endingBalance), 0, ',', '.') : '-' }}</td>
                <td class="text-right font-mono" style="font-size: 8.5pt;">
                    {{ !$isDebitAcc ? number_format(abs($endingBalance), 0, ',', '.') : '-' }}</td>
            </tr>
        </tfoot>
    </table>

    {{-- KOLOM TANDA TANGAN FOOTER --}}
    <div class="signature-container">
        <table class="signature-table">
            <tr>
                <td>
                    <p class="signature-title">
                        Mengetahui,<br>
                        Ketua PWA Jawa Timur
                    </p>
                    <p class="signature-name">Dra. Hj. Rukmini M.AP.</p>
                </td>
                <td>
                    <p class="signature-title">
                        Surabaya, {{ \Carbon\Carbon::now()->isoFormat('D MMMM Y') }}<br>
                        Bendahara PWA Jawa Timur
                    </p>
                    <p class="signature-name">Dr. Hj. Heni Mardiningsih, S.E. M.M.</p>
                </td>
            </tr>
        </table>
    </div>

</body>

</html>
