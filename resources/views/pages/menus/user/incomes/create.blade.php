@extends('layouts.app')

@section('content')
    <x-common.page-breadcrumb pageTitle="Tambah Penerimaan" />

    <x-common.component-card title="Transaksi Penerimaan">
        <form method="POST" action="{{ route('user.incomes.store') }}" enctype="multipart/form-data" class="space-y-6"
            x-data="receiptUpload()">
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
                        <input type="text" id="amount_display" placeholder="Rp 0"
                            class="rupiah-input h-11 w-full rounded-lg border border-stroke bg-transparent px-4 text-sm text-gray-700 outline-none focus:border-primary">

                        <input type="hidden" name="income_lines[0][amount]" id="amount_real">

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

            {{-- ================= BUKTI TRANSAKSI ================= --}}
            <div class="space-y-3">
                <h4 class="text-base font-semibold text-gray-800">
                    Bukti Transaksi
                </h4>

                <div>
                    <input type="file" name="receipt" accept="image/*" x-ref="fileInput" @change="handleImage"
                        class="block w-full text-sm text-gray-600 file:mr-4 file:py-2 file:px-4 
                      file:rounded-lg file:border-0 file:text-sm file:font-semibold 
                      file:bg-primary file:text-white hover:file:bg-opacity-90">

                    <p class="mt-1 text-xs text-gray-500">
                        Maksimal 2MB. Gambar akan dikompresi otomatis.
                    </p>

                    <div x-show="loading" class="mt-2 text-sm text-blue-600">
                        Mengompresi gambar...
                    </div>
                </div>

                {{-- Preview --}}
                <template x-if="preview">
                    <div class="mt-3">
                        <img :src="preview" class="w-48 rounded-lg border border-gray-200 shadow-sm">
                    </div>
                </template>
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

    @push('scripts')
        <script src="https://unpkg.com/browser-image-compression@latest/dist/browser-image-compression.js"></script>

        <script>
            const cashSelect = document.getElementById('cash_coa_id');
            const balanceText = document.getElementById('cash-balance');
            const displayInput = document.getElementById('amount_display');
            const realInput = document.getElementById('amount_real');

            function updateBalance() {
                const option = cashSelect.options[cashSelect.selectedIndex];
                const balance = option.dataset.balance || 0;

                balanceText.textContent =
                    'Rp ' + Number(balance).toLocaleString('id-ID');

                balanceText.classList.toggle(
                    'text-red-600',
                    Number(balance) <= 0
                );
            }

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

            function receiptUpload() {
                return {
                    preview: null,
                    loading: false,

                    async handleImage(event) {
                        const input = event.target;
                        const file = input.files[0];

                        if (!file) return;

                        // ===== VALIDASI TYPE =====
                        if (!file.type.startsWith('image/')) {
                            alert("File harus berupa gambar.");
                            input.value = "";
                            return;
                        }

                        // ===== VALIDASI SIZE AWAL (2MB) =====
                        if (file.size > 2 * 1024 * 1024) {
                            alert("Ukuran maksimal 2MB.");
                            input.value = "";
                            return;
                        }

                        this.loading = true;

                        const options = {
                            maxSizeMB: 0.8,
                            maxWidthOrHeight: 1280,
                            initialQuality: 0.7,
                            useWebWorker: true
                        };

                        try {
                            const compressedBlob = await imageCompression(file, options);

                            // Pastikan benar-benar File object
                            const compressedFile = new File(
                                [compressedBlob],
                                file.name, {
                                    type: compressedBlob.type
                                }
                            );

                            // Preview
                            this.preview = URL.createObjectURL(compressedFile);

                            // ===== SAFE DataTransfer =====
                            if (typeof DataTransfer !== "undefined") {
                                const dt = new DataTransfer();
                                dt.items.add(compressedFile);
                                input.files = dt.files;
                            } else {
                                console.warn("Browser tidak support DataTransfer.");
                            }

                        } catch (error) {
                            console.error(error);
                            alert("Gagal mengompresi gambar.");
                            input.value = "";
                        }

                        this.loading = false;
                    }
                }
            }
        </script>
    @endpush
@endsection
