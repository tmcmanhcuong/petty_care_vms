<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DichVuSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Clear table first
        DB::table('dich_vus')->delete();
        // Temporarily disable foreign key checks so we can truncate when other tables
        // (like lich_hens) reference this table.
        DB::statement('SET FOREIGN_KEY_CHECKS=0');
        DB::table('dich_vus')->truncate();
        DB::statement('SET FOREIGN_KEY_CHECKS=1');

        $now = now();

        DB::table('dich_vus')->insert([
            [
                'ten' => 'Khám tổng quát',
                'gia_tien' => 200000.00,
                'thoi_gian_thuc_hien' => 30,
                'mo_ta' => 'Khám sức khỏe tổng quát cho thú cưng',
                'trang_thai' => 'active',
                'danh_muc_id' => null,
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'ten' => 'Vệ sinh tai',
                'gia_tien' => 80000.00,
                'thoi_gian_thuc_hien' => 15,
                'mo_ta' => 'Làm sạch tai, kiểm tra nhiễm trùng',
                'trang_thai' => 'active',
                'danh_muc_id' => null,
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'ten' => 'Cắt tỉa lông',
                'gia_tien' => 150000.00,
                'thoi_gian_thuc_hien' => 45,
                'mo_ta' => 'Grooming cơ bản: tắm, sấy, cắt tỉa',
                'trang_thai' => 'active',
                'danh_muc_id' => null,
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'ten' => 'Tiêm phòng cơ bản',
                'gia_tien' => 300000.00,
                'thoi_gian_thuc_hien' => 10,
                'mo_ta' => 'Tiêm phòng định kỳ (vắc-xin cơ bản)',
                'trang_thai' => 'active',
                'danh_muc_id' => null,
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'ten' => 'Khám nha khoa',
                'gia_tien' => 180000.00,
                'thoi_gian_thuc_hien' => 30,
                'mo_ta' => 'Kiểm tra răng miệng, làm sạch cao răng cơ bản',
                'trang_thai' => 'active',
                'danh_muc_id' => null,
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'ten' => 'Phẫu thuật nhỏ',
                'gia_tien' => 1200000.00,
                'thoi_gian_thuc_hien' => 120,
                'mo_ta' => 'Phẫu thuật nhỏ dưới gây mê',
                'trang_thai' => 'inactive',
                'danh_muc_id' => null,
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'ten' => 'Siêu âm',
                'gia_tien' => 350000.00,
                'thoi_gian_thuc_hien' => 25,
                'mo_ta' => 'Siêu âm chẩn đoán nội tạng',
                'trang_thai' => 'active',
                'danh_muc_id' => null,
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'ten' => 'Xét nghiệm máu',
                'gia_tien' => 250000.00,
                'thoi_gian_thuc_hien' => 20,
                'mo_ta' => 'Xét nghiệm công thức máu cơ bản',
                'trang_thai' => 'active',
                'danh_muc_id' => null,
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'ten' => 'Triệt sản',
                'gia_tien' => 1500000.00,
                'thoi_gian_thuc_hien' => 90,
                'mo_ta' => 'Triệt sản cho chó/mèo (bao gồm tiền mê và chăm sóc cơ bản)',
                'trang_thai' => 'active',
                'danh_muc_id' => null,
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'ten' => 'Khám tai mũi họng',
                'gia_tien' => 120000.00,
                'thoi_gian_thuc_hien' => 20,
                'mo_ta' => 'Khám chuyên khoa tai mũi họng',
                'trang_thai' => 'active',
                'danh_muc_id' => null,
                'created_at' => $now,
                'updated_at' => $now,
            ],
        ]);
    }
}
