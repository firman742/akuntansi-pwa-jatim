<?php

namespace App\Http\Requests\Bendahara\RequestBalances;

use Illuminate\Foundation\Http\FormRequest;

class RejectRequestBalanceRequest extends FormRequest
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
            'rejection_notes' => 'nullable|string|max:255',
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
            'rejection_notes.string' => 'Catatan penolakan harus berupa teks.',
            'rejection_notes.max' => 'Catatan penolakan tidak boleh lebih dari 255 karakter.',
        ];
    }
}
