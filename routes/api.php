<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\KhachHangController;
use App\Models\KhachHang;
use App\Http\Controllers\ThuCungController;
use App\Http\Controllers\LichHenController;
use App\Http\Controllers\DichVuController;


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
    Route::patch('/lich-hen/{lichHen}/ngay-gio', [LichHenController::class, 'updateNgayGio']);
    Route::delete('/lich-hen/{lichHen}', [LichHenController::class, 'destroy']);
});

// Public: list services
Route::get('/dich-vu', [DichVuController::class, 'index']);
