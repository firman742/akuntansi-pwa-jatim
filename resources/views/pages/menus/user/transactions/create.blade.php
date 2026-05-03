@extends('layouts.app')

@section('title', 'Buat Transaksi')

@section('content')
    <x-common.page-breadcrumb pageTitle="Buat Transaksi" />

    <div x-data="transactionForm()" x-init="init()" class="max-w-5xl mx-auto pb-20">
        <form method="POST" action="{{ route('user.transactions.store') }}">
            @csrf

            {{-- Alert System --}}
            @if (session('success') || $errors->any())
                <div class="mb-6 space-y-2">
                    @if (session('success'))
                        <x-ui.alert variant="success" title="Sukses" :dismissible="true">
                            {{ session('success') }}
                        </x-ui.alert>
                    @endif
                    @if ($errors->any())
                        <x-ui.alert variant="error" title="Terjadi Kesalahan" :dismissible="true">
                            <ul class="list-disc list-inside text-sm">
                                @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </x-ui.alert>
                    @endif
                </div>
            @endif

            <div class="grid md:grid-cols-3 gap-8 items-start">

                {{-- LEFT COLUMN: FORM INPUTS --}}
                <div class="md:col-span-2 space-y-6">

                    {{-- Selector Tipe Transaksi (Dibuat lebih visual) --}}
                    <div class="bg-white p-2 rounded-xl shadow-sm border border-gray-100 flex gap-2">
                        <template x-for="item in ['INCOME', 'EXPENSE', 'TRANSFER']">
                            <button type="button" @click="type = item"
                                :class="type === item ?
                                    (item === 'INCOME' ? 'bg-green-50 text-green-700 border-green-200' :
                                        (item === 'EXPENSE' ? 'bg-red-50 text-red-700 border-red-200' :
                                            'bg-blue-50 text-blue-700 border-blue-200')) :
                                    'text-gray-500 border-transparent hover:bg-gray-50'"
                                class="flex-1 py-3 px-4 rounded-lg border-2 font-bold text-sm transition-all duration-200 flex flex-col items-center gap-1">
                                <span
                                    x-text="item === 'INCOME' ? '📥 Penerimaan' : (item === 'EXPENSE' ? '📤 Pengeluaran' : '🔄 Transfer')"></span>
                            </button>
                        </template>
                        <input type="hidden" name="type" x-model="type">
                    </div>

                    <x-common.component-card title="Informasi Utama">
                        <div class="grid md:grid-cols-2 gap-5">
                            <div class="space-y-1">
                                <label class="text-xs font-bold uppercase text-gray-500 tracking-wider">Periode</label>
                                <select name="period_id" x-model="period_id" @change="onPeriodChange"
                                    class="w-full border rounded-lg focus:ring-primary focus:border-primary px-3 py-2.5 text-sm">
                                    @foreach ($periods as $p)
                                        <option value="{{ $p->id }}" @selected($p->id == $selectedPeriodId)>{{ $p->name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>

                            <div class="space-y-1">
                                <label class="text-xs font-bold uppercase text-gray-500 tracking-wider">Sub Periode</label>
                                <select name="sub_period_id" x-model="sub_period_id" @change="loadCashBalance"
                                    class="w-full border rounded-lg focus:ring-primary focus:border-primary px-3 py-2.5 text-sm">
                                    @foreach ($subPeriods as $s)
                                        <option value="{{ $s->id }}">{{ $s->name }}</option>
                                    @endforeach
                                </select>
                            </div>

                            <div class="space-y-1">
                                <label class="text-xs font-bold uppercase text-gray-500 tracking-wider">Tanggal
                                    Transaksi</label>
                                <x-form.date-picker name="transaction_date" defaultDate="{{ now()->format('Y-m-d') }}" />
                            </div>

                            <template x-if="type !== 'TRANSFER'">
                                <div class="space-y-1">
                                    <label class="text-xs font-bold uppercase text-gray-500 tracking-wider">Pilih
                                        Kas</label>
                                    <select name="cash_coa_id" x-model="cash_coa_id" @change="loadCashBalance"
                                        class="w-full border rounded-lg focus:ring-primary focus:border-primary px-3 py-2.5 text-sm">
                                        <option value="">-- pilih --</option>
                                        @foreach ($cashCoas as $coa)
                                            <option value="{{ $coa->id }}">{{ $coa->code }} - {{ $coa->name }}
                                            </option>
                                        @endforeach
                                    </select>

                                    <div class="flex items-center gap-2 mt-1.5 px-1">
                                        <div class="h-2 w-2 rounded-full bg-green-500 animate-pulse"
                                            x-show="!isLoadingBalance && cash_coa_id"></div>
                                        <span class="text-[11px] text-gray-500 font-medium italic">
                                            <span x-show="isLoadingBalance">Menghitung saldo...</span>
                                            <span x-show="!isLoadingBalance && cash_coa_id">
                                                Saldo Saat Ini: <span class="text-gray-800 font-bold">Rp <span
                                                        x-text="formatRupiah(cashBalance)"></span></span>
                                            </span>
                                        </span>
                                    </div>
                                </div>
                            </template>
                        </div>

                        <div class="mt-5">
                            <label class="text-xs font-bold uppercase text-gray-500 tracking-wider">Keterangan</label>
                            <textarea name="description" rows="3"
                                class="mt-1 w-full rounded-lg border focus:ring-primary focus:border-primary px-4 py-3 text-sm"
                                placeholder="Tuliskan detail transaksi di sini..."></textarea>
                        </div>
                    </x-common.component-card>

                    {{-- Dynamic Sections with Animation --}}
                    <template x-if="type === 'INCOME'" x-transition>
                        <div>
                            <x-common.component-card title="Rincian Pendapatan">
                                <div class="space-y-3">
                                    <template x-for="(line,i) in incomeLines" :key="i">
                                        <div
                                            class="group flex gap-3 items-start bg-gray-50/50 p-4 rounded-xl border border-gray-100 transition-hover hover:border-green-200">
                                            <div class="flex-1 space-y-1">
                                                <label class="text-[10px] font-bold text-gray-400 uppercase">Akun
                                                    Pendapatan</label>
                                                <select :name="`income_lines[${i}][coa_id]`"
                                                    class="w-full rounded-lg border bg-white px-3 py-2 text-sm">
                                                    @foreach ($incomeCoas as $coa)
                                                        <option value="{{ $coa->id }}">{{ $coa->code }} -
                                                            {{ $coa->name }}</option>
                                                    @endforeach
                                                </select>
                                            </div>
                                            <div class="w-1/3 space-y-1">
                                                <label
                                                    class="text-[10px] font-bold text-gray-400 uppercase text-right block pt-2 ">Nominal</label>
                                                <input type="text" @input="onAmountInput($event,'incomeLines',i)"
                                                    class="w-full rounded-lg border bg-white px-3 py-2 text-sm text-right font-semibold text-green-600 focus:ring-green-500"
                                                    placeholder="0">
                                                <input type="hidden" :name="`income_lines[${i}][amount]`"
                                                    x-model="line.amount">
                                            </div>
                                            <button type="button" @click="removeLine('incomeLines',i)"
                                                class="mt-6 text-gray-300 hover:text-red-500 transition-colors">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20"
                                                    fill="currentColor">
                                                    <path fill-rule="evenodd"
                                                        d=" accessibility-hidden 10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                                                        clip-rule="evenodd" />
                                                </svg>
                                            </button>
                                        </div>
                                    </template>
                                    <button type="button" @click="addLine('incomeLines')"
                                        class="w-full py-2 border-2 border-dashed border rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-50 hover:text-primary hover:border-primary transition-all">
                                        + Tambah Baris Pendapatan
                                    </button>
                                </div>
                            </x-common.component-card>

                            <div class="grid md:grid-cols-2 gap-6 mt-6">
                                <x-common.component-card title="Pajak (Dipotong)">
                                    <template x-for="(line,i) in taxLines" :key="i">
                                        <div class="flex gap-2 mb-3 items-center">
                                            <select :name="`tax_lines[${i}][tax_id]`" @change="onTaxSelect($event,i)"
                                                class="flex-1 w-full text-xs border rounded-md px-3 py-2">
                                                <option value="">Pilih Pajak</option>
                                                @foreach ($taxes as $t)
                                                    <option value="{{ $t->id }}" data-rate="{{ $t->rate }}"
                                                        data-prepaid-id="{{ $t->account_prepaid_id }}">{{ $t->name }}
                                                        ({{ $t->rate }}%)
                                                    </option>
                                                @endforeach
                                            </select>
                                            <div class="text-xs font-bold text-red-500 w-24 text-right"
                                                x-text="'-' + formatRupiah(line.amount)"></div>
                                            <input type="hidden" :name="`tax_lines[${i}][coa_id]`" x-model="line.coa_id">
                                            <input type="hidden" :name="`tax_lines[${i}][amount]`" x-model="line.amount">
                                            <button type="button" @click="removeLine('taxLines',i)"
                                                class="text-red-400">✕</button>
                                        </div>
                                    </template>
                                    <button type="button" @click="addLine('taxLines')"
                                        class="text-xs text-primary font-bold hover:underline">+ Tambah Pajak</button>
                                </x-common.component-card>

                                <x-common.component-card title="Bunga (Ditambah)">
                                    <template x-for="(line,i) in interestLines" :key="i">
                                        <div class="flex gap-2 mb-3 items-center">
                                            <select :name="`interest_lines[${i}][interest_id]`"
                                                @change="onInterestSelect($event,i)"
                                                class="flex-1 text-xs border rounded-md">
                                                <option value="">Pilih Bunga</option>
                                                @foreach ($interests as $int)
                                                    <option value="{{ $int->id }}" data-rate="{{ $int->rate }}"
                                                        data-interest-coa="{{ $int->account_interest_id }}">
                                                        {{ $int->name }} ({{ $int->rate }}%)</option>
                                                @endforeach
                                            </select>
                                            <div class="text-xs font-bold text-green-500 w-24 text-right"
                                                x-text="'+' + formatRupiah(line.amount)"></div>
                                            <input type="hidden" :name="`interest_lines[${i}][coa_id]`"
                                                x-model="line.coa_id">
                                            <input type="hidden" :name="`interest_lines[${i}][amount]`"
                                                x-model="line.amount">
                                            <button type="button" @click="removeLine('interestLines',i)"
                                                class="text-red-400">✕</button>
                                        </div>
                                    </template>
                                    <button type="button" @click="addLine('interestLines')"
                                        class="text-xs text-primary font-bold hover:underline">+ Tambah Bunga</button>
                                </x-common.component-card>
                            </div>
                        </div>
                    </template>

                    <template x-if="type === 'EXPENSE'" x-transition>
                        <div>
                            <x-common.component-card title="Rincian Pengeluaran">
                                <div class="space-y-3">
                                    <template x-for="(line, i) in expenseLines" :key="i">
                                        <div
                                            class="flex gap-3 items-start bg-gray-50/50 p-4 rounded-xl border border-gray-100">
                                            <div class="flex-1 space-y-1">
                                                <label class="text-[10px] font-bold text-gray-400 uppercase">Akun Beban</label>
                                                <select :name="`expense_lines[${i}][coa_id]`"
                                                    class="w-full rounded-lg border bg-white px-3 py-2 text-sm">
                                                    @foreach ($expenseCoas as $coa)
                                                        <option value="{{ $coa->id }}">{{ $coa->code }} -
                                                            {{ $coa->name }}</option>
                                                    @endforeach
                                                </select>
                                            </div>
                                            <div class="w-1/3 space-y-1">
                                                <label
                                                    class="text-[10px] font-bold text-gray-400 uppercase text-right block">Nominal</label>
                                                <input type="text" @input="onAmountInput($event, 'expenseLines', i)"
                                                    class="w-full rounded-lg border bg-white px-3 py-2 text-sm text-right font-semibold text-red-600 focus:ring-red-500"
                                                    placeholder="0">
                                                <input type="hidden" :name="`expense_lines[${i}][amount]`"
                                                    x-model="line.amount">
                                            </div>
                                            <button type="button" @click="removeLine('expenseLines', i)"
                                                class="mt-6 text-gray-300 hover:text-red-500 transition-colors">✕</button>
                                        </div>
                                    </template>
                                    <button type="button" @click="addLine('expenseLines')"
                                        class="w-full py-2 border-2 border-dashed border rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-50 hover:text-red-500 hover:border-red-200 transition-all">
                                        + Tambah Akun Beban
                                    </button>
                                </div>
                            </x-common.component-card>
                        </div>
                    </template>

                    <template x-if="type === 'TRANSFER'" x-transition>
                        <div>
                            <x-common.component-card title="Transfer Antar Kas">
                                <div
                                    class="grid grid-cols-1 md:grid-cols-2 gap-6 bg-blue-50/30 p-4 rounded-xl border border-blue-100">
                                    <div class="space-y-1">
                                        <label class="text-xs font-bold text-blue-500 uppercase tracking-tighter">Dari Rekening
                                            (Asal)</label>
                                        <select name="from_coa_id"
                                            class="w-full rounded-lg border px-3 py-2 text-sm shadow-sm">
                                            @foreach ($cashCoas as $coa)
                                                <option value="{{ $coa->id }}">{{ $coa->code }} -
                                                    {{ $coa->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="space-y-1">
                                        <label class="text-xs font-bold text-blue-500 uppercase tracking-tighter">Ke Rekening
                                            (Tujuan)</label>
                                        <select name="to_coa_id"
                                            class="w-full rounded-lg border px-3 py-2 text-sm shadow-sm">
                                            @foreach ($cashCoas as $coa)
                                                <option value="{{ $coa->id }}">{{ $coa->code }} -
                                                    {{ $coa->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="md:col-span-2 mt-2">
                                        <label class="block text-center text-xs font-bold text-gray-400 uppercase mb-2">Jumlah
                                            yang Ditransfer</label>
                                        <input type="text" @input="onTransferInput($event)"
                                            class="w-full rounded-xl border-2 border-blue-200 px-4 py-4 text-2xl font-black text-center text-blue-500 focus:ring-blue-500 focus:border-blue-500 shadow-inner"
                                            placeholder="Rp 0">
                                        <input type="hidden" name="amount" x-model="transferAmount">
                                    </div>
                                </div>
                            </x-common.component-card>
                        </div>
                    </template>
                </div>

                {{-- RIGHT COLUMN: SUMMARY (Sticky) --}}
                <div class="md:sticky md:top-6 space-y-4">
                    <div class="bg-gray-900 rounded-2xl shadow-xl overflow-hidden text-white">
                        <div class="p-6 bg-gradient-to-br from-gray-800 to-gray-900 border-b border-gray-700">
                            <h3 class="text-sm font-bold uppercase tracking-widest text-gray-400">Ringkasan Nilai</h3>
                            <div class="mt-4">
                                <span class="text-xs text-gray-400 block mb-1">Total Net (Bersih)</span>
                                <div class="text-3xl font-black text-primary flex items-baseline gap-1">
                                    <span class="text-lg">Rp</span>
                                    <span x-text="formatRupiah(netAmount)"></span>
                                </div>
                            </div>
                        </div>

                        <div class="p-6 space-y-4 bg-gray-900/50">
                            <div class="flex justify-between items-center text-sm">
                                <span class="text-gray-400">Gross Amount</span>
                                <span class="font-bold font-mono" x-text="formatRupiah(grossAmount)"></span>
                            </div>

                            <template x-if="type === 'INCOME'">
                                <div class="space-y-3 pt-3 border-t border-gray-800 text-xs">
                                    <div class="flex justify-between items-center text-red-400">
                                        <span>Total Potongan Pajak</span>
                                        <span class="font-bold font-mono" x-text="'-' + formatRupiah(totalTax)"></span>
                                    </div>
                                    <div class="flex justify-between items-center text-green-400">
                                        <span>Total Pendapatan Bunga</span>
                                        <span class="font-bold font-mono"
                                            x-text="'+' + formatRupiah(totalInterest)"></span>
                                    </div>
                                </div>
                            </template>

                            <button type="submit"
                                class="w-full bg-primary hover:bg-primary-dark text-white font-bold py-4 rounded-xl shadow-lg shadow-primary/20 transition-all active:scale-[0.98] flex justify-center items-center gap-2 mt-4">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20"
                                    fill="currentColor">
                                    <path fill-rule="evenodd"
                                        d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                        clip-rule="evenodd" />
                                </svg>
                                Simpan Transaksi
                            </button>
                        </div>
                    </div>

                    <div
                        class="p-4 bg-yellow-50 rounded-xl border border-yellow-100 flex gap-3 italic text-[11px] text-yellow-800">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-600 flex-shrink-0"
                            fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        <span>Pastikan saldo kas mencukupi dan periode transaksi sudah benar sebelum menyimpan data.</span>
                    </div>
                </div>

            </div>
        </form>
    </div>

    {{-- Script tetap sama secara logika, hanya sedikit penyesuaian detail --}}
    <script>
        function transactionForm() {
            return {
                type: 'INCOME',
                period_id: '{{ $selectedPeriodId }}',
                sub_period_id: '{{ $subPeriods->first()?->id }}',
                cash_coa_id: '',
                incomeLines: [{
                    coa_id: '',
                    amount: 0
                }],
                expenseLines: [{
                    coa_id: '',
                    amount: 0
                }],
                taxLines: [],
                interestLines: [],
                transferAmount: 0,
                grossAmount: 0,
                totalTax: 0,
                totalInterest: 0,
                netAmount: 0,
                cashBalance: 0,
                isLoadingBalance: false,

                init() {
                    this.$watch('type', () => this.calculateSummary());
                    this.$watch('incomeLines', () => this.calculateSummary());
                    this.$watch('expenseLines', () => this.calculateSummary());
                    this.$watch('transferAmount', () => this.calculateSummary());
                    this.$watch('taxLines', () => this.calculateSummary());
                    this.$watch('interestLines', () => this.calculateSummary());
                },
                formatRupiah(v) {
                    return new Intl.NumberFormat('id-ID').format(v || 0);
                },
                stripRaw(s) {
                    return s.replace(/\D/g, '');
                },
                onAmountInput(e, target, i) {
                    let raw = this.stripRaw(e.target.value);
                    this[target][i].amount = Number(raw);
                    e.target.value = raw ? 'Rp ' + this.formatRupiah(raw) : '';
                    this.calculateSummary();
                },
                onTransferInput(e) {
                    let raw = this.stripRaw(e.target.value);
                    this.transferAmount = Number(raw);
                    e.target.value = raw ? 'Rp ' + this.formatRupiah(raw) : '';
                },
                addLine(target) {
                    this[target].push({
                        coa_id: '',
                        amount: 0
                    });
                },
                removeLine(target, i) {
                    this[target].splice(i, 1);
                    this.calculateSummary();
                },
                calculateSummary() {
                    let gross = 0;
                    if (this.type === 'INCOME') {
                        gross = this.incomeLines.reduce((s, l) => s + Number(l.amount || 0), 0);
                    } else if (this.type === 'EXPENSE') {
                        gross = this.expenseLines.reduce((s, l) => s + Number(l.amount || 0), 0);
                    } else if (this.type === 'TRANSFER') {
                        gross = Number(this.transferAmount || 0);
                    }
                    this.grossAmount = gross;
                    this.totalTax = this.taxLines.reduce((s, l) => s + Number(l.amount || 0), 0);
                    this.totalInterest = this.interestLines.reduce((s, l) => s + Number(l.amount || 0), 0);
                    this.netAmount = (this.grossAmount + this.totalInterest) - this.totalTax;
                },
                onTaxSelect(e, i) {
                    const opt = e.target.selectedOptions[0];
                    const rate = Number(opt.dataset.rate || 0);
                    this.taxLines[i].coa_id = opt.dataset.prepaidId || '';
                    const income = this.incomeLines.reduce((s, l) => s + Number(l.amount || 0), 0);
                    this.taxLines[i].amount = (income * rate) / 100;
                    this.calculateSummary();
                },
                onInterestSelect(e, i) {
                    const opt = e.target.selectedOptions[0];
                    const rate = Number(opt.dataset.rate || 0);
                    this.interestLines[i].coa_id = opt.dataset.interestCoa || '';
                    const income = this.incomeLines.reduce((s, l) => s + Number(l.amount || 0), 0);
                    this.interestLines[i].amount = (income * rate) / 100;
                    this.calculateSummary();
                },
                async loadCashBalance() {
                    if (!this.cash_coa_id || !this.period_id) return;
                    this.isLoadingBalance = true;
                    try {
                        const params = new URLSearchParams({
                            coa_id: this.cash_coa_id,
                            period_id: this.period_id,
                            sub_period_id: this.sub_period_id
                        });
                        const res = await fetch(`/user/transactions/cash-balance?${params}`);
                        const data = await res.json();
                        this.cashBalance = data.balance || 0;
                    } catch (e) {
                        console.error(e);
                    } finally {
                        this.isLoadingBalance = false;
                    }
                }
            }
        }
    </script>
@endsection
