@extends('layouts.app')

@section('title', 'Buat Transaksi Pengeluaran')

@section('content')

    <x-common.page-breadcrumb pageTitle="Buat Transaksi Pengeluaran" />

    <div x-data="transactionForm()" class="max-w-5xl mx-auto pb-20">
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

                {{-- FORM --}}
                <div class="md:col-span-2 space-y-6">

                    <x-common.component-card title="Informasi Utama">

                        <div class="grid md:grid-cols-2 gap-5">
                            <div class="space-y-1">
                                <label class="text-xs font-bold uppercase text-gray-500 tracking-wider">Sub Periode</label>
                                <select name="sub_period_id" x-model="sub_period_id"
                                    class="w-full border rounded-lg focus:ring-primary focus:border-primary px-3 py-2.5 text-sm">
                                    @foreach ($subPeriods as $s)
                                        <option value="{{ $s->id }}">{{ $s->name }}</option>
                                    @endforeach
                                </select>
                                <input type="hidden" name="period_id" value="{{ $selectedPeriodId }}">
                            </div>

                            <div>
                                <label class="text-xs font-bold">
                                    Tanggal
                                </label>
                                <x-form.date-picker id="transaction_date" name="transaction_date"
                                    placeholder="Tentukan Tanggal Transaksi" defaultDate="{{ now()->format('Y-m-d') }}" />
                            </div>
                        </div>
                        <div class="grid md:grid-cols-1 gap-5">
                            <div>
                                <label class="text-xs font-bold">
                                    Pilih Kas
                                </label>

                                <select name="user_account_balance_id" x-model="selectedBalance" @change="onCashChange"
                                    class="w-full border rounded-lg px-3 py-2">

                                    <option value="">
                                        -- Pilih Kas --
                                    </option>

                                    @foreach ($cashCoas as $cash)
                                        <option value="{{ $cash['user_account_balance_id'] }}"
                                            data-balance="{{ $cash['remaining_balance'] }}">

                                            {{ $cash['coa_code'] }}
                                            -
                                            {{ $cash['coa_name'] }}

                                            (Rp {{ number_format($cash['remaining_balance']) }})
                                        </option>
                                    @endforeach
                                </select>

                                <div class="mt-2 text-xs text-gray-500">
                                    Sisa Saldo:
                                    <span class="font-bold text-green-600" x-text="formatRupiah(balance)">
                                    </span>
                                </div>
                            </div>

                        </div>

                        <div class="mt-5">

                            <label class="text-xs font-bold">
                                Keterangan
                            </label>

                            <textarea name="description" rows="3" class="w-full border rounded-lg px-3 py-2"></textarea>

                        </div>

                    </x-common.component-card>

                    {{-- RINCIAN --}}
                    <x-common.component-card title="Rincian Pengeluaran">

                        <div class="space-y-4">

                            <template x-for="(line, index) in lines" :key="index">

                                <div class="grid md:grid-cols-12 gap-3">

                                    <div class="md:col-span-7">

                                        <select :name="`expense_lines[${index}][coa_id]`"
                                            class="w-full border rounded-lg px-3 py-2">

                                            @foreach ($expenseCoas as $coa)
                                                <option value="{{ $coa->id }}">

                                                    {{ $coa->code }}
                                                    -
                                                    {{ $coa->name }}

                                                </option>
                                            @endforeach

                                        </select>

                                    </div>

                                    <div class="md:col-span-4">

                                        <input type="text" @input="onAmountInput($event, index)"
                                            class="w-full border rounded-lg px-3 py-2 text-right" placeholder="Rp 0">

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

                    <div class="bg-gray-900 rounded-2xl p-6 text-white">

                        <div class="text-sm uppercase text-gray-400">
                            Total Pengeluaran
                        </div>

                        <div class="mt-3 text-3xl font-black">

                            Rp
                            <span x-text="formatRupiah(total)">
                            </span>

                        </div>

                        <button type="submit" class="w-full mt-6 bg-primary py-3 rounded-xl font-bold">

                            Simpan Transaksi

                        </button>

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
