<?php

namespace App\Http\Controllers;

use App\Models\NhaCungCap;
use App\Http\Requests\StoreNhaCungCapRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class NhaCungCapController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        try {
            $nhaCungCaps = NhaCungCap::orderBy('created_at', 'desc')->get();

            return response()->json([
                'status' => true,
                'message' => 'Lấy danh sách nhà cung cấp thành công',
                'data' => $nhaCungCaps
            ], 200);
        } catch (\Exception $e) {
            Log::error('Lỗi khi lấy danh sách nhà cung cấp: ' . $e->getMessage());

            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra khi lấy danh sách nhà cung cấp',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreNhaCungCapRequest $request): JsonResponse
    {
        try {
            DB::beginTransaction();

            $nhaCungCap = NhaCungCap::create([
                'ma_nha_cung_cap' => $request->ma_nha_cung_cap,
                'ten_nha_cung_cap' => $request->ten_nha_cung_cap,
                'ten_nguoi_lien_he' => $request->ten_nguoi_lien_he,
                'so_dien_thoai' => $request->so_dien_thoai,
                'dia_chi' => $request->dia_chi,
                'email' => $request->email,
                'ma_so_thue' => $request->ma_so_thue,
                'mo_ta' => $request->mo_ta,
                'trang_thai' => $request->trang_thai ?? 'hoat_dong',
            ]);

            DB::commit();

            return response()->json([
                'status' => true,
                'message' => 'Thêm nhà cung cấp thành công',
                'data' => $nhaCungCap
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Lỗi khi thêm nhà cung cấp: ' . $e->getMessage());

            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra khi thêm nhà cung cấp',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(NhaCungCap $nhaCungCap): JsonResponse
    {
        try {
            // Load relationships if needed
            $nhaCungCap->load('phieuNhapKhos');

            return response()->json([
                'status' => true,
                'message' => 'Lấy thông tin nhà cung cấp thành công',
                'data' => $nhaCungCap
            ], 200);
        } catch (\Exception $e) {
            Log::error('Lỗi khi lấy thông tin nhà cung cấp: ' . $e->getMessage());

            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra khi lấy thông tin nhà cung cấp',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, NhaCungCap $nhaCungCap): JsonResponse
    {
        try {
            $validated = $request->validate([
                'ma_nha_cung_cap' => 'sometimes|required|string|max:50|unique:nha_cung_caps,ma_nha_cung_cap,' . $nhaCungCap->id,
                'ten_nha_cung_cap' => 'sometimes|required|string|max:255',
                'ten_nguoi_lien_he' => 'sometimes|required|string|max:255',
                'so_dien_thoai' => 'sometimes|required|string|max:15|regex:/^[0-9+\-\s()]+$/',
                'dia_chi' => 'sometimes|required|string',
                'email' => 'sometimes|required|email|unique:nha_cung_caps,email,' . $nhaCungCap->id,
                'ma_so_thue' => 'sometimes|required|string|max:50',
                'mo_ta' => 'sometimes|required|string',
                'trang_thai' => 'sometimes|in:hoat_dong,ngung_hoat_dong',
            ]);

            DB::beginTransaction();

            $nhaCungCap->update($validated);

            DB::commit();

            return response()->json([
                'status' => true,
                'message' => 'Cập nhật nhà cung cấp thành công',
                'data' => $nhaCungCap
            ], 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'status' => false,
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Lỗi khi cập nhật nhà cung cấp: ' . $e->getMessage());

            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra khi cập nhật nhà cung cấp',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(NhaCungCap $nhaCungCap): JsonResponse
    {
        try {
            DB::beginTransaction();

            // Kiểm tra xem nhà cung cấp có phiếu nhập kho nào không
            if ($nhaCungCap->phieuNhapKhos()->count() > 0) {
                return response()->json([
                    'status' => false,
                    'message' => 'Không thể xóa nhà cung cấp này vì đã có phiếu nhập kho liên quan'
                ], 400);
            }

            $nhaCungCap->delete();

            DB::commit();

            return response()->json([
                'status' => true,
                'message' => 'Xóa nhà cung cấp thành công'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Lỗi khi xóa nhà cung cấp: ' . $e->getMessage());

            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra khi xóa nhà cung cấp',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Change status of supplier (hoat_dong <-> ngung_hoat_dong)
     */
    public function changeStatus(NhaCungCap $nhaCungCap): JsonResponse
    {
        try {
            DB::beginTransaction();

            // Đổi trạng thái
            $newStatus = $nhaCungCap->trang_thai === 'hoat_dong' ? 'ngung_hoat_dong' : 'hoat_dong';
            $nhaCungCap->trang_thai = $newStatus;
            $nhaCungCap->save();

            DB::commit();

            $statusText = $newStatus === 'hoat_dong' ? 'hoạt động' : 'ngừng hoạt động';

            return response()->json([
                'status' => true,
                'message' => "Đã chuyển nhà cung cấp sang trạng thái {$statusText}",
                'data' => $nhaCungCap
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Lỗi khi đổi trạng thái nhà cung cấp: ' . $e->getMessage());

            return response()->json([
                'status' => false,
                'message' => 'Có lỗi xảy ra khi đổi trạng thái nhà cung cấp',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
