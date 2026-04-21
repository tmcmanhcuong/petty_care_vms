<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreReactionRequest extends FormRequest
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
            'loai' => 'required|in:like,dislike',
            'reactionable_type' => 'required|in:bai_viet,binh_luan',
            'reactionable_id' => 'required|integer|min:1',
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
            'loai.required' => 'Loại reaction không được để trống',
            'loai.in' => 'Loại reaction phải là like hoặc dislike',
            'reactionable_type.required' => 'Loại đối tượng không được để trống',
            'reactionable_type.in' => 'Loại đối tượng phải là bai_viet hoặc binh_luan',
            'reactionable_id.required' => 'ID đối tượng không được để trống',
            'reactionable_id.integer' => 'ID đối tượng phải là số nguyên',
            'reactionable_id.min' => 'ID đối tượng phải lớn hơn 0',
        ];
    }
}
