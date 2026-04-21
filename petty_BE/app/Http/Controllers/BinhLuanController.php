<?php

namespace App\Http\Controllers;

use App\Models\BinhLuan;
use App\Models\BaiViet;
use Illuminate\Http\Request;

class BinhLuanController extends Controller
{
    /**
     * Get all comments for a post
     */
    public function index($baiVietId)
    {
        try {
            $baiViet = BaiViet::findOrFail($baiVietId);
            
            $binhLuans = BinhLuan::where('bai_viet_id', $baiVietId)
                ->whereNull('parent_id')
                ->where('trang_thai', 'active')
                ->with(['replies', 'reactions'])
                ->orderBy('created_at', 'desc')
                ->get();

            $binhLuans = $binhLuans->map(function ($comment) {
                return $this->formatComment($comment);
            });

            return response()->json([
                'status' => true,
                'message' => 'Lấy danh sách bình luận thành công',
                'data' => $binhLuans
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Lỗi khi lấy danh sách bình luận',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Store a new comment
     */
    public function store(Request $request, $baiVietId)
    {
        try {
            $validated = $request->validate([
                'noi_dung' => 'required|string',
                'parent_id' => 'nullable|exists:binh_luans,id',
            ]);

            $baiViet = BaiViet::findOrFail($baiVietId);
            $user = $request->user();

            $data = [
                'noi_dung' => $validated['noi_dung'],
                'bai_viet_id' => $baiVietId,
                'parent_id' => $validated['parent_id'] ?? null,
                'trang_thai' => 'active',
            ];

            // Determine user type
            if ($user instanceof \App\Models\KhachHang) {
                $data['khach_hang_id'] = $user->id;
            } elseif ($user instanceof \App\Models\NhanVien) {
                $data['nhan_vien_id'] = $user->id;
            }

            $binhLuan = BinhLuan::create($data);
            $binhLuan->load(['replies', 'reactions']);

            return response()->json([
                'status' => true,
                'message' => 'Tạo bình luận thành công',
                'data' => $this->formatComment($binhLuan)
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Lỗi khi tạo bình luận',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update a comment
     */
    public function update(Request $request, $id)
    {
        try {
            $validated = $request->validate([
                'noi_dung' => 'required|string',
            ]);

            $binhLuan = BinhLuan::findOrFail($id);
            $user = $request->user();

            // Check ownership
            if (($user instanceof \App\Models\KhachHang && $binhLuan->khach_hang_id !== $user->id) ||
                ($user instanceof \App\Models\NhanVien && $binhLuan->nhan_vien_id !== $user->id)) {
                return response()->json([
                    'status' => false,
                    'message' => 'Bạn không có quyền chỉnh sửa bình luận này'
                ], 403);
            }

            $binhLuan->update($validated);
            $binhLuan->load(['replies', 'reactions']);

            return response()->json([
                'status' => true,
                'message' => 'Cập nhật bình luận thành công',
                'data' => $this->formatComment($binhLuan)
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Lỗi khi cập nhật bình luận',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Delete a comment
     */
    public function destroy(Request $request, $id)
    {
        try {
            $binhLuan = BinhLuan::findOrFail($id);
            $user = $request->user();

            // Check ownership or admin
            $isOwner = ($user instanceof \App\Models\KhachHang && $binhLuan->khach_hang_id === $user->id) ||
                       ($user instanceof \App\Models\NhanVien && $binhLuan->nhan_vien_id === $user->id);
            
            $isAdmin = $user instanceof \App\Models\Admin || 
                       ($user instanceof \App\Models\NhanVien && $user->phanQuyen && $user->phanQuyen->ten_quyen === 'Admin');

            if (!$isOwner && !$isAdmin) {
                return response()->json([
                    'status' => false,
                    'message' => 'Bạn không có quyền xóa bình luận này'
                ], 403);
            }

            $binhLuan->delete();

            return response()->json([
                'status' => true,
                'message' => 'Xóa bình luận thành công'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Lỗi khi xóa bình luận',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Format comment data
     */
    private function formatComment($comment)
    {
        $likes = $comment->reactions->where('loai', 'like')->count();
        $dislikes = $comment->reactions->where('loai', 'dislike')->count();

        return [
            'id' => $comment->id,
            'noi_dung' => $comment->noi_dung,
            'bai_viet_id' => $comment->bai_viet_id,
            'parent_id' => $comment->parent_id,
            'trang_thai' => $comment->trang_thai,
            'author' => $comment->author,
            'replies' => $comment->replies->map(fn($reply) => $this->formatComment($reply)),
            'reactions' => [
                'likes' => $likes,
                'dislikes' => $dislikes,
            ],
            'created_at' => $comment->created_at,
            'updated_at' => $comment->updated_at,
        ];
    }
}
