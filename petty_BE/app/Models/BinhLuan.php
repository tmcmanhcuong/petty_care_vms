<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BinhLuan extends Model
{
    protected $table = 'binh_luans';

    protected $fillable = [
        'noi_dung',
        'bai_viet_id',
        'khach_hang_id',
        'nhan_vien_id',
        'parent_id',
        'trang_thai',
    ];

    protected $with = ['khachHang', 'nhanVien'];

    // Relationships
    public function baiViet()
    {
        return $this->belongsTo(BaiViet::class, 'bai_viet_id');
    }

    public function khachHang()
    {
        return $this->belongsTo(KhachHang::class, 'khach_hang_id');
    }

    public function nhanVien()
    {
        return $this->belongsTo(NhanVien::class, 'nhan_vien_id');
    }

    public function parent()
    {
        return $this->belongsTo(BinhLuan::class, 'parent_id');
    }

    public function replies()
    {
        return $this->hasMany(BinhLuan::class, 'parent_id')->where('trang_thai', 'active');
    }

    public function reactions()
    {
        return $this->morphMany(Reaction::class, 'reactionable');
    }

    // Helper to get author info
    public function getAuthorAttribute()
    {
        if ($this->khach_hang_id) {
            return [
                'type' => 'khach_hang',
                'id' => $this->khachHang->id,
                'ten' => $this->khachHang->ten_khach_hang,
                'anh_dai_dien' => $this->khachHang->anh_dai_dien,
            ];
        } elseif ($this->nhan_vien_id) {
            return [
                'type' => 'nhan_vien',
                'id' => $this->nhanVien->id,
                'ten' => $this->nhanVien->ten_nhan_vien,
                'anh_dai_dien' => $this->nhanVien->anh_dai_dien,
            ];
        }
        return null;
    }
}
