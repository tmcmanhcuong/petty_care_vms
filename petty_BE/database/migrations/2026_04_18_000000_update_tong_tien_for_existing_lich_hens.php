<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Cập nhật tong_tien cho các lịch hẹn đã tồn tại mà chưa có giá
        DB::statement("
            UPDATE lich_hens lh
            INNER JOIN dich_vus dv ON lh.dich_vu_id = dv.id
            SET lh.tong_tien = dv.gia_tien
            WHERE lh.tong_tien IS NULL OR lh.tong_tien = 0
        ");
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Không cần rollback vì đây là data fix
    }
};
