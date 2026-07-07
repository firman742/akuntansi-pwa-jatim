<?php

namespace App\Http\Requests\AccountingUsers\Transactions\Expenses;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreExpenseRequest extends FormRequest
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
            'period_id'        => [
                'required',
                'exists:periods,id',
            ],
            'sub_period_id'    => [
                'required',
                'exists:sub_periods,id',
                Rule::exists('sub_periods', 'id')->where(function ($query) {
                    $query->where('period_id', $this->input('period_id'));
                }),
            ],
            'transaction_date' => [
                'required',
                'date',
                'before_or_equal:today',
            ],
            'description'      => [
                'nullable',
                'string',
                'max:255',
            ],
            'expense_lines' => [
                'required',
                'array',
                'min:1'
            ],
            'expense_lines.*.coa_id' => [
                'required_with:expense_lines',
                'exists:chart_of_accounts,id'
            ],
            'expense_lines.*.amount' => [
                'required_with:expense_lines',
                'numeric',
                'min:0.01'
            ],
            'expense_lines.*.description' => [
                'nullable',
                'string',
                'max:255'
            ],
            'user_account_balance_id' => [
                'required',
                'exists:user_account_balances,id'
            ],
            'status' => [
                'required',
                Rule::in(['DRAFT', 'POSTED'])
            ]
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
            'period_id.required' => 'Periode harus dipilih.',
            'period_id.exists' => 'Periode yang dipilih tidak valid.',
            'sub_period_id.required' => 'Sub Periode harus dipilih.',
            'sub_period_id.exists' => 'Sub Periode yang dipilih tidak valid untuk periode yang dipilih.',
            'transaction_date.required' => 'Tanggal transaksi harus diisi.',
            'transaction_date.date' => 'Tanggal transaksi harus berupa tanggal yang valid.',
            'transaction_date.before_or_equal' => 'Tanggal transaksi tidak boleh di masa depan.',
            'description.string' => 'Deskripsi harus berupa teks.',
            'description.max' => 'Deskripsi tidak boleh lebih dari 255 karakter.',
            'expense_lines.required' => 'Baris pengeluaran harus diisi.',
            'expense_lines.array' => 'Baris pengeluaran harus berupa array.',
            'expense_lines.min' => 'Setidaknya harus ada satu baris pengeluaran.',
            'expense_lines.*.coa_id.required_with' => 'Chart of Account harus dipilih untuk setiap baris pengeluaran.',
            'expense_lines.*.coa_id.exists' => 'Chart of Account yang dipilih tidak valid.',
            'expense_lines.*.amount.required_with' => 'Jumlah harus diisi untuk setiap baris pengeluaran.',
            'expense_lines.*.amount.numeric' => 'Jumlah harus berupa angka.',
            'expense_lines.*.amount.min' => 'Jumlah minimal adalah 0.01.',
            'expense_lines.*.description.string' => 'Deskripsi baris pengeluaran harus berupa teks.',
            'expense_lines.*.description.max' => 'Deskripsi baris pengeluaran tidak boleh lebih dari 255 karakter.',
            'user_account_balance_id.required' => 'Akun pengguna harus dipilih.',
            'user_account_balance_id.exists' => 'Akun pengguna yang dipilih tidak valid.'
        ];
    }
}
