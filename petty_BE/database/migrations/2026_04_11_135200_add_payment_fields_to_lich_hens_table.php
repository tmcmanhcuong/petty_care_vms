<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('lich_hens', function (Blueprint $table) {
            $table->decimal('tong_tien', 15, 2)->default(0)->after('nhan_vien_id')->comment('Tổng tiền dịch vụ');
            $table->boolean('da_thanh_toan')->default(false)->after('tong_tien')->comment('Đã thanh toán hay chưa');
            $table->string('phuong_thuc_thanh_toan', 50)->nullable()->after('da_thanh_toan')->comment('Phương thức thanh toán (momo, vnpay, cash, etc.)');
            $table->dateTime('thoi_gian_thanh_toan')->nullable()->after('phuong_thuc_thanh_toan')->comment('Thời gian thanh toán');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('lich_hens', function (Blueprint $table) {
            $table->dropColumn(['tong_tien', 'da_thanh_toan', 'phuong_thuc_thanh_toan', 'thoi_gian_thanh_toan']);
        });
    }
};
