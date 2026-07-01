<?php

namespace App\Http\Requests\Bendahara\BudgetAllocations;

use Illuminate\Foundation\Http\FormRequest;

class StoreBudgetAllocationRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'period_id' => [
                'required',
                'uuid',
                'exists:periods,id',
            ],

            'sub_period_id' => [
                'nullable',
                'uuid',
                'exists:sub_periods,id',
            ],

            'from_chart_of_account_id' => [
                'required',
                'uuid',
                'different:to_chart_of_account_id',
                'exists:chart_of_accounts,id',
            ],

            'to_chart_of_account_id' => [
                'required',
                'uuid',
                'exists:chart_of_accounts,id',
                'different:from_chart_of_account_id',
            ],

            'amount' => [
                'required',
                'numeric',
                'min:1',
                'max:9999999999',
            ],

            'allocation_type' => [
                'required'
            ],

            'description' => [
                'nullable',
                'string',
                'max:1000',
            ],
        ];
    }

    /**
     * Get custom messages for validator errors.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'period_id.required' => 'Periode harus dipilih.',
            'period_id.uuid' => 'Periode tidak valid.',
            'period_id.exists' => 'Periode yang dipilih tidak ditemukan.',

            'sub_period_id.uuid' => 'Sub periode tidak valid.',
            'sub_period_id.exists' => 'Sub periode yang dipilih tidak ditemukan.',

            'from_chart_of_account_id.required' => 'Akun sumber harus dipilih.',
            'from_chart_of_account_id.uuid' => 'Akun sumber tidak valid.',
            'from_chart_of_account_id.different' => 'Akun sumber dan tujuan harus berbeda.',
            'from_chart_of_account_id.exists' => 'Akun sumber yang dipilih tidak ditemukan.',

            'to_chart_of_account_id.required' => 'Akun tujuan harus dipilih.',
            'to_chart_of_account_id.uuid' => 'Akun tujuan tidak valid.',
            'to_chart_of_account_id.exists' => 'Akun tujuan yang dipilih tidak ditemukan.',
            'to_chart_of_account_id.different' => 'Akun tujuan dan sumber harus berbeda.',

            'amount.required' => 'Jumlah alokasi harus diisi.',
            'amount.numeric' => 'Jumlah alokasi harus berupa angka.',
            'amount.min' => 'Jumlah alokasi harus minimal 1.',
            'amount.max' => 'Jumlah alokasi terlalu besar.',

            'allocation_type.required' => 'Tipe alokasi harus dipilih.',

            'description.string' => 'Deskripsi harus berupa teks.',
            'description.max' => 'Deskripsi tidak boleh lebih dari 1000 karakter.',
        ];
    }
}
