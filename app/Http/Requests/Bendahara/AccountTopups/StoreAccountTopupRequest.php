<?php

namespace App\Http\Requests\Bendahara\AccountTopups;

use Illuminate\Foundation\Http\FormRequest;

class StoreAccountTopupRequest extends FormRequest
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
            'period_id' => 'required|exists:periods,id',
            'sub_period_id' => 'required|exists:sub_periods,id',
            'amount' => 'required|numeric|min:0',
            'reason' => 'nullable|string|max:255',
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
            'chart_of_account_id.exists' => 'Akun yang dipilih tidak valid.',
            'period_id.required' => 'Periode harus dipilih.',
            'period_id.exists' => 'Periode yang dipilih tidak valid.',
            'sub_period_id.required' => 'Sub periode harus dipilih.',
            'sub_period_id.exists' => 'Sub periode yang dipilih tidak valid.',
            'amount.required' => 'Jumlah topup harus diisi.',
            'amount.numeric' => 'Jumlah topup harus berupa angka.',
            'amount.min' => 'Jumlah topup tidak boleh negatif.',
            'reason.string' => 'Alasan harus berupa teks.',
            'reason.max' => 'Alasan tidak boleh lebih dari 255 karakter.',
        ];
    }
}
