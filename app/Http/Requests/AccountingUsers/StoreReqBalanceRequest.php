<?php

namespace App\Http\Requests\AccountingUsers;

use Illuminate\Foundation\Http\FormRequest;

class StoreReqBalanceRequest extends FormRequest
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
            'user_account_id' => [
                'required',
                'exists:user_accounts,id'
            ],

            'sub_period_id' => [
                'required',
                'exists:sub_periods,id'
            ],

            'amount' => [
                'required',
                'numeric',
                'min:1'
            ],

            'purpose' => [
                'required',
                'string',
                'max:1000'
            ],

            'note' => [
                'nullable',
                'string',
                'max:1000'
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
            'user_account_id.required' => 'Akun pengguna wajib diisi.',
            'user_account_id.exists' => 'Akun pengguna yang dipilih tidak ada.',

            'sub_period_id.required' => 'Sub periode wajib diisi.',
            'sub_period_id.exists' => 'Sub periode yang dipilih tidak ada.',

            'amount.required' => 'Jumlah wajib diisi.',
            'amount.numeric' => 'Jumlah harus berupa angka.',
            'amount.min' => 'Jumlah minimal 1.',

            'purpose.required' => 'Tujuan wajib diisi.',
            'purpose.string' => 'Tujuan harus berupa string.',
            'purpose.max' => 'Tujuan tidak boleh lebih dari 1000 karakter.',

            'note.string' => 'Catatan harus berupa string.',
            'note.max' => 'Catatan tidak boleh lebih dari 1000 karakter.',
        ];
    }
}
