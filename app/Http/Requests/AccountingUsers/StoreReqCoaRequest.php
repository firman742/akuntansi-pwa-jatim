<?php

namespace App\Http\Requests\AccountingUsers;

use App\Enums\NormalBalanceEnum;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreReqCoaRequest extends FormRequest
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
            'proposed_name' => [
                'required',
                'string',
                'max:255',
            ],

            'parent_coa_id' => [
                'nullable',
                'exists:chart_of_accounts,id'
            ],

            'account_type_id' => [
                'required',
                'exists:account_types,id'
            ],

            'normal_balance' => [
                'required',
                Rule::in(NormalBalanceEnum::values()),
            ],

            'description' => [
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
            'proposed_name.required' => 'Nama COA wajib diisi.',
            'proposed_name.string' => 'Nama COA harus berupa teks.',
            'proposed_name.max' => 'Nama COA tidak boleh lebih dari 255 karakter.',

            'parent_coa_id.exists' => 'Parent COA yang dipilih tidak valid.',

            'account_type_id.required' => 'Tipe akun wajib dipilih.',
            'account_type_id.exists' => 'Tipe akun yang dipilih tidak valid.',

            'normal_balance.required' => 'Saldo normal wajib dipilih.',
            'normal_balance.in' => 'Saldo normal harus salah satu dari: DEBIT, KREDIT.',

            'description.string' => 'Deskripsi harus berupa teks.',
            'description.max' => 'Deskripsi tidak boleh lebih dari 1000 karakter.',
        ];
    }
}
