<?php

namespace App\Http\Requests\Bendahara\UserAccountBalances;

use Illuminate\Foundation\Http\FormRequest;

class StoreUserAccountBalanceRequest extends FormRequest
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
            'user_account_id' => 'required|exists:user_accounts,id',
            'coa_balance_id' => 'required|exists:coa_balances,id',
            'period_id' => 'required|exists:periods,id',
            'sub_period_id' => 'required|exists:sub_periods,id',
            'allocated_balance' => 'required|numeric|min:0',
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
            'user_account_id.required' => 'Akun pengguna harus dipilih.',
            'user_account_id.exists' => 'Akun pengguna yang dipilih tidak valid.',
            'coa_balance_id.required' => 'Saldo COA harus dipilih.',
            'coa_balance_id.exists' => 'Saldo COA yang dipilih tidak valid.',
            'period_id.required' => 'Periode harus dipilih.',
            'period_id.exists' => 'Periode yang dipilih tidak valid.',
            'sub_period_id.required' => 'Sub periode harus dipilih.',
            'sub_period_id.exists' => 'Sub periode yang dipilih tidak valid.',
            'allocated_balance.required' => 'Saldo yang dialokasikan harus diisi.',
            'allocated_balance.numeric' => 'Saldo yang dialokasikan harus berupa angka.',
            'allocated_balance.min' => 'Saldo yang dialokasikan tidak boleh negatif.',
        ];
    }
}
