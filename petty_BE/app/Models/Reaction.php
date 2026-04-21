<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Reaction extends Model
{
    protected $table = 'reactions';

    protected $fillable = [
        'loai',
        'reactionable_type',
        'reactionable_id',
        'khach_hang_id',
        'nhan_vien_id',
    ];

    // Polymorphic relationship
    public function reactionable()
    {
        return $this->morphTo();
    }

    public function khachHang()
    {
        return $this->belongsTo(KhachHang::class, 'khach_hang_id');
    }

    public function nhanVien()
    {
        return $this->belongsTo(NhanVien::class, 'nhan_vien_id');
    }
}
