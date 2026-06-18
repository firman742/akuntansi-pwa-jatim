<?php

namespace App\Http\Requests\Bendahara\RequestCoas;

use Illuminate\Foundation\Http\FormRequest;

class ApproveRequestCoaRequest extends FormRequest
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
            'approval_notes' => 'required|string|max:255',
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
            'approval_notes.required' => 'Catatan persetujuan harus diisi.',
            'approval_notes.string' => 'Catatan persetujuan harus berupa teks.',
            'approval_notes.max' => 'Catatan persetujuan tidak boleh lebih dari 255 karakter.',
        ];
    }
}
