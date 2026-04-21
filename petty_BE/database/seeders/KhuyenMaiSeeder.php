<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\KhuyenMai;
use Carbon\Carbon;

class KhuyenMaiSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $khuyenMais = [
            [
                'ten_khuyen_mai' => 'Giảm giá Tết 2025',
                'mo_ta' => 'Chương trình giảm giá đặc biệt dịp Tết Nguyên Đán 2025',
                'loai_khuyen_mai' => 'ma_giam_gia',
                'ma_code' => 'TET2025',
                'gia_tri_don_toi_thieu' => 500000,
                'loai_khach_hang' => 'tat_ca',
                'hinh_thuc_giam' => 'phan_tram',
                'giam_toi_da' => 200000,
                'gia_tri_giam' => 20,
                'tu_ngay' => Carbon::now()->subDays(5),
                'den_ngay' => Carbon::now()->addDays(25),
                'tong_so_luong' => 100,
                'so_luong_da_dung' => 15,
                'gioi_han_moi_khach' => 1,
                'trang_thai' => 'dang_chay',
            ],
            [
                'ten_khuyen_mai' => 'Khách hàng VIP - Giảm 30%',
                'mo_ta' => 'Ưu đãi đặc biệt dành cho khách hàng VIP',
                'loai_khuyen_mai' => 'chuong_trinh_tu_dong',
                'ma_code' => null,
                'gia_tri_don_toi_thieu' => 1000000,
                'loai_khach_hang' => 'vip',
                'hinh_thuc_giam' => 'phan_tram',
                'giam_toi_da' => 500000,
                'gia_tri_giam' => 30,
                'tu_ngay' => Carbon::now()->subDays(10),
                'den_ngay' => Carbon::now()->addDays(50),
                'tong_so_luong' => null,
                'so_luong_da_dung' => 0,
                'gioi_han_moi_khach' => null,
                'trang_thai' => 'dang_chay',
            ],
            [
                'ten_khuyen_mai' => 'Giảm 100K cho đơn đầu tiên',
                'mo_ta' => 'Giảm ngay 100.000đ cho đơn hàng đầu tiên',
                'loai_khuyen_mai' => 'ma_giam_gia',
                'ma_code' => 'FIRST100K',
                'gia_tri_don_toi_thieu' => 300000,
                'loai_khach_hang' => 'tat_ca',
                'hinh_thuc_giam' => 'so_tien',
                'giam_toi_da' => null,
                'gia_tri_giam' => 100000,
                'tu_ngay' => Carbon::now()->subDays(3),
                'den_ngay' => Carbon::now()->addDays(30),
                'tong_so_luong' => 50,
                'so_luong_da_dung' => 8,
                'gioi_han_moi_khach' => 1,
                'trang_thai' => 'dang_chay',
            ],
            [
                'ten_khuyen_mai' => 'Khuyến mãi hè 2024',
                'mo_ta' => 'Chương trình khuyến mãi đã kết thúc',
                'loai_khuyen_mai' => 'ma_giam_gia',
                'ma_code' => 'SUMMER2024',
                'gia_tri_don_toi_thieu' => 200000,
                'loai_khach_hang' => 'tat_ca',
                'hinh_thuc_giam' => 'phan_tram',
                'giam_toi_da' => 150000,
                'gia_tri_giam' => 15,
                'tu_ngay' => Carbon::now()->subDays(90),
                'den_ngay' => Carbon::now()->subDays(10),
                'tong_so_luong' => 200,
                'so_luong_da_dung' => 200,
                'gioi_han_moi_khach' => 2,
                'trang_thai' => 'da_ket_thuc',
            ],
        ];

        foreach ($khuyenMais as $khuyenMai) {
            KhuyenMai::create($khuyenMai);
        }
    }
}
