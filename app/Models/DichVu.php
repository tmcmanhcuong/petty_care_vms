<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DichVu extends Model
{
    use HasFactory;

    protected $table = 'dich_vus';

    protected $fillable = [
        'ten',
        'gia_tien',
        'thoi_gian_thuc_hien',
        'mo_ta',
        'trang_thai',
        'danh_muc_id',
    ];

    protected $casts = [
        'gia_tien' => 'decimal:2',
        'thoi_gian_thuc_hien' => 'integer',
    ];

    // Relationship: each service belongs to a category
    public function danhMuc()
    {
        return $this->belongsTo(DanhMucDichVu::class, 'danh_muc_id');
    }

    // Relationship: a service can have many appointments
    public function lichHens()
    {
        return $this->hasMany(LichHen::class, 'dich_vu_id');
    }
}
