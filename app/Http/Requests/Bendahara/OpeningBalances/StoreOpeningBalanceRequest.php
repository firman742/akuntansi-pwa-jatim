<?php

namespace App\Http\Requests\Bendahara\OpeningBalances;

use Illuminate\Foundation\Http\FormRequest;

class StoreOpeningBalanceRequest extends FormRequest
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
            'chart_of_account_id' => 'required|exists:chart_of_accounts,id',
            'sub_period_id'       => 'required|exists:sub_periods,id',
            'balance_type'        => 'required|in:DEBIT,CREDIT',
            'amount'              => 'required|numeric|min:0', // Ini adalah saldo sisa/akhir periode lalu
            'additional_amount'   => 'nullable|numeric|min:0', // Ini adalah saldo tambahan baru
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
            'chart_of_account_id.required' => 'Akun harus dipilih.',
            'chart_of_account_id.exists'   => 'Akun yang dipilih tidak valid.',
            'sub_period_id.required'       => 'Sub periode harus dipilih.',
            'sub_period_id.exists'         => 'Sub periode yang dipilih tidak valid.',
            'balance_type.required'        => 'Tipe saldo harus dipilih.',
            'balance_type.in'              => 'Tipe saldo harus DEBIT atau CREDIT.',
            'amount.required'              => 'Jumlah saldo harus diisi.',
            'amount.numeric'               => 'Jumlah saldo harus berupa angka.',
            'amount.min'                   => 'Jumlah saldo tidak boleh negatif.',
            'additional_amount.numeric'    => 'Jumlah tambahan harus berupa angka.',
            'additional_amount.min'        => 'Jumlah tambahan tidak boleh negatif.',
        ];
    }
}
