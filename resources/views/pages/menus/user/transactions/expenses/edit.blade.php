@extends('layouts.app')

@section('title', 'Edit Transaksi Pengeluaran')

@section('content')

    <x-common.page-breadcrumb pageTitle="Edit Transaksi Pengeluaran" defaultTitle="Edit Transaksi Pengeluaran"
        pageDescription="Monitoring transaksi penerimaan yang terjadi di sistem ini" pageIcon="transaction"
        parentTitle="Transaksi Pengeluaran" :parentRoute="route('user.transactions.expenses.index')" currentTitle="Edit" />

    {{-- BACK --}}
    <a href="{{ route('user.transactions.expenses.index') }}" class="mb-5">
        <x-ui.button variant="outline" size="sm" class="mb-5">
            ← Kembali
        </x-ui.button>
    </a>

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li class="text-dark-500">{{ $error }}</li>
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

    <div x-data="transactionForm()" x-init="init()" class="max-w-5xl mx-auto pb-20">
        <form method="POST" action="{{ route('user.transactions.expenses.update', $transaction->id) }}">
            @csrf
            @method('PUT')

            <div class="grid md:grid-cols-3 gap-8 items-start">
                {{-- FORM --}}
                <div class="md:col-span-2 space-y-6">
                    <x-common.component-card title="Informasi Utama">

                        <div class="grid md:grid-cols-2 gap-5">
                            <div class="space-y-1">
                                <x-form.select id="sub_period_id" name="sub_period_id" label="Sub Periode"
                                    placeholder="Pilih Sub Periode" :value="$selectedSubPeriodId" required>
                                    @foreach ($subPeriods as $s)
                                        <option value="{{ $s->id }}" @selected(old('sub_period_id', $selectedSubPeriodId) == $s->id)>
                                            {{ $s->name }}
                                        </option>
                                    @endforeach
                                </x-form.select>
                                <input type="hidden" name="period_id" value="{{ $selectedPeriodId }}">
                            </div>

                            <div>
                                <x-form.date-picker id="transaction_date" name="transaction_date" label="Tanggal"
                                    placeholder="Tentukan Tanggal Transaksi" defaultDate="{{ old('transaction_date', $transaction->transaction_date?->format('Y-m-d')) }}" />
                            </div>
                        </div>
                        <div class="grid md:grid-cols-1 gap-5">
                            <div>
                                <x-form.select name="user_account_balance_id" label="Pilih Kas"
                                    placeholder="-- Pilih Kas --" x-model="selectedBalance" @change="onCashChange" required>
                                    @foreach ($cashCoas as $cash)
                                        <option value="{{ $cash['user_account_balance_id'] }}"
                                            data-balance="{{ $cash['remaining_balance'] }}"
                                            @selected(
                                                old('user_account_balance_id', $transaction->user_account_balance_id)
                                                    == $cash['user_account_balance_id']
                                            )
                                            >

                                            {{ $cash['coa_code'] }}
                                            -
                                            {{ $cash['coa_name'] }}

                                            (Rp {{ number_format($cash['remaining_balance']) }})
                                        </option>
                                    @endforeach
                                </x-form.select>
                                {{-- <div class="mt-2 text-xs text-gray-500">
                                    Sisa Saldo:
                                    <span class="font-bold text-green-600" x-text="formatRupiah(balance)">
                                    </span>
                                </div> --}}
                            </div>
                        </div>

                        <div class="mt-5">
                            <x-form.text-area name="description" label="Deskripsi"
                                placeholder="Masukkan deskripsi transaksi...." rows="3"  :value="old('description', $transaction->description)" required />
                        </div>

                    </x-common.component-card>

                    {{-- RINCIAN --}}
                    <x-common.component-card title="Rincian Pengeluaran">

                        <div class="space-y-4">

                            <template x-for="(line, index) in lines" :key="index">

                                <div class="grid md:grid-cols-12 gap-3">

                                    <div class="md:col-span-7">
                                        <x-form.select name="" placeholder="-- Pilih Akun Keluar --"
                                            x-bind:name="`expense_lines[${index}][coa_id]`">
                                            @foreach ($expenseCoas as $coa)
                                                <option value="{{ $coa->id }}">
                                                    {{ $coa->code }} - {{ $coa->name }}
                                                </option>
                                            @endforeach
                                        </x-form.select>
                                    </div>

                                    <div class="md:col-span-4">
                                        <x-form.input name="" type="text" @input="onAmountInput($event, index)"
                                            placeholder="Rp 0" />

                                        <input type="hidden" :name="`expense_lines[${index}][amount]`"
                                            x-model="line.amount">

                                    </div>

                                    <div class="md:col-span-1">
                                        <button type="button" @click="removeLine(index)"
                                            class="w-full border rounded-lg py-2 text-red-500">
                                            ✕
                                        </button>

                                    </div>

                                </div>

                            </template>

                            <button type="button" @click="addLine" class="w-full border-2 border-dashed rounded-lg py-2">

                                + Tambah Rincian

                            </button>

                        </div>

                    </x-common.component-card>

                </div>

                {{-- SUMMARY --}}
                <div>
                    <div class="bg-gray-800 dark:bg-gray-700 rounded-2xl p-6 text-white dark:text-gray-200 shadow-lg">

                        <div class="text-sm uppercase text-gray-400 dark:text-gray-300 font-semibold tracking-wide">
                            Total Pengeluaran
                        </div>

                        <div class="mt-4 text-4xl font-extrabold text-primary dark:text-primary-light">
                            Rp
                            <span x-text="formatRupiah(total)">
                            </span>
                        </div>

                        <div class="grid grid-cols-2 gap-3">

                            <button type="submit" name="status" value="DRAFT"
                                class="w-full mt-6 rounded-xl border border-blue-700 
                                       bg-white py-3 font-semibold text-blue-700
                                       text-xs
                                       hover:bg-blue-200 hover:text-white
                                       transition">
                                Simpan sebagai Draft
                            </button>

                            <button type="submit" name="status" value="SUBMITTED"
                                class="w-full mt-6 rounded-xl border border-gray-25
                                       bg-primary py-3 font-semibold text-white
                                       text-xs
                                       hover:bg-primary/90
                                       transition">
                                Simpan
                            </button>

                        </div>
                    </div>
                </div>
            </div>

        </form>

    </div>

    <script>
        function transactionForm() {
            return {
                selectedBalance: '',
                balance: 0,
                total: 0,
                lines: [{
                    amount: 0
                }],

                init() {
                    this.$nextTick(() => {
                        const select = document.querySelector(
                            '[name="user_account_balance_id"]'
                        );

                        if (select && select.selectedOptions.length) {

                            this.balance = Number(
                                select.selectedOptions[0].dataset.balance
                            );

                        }

                    });

                },

                formatRupiah(v) {
                    return new Intl.NumberFormat(
                        'id-ID'
                    ).format(v || 0);
                },

                strip(v) {
                    return v.replace(/\D/g, '');
                },

                onCashChange(e) {

                    const option =
                        e.target.selectedOptions[0];

                    this.balance =
                        Number(
                            option.dataset.balance || 0
                        );
                },

                onAmountInput(e, index) {

                    let raw = this.strip(
                        e.target.value
                    );

                    this.lines[index].amount =
                        Number(raw);

                    e.target.value =
                        raw ?
                        'Rp ' + this.formatRupiah(raw) :
                        '';

                    this.calculate();
                },

                calculate() {

                    this.total =
                        this.lines.reduce(
                            (sum, line) =>
                            sum + Number(line.amount || 0),
                            0
                        );
                },

                addLine() {

                    this.lines.push({
                        amount: 0
                    });
                },

                removeLine(index) {

                    this.lines.splice(index, 1);

                    this.calculate();
                }
            }
        }
    </script>

@endsection
