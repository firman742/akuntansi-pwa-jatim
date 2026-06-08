@extends('layouts.app')

@section('title', 'Ajukan Penambahan Dana')

@section('content')
    <x-common.page-breadcrumb pageTitle="Ajukan Penambahan Dana" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-inside list-disc space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>
                            <span class="text-gray-500 dark:text-gray-400">
                                {{ $error }}
                            </span>
                        </li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    <div class="mb-6">
        <x-ui.alert variant="info" title="Informasi Pengajuan">
            Pengajuan dana akan berstatus <strong>Pending</strong> dan menunggu persetujuan dari pihak yang berwenang.
        </x-ui.alert>
    </div>

    <x-common.component-card title="Form Pengajuan Penambahan Dana">

        <form method="POST" action="{{ route('user.requests.balances.store') }}" x-data="balanceRequestForm()"
            x-init="init()">

            @csrf

            <div class="space-y-8">

                {{-- PERIODE --}}
                <div>
                    <div class="grid grid-cols-1 gap-5 md:grid-cols-2">
                        {{-- Sub Period --}}
                        <div>
                            <label class="mb-2 block text-sm font-medium">
                                Sub Periode
                                <span class="text-red-500">*</span>
                            </label>

                            <select name="sub_period_id" x-model="selectedSubPeriod" @change="syncPeriodId()"
                                class="h-11 w-full rounded-lg border border-gray-300 px-4">

                                <option value="">
                                    Pilih Sub Periode
                                </option>

                                @foreach ($subPeriods as $subPeriod)
                                    <option value="{{ $subPeriod->id }}" data-period="{{ $subPeriod->period_id }}"
                                        @selected(old('sub_period_id') == $subPeriod->id)>
                                        {{ $subPeriod->period->name }}
                                        -
                                        {{ $subPeriod->name }}
                                    </option>
                                @endforeach

                            </select>

                            @error('sub_period_id')
                                <p class="mt-1 text-sm text-red-500">
                                    {{ $message }}
                                </p>
                            @enderror

                            <input type="hidden" name="period_id" x-model="periodId">
                        </div>

                        {{-- Akun Tujuan --}}
                        <div>
                            <label class="mb-2 block text-sm font-medium">
                                Akun Tujuan
                                <span class="text-red-500">*</span>
                            </label>

                            <select name="user_account_id" class="h-11 w-full rounded-lg border border-gray-300 px-4">

                                <option value="">
                                    Pilih Akun
                                </option>

                                @foreach ($userAccounts as $account)
                                    <option value="{{ $account->id }}" @selected(old('user_account_id') == $account->id)>
                                        {{ $account->coa->code }}
                                        -
                                        {{ $account->coa->name }}
                                    </option>
                                @endforeach

                            </select>

                            @error('user_account_id')
                                <p class="mt-1 text-sm text-red-500">
                                    {{ $message }}
                                </p>
                            @enderror
                        </div>
                    </div>
                </div>

                {{-- NOMINAL --}}
                <div>
                    <div class="grid grid-cols-1 gap-5 md:grid-cols-1">
                        <div>
                            <label class="mb-2 block text-sm font-medium">
                                Nominal Pengajuan
                                <span class="text-red-500">*</span>
                            </label>

                            <input type="text" x-model="amountFormatted" @input="formatAmount" placeholder="Rp 0"
                                class="h-11 w-full rounded-lg border border-gray-300 px-4">

                            <input type="hidden" name="amount" x-model="amount">

                            @error('amount')
                                <p class="mt-1 text-sm text-red-500">
                                    {{ $message }}
                                </p>
                            @enderror
                        </div>
                    </div>
                </div>

                {{-- TUJUAN --}}
                <div>
                    <div class="grid grid-cols-1 gap-5 md:grid-cols-1">
                        <div>

                            <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                                Tujuan Penggunaan Dana
                                <span class="text-red-500">*</span>
                            </label>
                            <textarea name="purpose" rows="5" placeholder="Jelaskan tujuan penggunaan dana yang diajukan..."
                                class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10
    dark:focus:border-brand-800 w-full rounded-lg border border-gray-300
    bg-transparent px-4 py-3 text-sm text-gray-800 placeholder:text-gray-400
    focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:text-white/90">{{ old('purpose') }}</textarea>

                            @error('purpose')
                                <p class="mt-1 text-sm text-red-500">
                                    {{ $message }}
                                </p>
                            @enderror
                        </div>
                    </div>
                </div>

                {{-- CATATAN --}}
                <div>
                    <div class="grid grid-cols-1 gap-5 md:grid-cols-1">
                        <div>
                            <label class="mb-2 block text-sm font-medium text-gray-700 dark:text-gray-400">
                                Catatan Tambahan
                                <span class="text-red-500">*</span>
                            </label>

                            <textarea name="note" rows="4" placeholder="Catatan tambahan (opsional)..."
                                class="dark:bg-dark-900 shadow-theme-xs focus:border-brand-300 focus:ring-brand-500/10
                                dark:focus:border-brand-800 w-full rounded-lg border border-gray-300
                                bg-transparent px-4 py-3 text-sm text-gray-800 placeholder:text-gray-400
                                focus:ring-3 focus:outline-hidden dark:border-gray-700 dark:text-white/90">{{ old('note') }}</textarea>

                            @error('note')
                                <p class="mt-1 text-sm text-red-500">
                                    {{ $message }}
                                </p>
                            @enderror
                        </div>
                    </div>
                </div>

            </div>

            <div class="mt-8 flex justify-end gap-3">

                <a href="{{ route('user.requests.balances.index') }}">
                    <x-ui.button variant="outline" size="sm">
                        Kembali
                    </x-ui.button>
                </a>

                <x-ui.button type="submit" variant="primary" size="sm">
                    Ajukan Dana
                </x-ui.button>

            </div>

        </form>

    </x-common.component-card>



@endsection


@push('scripts')
    <script>
        function balanceRequestForm() {
            return {

                selectedSubPeriod: '{{ old('sub_period_id') }}',
                periodId: '{{ old('period_id') }}',

                amount: '{{ old('amount') }}',
                amountFormatted: '',

                init() {

                    if (this.amount) {
                        this.amountFormatted =
                            this.toRupiah(this.amount);
                    }

                    if (this.selectedSubPeriod) {
                        this.syncPeriodId();
                    }
                },

                syncPeriodId() {

                    const select =
                        document.querySelector(
                            '[name="sub_period_id"]'
                        );

                    const option =
                        select.options[
                            select.selectedIndex
                        ];

                    this.periodId =
                        option.dataset.period || '';
                },

                formatAmount(event) {

                    const raw =
                        event.target.value
                        .replace(/[^\d]/g, '');

                    this.amount = raw;

                    this.amountFormatted =
                        raw ?
                        this.toRupiah(raw) :
                        '';
                },

                toRupiah(value) {

                    return new Intl.NumberFormat(
                        'id-ID', {
                            style: 'currency',
                            currency: 'IDR',
                            minimumFractionDigits: 0
                        }
                    ).format(value);
                }
            }
        }
    </script>
@endpush
