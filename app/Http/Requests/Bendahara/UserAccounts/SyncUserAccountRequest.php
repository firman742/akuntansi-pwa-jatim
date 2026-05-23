<?php

namespace App\Http\Requests\Bendahara\UserAccounts;

use App\Models\ChartOfAccount;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\ValidationException;

class SyncUserAccountRequest extends FormRequest
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
            'coa_ids' => ['nullable', 'array'],
            'coa_ids.*' => [
                'required',
                'distinct',
                'exists:chart_of_accounts,id'
            ],
        ];
    }

    /**
     *
     * @return void
     */
    protected function passedValidation(): void
    {
        $coas = ChartOfAccount::whereIn(
            'id',
            $this->coa_ids
        )->get();

        $hasDebit = $coas->contains(function ($coa) {
            return strtoupper($coa->normal_balance) === 'DEBIT';
        });

        $hasCredit = $coas->contains(function ($coa) {
            return strtoupper($coa->normal_balance) === 'CREDIT';
        });

        if (!$hasDebit || !$hasCredit) {

            throw ValidationException::withMessages([
                'coa_ids' => 'Minimal harus memilih 1 akun Debit dan 1 akun Credit.'
            ]);
        }
    }

    /**
     * Get custom messages for validator errors.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'coa_ids.array' => 'Daftar COA harus berupa array.',
            'coa_ids.*.required' => 'COA wajib dipilih.',
            'coa_ids.*.distinct' => 'COA tidak boleh duplikat.',
            'coa_ids.*.exists' => 'COA yang dipilih tidak valid.',
        ];
    }
}
