<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\KhachHangController;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\KhoaController;
use App\Http\Controllers\LichLamViecController;
use App\Http\Controllers\NhanVienController;
use App\Models\KhachHang;
use App\Http\Controllers\ThuCungController;
use App\Http\Controllers\LichHenController;
use App\Http\Controllers\DichVuController;
use App\Http\Controllers\DanhMucDichVuController;
use App\Http\Controllers\DanhMucHangHoaController;
use App\Http\Controllers\HangHoaController;
use App\Http\Controllers\PhanLoaiBaiVietController;
use App\Http\Controllers\BaiVietController;
use App\Http\Controllers\NhaCungCapController;
use App\Http\Controllers\PhieuNhapKhoController;


Route::post('/khach-hang/dang-ki', [KhachHangController::class, 'dangKi']);
Route::post('/khach-hang/dang-nhap', [KhachHangController::class, 'dangNhap']);


// Routes đăng nhập mạng xã hội
Route::get('/auth/google', [KhachHangController::class, 'redirectToGoogle']);
Route::get('/auth/google/callback', [KhachHangController::class, 'handleGoogleCallback']);
Route::get('/auth/facebook', [KhachHangController::class, 'redirectToFacebook']);
Route::get('/auth/facebook/callback', [KhachHangController::class, 'handleFacebookCallback']);

// Route xác thực Email
Route::get('/email/verify/{id}/{hash}', [KhachHangController::class, 'verifyEmail'])->name('verification.verify');

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', function (Request $request) {
        return response()->json([
            'status' => true,
            'data' => $request->user()
        ]);
    });

    Route::post('/khach-hang/cap-nhat', [KhachHangController::class, 'capNhat']);
    Route::put('/khach-hang/{id}', [KhachHangController::class, 'update']);

    // Thu cưng routes (require authentication)
    Route::get('/thu-cung', [ThuCungController::class, 'index']);
    Route::get('/thu-cung/{thuCung}', [ThuCungController::class, 'show']);
    Route::post('/thu-cung', [ThuCungController::class, 'store']);
    Route::put('/thu-cung/{thuCung}', [ThuCungController::class, 'update']);
    Route::patch('/thu-cung/{thuCung}', [ThuCungController::class, 'update']);
    Route::delete('/thu-cung/{thuCung}', [ThuCungController::class, 'destroy']);

    // Appointments (lich_hen)
    Route::post('/lich-hen', [LichHenController::class, 'store']);
    Route::get('/lich-hen', [LichHenController::class, 'index']);
    Route::get('/lich-hen/{lichHen}', [LichHenController::class, 'show']);
    Route::match(['put', 'patch'], '/lich-hen/{lichHen}', [LichHenController::class, 'update']);
    Route::patch('/lich-hen/{lichHen}/xac-nhan', [LichHenController::class, 'confirm']);
    Route::match(['put', 'patch'], '/lich-hen/{lichHen}/ngay-gio', [LichHenController::class, 'updateNgayGio']);
    Route::delete('/lich-hen/{lichHen}', [LichHenController::class, 'destroy']);
    // Lịch làm việc: tạo mới
    Route::post('/lich-lam-viec', [LichLamViecController::class, 'store']);
    // Lịch làm việc: list & view
    Route::get('/lich-lam-viec', [LichLamViecController::class, 'index']);
    Route::get('/lich-lam-viec/{lichLamViec}', [LichLamViecController::class, 'show']);
});

// Public: list services
Route::get('/dich-vu', [DichVuController::class, 'index']);
// Public: view single service
Route::get('/dich-vu/{dichVu}', [DichVuController::class, 'show']);

// Public: list and view service categories
Route::get('/danh-muc-dich-vu', [DanhMucDichVuController::class, 'index']);
Route::get('/danh-muc-dich-vu/{danhMucDichVu}', [DanhMucDichVuController::class, 'show']);

// Public: list and view product categories
Route::get('/danh-muc-hang-hoa', [DanhMucHangHoaController::class, 'index']);
Route::get('/danh-muc-hang-hoa/{danhMucHangHoa}', [DanhMucHangHoaController::class, 'show']);

// Public: list and view products
Route::get('/hang-hoa', [HangHoaController::class, 'index']);
Route::get('/hang-hoa/{hangHoa}', [HangHoaController::class, 'show']);

// Public: list and view article categories
Route::get('/phan-loai-bai-viet', [PhanLoaiBaiVietController::class, 'index']);
Route::get('/phan-loai-bai-viet/{phanLoaiBaiViet}', [PhanLoaiBaiVietController::class, 'show']);

// Public: list and view articles
Route::get('/bai-viet', [BaiVietController::class, 'index']);
Route::get('/bai-viet/{baiViet}', [BaiVietController::class, 'show']);

// Admin login route
Route::post('/admin/dang-nhap', [AdminController::class, 'dangNhap']);

