<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class NhanVien extends Model
{
    /**
     * Khoa relationship (many-to-many)
     */
    public function khoas()
    {
        return $this->belongsToMany('App\\Models\\Khoa', 'khoa_nhan_vien', 'nhan_vien_id', 'khoa_id');
    }
}
