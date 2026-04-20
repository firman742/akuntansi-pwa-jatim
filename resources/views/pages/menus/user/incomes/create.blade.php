@extends('layouts.app')

@section('title', 'Tambah Transaksi')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Transaksi" />

    <div x-data="transactionForm()" class="max-w-5xl mx-auto">
        <form method="POST" action="{{ route('user.transactions.incomes.store') }}" enctype="multipart/form-data">
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
                <div class="grid grid-cols-1 md:grid-cols-1 gap-6">
                    {{-- Tipe Transaksi --}}
                    <div>
                        <label class="mb-2 block text-sm font-semibold text-gray-700">Tipe Transaksi</label>
                        <select name="type" x-model="type"
                            class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                            <option value="INCOME">Penerimaan (Masuk)</option>
                            <option value="EXPENSE">Pengeluaran (Keluar)</option>
                            <option value="TRANSFER">Transfer Antar Kas</option>
                        </select>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    {{-- Periode --}}
                    <div>
                        <label class="mb-2 block text-sm font-semibold text-gray-700">Periode</label>
                        <select name="period_id" @change="onPeriodChange($event)"
                            class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                            @foreach ($periods as $period)
                                <option value="{{ $period->id }}" @selected($period->id == $selectedPeriodId)>{{ $period->name }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    {{-- Sub Periode --}}
                    <div>
                        <label class="mb-2 block text-sm font-semibold text-gray-700">Sub Periode</label>
                        <select name="sub_period_id" x-model="sub_period_id" @change="loadCashBalance"
                            class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                            @foreach ($subPeriods as $sub)
                                <option value="{{ $sub->id }}">{{ $sub->name }}</option>
                            @endforeach
                        </select>
                    </div>

                    {{-- Tanggal --}}
                    <div>
                        <label class="mb-2 block text-sm font-semibold text-gray-700">Tanggal</label>
                        <x-form.date-picker name="transaction_date" defaultDate="{{ now()->format('Y-m-d') }}" />
                    </div>

                    {{-- Kas / Bank --}}
                    <div x-show="type !== 'TRANSFER'">
                        <label class="mb-2 block text-sm font-semibold text-gray-700">Kas / Bank Tujuan/Asal</label>
                        <select name="cash_coa_id" x-model="cash_coa_id" @change="loadCashBalance"
                            class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                            <option value="">-- Pilih Kas/Bank --</option>
                            @foreach ($cashCoas as $coa)
                                <option value="{{ $coa->id }}">{{ $coa->code }} — {{ $coa->name }}</option>
                            @endforeach
                        </select>
                        <div class="mt-2 flex justify-between items-center text-xs">
                            <span class="text-gray-500 italic" x-show="isLoadingBalance">Memuat saldo...</span>
                            <span class="text-gray-600" x-show="!isLoadingBalance">
                                Saldo Saat Ini: <b class="text-blue-600">Rp <span
                                        x-text="formatRupiah(cashBalance)">0</span></b>
                            </span>
                        </div>
                    </div>


                </div>

                <div class="grid grid-cols-1 md:grid-cols-1 gap-6">
                    {{-- Keterangan --}}
                    <div>
                        <label class="mb-2 block text-sm font-semibold text-gray-700">Keterangan Transaksi</label>
                        <textarea name="description" rows="4" cols="50" class="w-full rounded-lg border border-stroke px-4 py-4 text-sm"
                            placeholder="Contoh: Pembayaran invoice #001"></textarea>
                    </div>
                </div>
            </x-common.component-card>

            <div class="mt-6">
                {{-- SECTION: INCOME --}}
                <div x-show="type === 'INCOME'" class="space-y-4">
                    <x-common.component-card title="Rincian Pendapatan">
                        <div class="space-y-3">
                            <template x-for="(line, i) in incomeLines" :key="i">
                                <div class="flex gap-3 items-start bg-gray-50 p-3 rounded-lg border border-gray-100">
                                    <div class="flex-1">
                                        <select :name="`income_lines[${i}][coa_id]`"
                                            class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                                            @foreach ($incomeCoas as $coa)
                                                <option value="{{ $coa->id }}">{{ $coa->code }} -
                                                    {{ $coa->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="w-1/3">
                                        <input type="text" placeholder="Nominal"
                                            @input="onAmountInput($event, 'incomeLines', i)"
                                            class="h-11 w-full rounded-lg border border-stroke px-4 text-sm text-left">
                                        <input type="hidden" :name="`income_lines[${i}][amount]`" x-model="line.amount">
                                    </div>
                                    <button type="button" @click="removeLine('incomeLines', i)"
                                        class="text-red-500 p-2 hover:bg-red-50 rounded">
                                        <svg class="size-5 hover:text-red-500 dark:text-gray-400 dark:hover:text-red-500"
                                                fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6
                                                         m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                        </svg>
                                    </button>
                                </div>
                            </template>
                            <button type="button" @click="addLine('incomeLines')"
                                class="text-sm text-primary font-medium flex items-center gap-1 hover:underline">
                                <span>+ Tambah Akun Pendapatan</span>
                            </button>
                        </div>

                        <hr class="my-6 border-dashed">

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            {{-- Pajak (Potongan/Tambahan) --}}
                            <div>
                                <h4 class="text-sm font-bold text-gray-700 mb-3 flex items-center gap-2">
                                    Pajak <small class="text-gray-400 font-normal">(Optional)</small>
                                </h4>
                                <div class="space-y-3">
                                    <template x-for="(line, i) in taxLines" :key="i">
                                        <div class="flex gap-2 items-center">
                                            <select :name="`tax_lines[${i}][tax_id]`" @change="onTaxSelect($event, i)"
                                                class="flex-1 rounded border border-stroke text-xs px-2 py-1">
                                                <option value="">Pilih Pajak</option>
                                                @foreach ($taxes as $tax)
                                                    <option value="{{ $tax->id }}"
                                                        data-prepaid-id="{{ $tax->account_prepaid_id }}">
                                                        {{ $tax->name }}</option>
                                                @endforeach
                                            </select>
                                            <input type="hidden" :name="`tax_lines[${i}][coa_id]`" x-model="line.coa_id">
                                            <input type="text" placeholder="Rp"
                                                @input="onAmountInput($event, 'taxLines', i)"
                                                class="w-32 rounded border border-stroke text-xs text-right">
                                            <input type="hidden" :name="`tax_lines[${i}][amount]`" x-model="line.amount">
                                            <button type="button" @click="removeLine('taxLines', i)"
                                                class="text-gray-400 hover:text-red-500">✕</button>
                                        </div>
                                    </template>
                                    <button type="button" @click="addLine('taxLines')"
                                        class="text-xs text-gray-500 hover:text-primary">+ Tambah Pajak</button>
                                </div>
                            </div>
                            {{-- Bunga --}}
                            <div>
                                <h4 class="text-sm font-bold text-gray-700 mb-3 flex items-center gap-2">
                                    Bunga / Adm <small class="text-gray-400 font-normal">(Optional)</small>
                                </h4>
                                <div class="space-y-3">
                                    <template x-for="(line, i) in interestLines" :key="i">
                                        <div class="flex gap-2 items-center">
                                            <select :name="`interest_lines[${i}][interest_id]`"
                                                class="flex-1 rounded border border-stroke text-xs px-2 py-1">
                                                @foreach ($interests as $int)
                                                    <option value="{{ $int->id }}">{{ $int->name }}</option>
                                                @endforeach
                                            </select>
                                            <input type="text" placeholder="Rp"
                                                @input="onAmountInput($event, 'interestLines', i)"
                                                class="w-32 rounded border border-stroke text-xs text-right">
                                            <input type="hidden" :name="`interest_lines[${i}][amount]`"
                                                x-model="line.amount">
                                            <button type="button" @click="removeLine('interestLines', i)"
                                                class="text-gray-400 hover:text-red-500">✕</button>
                                        </div>
                                    </template>
                                    <button type="button" @click="addLine('interestLines')"
                                        class="text-xs text-gray-500 hover:text-primary">+ Tambah Bunga</button>
                                </div>
                            </div>
                        </div>
                    </x-common.component-card>
                </div>

                {{-- SECTION: EXPENSE --}}
                <div x-show="type === 'EXPENSE'" class="space-y-4">
                    <x-common.component-card title="Rincian Pengeluaran">
                        <div class="space-y-3">
                            <template x-for="(line, i) in expenseLines" :key="i">
                                <div class="flex gap-3 items-start bg-gray-50 p-3 rounded-lg">
                                    <div class="flex-1">
                                        <select :name="`expense_lines[${i}][coa_id]`"
                                            class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                                            @foreach ($expenseCoas as $coa)
                                                <option value="{{ $coa->id }}">{{ $coa->name }}</option>
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

                {{-- SECTION: TRANSFER --}}
                <div x-show="type === 'TRANSFER'">
                    <x-common.component-card title="Transfer Antar Rekening">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="mb-2 block text-sm font-medium text-gray-700">Dari Akun (Asal)</label>
                                <select name="from_coa_id" class="w-full rounded border border-stroke px-4 py-2 text-sm">
                                    @foreach ($cashCoas as $coa)
                                        <option value="{{ $coa->id }}">{{ $coa->name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div>
                                <label class="mb-2 block text-sm font-medium text-gray-700">Ke Akun (Tujuan)</label>
                                <select name="to_coa_id" class="w-full rounded border border-stroke px-4 py-2 text-sm">
                                    @foreach ($cashCoas as $coa)
                                        <option value="{{ $coa->id }}">{{ $coa->name }}</option>
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
            </div>

            {{-- FOOTER ACTION --}}
            <div class="mt-8 flex items-center justify-between bg-white p-4 rounded-xl border border-stroke shadow-sm">
                <div>
                    <span class="text-sm text-gray-500">Pastikan data sudah benar sebelum menyimpan.</span>
                </div>
                <div class="flex gap-3">
                    <a href="{{ route('user.transactions.incomes.index') }}">
                        <x-ui.button variant="outline" size="sm">
                            Batal
                        </x-ui.button>
                    </a>
                    <x-ui.button type="submit" variant="primary" size="sm">
                        Simpan Transaksi
                    </x-ui.button>
                </div>
            </div>
        </form>
    </div>

    @push('scripts')
        <script>
            function transactionForm() {
                return {
                    type: 'INCOME',
                    period_id: '{{ $selectedPeriodId }}',
                    sub_period_id: '{{ $subPeriods->first()?->id }}',
                    cash_coa_id: '',

                    // Lines
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
                    cashBalance: 0,
                    isLoadingBalance: false,

                    formatRupiah(v) {
                        return new Intl.NumberFormat('id-ID').format(v || 0);
                    },

                    stripRaw(s) {
                        return s.replace(/\D/g, '');
                    },

                    addLine(target) {
                        this[target].push({
                            coa_id: '',
                            amount: 0
                        });
                    },

                    removeLine(target, i) {
                        this[target].splice(i, 1);
                    },

                    onAmountInput(e, target, i) {
                        let raw = this.stripRaw(e.target.value);
                        this[target][i].amount = raw;
                        e.target.value = raw ? 'Rp ' + this.formatRupiah(raw) : '';
                    },

                    onTransferInput(e) {
                        let raw = this.stripRaw(e.target.value);
                        this.transferAmount = raw;
                        e.target.value = raw ? 'Rp ' + this.formatRupiah(raw) : '';
                    },

                    onTaxSelect(e, i) {
                        const opt = e.target.selectedOptions[0];
                        this.taxLines[i].coa_id = opt.dataset.prepaidId || '';
                    },

                    onPeriodChange(e) {
                        // Redirect atau Fetch Sub-periode baru via AJAX
                        const url = new URL(window.location.href);
                        url.searchParams.set('period_id', e.target.value);
                        window.location.href = url.toString();
                    },

                    async loadCashBalance() {
                        if (!this.cash_coa_id || !this.period_id || !this.sub_period_id) return;

                        this.isLoadingBalance = true;
                        try {
                            // Asumsi endpoint API untuk ambil saldo
                            const response = await fetch(
                                `/user/transactions/incomes/cash-balance?coa_id=${this.cash_coa_id}$period_id=${this.period_id}&sub_period_id=${this.sub_period_id}`
                                );
                            const data = await response.json();
                            this.cashBalance = data.balance || 0;
                        } catch (e) {
                            console.error("Gagal memuat saldo");
                        } finally {
                            this.isLoadingBalance = false;
                        }
                    }
                }
            }
        </script>
    @endpush
@endsection
