@extends('layouts.app')

@section('title', 'Tambah Saldo')

@section('content')
    <x-common.page-breadcrumb defaultTitle="Penambahan Saldo" pageTitle="Topup Saldo" pageDescription="Buat dan kelola Penambahan Saldo berdasarkan periode"
            pageIcon="money" 
            parentTitle="Penambahan Saldo"
            :parentRoute="route('bendahara.account-topups.index')"
            currentTitle="Tambah Saldo Baru" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
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
        {{-- Form Seleksi (Input periode, sub periode, coa seperti kode sebelumnya) --}}
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">
            <div>
                <x-form.select 
                    id="select_period" 
                    name="period_id" 
                    label="Periode" 
                    placeholder="-- Pilih Periode --">
                    @foreach ($periods as $period)
                        <option value="{{ $period->id }}">{{ $period->name }}</option>
                    @endforeach
                </x-form.select>
            </div>

            <div>
                <x-form.select 
                    id="select_sub_period" 
                    name="sub_period_id" 
                    label="Sub Periode" 
                    placeholder="-- Pilih Sub Periode --">
                </x-form.select>
            </div>

            <div>
                <x-form.select 
                    id="select_coa" 
                    name="coa_id" 
                    label="Akun (COA)" 
                    placeholder="-- Pilih Akun --">
                    @foreach ($coaLists as $coa)
                        <option value="{{ $coa->id }}" data-balance="{{ $coa->normal_balance }}">
                            {{ $coa->code }} — {{ $coa->name }}
                        </option>
                    @endforeach
                </x-form.select>
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
                        <x-form.input 
                            id="amount_display" 
                            name=""
                            label="Saldo Sisa (Periode Sebelumnya)"
                            colorLabel="blue"
                            placeholder="Rp 0" 
                            readonly />

                        <input type="hidden" name="amount" id="amount_hidden">
                        
                        <p class="mt-1 text-xs text-gray-500 italic">* Diambil otomatis dari closing balance terakhir</p>
                    </div>

                    {{-- SALDO TAMBAHAN --}}
                    <div>
                        <x-form.input 
                            id="additional_display" 
                            name=""
                            label="Saldo Tambahan (Jika Ada)"
                            colorLabel="green"
                            placeholder="Masukkan nominal tambahan jika ada" 
                        />

                        <input type="hidden" name="additional_amount" id="additional_hidden" value="0">
                    </div>

                    {{-- TIPE SALDO --}}
                    <div>
                        <x-form.select 
                            id="final_balance_type" 
                            name="balance_type" 
                            label="Tipe Saldo">
                            <option value="DEBIT">DEBIT</option>
                            <option value="CREDIT">KREDIT</option>
                        </x-form.select>

                    </div>

                    {{-- TOTAL PREVIEW --}}
                    <div class="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg border border-blue-100 dark:border-blue-800">
                        <label class="block text-xs font-bold uppercase text-blue-800 dark:text-blue-300">Estimasi Total
                            Saldo Awal</label>
                        <p id="total_preview" class="text-2xl font-bold text-blue-700 dark:text-blue-400">Rp 0</p>
                    </div>
                </div>

                <div class="mt-8 flex justify-end gap-3 border-t pt-6">
                    <a href="{{ route('bendahara.account-topups.index') }}">
                        <x-ui.button variant="outline" size="sm">
                            Kembali
                        </x-ui.button>
                    </a>
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


        // Auto set balance type berdasarkan normal balance COA
        selectCoa.addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            const normalBalance = selectedOption.dataset.balance;

            if (normalBalance) {
                document.getElementById('final_balance_type').value = normalBalance;
            }
        });
    </script>
@endsection
