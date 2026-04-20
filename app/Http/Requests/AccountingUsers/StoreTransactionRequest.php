<?php

namespace App\Http\Requests\AccountingUsers;

use App\Enums\TransactionType;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\Enum;

class StoreTransactionRequest extends FormRequest
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

            // ── COMMON ───────────────────────────────────────────
            'type' => ['required', Rule::in(TransactionType::values())],
            'period_id'        => 'required|exists:periods,id',
            'sub_period_id'    => 'required|exists:sub_periods,id',
            'transaction_date' => 'required|date',
            'description'      => 'nullable|string|max:255',

            /*
        |--------------------------------------------------------------------------
        | 🔹 INCOME
        |--------------------------------------------------------------------------
        */

            'cash_coa_id' => [
                'required_if:type,' . TransactionType::INCOME->value . ',' . TransactionType::EXPENSE->value,
                'exists:chart_of_accounts,id'
            ],

            'income_lines' => [
                'required_if:type,' . TransactionType::INCOME->value,
                'array',
                'min:1'
            ],
            'income_lines.*.coa_id' => 'required_with:income_lines|exists:chart_of_accounts,id',
            'income_lines.*.amount' => 'required_with:income_lines|numeric|min:1',
            'income_lines.*.description' => 'nullable|string|max:255',

            'interest_lines' => 'nullable|array',
            'interest_lines.*.interest_id' => 'required_with:interest_lines|exists:interests,id',
            'interest_lines.*.coa_id' => 'required_with:interest_lines|exists:chart_of_accounts,id',
            'interest_lines.*.amount' => 'required_with:interest_lines|numeric|min:0',

            'tax_lines' => 'nullable|array',
            'tax_lines.*.tax_id' => 'required_with:tax_lines|exists:taxes,id',
            'tax_lines.*.coa_id' => 'required_with:tax_lines|exists:chart_of_accounts,id',
            'tax_lines.*.amount' => 'required_with:tax_lines|numeric|min:0',

            /*
        |--------------------------------------------------------------------------
        | 🔹 EXPENSE
        |--------------------------------------------------------------------------
        */

            'expense_lines' => [
                'required_if:type,' . TransactionType::EXPENSE->value,
                'array',
                'min:1'
            ],
            'expense_lines.*.coa_id' => 'required_with:expense_lines|exists:chart_of_accounts,id',
            'expense_lines.*.amount' => 'required_with:expense_lines|numeric|min:1',
            'expense_lines.*.description' => 'nullable|string|max:255',

            /*
        |--------------------------------------------------------------------------
        | 🔹 TRANSFER
        |--------------------------------------------------------------------------
        */

            'from_coa_id' => [
                'required_if:type,' . TransactionType::TRANSFER->value,
                'exists:chart_of_accounts,id'
            ],
            'to_coa_id' => [
                'required_if:type,' . TransactionType::TRANSFER->value,
                'exists:chart_of_accounts,id'
            ],
            'amount' => [
                'required_if:type,' . TransactionType::TRANSFER->value,
                'numeric',
                'min:1'
            ],
        ];
    }
}
