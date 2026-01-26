@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Penerimaan" />

    <x-common.component-card title="Transaksi Penerimaan">
        <form method="POST" action="{{ route('user.incomes.store') }}" class="space-y-6">
            @csrf

            {{-- ================= HEADER ================= --}}
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Tanggal
                    </label>
                    <input type="date" name="transaction_date" value="{{ now()->format('Y-m-d') }}"
                        class="h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">
                </div>

                {{-- ================= KAS / BANK ================= --}}
                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Kas / Bank
                    </label>
                    <select name="cash_coa_id"
                        class="h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">
                        @foreach ($cashCoas as $coa)
                            <option value="{{ $coa->id }}">
                                {{ $coa->code }} — {{ $coa->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                <div>
                    <label class="mb-2 block text-sm font-medium text-gray-700">
                        Keterangan
                    </label>
                    <input type="text" name="description" placeholder="Contoh: Penerimaan iuran anggota"
                        class="h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">
                </div>
            </div>

            {{-- ================= DETAIL PENDAPATAN ================= --}}
            <div class="space-y-3">
                <h4 class="text-base font-semibold text-gray-800">
                    Detail Pendapatan
                </h4>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div>
                        <label class="mb-2 block text-sm font-medium text-gray-700">
                            Akun Pendapatan
                        </label>
                        <select name="income_lines[0][coa_id]"
                            class="h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">
                            @foreach ($incomeCoas as $coa)
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
                        <input type="number" name="income_lines[0][amount]" placeholder="0"
                            class="h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">
                    </div>

                    <div>
                        <label class="mb-2 block text-sm font-medium text-gray-700">
                            Keterangan
                        </label>
                        <input type="text" name="income_lines[0][description]" placeholder="Opsional"
                            class="h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">
                    </div>
                </div>
            </div>



            {{-- ================= ACTION ================= --}}
            <div class="mt-8 flex justify-end gap-3">
                <a href="{{ route('user.incomes.index') }}">
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
@endsection
