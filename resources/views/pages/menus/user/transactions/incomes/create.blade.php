@extends('layouts.app')

@section('title', 'Buat Transaksi Penerimaan')

@section('content')

    {{-- HEADER & BACK BUTTON --}}
    <x-common.page-breadcrumb defaultTitle="Buat Transaksi Penerimaan" pageTitle="Transaksi Penerimaan"
        pageDescription="Catat transaksi penerimaan kas yang diterima oleh pengguna" pageIcon="transaction"
        parentTitle="Transaksi Penerimaan" :parentRoute="route('user.transactions.incomes.index')" currentTitle="Tambah" />

    <a href="{{ route('user.transactions.incomes.index') }}" class="inline-flex shrink-0 mb-5">
        <x-ui.button variant="outline" size="sm"
            class="inline-flex items-center gap-2 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
            Kembali
        </x-ui.button>
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
                        <li class="text-sm text-rose-600 dark:text-rose-400">{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    @if (session('success'))
        <div class="mb-6">
            <x-ui.alert variant="success" title="Berhasil" message="{{ session('success') }}" />
        </div>
    @endif

    {{-- FORM CONTAINER --}}
    <div class="mx-auto pb-10" x-data="incomeForm(@js($cashCoas))" x-init="init()">
        {{-- CATATAN: enctype="multipart/form-data" ditambahkan agar file upload dapat terkirim --}}
        <form action="{{ route('user.transactions.incomes.store') }}" method="POST" enctype="multipart/form-data">

            @csrf
            <input type="hidden" name="period_id" value="{{ $selectedPeriodId }}">

            <div class="grid lg:grid-cols-3 gap-8 items-start">

                {{-- LEFT COLUMN: FORM INPUTS --}}
                <div class="lg:col-span-2 space-y-6">

                    {{-- CARD 1: INFORMASI TRANSAKSI --}}
                    <x-common.component-card title="Informasi Transaksi" desc="Informasi dasar transaksi penerimaan">
                        <div class="grid md:grid-cols-2 gap-5">

                            {{-- SUB PERIOD --}}
                            <div class="space-y-1">
                                <x-form.select id="sub_period_id" name="sub_period_id" label="Sub Periode"
                                    placeholder="Pilih Sub Periode" x-model="subPeriod" required>
                                    @foreach ($subPeriods as $period)
                                        <option value="{{ $period->id }}">
                                            {{ $period->name }}
                                        </option>
                                    @endforeach
                                </x-form.select>
                            </div>

                            {{-- TANGGAL --}}
                            <div>
                                <x-form.date-picker id="transaction_date" name="transaction_date" label="Tanggal Transaksi"
                                    placeholder="Tentukan Tanggal Transaksi"
                                    defaultDate="{{ old('transaction_date', now()->format('Y-m-d')) }}" />
                            </div>

                        </div>
                    </x-common.component-card>

                    {{-- CARD 2: KAS PENERIMA --}}
                    <x-common.component-card title="Kas Penerima" desc="Pilih akun kas yang akan menerima uang">
                        <div class="space-y-4">
                            <div>
                                <x-form.select id="coa_id" name="coa_id" label="Akun Kas Penerima"
                                    x-model="selectedCash" required>
                                    <option value="">-- Pilih Akun Kas --</option>
                                    @foreach ($cashCoas as $cash)
                                        <option value="{{ $cash['coa_id'] }}">
                                            {{ $cash['coa_code'] }} - {{ $cash['coa_name'] }}
                                        </option>
                                    @endforeach
                                </x-form.select>
                            </div>

                            {{-- Live Balance Display --}}
                            <div
                                class="p-3.5 rounded-xl bg-slate-50 dark:bg-slate-800/60 border border-slate-200/80 dark:border-slate-700/80 flex items-center justify-between">
                                <div class="flex items-center gap-2">
                                    <div class="w-2 h-2 rounded-full bg-emerald-500 animate-pulse"></div>
                                    <span class="text-xs text-slate-500 dark:text-slate-400 font-medium">Saldo Kas Saat
                                        Ini:</span>
                                </div>
                                <span class="text-sm font-bold text-slate-900 dark:text-slate-100"
                                    x-text="'Rp ' + format(balance)"></span>
                            </div>
                        </div>
                    </x-common.component-card>

                    {{-- CARD 3: DETAIL PENERIMAAN --}}
                    <x-common.component-card title="Detail Penerimaan"
                        desc="Tentukan akun sumber penerimaan beserta nominalnya">
                        <div class="space-y-5">

                            {{-- AKUN PENERIMAAN --}}
                            <div>
                                <x-form.select name="income_coa_id" label="Akun Sumber Penerimaan"
                                    placeholder="-- Pilih Akun Penerimaan --" required>
                                    @foreach ($incomeCoas as $coa)
                                        <option value="{{ $coa->id }}">
                                            {{ $coa->code }} - {{ $coa->name }}
                                        </option>
                                    @endforeach
                                </x-form.select>
                            </div>

                            {{-- NOMINAL --}}
                            <div>
                                <x-form.input name="nominal_display" label="Nominal Penerimaan" type="text"
                                    placeholder="Rp 0" x-model="displayAmount" @input="inputAmount($event)" required />
                                <input type="hidden" name="amount" x-model="amount">
                            </div>

                            {{-- DESKRIPSI --}}
                            <div>
                                <x-form.text-area name="description" label="Deskripsi Transaksi"
                                    placeholder="Masukkan penjelasan detail mengenai transaksi penerimaan ini..."
                                    rows="4" required />
                            </div>

                        </div>
                    </x-common.component-card>

                    {{-- CARD 4: BUKTI TRANSAKSI (NEW) --}}
                    <x-common.component-card title="Bukti Transaksi"
                        desc="Unggah foto nota, kwitansi, atau bukti transfer (Opsional)">
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
                                                <span class="text-emerald-600 dark:text-emerald-400">Klik untuk
                                                    unggah</span> atau seret file ke sini
                                            </p>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Format: JPG, PNG, JPEG,
                                                atau PDF (Maks. 2MB)</p>
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

                {{-- RIGHT COLUMN: SUMMARY & ACTIONS --}}
                <div class="lg:col-span-1">
                    <div
                        class="sticky top-6 rounded-2xl border border-slate-200 dark:border-slate-700/80 bg-white dark:bg-slate-800 p-6 shadow-sm space-y-6">

                        <div
                            class="flex items-center justify-between pb-4 border-b border-slate-100 dark:border-slate-700/60">
                            <h3 class="text-base font-bold text-slate-900 dark:text-slate-100">Ringkasan Transaksi</h3>
                            <span
                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 dark:bg-emerald-950/60 text-emerald-700 dark:text-emerald-400">
                                Penerimaan Kas
                            </span>
                        </div>

                        <div class="space-y-4">
                            {{-- Saldo Saat Ini --}}
                            <div class="flex items-center justify-between text-sm">
                                <span class="text-slate-500 dark:text-slate-400">Saldo Awal Kas:</span>
                                <span class="font-semibold text-slate-700 dark:text-slate-300"
                                    x-text="'Rp ' + format(balance)"></span>
                            </div>

                            {{-- Total Penerimaan --}}
                            <div class="flex items-center justify-between text-sm">
                                <span class="text-slate-500 dark:text-slate-400">Total Penerimaan:</span>
                                <span class="font-bold text-emerald-600 dark:text-emerald-400"
                                    x-text="'+ Rp ' + format(amount)"></span>
                            </div>

                            <div class="border-t border-slate-100 dark:border-slate-700/60 pt-4">
                                {{-- Projected Balance Card --}}
                                <div
                                    class="p-4 rounded-xl bg-emerald-50/60 dark:bg-emerald-950/30 border border-emerald-100 dark:border-emerald-900/50 space-y-1">
                                    <div
                                        class="text-xs font-semibold uppercase tracking-wider text-emerald-800 dark:text-emerald-400">
                                        Proyeksi Saldo Akhir
                                    </div>
                                    <div class="text-2xl font-black text-emerald-600 dark:text-emerald-400 tracking-tight"
                                        x-text="'Rp ' + format(afterBalance())">
                                    </div>
                                </div>
                            </div>
                        </div>

                        {{-- Action Buttons --}}
                        <div class="space-y-3 pt-2">

                            {{-- PRIMARY BUTTON: SIMPAN --}}
                            <button type="submit" name="status" value="POSTED"
                                class="w-full h-11 inline-flex items-center justify-center gap-2 rounded-xl bg-emerald-600 hover:bg-emerald-700 active:bg-emerald-800 text-white font-semibold text-sm shadow-md shadow-emerald-600/20 focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:ring-offset-2 transition-all cursor-pointer">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M5 13l4 4L19 7" />
                                </svg>
                                Simpan Transaksi
                            </button>

                            {{-- SECONDARY BUTTON: DRAFT --}}
                            {{-- <button type="submit" name="status" value="DRAFT"
                                class="w-full h-11 inline-flex items-center justify-center gap-2 rounded-xl border border-slate-300 dark:border-slate-600 bg-white dark:bg-slate-800 text-slate-700 dark:text-slate-200 font-medium text-sm hover:bg-slate-50 dark:hover:bg-slate-700 focus:outline-none focus:ring-2 focus:ring-slate-400 transition-all shadow-sm cursor-pointer">
                                <svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4" />
                                </svg>
                                Simpan sebagai Draft
                            </button> --}}

                        </div>

                    </div>
                </div>

            </div>

        </form>
    </div>
    @push('scripts')
        <script>
            function incomeForm(cashCoas = []) {
                return {
                    cashCoas: cashCoas,
                    selectedCash: '',
                    subPeriod: '',
                    amount: 0,
                    displayAmount: '',
                    recieptPreview: null,
                    recieptFileName: '',

                    init() {
                        if (this.cashCoas.length > 0) {
                            this.selectedCash = this.cashCoas[0].coa_id;
                        }
                    },

                    get balance() {
                        if (!this.selectedCash) return 0;
                        const found = this.cashCoas.find(
                            item => String(item.coa_id) === String(this.selectedCash)
                        );
                        return found ? Number(found.remaining_balance) : 0;
                    },

                    inputAmount(event) {
                        const raw = this.onlyNumber(event.target.value);
                        this.amount = raw ? Number(raw) : 0;
                        const formatted = raw ? 'Rp ' + this.format(raw) : '';
                        this.displayAmount = formatted;
                        event.target.value = formatted;
                    },

                    onlyNumber(value) {
                        return String(value).replace(/\D/g, '');
                    },

                    format(value) {
                        return new Intl.NumberFormat('id-ID').format(Number(value) || 0);
                    },

                    afterBalance() {
                        return Number(this.balance) + Number(this.amount);
                    },

                    // ==========================================
                    // TAMBAHAN FUNGSI UNTUK HANDLE UPLOAD FILE
                    // ==========================================
                    handleFileChange(event) {
                        const file = event.target.files[0];
                        if (file) {
                            this.recieptFileName = file.name;

                            // Jika file berupa gambar, buatkan pratinjau (preview)
                            if (file.type.startsWith('image/')) {
                                const reader = new FileReader();
                                reader.onload = (e) => {
                                    this.recieptPreview = e.target.result;
                                };
                                reader.readAsDataURL(file);
                            } else {
                                // Jika non-gambar (misal: PDF), kosongkan preview gambar
                                this.recieptPreview = null;
                            }
                        }
                    },

                    removeFile() {
                        this.recieptFileName = '';
                        this.recieptPreview = null;

                        // Reset nilai input file HTML
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
