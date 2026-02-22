@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Pengeluaran" />

    <x-common.component-card title="Transaksi Pengeluaran">
        <form method="POST" action="{{ route('user.expenses.store') }}" class="space-y-6">
            @csrf

            {{-- ================= HEADER ================= --}}
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Tanggal
                    </label>
                    <input type="date" name="transaction_date" value="{{ old('transaction_date', now()->format('Y-m-d')) }}"
                        class="h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">
                </div>

                {{-- ================= KAS / BANK ================= --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Kas / Bank
                    </label>

                    <select name="cash_coa_id" id="cash_coa_id"
                        class="h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">
                        @foreach ($cashCoas as $coa)
                            <option value="{{ $coa->id }}" data-balance="{{ $cashBalances[$coa->id] ?? 0 }}">
                                {{ $coa->code }} — {{ $coa->name }}
                            </option>
                        @endforeach
                    </select>

                    <p class="mt-1 text-sm text-gray-500">
                        Saldo kas tersedia:
                        <span id="cash-balance" class="font-semibold text-green-600">
                            Rp 0
                        </span>
                    </p>
                </div>


                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Keterangan
                    </label>
                    <input type="text" name="description" value="{{ old('description') }}"
                        placeholder="Contoh: Pembayaran listrik kantor"
                        class="h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">
                </div>
            </div>

            {{-- ================= DETAIL BEBAN ================= --}}
            <div class="space-y-3">
                <h4 class="text-base font-semibold text-gray-800">
                    Detail Beban
                </h4>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="mb-2 block text-sm font-medium text-gray-700">
                            Akun Beban
                        </label>
                        <select name="expense_lines[0][coa_id]"
                            class="h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">
                            @foreach ($expenseCoas as $coa)
                                <option value="{{ $coa->id }}">
                                    {{ $coa->code }} — {{ $coa->name }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <div>
                        <label class="mb-2 block text-sm font-medium text-gray-700">
                            Nominal
                        </label>

                        <input type="text" id="amount_display" placeholder="Rp 0"
                            class="rupiah-input h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">

                        <input type="hidden" name="expense_lines[0][amount]" id="amount_real">

                    </div>

                    <div>
                        <label class="mb-2 block text-sm font-medium text-gray-700">
                            Keterangan
                        </label>
                        <input type="text" name="expense_lines[0][description]"
                            value="{{ old('expense_lines.0.description') }}" placeholder="Opsional"
                            class="h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">
                    </div>
                </div>
            </div>

            {{-- ================= ACTION ================= --}}
            <div class="mt-8 flex justify-end gap-3">
                <a href="{{ route('user.expenses.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Simpan Transaksi
                </x-ui.button>
            </div>
        </form>
    </x-common.component-card>

    @push('scripts')
        <script>
            const cashSelect = document.getElementById('cash_coa_id');
            const balanceText = document.getElementById('cash-balance');
            const displayInput = document.getElementById('amount_display');
            const realInput = document.getElementById('amount_real');

            function updateBalance() {
                const option = cashSelect.options[cashSelect.selectedIndex];
                const balance = option.dataset.balance || 0;

                console.log(balance);
                balanceText.textContent =
                    'Rp ' + Number(balance).toLocaleString('id-ID');

                balanceText.classList.toggle(
                    'text-red-600',
                    Number(balance) <= 0
                );
            }
            console.log(updateBalance);

            cashSelect.addEventListener('change', updateBalance);
            document.addEventListener('DOMContentLoaded', updateBalance);


            function formatRupiah(value) {
                return new Intl.NumberFormat('id-ID').format(value);
            }

            displayInput.addEventListener('input', function(e) {
                let raw = this.value.replace(/\D/g, ''); // hanya angka
                realInput.value = raw; // kirim angka bersih ke backend

                if (raw) {
                    this.value = 'Rp ' + formatRupiah(raw);
                } else {
                    this.value = '';
                }
            });
        </script>
    @endpush
@endsection
