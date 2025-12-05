<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PhieuChi extends Model
{
    protected $table = 'phieu_chis';

    protected $fillable = [
        'ma_phieu_chi',
        'so_tien',
        'ly_do',
        'ngay_chi',
        'nguoi_nhan',
        'ghi_chu',
        'trang_thai',
        'nhan_vien_id',
    ];

    protected $casts = [
        'ngay_chi' => 'date',
        'so_tien' => 'decimal:2',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    /**
     * Quan hệ với bảng NhanVien
     */
    public function nhanVien(): BelongsTo
    {
        return $this->belongsTo(NhanVien::class, 'nhan_vien_id');
    }

    /**
     * Quan hệ với bảng PhieuNhapKho
     */
    public function phieuNhapKhos(): HasMany
    {
        return $this->hasMany(PhieuNhapKho::class, 'phieu_chi_id');
    }
}
