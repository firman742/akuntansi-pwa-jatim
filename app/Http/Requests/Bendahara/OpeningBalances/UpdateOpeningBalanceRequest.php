<?php

namespace App\Http\Requests\Bendahara\OpeningBalances;

use Illuminate\Foundation\Http\FormRequest;

class UpdateOpeningBalanceRequest extends FormRequest
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
            'amount' => 'required|numeric|min:0', // Ini adalah saldo sisa/akhir periode lalu
            'correction_reason' => 'required|string|max:255', // Alasan koreksi wajib diisi
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
            'amount.required' => 'Jumlah saldo harus diisi.',
            'amount.numeric' => 'Jumlah saldo harus berupa angka.',
            'amount.min' => 'Jumlah saldo tidak boleh negatif.',
            'correction_reason.required' => 'Alasan koreksi harus diisi.',
            'correction_reason.string' => 'Alasan koreksi harus berupa teks.',
            'correction_reason.max' => 'Alasan koreksi tidak boleh lebih dari 255 karakter.',
        ];
    }
}
