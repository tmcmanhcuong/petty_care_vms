<?php
/**
 * Script tự động cấp quyền phieu_nhap_kho và phieu_chi
 * Chạy: php auto-grant-permissions.php
 */

require __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use App\Models\PhanQuyen;
use Illuminate\Support\Facades\DB;

echo "\n=== AUTO GRANT PERMISSIONS SCRIPT ===\n\n";

try {
    // 1. Cập nhật quyền cho vai trò "Quản lý" (ID = 1)
    echo "1. Cập nhật quyền cho vai trò 'Quản lý'...\n";
    
    $updated = DB::table('phan_quyens')
        ->where('id', 1)
        ->update([
            // Phiếu chi
            'phieu_chi_xem' => true,
            'phieu_chi_tao' => true,
            'phieu_chi_sua' => true,
            'phieu_chi_xoa' => true,
            'phieu_chi_xuat_pdf' => true,
            'phieu_chi_thanh_toan' => true,
            
            // Phiếu nhập kho
            'phieu_nhap_kho_xem' => true,
            'phieu_nhap_kho_tao' => true,
            'phieu_nhap_kho_doi_trang_thai' => true,
            'phieu_nhap_kho_xuat_pdf' => true,
            'phieu_nhap_kho_xoa' => true,
            
            // Hàng hóa
            'hang_hoa_xem' => true,
            'hang_hoa_tao' => true,
            'hang_hoa_sua' => true,
            'hang_hoa_xoa' => true,
            'hang_hoa_doi_trang_thai' => true,
            
            // Nhà cung cấp
            'nha_cung_cap_xem' => true,
            'nha_cung_cap_tao' => true,
            'nha_cung_cap_sua' => true,
            'nha_cung_cap_xoa' => true,
            'nha_cung_cap_doi_trang_thai' => true,
            
            // Kiểm kê
            'kiem_ke_xem' => true,
            'kiem_ke_tao' => true,
            'kiem_ke_sua' => true,
            'kiem_ke_xoa' => true,
        ]);
    
    echo "   ✓ Đã cập nhật vai trò 'Quản lý'\n\n";
    
    // 2. Cập nhật quyền cho vai trò "Bác sĩ" (ID = 2)
    echo "2. Cập nhật quyền cho vai trò 'Bác sĩ'...\n";
    
    DB::table('phan_quyens')
        ->where('id', 2)
        ->update([
            'phieu_chi_xem' => true,
            'phieu_chi_xuat_pdf' => true,
            'phieu_nhap_kho_xem' => true,
            'phieu_nhap_kho_xuat_pdf' => true,
        ]);
    
    echo "   ✓ Đã cập nhật vai trò 'Bác sĩ'\n\n";
    
    // 3. Cập nhật quyền cho vai trò "Điều dưỡng" (ID = 3)
    echo "3. Cập nhật quyền cho vai trò 'Điều dưỡng'...\n";
    
    DB::table('phan_quyens')
        ->where('id', 3)
        ->update([
            'phieu_chi_xem' => true,
            'phieu_chi_tao' => true,
            'phieu_chi_xuat_pdf' => true,
            'phieu_nhap_kho_xem' => true,
            'phieu_nhap_kho_tao' => true,
            'phieu_nhap_kho_xuat_pdf' => true,
        ]);
    
    echo "   ✓ Đã cập nhật vai trò 'Điều dưỡng'\n\n";
    
    // 4. Cập nhật quyền cho vai trò "Lễ tân" (ID = 4)
    echo "4. Cập nhật quyền cho vai trò 'Lễ tân'...\n";
    
    DB::table('phan_quyens')
        ->where('id', 4)
        ->update([
            'phieu_chi_xem' => true,
            'phieu_chi_xuat_pdf' => true,
            'phieu_nhap_kho_xem' => true,
        ]);
    
    echo "   ✓ Đã cập nhật vai trò 'Lễ tân'\n\n";
    
    // 5. Gán vai trò cho Admin chưa có
    echo "5. Gán vai trò cho Admin chưa có...\n";
    
    $adminUpdated = DB::table('admins')
        ->whereNull('phan_quyen_id')
        ->update(['phan_quyen_id' => 1]);
    
    echo "   ✓ Đã gán vai trò cho {$adminUpdated} Admin\n\n";
    
    // 6. Gán vai trò cho NhanVien chưa có
    echo "6. Gán vai trò cho NhanVien chưa có...\n";
    
    $nvUpdated = DB::table('nhan_viens')
        ->whereNull('phan_quyen_id')
        ->update(['phan_quyen_id' => 2]); // Mặc định là Bác sĩ
    
    echo "   ✓ Đã gán vai trò cho {$nvUpdated} NhanVien\n\n";
    
    // 7. Hiển thị kết quả
    echo "7. Kiểm tra kết quả...\n";
    echo "\n--- Vai trò và quyền ---\n";
    
    $roles = DB::table('phan_quyens')
        ->select([
            'id',
            'ten_vai_tro',
            'phieu_nhap_kho_xem',
            'phieu_nhap_kho_tao',
            'phieu_chi_xem',
            'phieu_chi_tao'
        ])
        ->orderBy('id')
        ->get();
    
    foreach ($roles as $role) {
        echo "\nID {$role->id}: {$role->ten_vai_tro}\n";
        echo "  - Phiếu nhập kho: Xem=" . ($role->phieu_nhap_kho_xem ? '✓' : '✗') . 
             ", Tạo=" . ($role->phieu_nhap_kho_tao ? '✓' : '✗') . "\n";
        echo "  - Phiếu chi: Xem=" . ($role->phieu_chi_xem ? '✓' : '✗') . 
             ", Tạo=" . ($role->phieu_chi_tao ? '✓' : '✗') . "\n";
    }
    
    echo "\n--- Tài khoản Admin ---\n";
    $admins = DB::table('admins')
        ->leftJoin('phan_quyens', 'admins.phan_quyen_id', '=', 'phan_quyens.id')
        ->select('admins.id', 'admins.ho_ten', 'admins.phan_quyen_id', 'phan_quyens.ten_vai_tro')
        ->get();
    
    foreach ($admins as $admin) {
        echo "  Admin #{$admin->id}: {$admin->ho_ten} - Vai trò: " . 
             ($admin->ten_vai_tro ?? 'CHƯA CÓ') . "\n";
    }
    
    echo "\n--- Tài khoản NhanVien ---\n";
    $nhanviens = DB::table('nhan_viens')
        ->leftJoin('phan_quyens', 'nhan_viens.phan_quyen_id', '=', 'phan_quyens.id')
        ->select('nhan_viens.id', 'nhan_viens.full_name', 'nhan_viens.phan_quyen_id', 'phan_quyens.ten_vai_tro')
        ->limit(5)
        ->get();
    
    foreach ($nhanviens as $nv) {
        echo "  NhanVien #{$nv->id}: {$nv->full_name} - Vai trò: " . 
             ($nv->ten_vai_tro ?? 'CHƯA CÓ') . "\n";
    }
    
    echo "\n=== HOÀN THÀNH ===\n";
    echo "\nTất cả quyền đã được cấp thành công!\n";
    echo "Bạn có thể đăng nhập lại và kiểm tra.\n\n";
    
} catch (\Exception $e) {
    echo "\n❌ LỖI: " . $e->getMessage() . "\n";
    echo "File: " . $e->getFile() . "\n";
    echo "Line: " . $e->getLine() . "\n\n";
    exit(1);
}