// Admin authenticated routes
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/admin/dang-xuat', [AdminController::class, 'dangXuat']);

    // Khoa: tạo mới (chỉ admin)
    Route::post('/khoa', [KhoaController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Nhân viên: tạo mới (chỉ admin)
    Route::post('/nhan-vien', [NhanVienController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Nhân viên: đổi mật khẩu (chỉ admin)
    Route::patch('/nhan-vien/{nhanVien}/mat-khau', [NhanVienController::class, 'changePassword'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Nhân viên: khóa tài khoản (chỉ admin)
    Route::patch('/nhan-vien/{nhanVien}/khoa', [NhanVienController::class, 'lockAccount'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Nhân viên: mở khóa tài khoản (chỉ admin)
    Route::patch('/nhan-vien/{nhanVien}/mo-khoa', [NhanVienController::class, 'unlockAccount'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Nhân viên: danh sách (chỉ admin)
    Route::get('/nhan-vien', [NhanVienController::class, 'index'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Danh mục dịch vụ: tạo mới (chỉ admin)
    Route::post('/danh-muc-dich-vu', [\App\Http\Controllers\DanhMucDichVuController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Danh mục hàng hóa: tạo mới (chỉ admin)
    Route::post('/danh-muc-hang-hoa', [\App\Http\Controllers\DanhMucHangHoaController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Hàng hóa: tạo mới (chỉ admin)
    Route::post('/hang-hoa', [HangHoaController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Hàng hóa: cập nhật & xóa (chỉ admin)
    Route::match(['put', 'patch'], '/hang-hoa/{hangHoa}', [HangHoaController::class, 'update'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::delete('/hang-hoa/{hangHoa}', [HangHoaController::class, 'destroy'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Hàng hóa: đổi trạng thái (chỉ admin)
    Route::patch('/hang-hoa/{hangHoa}/trang-thai', [HangHoaController::class, 'changeStatus'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Dich vu: tạo mới (chỉ admin)
    Route::post('/dich-vu', [\App\Http\Controllers\DichVuController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Dich vu: update & delete (admin)
    Route::match(['put', 'patch'], '/dich-vu/{dichVu}', [\App\Http\Controllers\DichVuController::class, 'update'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::delete('/dich-vu/{dichVu}', [\App\Http\Controllers\DichVuController::class, 'destroy'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // File upload for admin (images etc.)
    Route::post('/upload', [\App\Http\Controllers\UploadController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::post('/upload-image', [\App\Http\Controllers\UploadController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Danh mục dịch vụ: xóa (chỉ admin)
    Route::delete('/danh-muc-dich-vu/{danhMucDichVu}', [\App\Http\Controllers\DanhMucDichVuController::class, 'destroy'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Danh mục hàng hoa: update & delete (admin)
    Route::match(['put', 'patch'], '/danh-muc-hang-hoa/{danhMucHangHoa}', [\App\Http\Controllers\DanhMucHangHoaController::class, 'update'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::delete('/danh-muc-hang-hoa/{danhMucHangHoa}', [\App\Http\Controllers\DanhMucHangHoaController::class, 'destroy'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Phân loại bài viết: tạo mới, cập nhật, xóa (chỉ admin)
    Route::post('/phan-loai-bai-viet', [PhanLoaiBaiVietController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::match(['put', 'patch'], '/phan-loai-bai-viet/{phanLoaiBaiViet}', [PhanLoaiBaiVietController::class, 'update'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::delete('/phan-loai-bai-viet/{phanLoaiBaiViet}', [PhanLoaiBaiVietController::class, 'destroy'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    // Bài viết: tạo mới, cập nhật, xóa (chỉ admin)
    Route::post('/bai-viet', [BaiVietController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::match(['put', 'patch'], '/bai-viet/{baiViet}', [BaiVietController::class, 'update'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::delete('/bai-viet/{baiViet}', [BaiVietController::class, 'destroy'])->middleware(\App\Http\Middleware\EnsureAdmin::class);

    // Nhà cung cấp: CRUD (chỉ admin)
    Route::get('/nha-cung-cap', [NhaCungCapController::class, 'index'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::get('/nha-cung-cap/{nhaCungCap}', [NhaCungCapController::class, 'show'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::post('/nha-cung-cap', [NhaCungCapController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::match(['put', 'patch'], '/nha-cung-cap/{nhaCungCap}', [NhaCungCapController::class, 'update'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::patch('/nha-cung-cap/{nhaCungCap}/trang-thai', [NhaCungCapController::class, 'changeStatus'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::delete('/nha-cung-cap/{nhaCungCap}', [NhaCungCapController::class, 'destroy'])->middleware(\App\Http\Middleware\EnsureAdmin::class);

    // Phiếu nhập kho: CRUD (chỉ admin)
    Route::get('/phieu-nhap-kho', [PhieuNhapKhoController::class, 'index'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::get('/phieu-nhap-kho/{phieuNhapKho}', [PhieuNhapKhoController::class, 'show'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::post('/phieu-nhap-kho', [PhieuNhapKhoController::class, 'store'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::patch('/phieu-nhap-kho/{phieuNhapKho}/trang-thai', [PhieuNhapKhoController::class, 'changeStatus'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::get('/phieu-nhap-kho/{phieuNhapKho}/pdf', [PhieuNhapKhoController::class, 'exportPdf'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
    Route::delete('/phieu-nhap-kho/{phieuNhapKho}', [PhieuNhapKhoController::class, 'destroy'])->middleware(\App\Http\Middleware\EnsureAdmin::class);
});
