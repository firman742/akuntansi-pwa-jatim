<?php

namespace App\Http\Requests\Bendahara\RequestCoas;

use Illuminate\Foundation\Http\FormRequest;

class RejectRequestCoaRequest extends FormRequest
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
            'rejection_reason' => 'required|string|max:255',
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
            'rejection_reason.required' => 'Alasan penolakan harus diisi.',
            'rejection_reason.string' => 'Alasan penolakan harus berupa teks.',
            'rejection_reason.max' => 'Alasan penolakan tidak boleh lebih dari 255 karakter.',
        ];
    }
}
