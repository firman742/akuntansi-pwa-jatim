@extends('layouts.app')

@section('title', 'Tambah Penerimaan')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Penerimaan" />

    <x-common.component-card title="Transaksi Penerimaan">
        <form method="POST" action="{{ route('user.transactions.incomes.store') }}" enctype="multipart/form-data"
            class="space-y-6" x-data="receiptUpload()">
            @csrf

            {{-- ================= HEADER ================= --}}
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                {{-- PERIOD --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">Periode</label>
                    <select name="period_id" id="period_id" class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                        <option value="">-- Pilih Periode --</option>
                        @foreach ($periods as $period)
                            <option value="{{ $period->id }}" @selected($period->id == $selectedPeriodId)>
                                {{ $period->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                {{-- SUB PERIOD --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">Sub Periode</label>
                    <select name="sub_period_id" id="sub_period_id"
                        class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                        <option value="">-- Pilih Sub Periode --</option>
                        @foreach ($subPeriods as $sub)
                            <option value="{{ $sub->id }}">{{ $sub->name }}</option>
                        @endforeach
                    </select>
                </div>

                {{-- TANGGAL --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">Tanggal</label>
                    <x-form.date-picker id="transaction_date" name="transaction_date"
                        defaultDate="{{ now()->format('Y-m-d') }}" />
                </div>

                {{-- KAS / BANK --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">Kas / Bank</label>
                    <select name="cash_coa_id" id="cash_coa_id"
                        class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                        @foreach ($cashCoas as $coa)
                            <option value="{{ $coa->id }}">
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

                {{-- KETERANGAN --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">Keterangan</label>
                    <input type="text" name="description"
                        class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                </div>
            </div>

            {{-- ================= DETAIL ================= --}}
            <div class="space-y-3">
                <h4 class="text-base font-semibold text-gray-800">Detail Pendapatan</h4>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">

                    <div>
                        <label class="mb-2 block text-sm font-medium text-gray-700">Akun Pendapatan</label>
                        <select name="income_lines[0][coa_id]"
                            class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                            @foreach ($incomeCoas as $coa)
                                <option value="{{ $coa->id }}">
                                    {{ $coa->code }} — {{ $coa->name }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <div>
                        <label class="mb-2 block text-sm font-medium text-gray-700">Nominal</label>

                        <input type="text" id="amount_display"
                            class="rupiah-input h-11 w-full rounded-lg border border-stroke px-4 text-sm"
                            placeholder="Rp 0">

                        <input type="hidden" name="income_lines[0][amount]" id="amount_real">
                    </div>

                    <div>
                        <label class="mb-2 block text-sm font-medium text-gray-700">Keterangan</label>
                        <input type="text" name="income_lines[0][description]"
                            class="h-11 w-full rounded-lg border border-stroke px-4 text-sm">
                    </div>
                </div>
            </div>

            {{-- ================= ACTION ================= --}}
            <div class="flex justify-end gap-3">
                <a href="{{ route('user.transactions.incomes.index') }}">
                    <x-ui.button variant="outline" size="sm">Kembali</x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Simpan
                </x-ui.button>
            </div>
        </form>
    </x-common.component-card>
@endsection


@push('scripts')
    <script>
        const cashBalanceUrl = "{{ route('user.transactions.incomes.cash-balance') }}";
        const cashSelect = document.getElementById('cash_coa_id');
        const periodSelect = document.getElementById('period_id');
        const subPeriodSelect = document.getElementById('sub_period_id');
        const balanceText = document.getElementById('cash-balance');

        const displayInput = document.getElementById('amount_display');
        const realInput = document.getElementById('amount_real');

        function formatRupiah(value) {
            return new Intl.NumberFormat('id-ID').format(value);
        }

        // ================= FORMAT RUPIAH =================
        displayInput.addEventListener('input', function() {
            let raw = this.value.replace(/\D/g, '');
            realInput.value = raw;

            this.value = raw ? 'Rp ' + formatRupiah(raw) : '';
        });

        // ================= LOAD SALDO =================
        async function loadCashBalance() {
            const coaId = cashSelect.value;
            const periodId = periodSelect.value;
            const subPeriodId = subPeriodSelect.value;

            if (!coaId || !periodId) {
                balanceText.innerText = 'Rp 0';
                return;
            }

            try {
                const res = await fetch(
                    `/user/transactions/incomes/cash-balance?coa_id=${coaId}&period_id=${periodId}&sub_period_id=${subPeriodId}`, {
                        headers: {
                            'X-Requested-With': 'XMLHttpRequest'
                        }
                    }
                );

                const data = await res.json();

                balanceText.innerText = 'Rp ' + formatRupiah(data.balance);

            } catch (err) {
                balanceText.innerText = 'Error';
            }
        }

        // ================= DEBOUNCE =================
        let timeout;

        function debounceLoad() {
            clearTimeout(timeout);
            timeout = setTimeout(loadCashBalance, 300);
        }

        // ================= EVENT =================
        cashSelect.addEventListener('change', debounceLoad);
        periodSelect.addEventListener('change', async function() {

            let periodId = this.value;

            subPeriodSelect.innerHTML = '<option>Loading...</option>';

            if (!periodId) {
                subPeriodSelect.innerHTML = '<option value="">-- Pilih Sub Periode --</option>';
                return;
            }

            try {
                const res = await fetch(`/user/periode/${periodId}/sub-periods`);
                const data = await res.json();

                subPeriodSelect.innerHTML = '<option value="">-- Pilih Sub Periode --</option>';

                data.forEach(sub => {
                    subPeriodSelect.innerHTML += `<option value="${sub.id}">${sub.name}</option>`;
                });

            } catch {
                subPeriodSelect.innerHTML = '<option>Error</option>';
            }

            debounceLoad();
        });

        subPeriodSelect.addEventListener('change', debounceLoad);

        // ================= INIT =================
        document.addEventListener('DOMContentLoaded', loadCashBalance);
    </script>
@endpush
