<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\KhachHangController;
use App\Models\KhachHang;


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
});
