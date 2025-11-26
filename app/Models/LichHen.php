<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LichHen extends Model
{
    use HasFactory;

    protected $table = 'lich_hens';

    protected $fillable = [
        'ngay_gio',
        'ghi_chu',
        'huong_dan',
        'trang_thai',
        'khach_hang_id',
        'thu_cung_id',
        'dich_vu_id',
        'thanh_toan_id',
        'nhan_vien_id',
    ];

    protected $casts = [
        'ngay_gio' => 'datetime',
    ];

    // Relationships
    public function khachHang()
    {
        return $this->belongsTo(KhachHang::class, 'khach_hang_id');
    }

    public function thuCung()
    {
        return $this->belongsTo(ThuCung::class, 'thu_cung_id');
    }

    public function dichVu()
    {
        return $this->belongsTo(DichVu::class, 'dich_vu_id');
    }

    public function thanhToan()
    {
        return $this->belongsTo(ThanhToan::class, 'thanh_toan_id');
    }

    public function nhanVien()
    {
        return $this->belongsTo(NhanVien::class, 'nhan_vien_id');
    }
}
