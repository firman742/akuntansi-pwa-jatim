<?php

namespace App\Http\Requests\AccountingUsers\Transactions\Incomes;

use Illuminate\Foundation\Http\FormRequest;

class UpdateIncomeRequest extends FormRequest
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
            'period_id' => 'required|exists:periods,id',
            'sub_period_id' => 'required|exists:sub_periods,id',
            'transaction_date' => 'required|date',
            'user_account_balance_id' => 'required|exists:user_account_balances,id',
            'income_coa_id' => 'required|exists:chart_of_accounts,id',
            'amount' => 'required|numeric|min:0.01',
            'description' => 'required|string|max:255',
            'proof_file' => 'nullable|file|mimes:jpeg,png,jpg,webp,pdf|max:2048',
        ];
    }

    /**
     * Get custom error messages for validation rules.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'period_id.required' => 'Periode harus dipilih.',
            'period_id.exists' => 'Periode yang dipilih tidak valid.',
            'sub_period_id.required' => 'Sub Periode harus dipilih.',
            'sub_period_id.exists' => 'Sub Periode yang dipilih tidak valid.',
            'transaction_date.required' => 'Tanggal transaksi harus diisi.',
            'transaction_date.date' => 'Tanggal transaksi tidak valid.',
            'user_account_balance_id.required' => 'Akun kas harus dipilih.',
            'user_account_balance_id.exists' => 'Akun kas yang dipilih tidak valid.',
            'income_coa_id.required' => 'Akun pendapatan harus dipilih.',
            'income_coa_id.exists' => 'Akun pendapatan yang dipilih tidak valid.',
            'amount.required' => 'Jumlah harus diisi.',
            'amount.numeric' => 'Jumlah harus berupa angka.',
            'amount.min' => 'Jumlah harus lebih besar dari 0.',
            'description.required' => 'Deskripsi harus diisi.',
            'description.string' => 'Deskripsi harus berupa teks.',
            'description.max' => 'Deskripsi maksimal 255 karakter.',
            'proof_file.file' => 'File bukti harus berupa file yang valid.',
            'proof_file.mimes' => 'File bukti harus berupa file dengan format: jpeg, png, jpg, webp, pdf.',
            'proof_file.max' => 'Ukuran file bukti maksimal 2MB.',
        ];
    }
}
