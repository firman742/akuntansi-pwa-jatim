<?php

namespace App\Http\Requests\Superadmin\Configurations;

use Illuminate\Foundation\Http\FormRequest;

class UpdateConfigurationRequest extends FormRequest
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
            "app_name" => "required|string",
            "app_description" => "nullable|string",
            "app_tagline" => "required|string",
            "app_logo" => "nullable|file|mimes:jpg,jpeg,png,gif,svg|max:2048",
            "app_background_login" => "nullable|file|mimes:jpg,jpeg,png,gif,svg|max:2048",
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
            "app_name.required" => "Nama aplikasi wajib diisi.",
            "app_name.string" => "Nama aplikasi harus berupa teks.",
            "app_description.string" => "Deskripsi aplikasi harus berupa teks.",
            "app_tagline.string" => "Tagline aplikasi harus berupa teks.",
            "app_logo.file" => "Logo aplikasi harus berupa file.",
            "app_logo.mimes" => "Logo aplikasi harus berformat jpg, jpeg, png, gif, atau svg.",
            "app_logo.max" => "Ukuran logo aplikasi tidak boleh lebih dari 2MB.",
            "app_background_login.file" => "Background login harus berupa file.",
            "app_background_login.mimes" => "Background login harus berformat jpg, jpeg, png, gif, atau svg.",
            "app_background_login.max" => "Ukuran background login tidak boleh lebih dari 2MB.",
        ];
    }
}
