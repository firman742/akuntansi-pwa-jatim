<?php

namespace App\Http\Requests\Bendahara\RequestBalances;

use Illuminate\Foundation\Http\FormRequest;

class ApproveRequestBalanceRequest extends FormRequest
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
            'approval_notes' => 'nullable|string|max:255',
            'source_coa_id' => 'required|exists:coa_balances,id',
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
            'approval_notes.string' => 'Catatan persetujuan harus berupa teks.',
            'approval_notes.max' => 'Catatan persetujuan tidak boleh lebih dari 255 karakter.',
            'source_coa_id.required' => 'CoA sumber harus dipilih.',
            'source_coa_id.exists' => 'CoA sumber yang dipilih tidak valid.',
        ];
    }
}
