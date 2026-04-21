<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreBinhLuanRequest extends FormRequest
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
            'noi_dung' => 'required|string|max:5000',
            'parent_id' => 'nullable|exists:binh_luans,id',
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
            'noi_dung.required' => 'Nội dung bình luận không được để trống',
            'noi_dung.string' => 'Nội dung bình luận phải là chuỗi ký tự',
            'noi_dung.max' => 'Nội dung bình luận không được vượt quá 5000 ký tự',
            'parent_id.exists' => 'Bình luận cha không tồn tại',
        ];
    }
}
