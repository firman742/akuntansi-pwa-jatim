<?php

namespace App\Http\Requests\Superadmin\Users;

use Illuminate\Foundation\Http\FormRequest;

class UpdateUserRequest extends FormRequest
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
            'name'      => 'required|string|max:255',
            'no_telp'   => 'nullable|numeric|max_digits:15',
            'email'     => 'required|email|unique:users,email,' . $this->route('user'),
            'address'   => 'nullable|string',
            'role'      => 'required|exists:roles,name',
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
            'name.required' => 'Nama harus diisi.',
            'name.string' => 'Nama harus berupa teks.',
            'name.max' => 'Nama tidak boleh lebih dari 255 karakter.',
            'email.required' => 'Email harus diisi.',
            'email.email' => 'Email harus berupa alamat email yang valid.',
            'email.unique' => 'Email sudah digunakan. Silahkan ganti dengan email lain.',
            'no_telp.numeric' => 'No. Telepon harus berupa angka.',
            'no_telp.max_digits' => 'No. Telepon tidak boleh lebih dari 15 digit.',
            'address.string' => 'Alamat harus berupa teks.',
            'role.required' => 'Peran harus dipilih.',
            'role.exists' => 'Peran yang dipilih tidak valid.',
        ];
    }
}
