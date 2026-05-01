@extends('layouts.app')

@section('title', 'Neraca Saldo Awal - Buat Manual')

@section('content')
    <x-common.page-breadcrumb pageTitle="Neraca Saldo Awal - Buat Manual" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan" >
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </x-ui.alert>
        </div>
    @endif

    {{-- STEP 1: SELEKSI AKUN & PERIODE --}}
    <x-common.component-card title="1. Pilih Akun & Periode" class="mb-6">
        {{-- DESKRIPSI DETAIL --}}
        {{-- DESKRIPSI DETAIL FITUR --}}
        <div class="mb-6 rounded-lg border border-blue-200 bg-blue-50 p-5 dark:border-blue-900/30 dark:bg-blue-900/10">
            <h4 class="flex items-center gap-2 text-sm font-bold text-blue-900 dark:text-blue-300 mb-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                Panduan Input Saldo Awal (Mekanisme Carry-Over)
            </h4>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm text-blue-800 dark:text-blue-400">
                <ul class="list-disc list-inside space-y-1">
                    <li>
                        <strong>Saldo Sisa:</strong> Sistem akan mencari <em>Closing Balance</em> (Saldo Penutup) secara
                        otomatis dari sub-periode terakhir sebelum periode yang Anda pilih.
                    </li>
                    <li>
                        <strong>Saldo Tambahan:</strong> Gunakan kolom ini jika ada penyesuaian manual atau tambahan modal
                        yang ingin dimasukkan ke dalam saldo awal akun.
                    </li>
                </ul>
                <ul class="list-disc list-inside space-y-1">
                    <li>
                        <strong>Total Saldo:</strong> Hasil akhir yang disimpan adalah <code>Saldo Sisa + Saldo
                            Tambahan</code>.
                    </li>
                    <li>
                        <strong>Validasi:</strong> Penginputan hanya diizinkan jika <strong>belum ada transaksi
                            jurnal</strong> sama sekali pada sub-periode yang dipilih.
                    </li>
                </ul>
            </div>

            <p class="mt-3 text-xs font-medium text-blue-700/70 dark:text-blue-500 italic">
                * Jika sistem menampilkan Rp 0 pada Saldo Sisa, berarti tidak ditemukan riwayat penutupan saldo (Closing)
                untuk akun tersebut di periode sebelumnya.
            </p>
        </div>
        {{-- Form Seleksi (Input periode, sub periode, coa seperti kode sebelumnya) --}} 
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
            <div>
                <label class="block text-sm font-medium mb-2">Periode</label>
                <select id="select_period"
                    class="h-11 w-full rounded-lg border border-gray-300 px-4 text-sm dark:border-gray-700 dark:bg-dark-900">
                    <option value="">-- Pilih Periode --</option>
                    @foreach ($periods as $period)
                        <option value="{{ $period->id }}">{{ $period->name }}</option>
                    @endforeach
                </select>
            </div>

            <div>
                <label class="block text-sm font-medium mb-2">Sub Periode</label>
                <select id="select_sub_period"
                    class="h-11 w-full rounded-lg border border-gray-300 px-4 text-sm dark:border-gray-700 dark:bg-dark-900">
                    <option value="">-- Pilih Sub Periode --</option>
                </select>
            </div>

            <div>
                <label class="block text-sm font-medium mb-2">Akun (COA)</label>
                <select id="select_coa"
                    class="h-11 w-full rounded-lg border border-gray-300 px-4 text-sm dark:border-gray-700 dark:bg-dark-900">
                    <option value="">-- Pilih Akun --</option>
                    @foreach ($coaLists as $coa)
                        <option value="{{ $coa->id }}">{{ $coa->code }} — {{ $coa->name }}</option>
                    @endforeach
                </select>
            </div>
        </div>

        <div class="mt-4 flex justify-end">
            <x-ui.button type="button" id="btn_check_balance" variant="primary" size="sm">
                Cek Saldo Sebelumnya & Lanjutkan
            </x-ui.button>
        </div>
    </x-common.component-card>

    {{-- STEP 2: FORM INPUT (HIDDEN BY DEFAULT) --}}
    <div id="form_container" style="display: none;">
        <x-common.component-card title="2. Detail Saldo Awal">
            <form method="POST" action="{{ route('bendahara.opening-balances.store') }}">
                @csrf

                <input type="hidden" name="chart_of_account_id" id="final_coa_id">
                <input type="hidden" name="sub_period_id" id="final_sub_period_id">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    {{-- SALDO SISA (DARI PERIODE LALU) --}}
                    <div>
                        <label class="block text-sm font-medium mb-2 text-blue-600 dark:text-blue-400">
                            Saldo Sisa (Periode Sebelumnya)
                        </label>
                        <div class="relative">
                            <input type="text" id="amount_display" readonly
                                class="h-11 w-full rounded-lg border border-gray-200 bg-gray-100 px-4 text-sm cursor-not-allowed dark:bg-white/5"
                                placeholder="Rp 0">
                            <input type="hidden" name="amount" id="amount_hidden">
                        </div>
                        <p class="mt-1 text-xs text-gray-500 italic">* Diambil otomatis dari closing balance terakhir</p>
                    </div>

                    {{-- SALDO TAMBAHAN --}}
                    <div>
                        <label class="block text-sm font-medium mb-2 text-green-600 dark:text-green-400">
                            Saldo Tambahan (Baru)
                        </label>
                        <input type="text" id="additional_display"
                            class="h-11 w-full rounded-lg border border-blue-300 px-4 text-sm focus:ring-2 focus:ring-blue-500 dark:bg-dark-900"
                            placeholder="Masukkan nominal tambahan jika ada">
                        <input type="hidden" name="additional_amount" id="additional_hidden" value="0">
                    </div>

                    {{-- TIPE SALDO --}}
                    <div>
                        <label class="block text-sm font-medium mb-2">Tipe Saldo</label>
                        <select name="balance_type" id="final_balance_type"
                            class="h-11 w-full rounded-lg border border-gray-300 px-4 text-sm dark:bg-dark-900">
                            <option value="DEBIT">DEBIT</option>
                            <option value="CREDIT">KREDIT</option>
                        </select>
                    </div>

                    {{-- TOTAL PREVIEW --}}
                    <div class="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg border border-blue-100 dark:border-blue-800">
                        <label class="block text-xs font-bold uppercase text-blue-800 dark:text-blue-300">Estimasi Total
                            Saldo Awal</label>
                        <p id="total_preview" class="text-2xl font-bold text-blue-700 dark:text-blue-400">Rp 0</p>
                    </div>
                </div>

                <div class="mt-8 flex justify-end gap-3 border-t pt-6">
                    <x-ui.button type="button" onclick="location.reload()" variant="outline" size="sm">
                        Batal
                    </x-ui.button>
                    <x-ui.button type="submit" variant="primary" size="sm">
                        Simpan Saldo Awal
                    </x-ui.button>
                </div>
            </form>
        </x-common.component-card>
    </div>

    <script>
        const selectPeriod = document.getElementById('select_period');
        const selectSubPeriod = document.getElementById('select_sub_period');
        const selectCoa = document.getElementById('select_coa');
        const btnCheck = document.getElementById('btn_check_balance');
        const formContainer = document.getElementById('form_container');

        // Utils
        function formatRupiah(value) {
            if (!value) return 'Rp 0';
            let numberString = value.toString().replace(/[^0-9]/g, '');
            let split = numberString.split(',');
            let sisa = split[0].length % 3;
            let rupiah = split[0].substr(0, sisa);
            let ribuan = split[0].substr(sisa).match(/\d{3}/gi);
            if (ribuan) {
                let separator = sisa ? '.' : '';
                rupiah += separator + ribuan.join('.');
            }
            return 'Rp ' + rupiah;
        }

        // 1. Handle Dependent Dropdown (Sub Period)
        selectPeriod.addEventListener('change', async function() {
            let periodId = this.value;
            selectSubPeriod.innerHTML = '<option value="">Loading...</option>';
            if (!periodId) return;

            try {
                const response = await fetch(`/bendahara/periods/${periodId}/sub-periods`);
                const data = await response.json();
                selectSubPeriod.innerHTML = '<option value="">-- Pilih Sub Periode --</option>';
                data.forEach(sub => {
                    selectSubPeriod.innerHTML += `<option value="${sub.id}">${sub.name}</option>`;
                });
            } catch (error) {
                selectSubPeriod.innerHTML = '<option value="">Gagal mengambil data</option>';
            }
        });

        // 2. Handle Check Balance API
        btnCheck.addEventListener('click', async function() {
            const coaId = selectCoa.value;
            const subId = selectSubPeriod.value;

            if (!coaId || !subId) {
                alert('Silahkan pilih Akun dan Sub Periode terlebih dahulu.');
                return;
            }

            btnCheck.innerText = 'Memproses...';
            btnCheck.disabled = true;

            try {
                // Panggil endpoint yang kita buat di controller sebelumnya
                const response = await fetch(
                    `/bendahara/opening-balances/get-last-closing?coa_id=${coaId}&sub_period_id=${subId}`);
                const data = await response.json();

                // Isi data ke Form Tahap 2
                document.getElementById('final_coa_id').value = coaId;
                document.getElementById('final_sub_period_id').value = subId;

                // Saldo Sisa Otomatis
                document.getElementById('amount_hidden').value = data.amount;
                document.getElementById('amount_display').value = formatRupiah(data.amount);
                document.getElementById('final_balance_type').value = data.balance_type;

                // Reset Saldo Tambahan
                document.getElementById('additional_hidden').value = 0;
                document.getElementById('additional_display').value = '';

                // Tampilkan Form
                formContainer.style.display = 'block';
                formContainer.scrollIntoView({
                    behavior: 'smooth'
                });
                calculateTotal();

            } catch (error) {
                alert('Gagal mengambil saldo terakhir.');
            } finally {
                btnCheck.innerText = 'Cek Saldo Sebelumnya & Lanjutkan';
                btnCheck.disabled = false;
            }
        });

        // 3. Handle Formatting & Calculation
        const addDisplay = document.getElementById('additional_display');
        const addHidden = document.getElementById('additional_hidden');

        addDisplay.addEventListener('input', function(e) {
            let rawValue = e.target.value.replace(/[^0-9]/g, '');
            addHidden.value = rawValue || 0;
            e.target.value = rawValue ? formatRupiah(rawValue) : '';
            calculateTotal();
        });

        function calculateTotal() {
            const sisa = parseFloat(document.getElementById('amount_hidden').value) || 0;
            const tambahan = parseFloat(addHidden.value) || 0;
            const total = sisa + tambahan;
            document.getElementById('total_preview').innerText = formatRupiah(total);
        }
    </script>
@endsection
