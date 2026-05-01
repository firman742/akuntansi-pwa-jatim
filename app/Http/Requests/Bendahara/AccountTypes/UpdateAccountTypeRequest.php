<?php

namespace App\Http\Requests\Bendahara\AccountTypes;

use Illuminate\Foundation\Http\FormRequest;

class UpdateAccountTypeRequest extends FormRequest
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
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'is_active' => 'required|boolean',
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
            'name.required' => 'Nama Tipe akun harus diisi.',
            'name.string' => 'Nama Tipe akun harus berupa teks.',
            'name.max' => 'Nama Tipe akun tidak boleh lebih dari 255 karakter.',
            'description.string' => 'Deskripsi harus berupa teks.',
            'is_active.required' => 'Status aktif harus diisi.',
            'is_active.boolean' => 'Status aktif harus berupa nilai true atau false.',
        ];
    }
}
