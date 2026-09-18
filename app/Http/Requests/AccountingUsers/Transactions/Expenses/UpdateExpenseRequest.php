<?php

namespace App\Http\Requests\AccountingUsers\Transactions\Expenses;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateExpenseRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'period_id' => ['required', 'exists:periods,id'],
            'sub_period_id' => [
                'required',
                'exists:sub_periods,id',
                Rule::exists('sub_periods', 'id')->where(function ($query) {
                    $query->where('period_id', $this->input('period_id'));
                }),
            ],
            'transaction_date' => ['required', 'date', 'before_or_equal:today'],
            'description' => ['nullable', 'string', 'max:255'],
            'expense_lines' => ['required', 'array', 'min:1'],
            'expense_lines.*.coa_id' => ['required_with:expense_lines', 'exists:chart_of_accounts,id'],
            'expense_lines.*.amount' => ['required_with:expense_lines', 'numeric', 'min:0.01'],
            'expense_lines.*.description' => ['nullable', 'string', 'max:255'],
            'user_account_balance_id' => ['required', 'exists:user_account_balances,id'],
            'status' => ['required', Rule::in(['DRAFT', 'POSTED'])],
            'proof_file' => ['nullable', 'file', 'mimes:jpeg,png,jpg,pdf', 'max:2048'],
        ];
    }

    public function messages(): array
    {
        return [
            'period_id.required' => 'Periode harus dipilih.',
            'sub_period_id.required' => 'Sub Periode harus dipilih.',
            'transaction_date.required' => 'Tanggal transaksi harus diisi.',
            'expense_lines.required' => 'Baris pengeluaran harus diisi.',
            'expense_lines.*.coa_id.required_with' => 'COA pada baris pengeluaran harus dipilih.',
            'expense_lines.*.coa_id.exists' => 'COA pada baris pengeluaran tidak valid.',
            'expense_lines.*.amount.required_with' => 'Jumlah pada baris pengeluaran harus diisi.',
            'expense_lines.*.amount.numeric' => 'Jumlah pada baris pengeluaran harus berupa angka.',
            'expense_lines.*.amount.min' => 'Jumlah pada baris pengeluaran harus minimal 0.01.',
            'expense_lines.*.description.string' => 'Deskripsi pada baris pengeluaran harus berupa teks.',
            'expense_lines.*.description.max' => 'Deskripsi pada baris pengeluaran tidak boleh lebih dari 255 karakter.',
            'user_account_balance_id.required' => 'Akun kas sumber harus dipilih.',
            'user_account_balance_id.exists' => 'Akun kas sumber tidak valid.',
            'status.required' => 'Status harus dipilih.',
            'proof_file.file' => 'Bukti transaksi harus berupa file.',
            'proof_file.mimes' => 'Bukti transaksi harus berupa file dengan format: jpeg, png, jpg, pdf.',
            'proof_file.max' => 'Bukti transaksi tidak boleh lebih dari 2MB.',
        ];
    }
}
