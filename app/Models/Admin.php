<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable;

class Admin extends Model
{
    use HasApiTokens, Notifiable;
    protected $fillable = [
        'ho_ten',
        'anh_dai_dien',
        'mat_khau',
        'email',
        'so_dien_thoai',
        'dia_chi',
        'trang_thai',
    ];

    protected $hidden = [
        'mat_khau',
    ];

    protected $casts = [
        'trang_thai' => 'integer',
    ];
}
