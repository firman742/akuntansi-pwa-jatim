<?php

namespace App\Http\Requests\Bendahara\Coas;

use App\Enums\NormalBalanceEnum;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreCOARequest extends FormRequest
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
            'name' => 'required|string|max:255|unique:chart_of_accounts,name',
            'account_type_id' => 'required|exists:account_types,id',
            'parent_id' => 'nullable|exists:chart_of_accounts,id',
            'description' => 'nullable|string',
            'is_active' => 'boolean',
            'normal_balance' => [
                'required',
                Rule::in(NormalBalanceEnum::values()),
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
            'name.required' => 'Nama akun harus diisi.',
            'name.string' => 'Nama akun harus berupa teks.',
            'name.max' => 'Nama akun tidak boleh lebih dari 255 karakter.',
            'name.unique' => 'Nama akun sudah digunakan. Silahkan ganti dengan nama lain.',
            'account_type_id.required' => 'Tipe akun harus dipilih.',
            'account_type_id.exists' => 'Tipe akun yang dipilih tidak valid.',
            'parent_id.exists' => 'Akun induk yang dipilih tidak valid.',
            'description.string' => 'Deskripsi harus berupa teks.',
            'is_active.boolean' => 'Status aktif harus berupa nilai true atau false.',
            'normal_balance.required' => 'Saldo normal harus dipilih.',
            'normal_balance.in' => 'Saldo normal harus bernilai debit atau credit.',
        ];
    }
}
