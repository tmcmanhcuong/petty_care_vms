<?php

namespace App\Http\Controllers;

use App\Http\Requests\ChatbotMessageRequest;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class ChatbotController extends Controller
{
    public function message(ChatbotMessageRequest $request): JsonResponse
    {
        $apiKey = config('services.together.api_key');
        $model = config('services.together.model', 'meta-llama/Llama-4-Maverick-17B-128E-Instruct-FP8');

        if (! $apiKey) {
            return response()->json([
                'status' => false,
                'message' => 'Chưa cấu hình Together API key ở backend.',
            ], 500);
        }

        $validated = $request->validated();
        $history = collect($validated['history'] ?? [])
            ->map(function ($item) {
                return [
                    'role' => $item['role'],
                    'content' => $item['content'],
                ];
            })
            ->values()
            ->all();

        $images = collect($validated['images'] ?? [])
            ->map(function ($imageData) {
                return [
                    'type' => 'image_url',
                    'image_url' => [
                        'url' => $imageData,
                    ],
                ];
            })
            ->values()
            ->all();

        $systemPrompt = 'Bạn là trợ lý tư vấn chăm sóc thú cưng (chó, mèo và thú cưng phổ biến). '
            . 'Chỉ trả lời về chăm sóc thú cưng: dinh dưỡng, vệ sinh, hành vi, huấn luyện cơ bản, môi trường sống, dấu hiệu sức khỏe cần lưu ý. '
            . 'Nếu câu hỏi không liên quan thú cưng, từ chối lịch sự và nhắc người dùng hỏi đúng chủ đề. '
            . 'Không đưa chẩn đoán y khoa chắc chắn; với dấu hiệu nghiêm trọng hãy khuyên đi bác sĩ thú y. '
            . 'Trả lời ngắn gọn, dễ hiểu, có bước hành động cụ thể.';

        $userText = trim((string) ($validated['message'] ?? ''));
        $userContent = [];

        if ($userText !== '') {
            $userContent[] = [
                'type' => 'text',
                'text' => $userText,
            ];
        }

        if (! empty($images)) {
            $userContent = array_merge($userContent, $images);
        }

        if (empty($userContent)) {
            $userContent[] = [
                'type' => 'text',
                'text' => 'Nhờ bạn xem ảnh thú cưng này giúp mình.',
            ];
        }

        $messages = array_merge(
            [['role' => 'system', 'content' => $systemPrompt]],
            $history,
            [['role' => 'user', 'content' => $userContent]]
        );

        try {
            $response = Http::withToken($apiKey)
                ->timeout(30)
                ->post('https://api.together.xyz/v1/chat/completions', [
                    'model' => $model,
                    'messages' => $messages,
                ]);

            if (! $response->ok()) {
                $error = $response->json('error.message') ?: ('Together API Error: ' . $response->status());

                return response()->json([
                    'status' => false,
                    'message' => $error,
                ], 502);
            }

            $reply = data_get($response->json(), 'choices.0.message.content', 'Không có nội dung phản hồi.');

            return response()->json([
                'status' => true,
                'reply' => $reply,
            ]);
        } catch (\Throwable $e) {
            Log::error('Chatbot message failed', [
                'message' => $e->getMessage(),
            ]);

            return response()->json([
                'status' => false,
                'message' => 'Không thể kết nối chatbot lúc này. Vui lòng thử lại sau.',
            ], 500);
        }
    }
}
