<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <title>Laporan Jurnal Umum</title>
    <style>
        @page {
            margin: 12mm 10mm 15mm 10mm;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 9px;
            color: #1f2937;
            line-height: 1.3;
        }

        /* KOP HEADER */
        .header-container {
            text-align: center;
            border-bottom: 2px solid #1e3a8a;
            padding-bottom: 8px;
            margin-bottom: 12px;
        }

        .header-container h2 {
            margin: 0;
            font-size: 15px;
            text-transform: uppercase;
            color: #1e3a8a;
            font-weight: bold;
        }

        .header-container h3 {
            margin: 3px 0 0 0;
            font-size: 12px;
            color: #374151;
            font-weight: bold;
        }

        .header-container p {
            margin: 3px 0 0 0;
            font-size: 8.5px;
            color: #6b7280;
        }

        .filter-info {
            margin-bottom: 12px;
            font-size: 9px;
            background-color: #f8fafc;
            padding: 6px 10px;
            border-radius: 4px;
            border: 1px solid #e2e8f0;
        }

        /* OVERRIDE DOMPDF CSS UNTUK BLADE COMPONENT JOURNAL TABLE */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 8.5px;
            margin-bottom: 15px;
        }

        table th,
        table td {
            border: 1px solid #cbd5e1 !important;
            padding: 4px 5px !important;
            vertical-align: top;
        }

        table thead th {
            background-color: #f1f5f9 !important;
            color: #0f172a !important;
            font-weight: bold !important;
            text-transform: uppercase;
            text-align: center;
        }

        /* Utility Class Mapping Tailwind -> DomPDF */
        .text-center {
            text-align: center !important;
        }

        .text-right {
            text-align: right !important;
        }

        .text-left {
            text-align: left !important;
        }

        .font-bold,
        .font-extrabold,
        .font-semibold,
        .font-black {
            font-weight: bold !important;
        }

        .uppercase {
            text-transform: uppercase !important;
        }

        .whitespace-nowrap {
            white-space: nowrap !important;
        }

        .pl-10 {
            padding-left: 18px !important;
        }

        .bg-indigo-50\/70,
        .bg-indigo-50 {
            background-color: #e0f2fe !important;
        }

        .text-indigo-900,
        .text-indigo-950 {
            color: #0369a1 !important;
        }

        .bg-slate-100\/90,
        .bg-slate-100 {
            background-color: #f1f5f9 !important;
        }

        .bg-slate-200 {
            background-color: #e2e8f0 !important;
        }

        .text-emerald-700 {
            color: #047857 !important;
        }

        .text-rose-700 {
            color: #be123c !important;
        }

        /* FOOTER / KOLOM TANDA TANGAN */
        .signature-container {
            margin-top: 25px;
            width: 100%;
            page-break-inside: avoid;
        }

        .signature-table {
            width: 100%;
            border-collapse: collapse;
            border: none !important;
        }

        .signature-table td {
            border: none !important;
            vertical-align: top;
            padding: 0 15px;
        }

        .signature-date {
            text-align: right !important;
            padding-bottom: 15px !important;
            font-size: 9px;
            color: #374151;
        }

        .signature-col {
            width: 50%;
            text-align: center;
        }

        .signature-title {
            font-size: 9.5px;
            font-weight: bold;
            color: #374151;
            line-height: 1.4;
            margin-bottom: 60px;
            /* Ruang untuk tanda tangan basah/stempel */
        }

        .signature-name {
            font-size: 9.5px;
            font-weight: bold;
            text-decoration: underline;
            color: #111827;
            margin: 0;
        }
    </style>
</head>

<body>

    {{-- KOP HEADER --}}
    <div class="header-container">
        <h2>PIMPINAN WILAYAH AISYIYAH JAWA TIMUR</h2>
        <h3>LAPORAN JURNAL UMUM</h3>
        <p>Jl. Taman Apsari No. 15–17, Embong Kaliasin, Kecamatan Genteng, Kota Surabaya, Jawa Timur 60271</p>
        <p>Laporan Keuangan Terintegrasi Bendahara</p>
    </div>

    {{-- FILTER INFORMATION --}}
    <div class="filter-info">
        <table style="width: 100%; border: none; margin-bottom: 0;">
            <tr>
                <td style="border: none !important; padding: 0 !important; width: 50%;">
                    <strong>Periode:</strong> {{ $selectedPeriod->name ?? 'Semua Periode' }}
                    @if ($selectedSubPeriod)
                        | <strong>Sub Periode:</strong> {{ $selectedSubPeriod->name }}
                    @endif
                </td>
                <td style="border: none !important; padding: 0 !important; width: 50%; text-align: right;">
                    <strong>Tanggal:</strong>
                    {{ $startDate ? \Carbon\Carbon::parse($startDate)->format('d/m/Y') : '-' }}
                    s/d
                    {{ $endDate ? \Carbon\Carbon::parse($endDate)->format('d/m/Y') : '-' }}
                </td>
            </tr>
        </table>
    </div>

    {{-- PANGGIL BLADE COMPONENT DENGAN PARAMETER IS_PDF --}}
    <x-core.basic-tables.bendahara.journal-table :groupedJournals="$groupedJournals" :journals="$journals" :grandTotalDebit="$grandTotalDebit" :grandTotalCredit="$grandTotalCredit"
        :isPdf="true" />

    {{-- FOOTER / KOLOM TANDA TANGAN --}}
    <div class="signature-container">
        <table class="signature-table">
            <tr>
                <td colspan="2" class="signature-date">
                    Surabaya, {{ \Carbon\Carbon::now()->translatedFormat('d F Y') }}
                </td>
            </tr>
            <tr>
                <td class="signature-col">
                    <div class="signature-title">Mengetahui,<br>Ketua PWA Jawa Timur</div>
                    <p class="signature-name">Dra. Hj. Rukmini M.AP.</p>
                </td>
                <td class="signature-col">
                    <div class="signature-title">Mengetahui,<br>Bendahara PWA Jawa Timur</div>
                    <p class="signature-name">Dr. Hj. Heni Mardiningsih, S.E. M.M.</p>
                </td>
            </tr>
        </table>
    </div>

</body>

</html>
