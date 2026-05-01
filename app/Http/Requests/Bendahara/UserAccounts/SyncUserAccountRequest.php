<?php

namespace App\Http\Requests\Bendahara\UserAccounts;

use Illuminate\Foundation\Http\FormRequest;

class SyncUserAccountRequest extends FormRequest
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
            'coa_ids' => ['nullable', 'array'],
            'coa_ids.*' => [
                'required',
                'distinct',
                'exists:chart_of_accounts,id'
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
            'coa_ids.array' => 'Daftar COA harus berupa array.',
            'coa_ids.*.required' => 'COA wajib dipilih.',
            'coa_ids.*.distinct' => 'COA tidak boleh duplikat.',
            'coa_ids.*.exists' => 'COA yang dipilih tidak valid.',
        ];
    }
}
