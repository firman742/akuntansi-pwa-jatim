@extends('layouts.app')

@section('title', 'Tambah Transaksi')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Transaksi" />

    <div x-data="transactionForm()" x-init="init()" class="max-w-5xl mx-auto">
        <form method="POST" action="{{ route('user.transactions.incomes.store') }}">
            @csrf

            {{-- Notifikasi Error --}}
            @if ($errors->any())
                <div class="mb-6">
                    <x-ui.alert variant="error" title="Terjadi Kesalahan" :dismissible="true">
                        <ul class="list-disc list-inside text-sm">
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </x-ui.alert>
                </div>
            @endif


            <x-common.component-card title="Informasi Utama Transaksi">

                <div class="grid md:grid-cols-1 gap-6">
                    <div>
                        <label class="text-sm font-semibold">Tipe</label>
                        <select name="type" x-model="type" class="w-full border rounded px-3 py-2">
                            <option value="INCOME">Penerimaan</option>
                            <option value="EXPENSE">Pengeluaran</option>
                            <option value="TRANSFER">Transfer</option>
                        </select>
                    </div>
                </div>

                <div class="grid md:grid-cols-2 gap-6">
                    <div>
                        <label class="text-sm font-semibold">Periode</label>
                        <select name="period_id" x-model="period_id" @change="onPeriodChange"
                            class="w-full border rounded px-3 py-2">
                            @foreach ($periods as $p)
                                <option value="{{ $p->id }}" @selected($p->id == $selectedPeriodId)>{{ $p->name }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <div>
                        <label class="text-sm font-semibold">Sub Periode</label>
                        <select name="sub_period_id" x-model="sub_period_id" @change="loadCashBalance"
                            class="w-full border rounded px-3 py-2">
                            @foreach ($subPeriods as $s)
                                <option value="{{ $s->id }}">{{ $s->name }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div>
                        <label class="text-sm font-semibold">Tanggal</label>
                        <x-form.date-picker name="transaction_date" defaultDate="{{ now()->format('Y-m-d') }}" />
                    </div>

                    <template x-if="type !== 'TRANSFER'">
                        <div>
                            <label class="text-sm font-semibold">Kas</label>
                            <select name="cash_coa_id" x-model="cash_coa_id" @change="loadCashBalance"
                                class="w-full border rounded px-3 py-2">
                                <option value="">-- pilih --</option>
                                @foreach ($cashCoas as $coa)
                                    <option value="{{ $coa->id }}">{{ $coa->code }} - {{ $coa->name }}</option>
                                @endforeach
                            </select>

                            <div class="text-xs mt-1">
                                <span x-show="isLoadingBalance">Loading...</span>
                                <span x-show="!isLoadingBalance">
                                    Saldo: Rp <b x-text="formatRupiah(cashBalance)"></b>
                                </span>
                            </div>
                        </div>
                    </template>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-1 gap-6">
                    {{-- Keterangan --}}
                    <div>
                        <label class="mb-2 block text-sm font-semibold text-gray-700">Keterangan Transaksi</label>
                        <textarea name="description" rows="4" cols="50"
                            class="w-full rounded-lg border border-stroke px-4 py-4 text-sm" placeholder="Contoh: Pembayaran invoice #001"></textarea>
                    </div>
                </div>
            </x-common.component-card>

            {{-- ================= INCOME ================= --}}
            <template x-if="type === 'INCOME'">
                <div class="space-y-4 py-4">

                    <x-common.component-card title="Rincian Pendapatan">
                        <template x-for="(line,i) in incomeLines" :key="i">
                            <div class="flex gap-3 items-start bg-gray-50 p-3 rounded-lg">
                                <div class="flex-1">
                                    <select :name="`income_lines[${i}][coa_id]`"
                                        class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                                        @foreach ($incomeCoas as $coa)
                                            <option value="{{ $coa->id }}">{{ $coa->code }} - {{ $coa->name }}
                                            </option>
                                        @endforeach
                                    </select>
                                </div>

                                <div class="w-1/3">
                                    <input type="text" @input="onAmountInput($event,'incomeLines',i)"
                                        placeholder="Nominal"
                                        class="h-11 w-full rounded-lg border border-stroke px-4 text-sm text-left">
                                    <input type="hidden" :name="`income_lines[${i}][amount]`" x-model="line.amount">
                                </div>

                                <button type="button" @click="removeLine('incomeLines',i)"
                                    class="text-red-500 p-2 hover:bg-red-50 rounded">✕</button>
                            </div>
                        </template>

                        <button type="button" @click="addLine('incomeLines')">+ Tambah</button>
                    </x-common.component-card>

                    <x-common.component-card title="Pajak & Bunga">
                        <div class="grid md:grid-cols-2 gap-4">

                            {{-- PAJAK --}}
                            <div>
                                <h4 class="font-semibold text-sm mb-2">Pajak</h4>
                                <template x-for="(line,i) in taxLines" :key="i">
                                    <div class="flex gap-2 mb-2">
                                        <select :name="`tax_lines[${i}][tax_id]`" @change="onTaxSelect($event,i)"
                                            class="flex-1 border rounded px-2">

                                            <option value="">Pilih</option>
                                            @foreach ($taxes as $t)
                                                <option value="{{ $t->id }}" data-rate="{{ $t->rate }}"
                                                    data-prepaid-id="{{ $t->account_prepaid_id }}">
                                                    {{ $t->name }}
                                                </option>
                                            @endforeach
                                        </select>

                                        <input type="hidden" :name="`tax_lines[${i}][coa_id]`" x-model="line.coa_id">

                                        <input type="text" :value="'Rp ' + formatRupiah(line.amount)" readonly
                                            class="w-28 border rounded px-2 bg-gray-100">

                                        <input type="hidden" :name="`tax_lines[${i}][amount]`" x-model="line.amount">

                                        <button type="button" @click="removeLine('taxLines',i)">✕</button>
                                    </div>
                                </template>

                                <button type="button" @click="addLine('taxLines')">+ Pajak</button>
                            </div>

                            {{-- BUNGA --}}
                            <div>
                                <h4 class="font-semibold text-sm mb-2">Bunga</h4>
                                <template x-for="(line,i) in interestLines" :key="i">
                                    <div class="flex gap-2 mb-2">
                                        <select :name="`interest_lines[${i}][interest_id]`"
                                            @change="onInterestSelect($event,i)" class="flex-1 border rounded px-2">

                                            @foreach ($interests as $int)
                                                <option value="{{ $int->id }}" data-rate="{{ $int->rate ?? 0 }}">
                                                    {{ $int->name }}
                                                </option>
                                            @endforeach
                                        </select>

                                        <input type="text" :value="'Rp ' + formatRupiah(line.amount)" readonly
                                            class="w-28 border rounded px-2 bg-gray-100">

                                        <input type="hidden" :name="`interest_lines[${i}][amount]`"
                                            x-model="line.amount">

                                        <button type="button" @click="removeLine('interestLines',i)">✕</button>
                                    </div>
                                </template>

                                <button type="button" @click="addLine('interestLines')">+ Bunga</button>
                            </div>

                        </div>
                    </x-common.component-card>
                </div>
            </template>

            {{-- SECTION: EXPENSE --}}
            <template x-if="type === 'EXPENSE'">
                <div class="space-y-4 py-4">
                    <x-common.component-card title="Rincian Pengeluaran">
                        <div class="space-y-3">
                            <template x-for="(line, i) in expenseLines" :key="i">
                                <div class="flex gap-3 items-start bg-gray-50 p-3 rounded-lg">
                                    <div class="flex-1">
                                        <select :name="`expense_lines[${i}][coa_id]`"
                                            class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                                            @foreach ($expenseCoas as $coa)
                                                <option value="{{ $coa->id }}">{{ $coa->code }} -
                                                    {{ $coa->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="w-1/3">
                                        <input type="text" placeholder="Nominal"
                                            @input="onAmountInput($event, 'expenseLines', i)"
                                            class="h-11 w-full rounded-lg border border-stroke px-4 text-sm text-left">
                                        <input type="hidden" :name="`expense_lines[${i}][amount]`"
                                            x-model="line.amount">
                                    </div>
                                    <button type="button" @click="removeLine('expenseLines', i)"
                                        class="text-red-500 p-2 hover:bg-red-50 rounded">✕</button>
                                </div>
                            </template>
                            <button type="button" @click="addLine('expenseLines')"
                                class="text-sm text-primary font-medium hover:underline">+ Tambah Akun Beban</button>
                        </div>
                    </x-common.component-card>
                </div>
            </template>

            {{-- SECTION: TRANSFER --}}
            <template x-if="type === 'TRANSFER'">
                <div class="space-y-4 py-4">
                    <x-common.component-card title="Transfer Antar Rekening">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="mb-2 block text-sm font-medium text-gray-700">Dari Akun (Asal)</label>
                                <select name="from_coa_id" class="w-full rounded border border-stroke px-4 py-2 text-sm">
                                    @foreach ($cashCoas as $coa)
                                        <option value="{{ $coa->id }}">{{ $coa->code }} - {{ $coa->name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div>
                                <label class="mb-2 block text-sm font-medium text-gray-700">Ke Akun (Tujuan)</label>
                                <select name="to_coa_id" class="w-full rounded border border-stroke px-4 py-2 text-sm">
                                    @foreach ($cashCoas as $coa)
                                        <option value="{{ $coa->id }}">{{ $coa->code }} - {{ $coa->name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="md:col-span-2">
                                <label class="mb-2 block text-sm font-medium text-gray-700 font-bold">Nominal
                                    Transfer</label>
                                <input type="text" @input="onTransferInput($event)"
                                    class="w-full rounded border border-stroke px-4 py-3 text-lg font-bold text-primary">
                                <input type="hidden" name="amount" x-model="transferAmount">
                            </div>
                        </div>
                    </x-common.component-card>
                </div>
            </template>

            {{-- SUMMARY --}}
            <x-common.component-card title="Ringkasan">
                <div class="space-y-2 text-sm">

                    <div class="flex justify-between">
                        <span>Gross</span>
                        <span>Rp <b x-text="formatRupiah(grossAmount)"></b></span>
                    </div>

                    <div class="flex justify-between text-red-600">
                        <span>Pajak</span>
                        <span>- Rp <b x-text="formatRupiah(totalTax)"></b></span>
                    </div>

                    <div class="flex justify-between text-green-600">
                        <span>Bunga</span>
                        <span>+ Rp <b x-text="formatRupiah(totalInterest)"></b></span>
                    </div>

                    <hr>

                    <div class="flex justify-between font-bold text-blue-600">
                        <span>Net</span>
                        <span>Rp <span x-text="formatRupiah(netAmount)"></span></span>
                    </div>

                </div>
            </x-common.component-card>

            {{-- ================= ACTION ================= --}}
            <div class="mt-8 flex justify-end gap-3">
                <a href="{{ route('user.transactions.incomes.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Simpan Transaksi
                </x-ui.button>
            </div>

        </form>
    </div>

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
                    this.transferAmount = raw;
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
                    let grossAmount = 0;

                    // Hitung berdasarkan type
                    if (this.type === 'INCOME') {
                        grossAmount = this.incomeLines.reduce((s, l) => s + Number(l.amount || 0), 0);
                    } else if (this.type === 'EXPENSE') {
                        grossAmount = this.expenseLines.reduce((s, l) => s + Number(l.amount || 0), 0);
                    } else if (this.type === 'TRANSFER') {
                        grossAmount = Number(this.transferAmount || 0);
                    }

                    const tax = this.taxLines.reduce((s, l) => s + Number(l.amount || 0), 0);
                    const interest = this.interestLines.reduce((s, l) => s + Number(l.amount || 0), 0);

                    this.grossAmount = grossAmount;
                    this.totalTax = tax;
                    this.totalInterest = interest;
                    this.netAmount = (grossAmount + interest) - tax;
                },

                onTaxSelect(e, i) {
                    const opt = e.target.selectedOptions[0];
                    const rate = Number(opt.dataset.rate || 0);
                    const prepaid = opt.dataset.prepaidId || '';

                    this.taxLines[i].coa_id = prepaid;

                    const income = this.incomeLines.reduce((s, l) => s + Number(l.amount || 0), 0);
                    this.taxLines[i].amount = (income * rate) / 100;

                    this.calculateSummary();
                },

                onInterestSelect(e, i) {
                    const opt = e.target.selectedOptions[0];
                    const rate = Number(opt.dataset.rate || 0);

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

                        const res = await fetch(`/user/transactions/incomes/cash-balance?${params}`);
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
