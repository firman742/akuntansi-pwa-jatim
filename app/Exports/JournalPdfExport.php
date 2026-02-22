<?php

namespace App\Exports;

use Barryvdh\DomPDF\Facade\Pdf;

class JournalPdfExport
{
    public function download($journals, array $meta = [])
    {
        $fileName = 'Jurnal-Umum';

        if (!empty($meta['period_name'])) {
            $fileName .= '-Periode-' . str_replace(' ', '_', $meta['period_name']);
        }

        if (!empty($meta['month_label'])) {
            $fileName .= '-Bulan-' . str_replace(' ', '_', $meta['month_label']);
        }

        if (!empty($meta['year'])) {
            $fileName .= '-Tahun-' . $meta['year'];
        }

        $fileName .= '.pdf';

        $pdf = Pdf::loadView('pages.menus.bendahara.journals.pdf', [
            'journals' => $journals,
            'meta'     => $meta,
        ])->setPaper('A4', 'portrait')
            ->setOptions([
                'isHtml5ParserEnabled' => true,
                'isRemoteEnabled' => false,
                'dpi' => 72,
                'defaultFont' => 'DejaVu Sans'
            ]);

        return $pdf->download($fileName);
    }
}
