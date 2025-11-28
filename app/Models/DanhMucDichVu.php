<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Khoa;

class DanhMucDichVu extends Model
{
    /**
     * Khoa relationship (many-to-many)
     */
    public function khoas()
    {
        return $this->belongsToMany('App\\Models\\Khoa', 'danh_muc_dich_vu_khoa', 'danh_muc_dich_vu_id', 'khoa_id');
    }
}
