@extends('layouts.app')

@section('title', 'Alokasikan Dana Akun')

@section('content')
<x-common.page-breadcrumb defaultTitle="Alokasikan Dana Akun " pageTitle="Alokasikan Dana Akun"
        pageDescription="Monitoring dan Alokasi dana akun di sistem" pageIcon="transaction" parentTitle="Alokasi Dana Akun"
        :parentRoute="route('bendahara.budget-allocations.index')" currentTitle="Alokasi" />

    @if ($errors->any())
        <div class="mb-6">
            <x-ui.alert variant="error" title="Terjadi Kesalahan">
                <ul class="list-disc list-inside space-y-1">
                    @foreach ($errors->all() as $error)
                        <li class="text-danger-500">{{ $error }}</li>
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

    {{-- STEP 1 --}}
    <x-common.component-card title="1. Pilih Periode & Akun">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-end">

            <!-- PERIOD -->
            <div>
                <x-form.select 
                    id="period_id" 
                    name=""
                    label="Periode" 
                    placeholder="-- Pilih Periode --">
                    @foreach ($periods as $period)
                        <option value="{{ $period->id }}">{{ $period->name }}</option>
                    @endforeach
                </x-form.select>
            </div>

            <!-- SUB PERIOD -->
            <div>
                <x-form.select 
                    id="sub_period_id" 
                    name=""
                    label="Sub Periode" 
                    placeholder="-- Pilih Sub Periode --">
                </x-form.select>
            </div>

            <!-- FROM COA (Akun Kas Debit Only) -->
            <div>
                <x-form.select 
                    id="from_coa" 
                    name=""
                    label="Akun Sumber (Kas Debit)" 
                    placeholder="-- Pilih COA --">
                    @foreach ($coaDebits as $coa)
                        <option value="{{ $coa->id }}">{{ $coa->code }} - {{ $coa->name }}</option>
                    @endforeach
                </x-form.select>
            </div>

        </div>

        <div class="mt-4 flex justify-end">
            <x-ui.button type="button" id="btn_continue" variant="primary">
                Lanjutkan
            </x-ui.button>
        </div>
    </x-common.component-card>

    {{-- STEP 2 --}}
    <div id="form_container" style="display:none;" class="mt-6">
        <x-common.component-card title="2. Detail Distribusi Saldo">

            <form method="POST" action="{{ route('bendahara.budget-allocations.store') }}">
                @csrf

                <input type="hidden" name="period_id" id="final_period">
                <input type="hidden" name="sub_period_id" id="final_sub_period">
                <input type="hidden" name="from_chart_of_account_id" id="final_from_coa">
                <input type="hidden" name="allocation_type" value="manual">

                <div class="grid grid-cols-1 md:grid-cols-1 gap-6 mb-4">
                    {{-- AVAILABLE FUND --}}
                    <div class="p-4 bg-green-50 border rounded-lg hidden dark:bg-gray-900 dark:border-gray-700" id="available_box">
                        <div class="text-sm text-gray-500">Dana Tersedia Saat ini</div>
                        <div class="text-xl font-bold text-green-700" id="available_value">Rp 0</div>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    {{-- TO COA --}}
                    <div>
                        <x-form.select 
                            id="to_coa" 
                            name="to_chart_of_account_id"
                            label="Akun Tujuan (Debit)" 
                            placeholder="-- Pilih Akun Tujuan --">
                            @foreach ($coaDebits as $coa)
                                <option value="{{ $coa->id }}">{{ $coa->code }} - {{ $coa->name }}</option>
                            @endforeach
                        </x-form.select>
                    </div>



                    {{-- AMOUNT --}}
                    <div>
                        <x-form.input 
                            id="additional_display" 
                            name=""
                            label="Nominal Distribusi"
                            colorLabel="green"
                            placeholder="Masukkan nominal tambahan jika ada" 
                            required
                        />
                        <input type="hidden" name="amount" id="additional_hidden" value="0">
                    </div>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-1 gap-6">
                    {{-- DESCRIPTION --}}
                    <div>
                        <x-form.text-area name="description" label="Keterangan" placeholder="Masukkan deskripsi...."
                            rows="4" />
                    </div>
                </div>

                <div class="mt-6 flex justify-end gap-3">
                    <a href="{{ route('bendahara.budget-allocations.index') }}">
                        <x-ui.button variant="outline" size="sm">
                            Kembali
                        </x-ui.button>
                    </a>
                    <x-ui.button type="submit" variant="primary" size="sm">
                        Alokasikan
                    </x-ui.button>
                </div>

            </form>

        </x-common.component-card>
    </div>

    <script>
        const period = document.getElementById('period_id');
        const subPeriod = document.getElementById('sub_period_id');
        const fromCoa = document.getElementById('from_coa');
        const btnContinue = document.getElementById('btn_continue');

        const formContainer = document.getElementById('form_container');

        const toCoa = document.getElementById('to_coa');
        const availableBox = document.getElementById('available_box');
        const availableValue = document.getElementById('available_value');

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

        /**
         * LOAD SUB PERIOD
         */
        period.addEventListener('change', async function() {
            let periodId = this.value;
            subPeriod.innerHTML = '<option value="">Loading...</option>';
            if (!periodId) return;

            try {
                const response = await fetch(`/bendahara/periods/${periodId}/sub-periods`);
                const data = await response.json();
                subPeriod.innerHTML = '<option value="">-- Pilih Sub Periode --</option>';
                data.forEach(sub => {
                    subPeriod.innerHTML += `<option value="${sub.id}">${sub.name}</option>`;
                });
            } catch (error) {
                subPeriod.innerHTML = '<option value="">Gagal mengambil data</option>';
            }
        });

        /**
         * CONTINUE BUTTON (STEP FLOW CONTROL)
         */
        btnContinue.addEventListener('click', async function() {

            if (!period.value || !subPeriod.value || !fromCoa.value) {
                alert('Lengkapi periode, sub periode, dan akun terlebih dahulu.');
                return;
            }

            document.getElementById('final_period').value = period.value;
            document.getElementById('final_sub_period').value = subPeriod.value;
            document.getElementById('final_from_coa').value = fromCoa.value;

            btnContinue.innerText = 'Loading...';
            btnContinue.disabled = true;

            try {
                /**
                 * LOAD AVAILABLE FUND
                 */
                const bal = await fetch(
                    `/bendahara/coa-available-fund/${fromCoa.value}?period_id=${period.value}&sub_period_id=${subPeriod.value}`
                );

                const json = await bal.json();

                availableBox.classList.remove('hidden');
                availableValue.innerText = new Intl.NumberFormat('id-ID', {
                    style: 'currency',
                    currency: 'IDR'
                }).format(json.available ?? 0);

                formContainer.style.display = 'block';
                formContainer.scrollIntoView({
                    behavior: 'smooth'
                });
            } catch (error) {
                alert('Gagal memuat data COA anak atau dana available.');
            } finally {
                btnContinue.innerText = 'Lanjutkan';
                btnContinue.disabled = false;
            }
        });

        // 3. Handle Formatting & Calculation
        const addDisplay = document.getElementById('additional_display');
        const addHidden = document.getElementById('additional_hidden');

        addDisplay.addEventListener('input', function(e) {
            let rawValue = e.target.value.replace(/[^0-9]/g, '');
            addHidden.value = rawValue || 0;
            e.target.value = rawValue ? formatRupiah(rawValue) : '';
        });
    </script>

@endsection
