@extends('layouts.app')

@section('title', 'Edit Transaksi Pengeluaran')

@section('content')

    {{-- HEADER & BREADCRUMB --}}
    <x-common.page-breadcrumb defaultTitle="Edit Transaksi Pengeluaran" pageTitle="Transaksi Pengeluaran"
        pageDescription="Perbarui data pencatatan transaksi pengeluaran kas" pageIcon="transaction"
        parentTitle="Transaksi Pengeluaran" :parentRoute="route('user.transactions.expenses.index')" currentTitle="Edit" />

    <div class="mb-5">
        <a href="{{ route('user.transactions.expenses.index') }}" class="inline-flex shrink-0">
            <x-ui.button variant="outline" size="sm"
                class="inline-flex items-center gap-2 hover:bg-slate-100 transition-colors">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                Kembali
            </x-ui.button>
        </a>
    </div>

    {{-- ALERTS --}}
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

    {{-- FORM CONTAINER --}}
    <div class="mx-auto pb-10" x-data="expenseEditForm(@js($cashCoas), @js($oldLines), '{{$selectedCashCoaId }}')" x-init="init()">
        <form action="{{ route('user.transactions.expenses.update', $transaction->id) }}" method="POST"
            enctype="multipart/form-data">
            @csrf
            @method('PUT')
            <input type="hidden" name="period_id" value="{{ $selectedPeriodId }}">
            <input type="hidden" name="sub_period_id" value="{{ $selectedSubPeriodId }}">
            <input type="hidden" name="cash_coa_id" value="{{ $selectedCashCoaId }}">

            <div class="grid lg:grid-cols-3 gap-8 items-start">

                {{-- LEFT COLUMN: FORM INPUTS --}}
                <div class="lg:col-span-2 space-y-6">

                    {{-- CARD 1: INFORMASI TRANSAKSI --}}
                    <x-common.component-card title="Informasi Transaksi"
                        desc="Informasi dasar waktu dan periode pengeluaran">
                        <div class="grid md:grid-cols-2 gap-5">
                            <div>
                                <label class="block text-xs font-semibold text-slate-600 dark:text-slate-400 mb-1.5">Sub Periode</label>
                                <input type="text" value="{{ $subPeriodName }}" disabled
                                    class="w-full h-10 px-3 py-2 text-sm rounded-lg border border-slate-200 bg-slate-100 dark:bg-slate-800 dark:border-slate-700 text-slate-500 dark:text-slate-400 cursor-not-allowed">
                                <p class="text-[11px] text-slate-400 mt-1">Sub periode tidak dapat diubah pada mode edit.</p>
                            </div>
                            <div>
                                <x-form.date-picker id="transaction_date" name="transaction_date" label="Tanggal Transaksi"
                                    placeholder="Tentukan Tanggal Transaksi" x-model="transactionDate"
                                    defaultDate="{{ old('transaction_date', $transaction->transaction_date->format('Y-m-d')) }}" />
                            </div>
                        </div>
                    </x-common.component-card>

                    {{-- CARD 2: KAS SUMBER PENGELUARAN --}}
                    <x-common.component-card title="Sumber Kas Pengeluaran" desc="Akun kas sumber pembayaran transaksi">
                        <div class="space-y-4">
                            <div>
                                <label class="block text-xs font-semibold text-slate-600 dark:text-slate-400 mb-1.5">Akun Kas Sumber</label>
                                <input type="text" value="{{ $selectedCashName }}" disabled
                                    class="w-full h-10 px-3 py-2 text-sm rounded-lg border border-slate-200 bg-slate-100 dark:bg-slate-800 dark:border-slate-700 text-slate-500 dark:text-slate-400 cursor-not-allowed">
                                <p class="text-[11px] text-slate-400 mt-1">Sumber kas pembayaran bersifat tetap.</p>
                            </div>

                            {{-- Live Balance Indicator --}}
                            <div class="p-4 rounded-xl border flex items-center justify-between transition-colors"
                                :class="balance < 0 ? 'bg-rose-50/70 border-rose-200' : 'bg-slate-50 border-slate-200'">
                                <div class="flex items-center gap-2.5">
                                    <div class="w-2.5 h-2.5 rounded-full"
                                        :class="balance < 0 ? 'bg-rose-500 animate-pulse' : 'bg-emerald-500 animate-pulse'">
                                    </div>
                                    <span class="text-xs font-semibold uppercase tracking-wider text-slate-500">Sisa Saldo Kas Terpilih</span>
                                </div>
                                <span class="text-base font-black font-mono"
                                    :class="balance < 0 ? 'text-rose-600' : 'text-slate-900'"
                                    x-text="formatRupiah(balance)"></span>
                            </div>
                        </div>
                    </x-common.component-card>

                    {{-- CARD 3: RINCIAN PENGELUARAN --}}
                    <x-common.component-card title="Rincian Pengeluaran"
                        desc="Sesuaikan rincian akun pengeluaran beserta nominalnya">
                        <div class="space-y-4">
                            <template x-for="(line, index) in lines" :key="index">
                                <div class="p-4 rounded-xl bg-slate-50/70 border border-slate-200 space-y-4 shadow-sm">
                                    <div class="flex items-center justify-between pb-3 border-b border-slate-200">
                                        <div class="flex items-center gap-2">
                                            <span
                                                class="w-6 h-6 rounded-full bg-indigo-100 text-indigo-700 font-bold text-xs flex items-center justify-center font-mono"
                                                x-text="index + 1"></span>
                                            <h4 class="text-xs font-bold uppercase tracking-wider text-slate-700"
                                                x-text="`Rincian Item #${index + 1}`"></h4>
                                        </div>
                                        <button type="button" @click="removeLine(index)" :disabled="lines.length === 1"
                                            class="px-3 py-1.5 text-xs font-semibold text-rose-600 hover:bg-rose-50 rounded-lg border border-rose-200 transition-colors disabled:opacity-30 disabled:cursor-not-allowed">
                                            Hapus
                                        </button>
                                    </div>
                                    <div class="space-y-3">
                                        <div>
                                            <label class="block text-xs font-semibold text-slate-600 mb-1.5">Akun Pengeluaran (COA) <span class="text-rose-500">*</span></label>
                                            <select :name="`expense_lines[${index}][coa_id]`" x-model="line.coa_id" required
                                                class="w-full h-10 px-3 py-2 text-sm rounded-lg border border-slate-300 bg-white text-slate-800">
                                                <option value="">-- Pilih Akun Keluar --</option>
                                                @foreach ($expenseCoas as $coa)
                                                    <option value="{{ $coa->id }}">{{ $coa->code }} - {{$coa->name }}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                                            <div>
                                                <label class="block text-xs font-semibold text-slate-600 mb-1.5">Nominal (Rp) <span class="text-rose-500">*</span></label>
                                                <input type="text" @input="onAmountInput($event, index)"
                                                    :value="formatRupiah(line.amount)" placeholder="Rp 0" required
                                                    class="w-full h-10 px-3 py-2 text-sm font-mono rounded-lg border border-slate-300 bg-white">
                                                <input type="hidden" :name="`expense_lines[${index}][amount]`"
                                                    x-model="line.amount">
                                            </div>
                                            <div>
                                                <label class="block text-xs font-semibold text-slate-600 mb-1.5">Keterangan Detail</label>
                                                <input type="text" :name="`expense_lines[${index}][description]`"
                                                    x-model="line.description" placeholder="Catatan detail item..."
                                                    class="w-full h-10 px-3 py-2 text-sm rounded-lg border border-slate-300 bg-white">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </template>
                            <button type="button" @click="addLine()"
                                class="w-full border-2 border-dashed border-slate-300 hover:border-indigo-500 rounded-xl py-3 text-slate-600 hover:text-indigo-600 transition-all font-medium text-sm bg-white">
                                + Tambah Baris Pengeluaran
                            </button>
                        </div>
                    </x-common.component-card>

                </div>

                {{-- RIGHT COLUMN: RINGKASAN PERUBAHAN & AKSI --}}
                <div class="lg:col-span-1">
                    <div class="sticky top-6 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm space-y-5">
                        <h3 class="text-base font-bold text-slate-900 border-b pb-4">Ringkasan Perubahan</h3>

                        <div class="space-y-3 text-xs text-slate-600">
                            <div class="flex justify-between items-center py-1.5 border-b border-slate-100">
                                <span class="text-slate-400">Tanggal Transaksi:</span>
                                <div class="text-right font-mono font-medium">
                                    <span class="line-through text-slate-400 mr-1">{{ $oldDate }}</span>
                                    <span class="text-indigo-600 font-bold" x-text="transactionDate"></span>
                                </div>
                            </div>

                            <div class="flex justify-between items-center py-1.5 border-b border-slate-100">
                                <span class="text-slate-400">Sub Periode:</span>
                                <span class="font-medium text-slate-800">{{ $subPeriodName }}</span>
                            </div>

                            <div class="flex justify-between items-center py-1.5 border-b border-slate-100">
                                <span class="text-slate-400">Jumlah Item Rincian:</span>
                                <span class="font-semibold text-slate-800" x-text="lines.length + ' Item'"></span>
                            </div>
                        </div>

                        <div class="space-y-3 text-sm pt-2">
                            <div class="flex items-center justify-between text-xs">
                                <span class="text-slate-500">Total Nominal Lama:</span>
                                <span class="font-mono text-slate-400 line-through">Rp {{ number_format($oldTotal, 0, ',', '.') }}</span>
                            </div>
                            <div class="flex items-center justify-between">
                                <span class="text-slate-500 font-medium">Total Nominal Baru:</span>
                                <span class="font-bold font-mono text-rose-600" x-text="formatRupiah(total)"></span>
                            </div>
                            <div class="border-t pt-3">
                                <div class="p-3.5 rounded-xl border bg-indigo-50/60 border-indigo-100 space-y-1">
                                    <div class="text-[11px] font-semibold uppercase tracking-wider text-indigo-800">Proyeksi Saldo Kas Akhir</div>
                                    <div class="text-xl font-black font-mono text-indigo-600" x-text="formatRupiah(balance - total)"></div>
                                </div>
                            </div>
                        </div>

                        <div class="space-y-3 pt-2">
                            <button type="submit" name="status" value="POSTED"
                                class="w-full h-11 inline-flex items-center justify-center gap-2 rounded-xl bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-sm shadow-md transition-all cursor-pointer">
                                Perbarui & Posting Transaksi
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        </form>
    </div>

    @push('scripts')
        <script>
            function expenseEditForm(cashCoas = [], oldLines = [], selectedCashId = '') {
                return {
                    cashCoas: cashCoas,
                    selectedCash: selectedCashId,
                    transactionDate: '{{ old('transaction_date', $transaction->transaction_date->format('Y-m-d')) }}',
                    proofFileName: '',
                    lines: oldLines.length > 0 ? oldLines : [{
                        amount: 0,
                        description: ''
                    }],

                    init() {
                        if (!this.selectedCash && this.cashCoas.length > 0) {
                            this.selectedCash = this.cashCoas[0].coa_id;
                        }

                        const dateInput = document.getElementById('transaction_date');
                        if (dateInput) {
                            dateInput.addEventListener('change', (e) => {
                                this.transactionDate = e.target.value;
                            });
                        }
                    },

                    get balance() {
                        if (!this.selectedCash) return 0;
                        const found = this.cashCoas.find(item => String(item.coa_id) === String(this.selectedCash));
                        return found ? Number(found.remaining_balance) : 0;
                    },

                    get total() {
                        return this.lines.reduce((sum, line) => sum + Number(line.amount || 0), 0);
                    },

                    onlyNumber(value) {
                        return String(value).replace(/D/g, '');
                    },

                    formatRupiah(value) {
                        const num = Number(value) || 0;
                        const absFormatted = new Intl.NumberFormat('id-ID').format(Math.abs(num));
                        return num < 0 ? `- Rp ${absFormatted}` : `Rp ${absFormatted}`;
                    },

                    onAmountInput(event, index) {
                        const raw = this.onlyNumber(event.target.value);
                        this.lines[index].amount = Number(raw);
                        event.target.value = raw ? this.formatRupiah(raw) : '';
                    },

                    addLine() {
                        this.lines.push({
                            amount: 0,
                            description: ''
                        });
                    },

                    removeLine(index) {
                        if (this.lines.length > 1) {
                            this.lines.splice(index, 1);
                        }
                    }
                };
            }
        </script>
    @endpush

@endsection
