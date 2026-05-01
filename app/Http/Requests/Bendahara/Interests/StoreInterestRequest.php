<?php

namespace App\Http\Requests\Bendahara\Interests;

use Illuminate\Foundation\Http\FormRequest;

class StoreInterestRequest extends FormRequest
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
            'name' => 'required|string|max:100',
            'type' => 'required|in:PERCENTAGE,FIXED',

            // rate hanya wajib jika percentage
            'rate' => 'nullable|numeric|min:0|max:100|required_if:type,PERCENTAGE',

            'account_interest_id' => 'nullable|exists:chart_of_accounts,id',
            'account_expense_id' => 'nullable|exists:chart_of_accounts,id',
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
            'name.required' => 'Nama pajak harus diisi.',
            'name.string' => 'Nama pajak harus berupa teks.',
            'name.max' => 'Nama pajak tidak boleh lebih dari 100 karakter.',
            'type.required' => 'Tipe pajak harus dipilih.',
            'type.in' => 'Tipe pajak harus berupa PERCENTAGE atau FIXED.',
            'rate.numeric' => 'Tarif pajak harus berupa angka.',
            'rate.min' => 'Tarif pajak tidak boleh kurang dari 0.',
            'rate.max' => 'Tarif pajak tidak boleh lebih dari 100.',
            'rate.required_if' => 'Tarif pajak harus diisi jika tipe adalah PERCENTAGE.',
            'account_interest_id.exists' => 'Akun pendapatan yang dipilih tidak valid.',
            'account_expense_id.exists' => 'Akun beban yang dipilih tidak valid.',
        ];
    }
}
