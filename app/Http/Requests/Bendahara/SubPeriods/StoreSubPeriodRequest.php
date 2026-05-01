<?php

namespace App\Http\Requests\Bendahara\SubPeriods;

use Illuminate\Foundation\Http\FormRequest;

class StoreSubPeriodRequest extends FormRequest
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
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'start_date' => 'required|date',
            'end_date' => 'required|date|after_or_equal:start_date',
            'is_active' => 'nullable|boolean',
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
            'name.required' => 'Nama sub-periode harus diisi.',
            'name.string' => 'Nama sub-periode harus berupa teks.',
            'name.max' => 'Nama sub-periode tidak boleh lebih dari 255 karakter.',
            'description.string' => 'Deskripsi harus berupa teks.',
            'start_date.required' => 'Tanggal mulai harus diisi.',
            'start_date.date' => 'Tanggal mulai harus berupa tanggal yang valid.',
            'end_date.required' => 'Tanggal selesai harus diisi.',
            'end_date.date' => 'Tanggal selesai harus berupa tanggal yang valid.',
            'end_date.after_or_equal' => 'Tanggal selesai harus sama dengan atau setelah tanggal mulai.',
            'is_active.boolean' => 'Status aktif harus berupa nilai true atau false.',
        ];
    }
}
