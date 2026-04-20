<?php

namespace App\Http\Requests\AccountingUsers;

use Illuminate\Foundation\Http\FormRequest;

class StoreIncomeRequest extends FormRequest
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
            'period_id'        => 'required|exists:periods,id',
            'sub_period_id'    => 'required|exists:sub_periods,id',
            'transaction_date' => 'required|date',
            'cash_coa_id'      => 'required|exists:chart_of_accounts,id',
            'description'      => 'nullable|string|max:255',

            // Income lines
            'income_lines'                => 'required|array|min:1',
            'income_lines.*.coa_id'      => 'required|exists:chart_of_accounts,id',
            'income_lines.*.amount'      => 'required|numeric|min:1',
            'income_lines.*.description' => 'nullable|string|max:255',

            // Tax lines - Gunakan '*' agar validasi spesifik ke elemen array
            'tax_lines'            => 'nullable|array',
            'tax_lines.*.tax_id'   => 'required|exists:taxes,id',
            'tax_lines.*.coa_id'   => 'required|exists:chart_of_accounts,id',
            'tax_lines.*.amount'   => 'required|numeric|min:0',

            // Interest lines
            'interest_lines'               => 'nullable|array',
            'interest_lines.*.interest_id' => 'required|exists:interests,id', // Langsung required karena berada di dalam array yang divalidasi
            // 'interest_lines.*.coa_id'      => 'required|exists:chart_of_accounts,id',
            'interest_lines.*.amount'      => 'required|numeric|min:0',
        ];
    }
}
