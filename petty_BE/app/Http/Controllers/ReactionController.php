<?php

namespace App\Http\Controllers;

use App\Models\Reaction;
use App\Models\BaiViet;
use App\Models\BinhLuan;
use Illuminate\Http\Request;

class ReactionController extends Controller
{
    /**
     * Toggle reaction on a post or comment
     */
    public function toggle(Request $request)
    {
        try {
            $validated = $request->validate([
                'loai' => 'required|in:like,dislike',
                'reactionable_type' => 'required|in:bai_viet,binh_luan',
                'reactionable_id' => 'required|integer',
            ]);

            $user = $request->user();
            
            // Map type to model class
            $modelClass = $validated['reactionable_type'] === 'bai_viet' 
                ? BaiViet::class 
                : BinhLuan::class;

            // Check if item exists
            $item = $modelClass::findOrFail($validated['reactionable_id']);

            // Prepare reaction data
            $reactionData = [
                'reactionable_type' => $modelClass,
                'reactionable_id' => $validated['reactionable_id'],
            ];

            // Determine user type
            if ($user instanceof \App\Models\KhachHang) {
                $reactionData['khach_hang_id'] = $user->id;
                $reactionData['nhan_vien_id'] = null;
            } elseif ($user instanceof \App\Models\NhanVien) {
                $reactionData['nhan_vien_id'] = $user->id;
                $reactionData['khach_hang_id'] = null;
            }

            // Find existing reaction
            $existingReaction = Reaction::where($reactionData)->first();

            if ($existingReaction) {
                // If same type, remove reaction
                if ($existingReaction->loai === $validated['loai']) {
                    $existingReaction->delete();
                    return response()->json([
                        'status' => true,
                        'message' => 'Đã bỏ reaction',
                        'action' => 'removed'
                    ]);
                } else {
                    // If different type, update reaction
                    $existingReaction->update(['loai' => $validated['loai']]);
                    return response()->json([
                        'status' => true,
                        'message' => 'Đã cập nhật reaction',
                        'action' => 'updated',
                        'data' => $existingReaction
                    ]);
                }
            } else {
                // Create new reaction
                $reactionData['loai'] = $validated['loai'];
                $reaction = Reaction::create($reactionData);
                
                return response()->json([
                    'status' => true,
                    'message' => 'Đã thêm reaction',
                    'action' => 'created',
                    'data' => $reaction
                ], 201);
            }
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Lỗi khi xử lý reaction',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get reactions for a post or comment
     */
    public function index(Request $request)
    {
        try {
            $validated = $request->validate([
                'reactionable_type' => 'required|in:bai_viet,binh_luan',
                'reactionable_id' => 'required|integer',
            ]);

            $modelClass = $validated['reactionable_type'] === 'bai_viet' 
                ? BaiViet::class 
                : BinhLuan::class;

            $reactions = Reaction::where('reactionable_type', $modelClass)
                ->where('reactionable_id', $validated['reactionable_id'])
                ->get();

            $summary = [
                'likes' => $reactions->where('loai', 'like')->count(),
                'dislikes' => $reactions->where('loai', 'dislike')->count(),
                'total' => $reactions->count(),
            ];

            return response()->json([
                'status' => true,
                'message' => 'Lấy thông tin reaction thành công',
                'data' => $summary
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Lỗi khi lấy thông tin reaction',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
