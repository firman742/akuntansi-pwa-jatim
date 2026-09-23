@extends('layouts.app')

@section('title', 'Edit Transaksi Penerimaan')

@section('content')

    <x-common.page-breadcrumb defaultTitle="Edit Transaksi Penerimaan" pageTitle="Transaksi Penerimaan"
        pageDescription="Perbarui data transaksi penerimaan kas" pageIcon="transaction" parentTitle="Transaksi Penerimaan"
        :parentRoute="route('user.transactions.incomes.index')" currentTitle="Edit" />

    <a href="{{ route('user.transactions.incomes.index') }}" class="inline-flex shrink-0 mb-5">
        <x-ui.button variant="outline" size="sm">Kembali</x-ui.button>
    </a>

    {{-- ALERTS --}}
    @if (session('error'))
        <div class="mb-6">
            <x-ui.alert variant="error" title="Gagal Mengunggah / Menyimpan" message="{{ session('error') }}" />
        </div>
    @endif

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li class="text-sm text-rose-600">{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    @php
        $initialSubPeriodName = $subPeriods->firstWhere('id', $transaction->sub_period_id)?->name ?? '-';
        $initialCashName = collect($cashCoas)->firstWhere('user_account_balance_id', $selectedUserBalanceId);
        $initialCashLabel = $initialCashName ? "{$initialCashName['coa_code']} - {$initialCashName['coa_name']}" : '-';

        $initialIncomeCoa = $incomeCoas->firstWhere('id', $selectedCreditLine?->chart_of_account_id);
        $initialIncomeCoaLabel = $initialIncomeCoa ? "{$initialIncomeCoa->code} - {$initialIncomeCoa->name}" : '-';

        // Cek data file lama
        $existingReceiptPath = $transaction->receipt_path;
        $existingReceiptUrl = $transaction->receipt_url; // Memanfaatkan accessor getReceiptUrlAttribute
        $existingReceiptName = $existingReceiptPath ? basename($existingReceiptPath) : '';
        $isExistingImage = $existingReceiptPath && preg_match('/\.(jpg|jpeg|png|webp)$/i', $existingReceiptPath);
    @endphp

    <div class="mx-auto pb-10" x-data="incomeForm(
        @js($cashCoas),
        @js($transaction->gross_amount),
        @js($selectedUserBalanceId),
        @js($transaction->transaction_date->format('Y-m-d')),
        @js($transaction->description),
        @js($existingReceiptUrl && $isExistingImage ? $existingReceiptUrl : null),
        @js($existingReceiptName)
    )" x-init="init()">

        {{-- enctype ditambahkan agar file upload terkirim --}}
        <form action="{{ route('user.transactions.incomes.update', $transaction->id) }}" method="POST"
            enctype="multipart/form-data">
            @csrf
            @method('PUT')

            <input type="hidden" name="period_id" value="{{ $selectedPeriodId }}">
            <input type="hidden" name="sub_period_id" value="{{ $transaction->sub_period_id }}">
            <input type="hidden" name="user_account_balance_id" value="{{ $selectedUserBalanceId }}">
            <input type="hidden" name="income_coa_id" value="{{ $selectedCreditLine?->chart_of_account_id }}">

            <div class="grid lg:grid-cols-3 gap-8 items-start">
                <div class="lg:col-span-2 space-y-6">

                    {{-- INFORMASI TRANSAKSI --}}
                    <x-common.component-card title="Informasi Transaksi" desc="Ubah informasi dasar transaksi">
                        <div class="grid md:grid-cols-2 gap-5">
                            <div>
                                <x-form.select id="sub_period_id_disabled" name="sub_period_id_disabled"
                                    label="Sub Periode (Terkunci)" disabled>
                                    @foreach ($subPeriods as $subPeriod)
                                        <option value="{{ $subPeriod->id }}" @selected($transaction->sub_period_id == $subPeriod->id)>
                                            {{ $subPeriod->name }}
                                        </option>
                                    @endforeach
                                </x-form.select>
                            </div>
                            <div>
                                <x-form.date-picker id="transaction_date" name="transaction_date" label="Tanggal Transaksi"
                                    defaultDate="{{ old('transaction_date', $transaction->transaction_date->format('Y-m-d')) }}"
                                    x-model="transactionDate" />
                            </div>
                        </div>
                    </x-common.component-card>

                    {{-- KAS PENERIMA --}}
                    <x-common.component-card title="Kas Penerima" desc="Akun kas penerima (Terkunci)">
                        <div class="space-y-4">
                            <x-form.select id="user_account_balance_id_disabled" name="user_account_balance_id_disabled"
                                label="Akun Kas Penerima" disabled>
                                <option value="">-- Pilih Akun Kas --</option>
                                @foreach ($cashCoas as $cash)
                                    <option value="{{ $cash['user_account_balance_id'] }}" @selected($selectedUserBalanceId == $cash['user_account_balance_id'])>
                                        {{ $cash['coa_code'] }} - {{ $cash['coa_name'] }}
                                    </option>
                                @endforeach
                            </x-form.select>
                        </div>
                    </x-common.component-card>

                    {{-- DETAIL PENERIMAAN --}}
                    <x-common.component-card title="Detail Penerimaan" desc="Ubah sumber penerimaan dan nominal">
                        <div class="space-y-5">
                            <x-form.select name="income_coa_id_disabled" label="Akun Sumber Penerimaan (Terkunci)" disabled>
                                @foreach ($incomeCoas as $coa)
                                    <option value="{{ $coa->id }}" @selected($selectedCreditLine?->chart_of_account_id == $coa->id)>
                                        {{ $coa->code }} - {{ $coa->name }}
                                    </option>
                                @endforeach
                            </x-form.select>

                            <div>
                                <x-form.input name="nominal_display" label="Nominal Penerimaan" type="text"
                                    x-model="displayAmount" @input="inputAmount($event)" required />
                                <input type="hidden" name="amount" x-model="amount">
                            </div>

                            <div>
                                <x-form.text-area name="description" label="Deskripsi" x-model="description" rows="4"
                                    required />
                            </div>
                        </div>
                    </x-common.component-card>

                    {{-- BUKTI TRANSAKSI (NEW) --}}
                    <x-common.component-card title="Bukti Transaksi"
                        desc="Unggah atau ubah foto nota, kwitansi, atau bukti transfer (Opsional)">
                        <div class="space-y-4">
                            <div class="flex items-center justify-center w-full">
                                <label for="receipt_file"
                                    class="flex flex-col items-center justify-center w-full h-44 border-2 border-dashed border-slate-300 dark:border-slate-700 rounded-xl cursor-pointer bg-slate-50/50 dark:bg-slate-800/40 hover:bg-slate-100/80 dark:hover:bg-slate-800 hover:border-emerald-500 dark:hover:border-emerald-400 transition-all relative overflow-hidden group">

                                    {{-- State 1: Belum ada file dipilih --}}
                                    <template x-if="!recieptPreview && !recieptFileName">
                                        <div class="flex flex-col items-center justify-center pt-5 pb-6 px-4 text-center">
                                            <div
                                                class="p-3 rounded-full bg-emerald-50 dark:bg-emerald-950/50 text-emerald-600 dark:text-emerald-400 mb-3 group-hover:scale-110 transition-transform">
                                                <svg class="w-6 h-6" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                        d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                </svg>
                                            </div>
                                            <p class="mb-1 text-sm font-semibold text-slate-700 dark:text-slate-300">
                                                <span class="text-emerald-600 dark:text-emerald-400">Klik untuk unggah file
                                                    baru</span> atau seret ke sini
                                            </p>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Format: JPG, PNG, JPEG,
                                                WEBP, atau PDF (Maks. 2MB)</p>
                                        </div>
                                    </template>

                                    {{-- State 2: Preview jika file gambar --}}
                                    <template x-if="recieptPreview">
                                        <div class="relative w-full h-full p-2 flex items-center justify-center">
                                            <img :src="recieptPreview"
                                                class="max-h-full max-w-full object-contain rounded-lg shadow-sm"
                                                alt="Preview Bukti">
                                        </div>
                                    </template>

                                    {{-- State 3: Tampilan file non-gambar (contoh: PDF) --}}
                                    <template x-if="!recieptPreview && recieptFileName">
                                        <div class="flex flex-col items-center justify-center p-4 text-center">
                                            <div
                                                class="p-3 rounded-full bg-slate-100 dark:bg-slate-700 text-emerald-600 dark:text-emerald-400 mb-2">
                                                <svg class="w-8 h-8" fill="none" stroke="currentColor"
                                                    viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                        d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                                </svg>
                                            </div>
                                            <p class="text-xs font-semibold text-slate-700 dark:text-slate-200 truncate max-w-[200px]"
                                                x-text="recieptFileName"></p>
                                        </div>
                                    </template>

                                    <input id="receipt_file" name="receipt_file" type="file" class="hidden"
                                        accept="image/*,.pdf" @change="handleFileChange($event)" />
                                </label>
                            </div>

                            {{-- File Info Footer & Clear Button --}}
                            <template x-if="recieptFileName">
                                <div
                                    class="flex items-center justify-between p-3 rounded-xl bg-slate-100/80 dark:bg-slate-800/60 border border-slate-200 dark:border-slate-700 text-xs">
                                    <div class="flex items-center gap-2 truncate pr-2">
                                        <svg class="w-4 h-4 text-emerald-600 dark:text-emerald-400 shrink-0"
                                            fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M5 13l4 4L19 7" />
                                        </svg>
                                        <span class="text-slate-700 dark:text-slate-300 font-medium truncate"
                                            x-text="recieptFileName"></span>
                                    </div>
                                    <button type="button" @click="removeFile()"
                                        class="text-rose-500 hover:text-rose-700 dark:hover:text-rose-400 font-semibold transition-colors shrink-0 flex items-center gap-1">
                                        <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                        </svg>
                                        Hapus
                                    </button>
                                </div>
                            </template>
                        </div>
                    </x-common.component-card>

                </div>

                {{-- SUMMARY SIDEBAR --}}
                <div class="lg:col-span-1">
                    <div
                        class="sticky top-6 rounded-2xl border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-6 shadow-sm space-y-6">
                        <h3 class="text-base font-bold text-slate-900 dark:text-slate-100">Ringkasan Perubahan</h3>

                        <div class="space-y-4 text-xs divide-y divide-slate-100 dark:divide-slate-700">
                            {{-- Tanggal --}}
                            <div class="pt-3 first:pt-0 space-y-1">
                                <span class="text-slate-500 font-medium block">Tanggal Transaksi:</span>
                                <div class="flex items-center justify-between text-slate-700 dark:text-slate-300">
                                    <span class="line-through text-slate-400" x-text="formatDate(initialDate)"></span>
                                    <span>→</span>
                                    <span class="font-bold text-emerald-600 dark:text-emerald-400"
                                        x-text="formatDate(transactionDate)"></span>
                                </div>
                            </div>

                            {{-- Nominal --}}
                            <div class="pt-3 space-y-1">
                                <span class="text-slate-500 font-medium block">Nominal Penerimaan:</span>
                                <div class="flex items-center justify-between text-slate-700 dark:text-slate-300">
                                    <span class="line-through text-slate-400"
                                        x-text="'Rp ' + format(initialAmount)"></span>
                                    <span>→</span>
                                    <span class="font-bold text-emerald-600 dark:text-emerald-400"
                                        x-text="'Rp ' + format(amount)"></span>
                                </div>
                            </div>

                            {{-- Deskripsi --}}
                            <div class="pt-3 space-y-1">
                                <span class="text-slate-500 font-medium block">Deskripsi:</span>
                                <p class="text-slate-500 italic truncate" x-text="'Lama: ' + initialDescription"></p>
                                <p class="font-semibold text-slate-800 dark:text-slate-200 line-clamp-2"
                                    x-text="'Baru: ' + description"></p>
                            </div>

                            {{-- Info Tetap (Terkunci) --}}
                            <div class="pt-3 space-y-1">
                                <span class="text-slate-500 font-medium block">Sub Periode (Tetap):</span>
                                <span
                                    class="font-medium text-slate-700 dark:text-slate-300">{{ $initialSubPeriodName }}</span>
                            </div>

                            <div class="pt-3 space-y-1">
                                <span class="text-slate-500 font-medium block">Akun Kas & Sumber (Tetap):</span>
                                <span class="font-medium text-slate-700 dark:text-slate-300 block truncate"
                                    title="{{ $initialCashLabel }}">Kas: {{ $initialCashLabel }}</span>
                                <span class="font-medium text-slate-700 dark:text-slate-300 block truncate"
                                    title="{{ $initialIncomeCoaLabel }}">Sumber: {{ $initialIncomeCoaLabel }}</span>
                            </div>
                        </div>

                        <button type="submit"
                            class="w-full h-11 bg-emerald-600 hover:bg-emerald-700 text-white font-semibold rounded-xl shadow-md transition-colors cursor-pointer">
                            Simpan Perubahan
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    @push('scripts')
        <script>
            function incomeForm(cashCoas = [], initialAmount = 0, initialCash = '', initialDate = '', initialDescription = '',
                initialReceiptPreview = null, initialReceiptName = '') {
                return {
                    cashCoas: cashCoas,
                    selectedCash: initialCash,
                    amount: initialAmount,
                    initialAmount: initialAmount,
                    initialDate: initialDate,
                    initialDescription: initialDescription,
                    transactionDate: initialDate,
                    description: initialDescription,
                    displayAmount: 'Rp ' + new Intl.NumberFormat('id-ID').format(initialAmount),
                    recieptPreview: initialReceiptPreview,
                    recieptFileName: initialReceiptName,

                    init() {
                        if (!this.selectedCash && this.cashCoas.length > 0) {
                            this.selectedCash = this.cashCoas[0].user_account_balance_id;
                        }
                    },
                    inputAmount(event) {
                        const raw = String(event.target.value).replace(/\D/g, '');
                        this.amount = raw ? Number(raw) : 0;
                        this.displayAmount = raw ? 'Rp ' + new Intl.NumberFormat('id-ID').format(raw) : '';
                        event.target.value = this.displayAmount;
                    },
                    format(value) {
                        return new Intl.NumberFormat('id-ID').format(Number(value) || 0);
                    },
                    formatDate(dateStr) {
                        if (!dateStr) return '-';
                        return new Date(dateStr).toLocaleDateString('id-ID', {
                            day: '2-digit',
                            month: 'short',
                            year: 'numeric'
                        });
                    },
                    handleFileChange(event) {
                        const file = event.target.files[0];
                        if (file) {
                            this.recieptFileName = file.name;
                            if (file.type.startsWith('image/')) {
                                const reader = new FileReader();
                                reader.onload = (e) => {
                                    this.recieptPreview = e.target.result;
                                };
                                reader.readAsDataURL(file);
                            } else {
                                this.recieptPreview = null;
                            }
                        }
                    },
                    removeFile() {
                        this.recieptFileName = '';
                        this.recieptPreview = null;
                        const fileInput = document.getElementById('receipt_file');
                        if (fileInput) {
                            fileInput.value = '';
                        }
                    }
                }
            }
        </script>
    @endpush
@endsection
