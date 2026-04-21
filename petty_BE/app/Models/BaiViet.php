<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BaiViet extends Model
{
    protected $table = 'bai_viets';

    protected $fillable = [
        'ten_bai_viet',
        'slug',
        'noi_dung',
        'mo_ta',
        'anh_bai_viet',
        'trang_thai',
        'nhan_vien_id',
        'phan_loai_bai_viet_id',
    ];

    // Relationships
    public function nhanVien()
    {
        return $this->belongsTo(NhanVien::class, 'nhan_vien_id');
    }

    public function phanLoai()
    {
        return $this->belongsTo(PhanLoaiBaiViet::class, 'phan_loai_bai_viet_id');
    }

    public function binhLuans()
    {
        return $this->hasMany(BinhLuan::class, 'bai_viet_id')->whereNull('parent_id')->where('trang_thai', 'active');
    }

    public function reactions()
    {
        return $this->morphMany(Reaction::class, 'reactionable');
    }
}
