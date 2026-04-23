-- =============================================================
-- Petty VMCS SaaS — Database Schema
-- Generated from Laravel migrations (trạng thái cuối cùng)
-- MySQL / MariaDB compatible
-- =============================================================

SET FOREIGN_KEY_CHECKS = 0;

-- -------------------------------------------------------------
-- Laravel framework tables
-- -------------------------------------------------------------

CREATE TABLE `users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `email_verified_at` TIMESTAMP NULL,
  `password` VARCHAR(255) NOT NULL,
  `remember_token` VARCHAR(100) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `password_reset_tokens` (
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `sessions` (
  `id` VARCHAR(255) NOT NULL,
  `user_id` BIGINT UNSIGNED NULL,
  `ip_address` VARCHAR(45) NULL,
  `user_agent` TEXT NULL,
  `payload` LONGTEXT NOT NULL,
  `last_activity` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `sessions_user_id_index` (`user_id`),
  INDEX `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `cache` (
  `key` VARCHAR(255) NOT NULL,
  `value` MEDIUMTEXT NOT NULL,
  `expiration` INT NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `cache_locks` (
  `key` VARCHAR(255) NOT NULL,
  `owner` VARCHAR(255) NOT NULL,
  `expiration` INT NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `jobs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` VARCHAR(255) NOT NULL,
  `payload` LONGTEXT NOT NULL,
  `attempts` TINYINT UNSIGNED NOT NULL,
  `reserved_at` INT UNSIGNED NULL,
  `available_at` INT UNSIGNED NOT NULL,
  `created_at` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `job_batches` (
  `id` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `total_jobs` INT NOT NULL,
  `pending_jobs` INT NOT NULL,
  `failed_jobs` INT NOT NULL,
  `failed_job_ids` LONGTEXT NOT NULL,
  `options` MEDIUMTEXT NULL,
  `cancelled_at` INT NULL,
  `created_at` INT NOT NULL,
  `finished_at` INT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `failed_jobs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(255) NOT NULL,
  `connection` TEXT NOT NULL,
  `queue` TEXT NOT NULL,
  `payload` LONGTEXT NOT NULL,
  `exception` LONGTEXT NOT NULL,
  `failed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `personal_access_tokens` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` VARCHAR(255) NOT NULL,
  `tokenable_id` BIGINT UNSIGNED NOT NULL,
  `name` TEXT NOT NULL,
  `token` VARCHAR(64) NOT NULL,
  `abilities` TEXT NULL,
  `last_used_at` TIMESTAMP NULL,
  `expires_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`, `tokenable_id`),
  INDEX `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Phân quyền (phải tạo trước nhan_viens và admins)
-- -------------------------------------------------------------

CREATE TABLE `phan_quyens` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ma_vai_tro` VARCHAR(255) NOT NULL,
  `ten_vai_tro` VARCHAR(255) NOT NULL,
  `mo_ta` TEXT NULL,
  -- Lịch hẹn
  `lich_hen_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `lich_hen_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `lich_hen_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `lich_hen_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  `lich_hen_xac_nhan` TINYINT(1) NOT NULL DEFAULT 0,
  -- Lịch làm việc
  `lich_lam_viec_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `lich_lam_viec_tao` TINYINT(1) NOT NULL DEFAULT 0,
  -- Lịch nhắc
  `lich_nhac_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `lich_nhac_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `lich_nhac_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `lich_nhac_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  `lich_nhac_gui` TINYINT(1) NOT NULL DEFAULT 0,
  -- Tài chính
  `tai_chinh_xem_doanh_thu` TINYINT(1) NOT NULL DEFAULT 0,
  `tai_chinh_thu_tien` TINYINT(1) NOT NULL DEFAULT 0,
  `tai_chinh_hoan_tien` TINYINT(1) NOT NULL DEFAULT 0,
  -- Phiếu chi
  `phieu_chi_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `phieu_chi_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `phieu_chi_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `phieu_chi_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  `phieu_chi_xuat_pdf` TINYINT(1) NOT NULL DEFAULT 0,
  `phieu_chi_thanh_toan` TINYINT(1) NOT NULL DEFAULT 0,
  -- Hàng hóa
  `hang_hoa_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `hang_hoa_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `hang_hoa_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `hang_hoa_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  `hang_hoa_doi_trang_thai` TINYINT(1) NOT NULL DEFAULT 0,
  -- Danh mục hàng hóa
  `danh_muc_hang_hoa_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `danh_muc_hang_hoa_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `danh_muc_hang_hoa_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `danh_muc_hang_hoa_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  -- Phiếu nhập kho
  `phieu_nhap_kho_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `phieu_nhap_kho_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `phieu_nhap_kho_doi_trang_thai` TINYINT(1) NOT NULL DEFAULT 0,
  `phieu_nhap_kho_xuat_pdf` TINYINT(1) NOT NULL DEFAULT 0,
  `phieu_nhap_kho_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  -- Kiểm kê
  `kiem_ke_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `kiem_ke_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `kiem_ke_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `kiem_ke_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  -- Thú cưng
  `thu_cung_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `thu_cung_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `thu_cung_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `thu_cung_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  -- Hồ sơ bệnh án
  `ho_so_benh_an_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `ho_so_benh_an_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `ho_so_benh_an_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `ho_so_benh_an_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  -- Dịch vụ
  `dich_vu_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `dich_vu_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `dich_vu_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `dich_vu_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  -- Danh mục dịch vụ
  `danh_muc_dich_vu_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `danh_muc_dich_vu_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `danh_muc_dich_vu_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `danh_muc_dich_vu_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  -- Khách hàng
  `khach_hang_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `khach_hang_sua` TINYINT(1) NOT NULL DEFAULT 0,
  -- Nhân viên
  `nhan_vien_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `nhan_vien_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `nhan_vien_doi_mat_khau` TINYINT(1) NOT NULL DEFAULT 0,
  `nhan_vien_khoa_tai_khoan` TINYINT(1) NOT NULL DEFAULT 0,
  `nhan_vien_mo_khoa_tai_khoan` TINYINT(1) NOT NULL DEFAULT 0,
  -- Khoa
  `khoa_tao` TINYINT(1) NOT NULL DEFAULT 0,
  -- Nhà cung cấp
  `nha_cung_cap_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `nha_cung_cap_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `nha_cung_cap_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `nha_cung_cap_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  `nha_cung_cap_doi_trang_thai` TINYINT(1) NOT NULL DEFAULT 0,
  -- Bài viết
  `bai_viet_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `bai_viet_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `bai_viet_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `bai_viet_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  -- Phân loại bài viết
  `phan_loai_bai_viet_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `phan_loai_bai_viet_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `phan_loai_bai_viet_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `phan_loai_bai_viet_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  -- Khuyến mãi
  `khuyen_mai_xem` TINYINT(1) NOT NULL DEFAULT 0,
  `khuyen_mai_tao` TINYINT(1) NOT NULL DEFAULT 0,
  `khuyen_mai_sua` TINYINT(1) NOT NULL DEFAULT 0,
  `khuyen_mai_xoa` TINYINT(1) NOT NULL DEFAULT 0,
  `khuyen_mai_doi_trang_thai` TINYINT(1) NOT NULL DEFAULT 0,
  -- Upload
  `upload_file` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phan_quyens_ma_vai_tro_unique` (`ma_vai_tro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Khách hàng
-- -------------------------------------------------------------

CREATE TABLE `khach_hangs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `email_verified_at` TIMESTAMP NULL,
  `phone` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `full_name` VARCHAR(255) NOT NULL,
  `address` TEXT NULL,
  `rank` ENUM('Silver','Gold','Diamond') NOT NULL DEFAULT 'Silver',
  `anh_dai_dien` VARCHAR(255) NULL,
  `trang_thai` VARCHAR(255) NOT NULL DEFAULT 'active',
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `khach_hangs_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `social_accounts` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `khach_hang_id` BIGINT UNSIGNED NOT NULL,
  `provider` VARCHAR(255) NOT NULL,
  `provider_user_id` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `social_accounts_khach_hang_id_foreign`
    FOREIGN KEY (`khach_hang_id`) REFERENCES `khach_hangs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Nhân viên & Admin
-- -------------------------------------------------------------

CREATE TABLE `nhan_viens` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `phan_quyen_id` BIGINT UNSIGNED NULL,
  `full_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(255) NULL,
  `address` TEXT NULL,
  `anh_dai_dien` VARCHAR(255) NULL,
  `vai_tro` ENUM('bac_si','y_ta') NOT NULL DEFAULT 'bac_si',
  `chuc_danh` VARCHAR(255) NULL,
  `nam_kinh_nghiem` INT UNSIGNED NOT NULL DEFAULT 0,
  `chung_chi_hanh_nghe` TEXT NULL,
  `bang_cap_chuyen_mon` TEXT NULL,
  `password` VARCHAR(255) NOT NULL,
  `trang_thai` ENUM('hoat_dong','da_khoa') NOT NULL DEFAULT 'hoat_dong',
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nhan_viens_email_unique` (`email`),
  CONSTRAINT `nhan_viens_phan_quyen_id_foreign`
    FOREIGN KEY (`phan_quyen_id`) REFERENCES `phan_quyens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admins` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `phan_quyen_id` BIGINT UNSIGNED NULL,
  `ho_ten` VARCHAR(255) NOT NULL,
  `anh_dai_dien` VARCHAR(255) NULL,
  `mat_khau` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `so_dien_thoai` VARCHAR(255) NULL,
  `dia_chi` TEXT NULL,
  `trang_thai` TINYINT NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`),
  CONSTRAINT `admins_phan_quyen_id_foreign`
    FOREIGN KEY (`phan_quyen_id`) REFERENCES `phan_quyens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Thú cưng
-- -------------------------------------------------------------

CREATE TABLE `thu_cungs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `khach_hang_id` BIGINT UNSIGNED NULL,
  `anh_dai_dien` VARCHAR(255) NULL,
  `ten_thu_cung` VARCHAR(255) NOT NULL,
  `loai_thu_cung` VARCHAR(255) NOT NULL,
  `giong_thu_cung` VARCHAR(255) NOT NULL,
  `tuoi_thu_cung` DATE NOT NULL,
  `gioi_tinh` VARCHAR(255) NOT NULL,
  `can_nang` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `thu_cungs_khach_hang_id_foreign`
    FOREIGN KEY (`khach_hang_id`) REFERENCES `khach_hangs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Khoa & Dịch vụ
-- -------------------------------------------------------------

CREATE TABLE `khoas` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ma_khoa` VARCHAR(255) NOT NULL,
  `ten_khoa` VARCHAR(255) NOT NULL,
  `mo_ta` TEXT NULL,
  `chuyen_mon` VARCHAR(255) NULL,
  `trang_thai` TINYINT NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `khoas_ma_khoa_unique` (`ma_khoa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `danh_muc_dich_vus` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ten_nhom` VARCHAR(255) NOT NULL,
  `mo_ta` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `danh_muc_dich_vus_ten_nhom_index` (`ten_nhom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `dich_vus` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ten` VARCHAR(255) NOT NULL,
  `ma_dich_vu` VARCHAR(255) NULL,
  `gia_tien` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `thoi_gian_thuc_hien` INT UNSIGNED NULL COMMENT 'Phút',
  `mo_ta` TEXT NULL,
  `huong_dan` TEXT NULL,
  `anh_dich_vu` VARCHAR(255) NULL,
  `trang_thai` ENUM('kinh_doanh','ngung') NOT NULL DEFAULT 'kinh_doanh',
  `danh_muc_id` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dich_vus_ma_dich_vu_unique` (`ma_dich_vu`),
  INDEX `dich_vus_ten_index` (`ten`),
  INDEX `dich_vus_trang_thai_index` (`trang_thai`),
  INDEX `dich_vus_danh_muc_id_index` (`danh_muc_id`),
  CONSTRAINT `dich_vus_danh_muc_id_foreign`
    FOREIGN KEY (`danh_muc_id`) REFERENCES `danh_muc_dich_vus` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `danh_muc_dich_vu_khoa` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `danh_muc_dich_vu_id` BIGINT UNSIGNED NOT NULL,
  `khoa_id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `danh_muc_dich_vu_khoa_unique` (`danh_muc_dich_vu_id`, `khoa_id`),
  CONSTRAINT `danh_muc_dich_vu_khoa_danh_muc_dich_vu_id_foreign`
    FOREIGN KEY (`danh_muc_dich_vu_id`) REFERENCES `danh_muc_dich_vus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `danh_muc_dich_vu_khoa_khoa_id_foreign`
    FOREIGN KEY (`khoa_id`) REFERENCES `khoas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `khoa_nhan_vien` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `khoa_id` BIGINT UNSIGNED NOT NULL,
  `nhan_vien_id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `khoa_nhan_vien_unique` (`khoa_id`, `nhan_vien_id`),
  CONSTRAINT `khoa_nhan_vien_khoa_id_foreign`
    FOREIGN KEY (`khoa_id`) REFERENCES `khoas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `khoa_nhan_vien_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Thanh toán (placeholder — chỉ có id + timestamps)
-- -------------------------------------------------------------

CREATE TABLE `thanh_toans` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Lịch hẹn (trạng thái cuối sau tất cả ALTER)
-- -------------------------------------------------------------

CREATE TABLE `lich_hens` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ngay_gio` DATETIME NOT NULL,
  `ghi_chu` TEXT NULL,
  `huong_dan` TEXT NULL,
  `trang_thai` VARCHAR(50) NOT NULL DEFAULT 'pending',
  `nguon_goc` VARCHAR(100) NULL COMMENT 'Nguồn gốc đặt lịch',
  `thoi_gian_checkin` DATETIME NULL,
  `y_ta_checkin_id` BIGINT UNSIGNED NULL COMMENT 'Y tá thực hiện check-in',
  `thoi_gian_bat_dau_kham` DATETIME NULL,
  `thoi_gian_hoan_thanh` DATETIME NULL,
  `khach_hang_id` BIGINT UNSIGNED NOT NULL,
  `thu_cung_id` BIGINT UNSIGNED NOT NULL,
  `dich_vu_id` BIGINT UNSIGNED NULL,
  `thanh_toan_id` BIGINT UNSIGNED NULL,
  `nhan_vien_id` BIGINT UNSIGNED NULL,
  `tong_tien` DECIMAL(15,2) NOT NULL DEFAULT 0 COMMENT 'Tổng tiền dịch vụ',
  `da_thanh_toan` TINYINT(1) NOT NULL DEFAULT 0,
  `phuong_thuc_thanh_toan` VARCHAR(50) NULL,
  `thoi_gian_thanh_toan` DATETIME NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `lich_hens_trang_thai_index` (`trang_thai`),
  INDEX `lich_hens_dich_vu_id_index` (`dich_vu_id`),
  INDEX `lich_hens_thanh_toan_id_index` (`thanh_toan_id`),
  INDEX `lich_hens_nhan_vien_id_index` (`nhan_vien_id`),
  CONSTRAINT `lich_hens_khach_hang_id_foreign`
    FOREIGN KEY (`khach_hang_id`) REFERENCES `khach_hangs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lich_hens_thu_cung_id_foreign`
    FOREIGN KEY (`thu_cung_id`) REFERENCES `thu_cungs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lich_hens_dich_vu_id_foreign`
    FOREIGN KEY (`dich_vu_id`) REFERENCES `dich_vus` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_hens_thanh_toan_id_foreign`
    FOREIGN KEY (`thanh_toan_id`) REFERENCES `thanh_toans` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_hens_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_lich_hen_y_ta_checkin`
    FOREIGN KEY (`y_ta_checkin_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Lịch làm việc (trạng thái cuối — enum mở rộng)
-- -------------------------------------------------------------

CREATE TABLE `lich_lam_viecs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ngay_lam` DATE NOT NULL,
  `phong_truc` VARCHAR(255) NOT NULL,
  `thoi_gian_truc` ENUM('ca_sang','ca_chieu','ca_toi','ca_ngay','ca_dem','ca_dang_ky') NOT NULL,
  `nhan_vien_id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_lich_lam_viecs_nhan_vien_id`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Lịch đăng ký (trạng thái cuối — đã bỏ khach_hang/thu_cung/dich_vu)
-- -------------------------------------------------------------

CREATE TABLE `lich_dang_kys` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ngay_gio` DATETIME NOT NULL COMMENT 'Ngày giờ đăng ký khám',
  `ghi_chu` TEXT NULL,
  `trang_thai` VARCHAR(50) NOT NULL DEFAULT 'chua_xac_nhan' COMMENT 'chua_xac_nhan | da_xac_nhan | tu_choi',
  `nhan_vien_id` BIGINT UNSIGNED NULL,
  `admin_id` BIGINT UNSIGNED NULL,
  `lich_lam_viec_id` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `lich_dang_kys_ngay_gio_index` (`ngay_gio`),
  INDEX `lich_dang_kys_trang_thai_index` (`trang_thai`),
  CONSTRAINT `lich_dang_kys_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_dang_kys_admin_id_foreign`
    FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_dang_kys_lich_lam_viec_id_foreign`
    FOREIGN KEY (`lich_lam_viec_id`) REFERENCES `lich_lam_viecs` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Lịch nghỉ
-- -------------------------------------------------------------

CREATE TABLE `lich_nghis` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nhan_vien_id` BIGINT UNSIGNED NOT NULL,
  `ngay_bat_dau` DATE NOT NULL,
  `ngay_ket_thuc` DATE NOT NULL,
  `ly_do` TEXT NULL,
  `trang_thai` ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `ly_do_tu_choi` TEXT NULL,
  `admin_id` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `lich_nghis_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lich_nghis_admin_id_foreign`
    FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Phiếu khám
-- -------------------------------------------------------------

CREATE TABLE `phieu_khams` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nhiet_do` DECIMAL(5,2) NULL COMMENT 'Nhiệt độ (°C)',
  `can_nang` DECIMAL(8,2) NULL COMMENT 'Cân nặng (kg)',
  `nhip_tim` INT NULL COMMENT 'Nhịp tim (bpm)',
  `nhip_tho` INT NULL COMMENT 'Nhịp thở (lần/phút)',
  `ly_do_den_kham` VARCHAR(255) NULL,
  `trieu_chung` TEXT NULL,
  `chan_doan` TEXT NULL,
  `ghi_chu` TEXT NULL,
  `loai_chi_dinh` VARCHAR(50) NULL,
  `lich_hen_id` BIGINT UNSIGNED NULL,
  `nhan_vien_id` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `phieu_khams_lich_hen_id_foreign`
    FOREIGN KEY (`lich_hen_id`) REFERENCES `lich_hens` (`id`) ON DELETE SET NULL,
  CONSTRAINT `phieu_khams_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Hồ sơ bệnh án & lịch nhắc
-- -------------------------------------------------------------

CREATE TABLE `ho_so_benh_ans` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ma_benh_an` VARCHAR(50) NOT NULL,
  `noi_dung` TEXT NOT NULL,
  `khach_hang_id` BIGINT UNSIGNED NULL,
  `thu_cung_id` BIGINT UNSIGNED NULL,
  `nhan_vien_id` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ho_so_benh_ans_ma_benh_an_unique` (`ma_benh_an`),
  INDEX `ho_so_benh_ans_ma_benh_an_index` (`ma_benh_an`),
  CONSTRAINT `ho_so_benh_ans_khach_hang_id_foreign`
    FOREIGN KEY (`khach_hang_id`) REFERENCES `khach_hangs` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ho_so_benh_ans_thu_cung_id_foreign`
    FOREIGN KEY (`thu_cung_id`) REFERENCES `thu_cungs` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ho_so_benh_ans_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `chi_tiet_ho_so_benh_ans` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `lich_nhacs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ngay_nhac` DATETIME NOT NULL,
  `phan_loai` VARCHAR(100) NOT NULL COMMENT 'tai_kham | tiem_phong | xet_nghiem | thuoc | khac',
  `noi_dung` TEXT NOT NULL,
  `ghi_chu` TEXT NULL,
  `trang_thai` VARCHAR(50) NOT NULL DEFAULT 'chua_gui' COMMENT 'chua_gui | da_gui | hoan_thanh | huy',
  `ho_so_benh_an_id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `lich_nhacs_ngay_nhac_index` (`ngay_nhac`),
  INDEX `lich_nhacs_trang_thai_index` (`trang_thai`),
  INDEX `lich_nhacs_phan_loai_index` (`phan_loai`),
  CONSTRAINT `lich_nhacs_ho_so_benh_an_id_foreign`
    FOREIGN KEY (`ho_so_benh_an_id`) REFERENCES `ho_so_benh_ans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Kho hàng
-- -------------------------------------------------------------

CREATE TABLE `danh_muc_hang_hoas` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ten_danh_muc_hang_hoa` VARCHAR(255) NOT NULL,
  `mo_ta` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `hang_hoas` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ma_hang_hoa` VARCHAR(255) NOT NULL,
  `ten_mat_hang` VARCHAR(255) NOT NULL,
  `don_vi_tinh` VARCHAR(255) NOT NULL,
  `gia_von` DECIMAL(12,2) NOT NULL,
  `gia_ban` DECIMAL(12,2) NOT NULL,
  `dinh_muc_toi_thieu` INT NOT NULL DEFAULT 0,
  `anh_san_pham` VARCHAR(255) NULL,
  `tinh_trang` ENUM('hoat_dong','ngung_kinh_doanh') NOT NULL DEFAULT 'hoat_dong',
  `danh_muc_hang_hoa_id` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hang_hoas_ma_hang_hoa_unique` (`ma_hang_hoa`),
  CONSTRAINT `hang_hoas_danh_muc_hang_hoa_id_foreign`
    FOREIGN KEY (`danh_muc_hang_hoa_id`) REFERENCES `danh_muc_hang_hoas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Nhà cung cấp & Phiếu chi / Nhập kho
-- -------------------------------------------------------------

CREATE TABLE `nha_cung_caps` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ma_nha_cung_cap` VARCHAR(50) NOT NULL,
  `ten_nha_cung_cap` VARCHAR(255) NOT NULL,
  `ten_nguoi_lien_he` VARCHAR(255) NOT NULL,
  `so_dien_thoai` VARCHAR(15) NOT NULL,
  `dia_chi` TEXT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `ma_so_thue` VARCHAR(50) NOT NULL,
  `mo_ta` TEXT NOT NULL,
  `trang_thai` ENUM('hoat_dong','ngung_hoat_dong') NOT NULL DEFAULT 'hoat_dong',
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nha_cung_caps_ma_nha_cung_cap_unique` (`ma_nha_cung_cap`),
  UNIQUE KEY `nha_cung_caps_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `phieu_chis` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ma_phieu_chi` VARCHAR(50) NOT NULL,
  `loai_phieu_chi` ENUM('chi_nhap_hang','chi_van_hanh') NOT NULL,
  `ly_do_chi` TEXT NOT NULL,
  `tong_so_tien` DECIMAL(15,2) NOT NULL,
  `so_tien_thanh_toan_ngay` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `so_tien_con_no` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `tien_mat` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `tien_chuyen_khoan` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `anh_chung_tu` JSON NULL,
  `doi_tuong_nhan_tien` VARCHAR(255) NULL,
  `nha_cung_cap_id` BIGINT UNSIGNED NULL,
  `trang_thai` ENUM('con_no','da_hoan_thanh') NOT NULL DEFAULT 'con_no',
  `admin_id` BIGINT UNSIGNED NULL,
  `nhan_vien_id` BIGINT UNSIGNED NULL,
  `nguoi_tao_type` VARCHAR(255) NULL,
  `ngay_chi` DATE NOT NULL,
  `ghi_chu` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phieu_chis_ma_phieu_chi_unique` (`ma_phieu_chi`),
  CONSTRAINT `phieu_chis_nha_cung_cap_id_foreign`
    FOREIGN KEY (`nha_cung_cap_id`) REFERENCES `nha_cung_caps` (`id`) ON DELETE SET NULL,
  CONSTRAINT `phieu_chis_admin_id_foreign`
    FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `phieu_chis_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `phieu_nhap_khos` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ma_phieu_nhap` VARCHAR(50) NOT NULL,
  `ngay_nhap` DATE NOT NULL,
  `tong_tien` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `ghi_chu` TEXT NULL,
  `trang_thai` ENUM('cho_duyet','da_duyet','huy') NOT NULL DEFAULT 'cho_duyet',
  `nha_cung_cap_id` BIGINT UNSIGNED NOT NULL,
  `phieu_chi_id` BIGINT UNSIGNED NOT NULL,
  `nhan_vien_id` BIGINT UNSIGNED NULL,
  `admin_id` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phieu_nhap_khos_ma_phieu_nhap_unique` (`ma_phieu_nhap`),
  CONSTRAINT `phieu_nhap_khos_nha_cung_cap_id_foreign`
    FOREIGN KEY (`nha_cung_cap_id`) REFERENCES `nha_cung_caps` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phieu_nhap_khos_phieu_chi_id_foreign`
    FOREIGN KEY (`phieu_chi_id`) REFERENCES `phieu_chis` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phieu_nhap_khos_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phieu_nhap_khos_admin_id_foreign`
    FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `chi_tiet_phieu_nhap_khos` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `phieu_nhap_kho_id` BIGINT UNSIGNED NOT NULL,
  `hang_hoa_id` BIGINT UNSIGNED NOT NULL,
  `so_luong` INT NOT NULL,
  `so_lo` VARCHAR(50) NOT NULL,
  `han_su_dung` DATE NOT NULL,
  `don_gia` DECIMAL(15,2) NOT NULL,
  `thanh_tien` DECIMAL(15,2) NOT NULL,
  `ghi_chu` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `chi_tiet_phieu_nhap_khos_phieu_nhap_kho_id_foreign`
    FOREIGN KEY (`phieu_nhap_kho_id`) REFERENCES `phieu_nhap_khos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chi_tiet_phieu_nhap_khos_hang_hoa_id_foreign`
    FOREIGN KEY (`hang_hoa_id`) REFERENCES `hang_hoas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `kiem_kes` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `hang_hoa_id` BIGINT UNSIGNED NOT NULL,
  `chi_tiet_phieu_nhap_kho_id` BIGINT UNSIGNED NULL,
  `so_luong_he_thong` INT NOT NULL DEFAULT 0,
  `so_luong_thuc_te` INT NOT NULL DEFAULT 0,
  `chenh_lech` INT NOT NULL DEFAULT 0 COMMENT 'Thực tế - Hệ thống',
  `ly_do` VARCHAR(255) NULL,
  `ngay_kiem_ke` DATE NOT NULL,
  `admin_id` BIGINT UNSIGNED NULL,
  `nhan_vien_id` BIGINT UNSIGNED NULL,
  `nguoi_kiem_ke_type` VARCHAR(255) NULL,
  `ghi_chu` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `kiem_kes_hang_hoa_id_foreign`
    FOREIGN KEY (`hang_hoa_id`) REFERENCES `hang_hoas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `kiem_kes_chi_tiet_phieu_nhap_kho_id_foreign`
    FOREIGN KEY (`chi_tiet_phieu_nhap_kho_id`) REFERENCES `chi_tiet_phieu_nhap_khos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `kiem_kes_admin_id_foreign`
    FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `kiem_kes_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `lich_su_thanh_toan_phieu_chis` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `phieu_chi_id` BIGINT UNSIGNED NOT NULL,
  `so_tien_thanh_toan` DECIMAL(15,2) NOT NULL,
  `hinh_thuc_thanh_toan` ENUM('tien_mat','chuyen_khoan','ca_hai') NOT NULL DEFAULT 'tien_mat',
  `tien_mat` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `tien_chuyen_khoan` DECIMAL(15,2) NOT NULL DEFAULT 0,
  `ghi_chu` TEXT NULL,
  `so_tien_da_tra_truoc_do` DECIMAL(15,2) NOT NULL,
  `so_tien_con_no_sau_thanh_toan` DECIMAL(15,2) NOT NULL,
  `ngay_thanh_toan` DATETIME NOT NULL,
  `admin_id` BIGINT UNSIGNED NULL,
  `nhan_vien_id` BIGINT UNSIGNED NULL,
  `nguoi_thanh_toan_type` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `lich_su_thanh_toan_phieu_chis_phieu_chi_id_index` (`phieu_chi_id`),
  INDEX `lich_su_thanh_toan_phieu_chis_ngay_thanh_toan_index` (`ngay_thanh_toan`),
  CONSTRAINT `lich_su_thanh_toan_phieu_chis_phieu_chi_id_foreign`
    FOREIGN KEY (`phieu_chi_id`) REFERENCES `phieu_chis` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lich_su_thanh_toan_phieu_chis_admin_id_foreign`
    FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_su_thanh_toan_phieu_chis_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Khuyến mãi
-- -------------------------------------------------------------

CREATE TABLE `khuyen_mais` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ten_khuyen_mai` VARCHAR(255) NOT NULL,
  `mo_ta` TEXT NULL,
  `loai_khuyen_mai` ENUM('ma_giam_gia','chuong_trinh_tu_dong') NOT NULL DEFAULT 'ma_giam_gia',
  `ma_code` VARCHAR(255) NULL,
  `gia_tri_don_toi_thieu` DECIMAL(15,2) NULL,
  `loai_khach_hang` ENUM('tat_ca','vip') NOT NULL DEFAULT 'tat_ca',
  `hinh_thuc_giam` ENUM('phan_tram','so_tien') NOT NULL DEFAULT 'phan_tram',
  `giam_toi_da` DECIMAL(15,2) NULL,
  `gia_tri_giam` DECIMAL(15,2) NOT NULL,
  `tu_ngay` DATETIME NOT NULL,
  `den_ngay` DATETIME NOT NULL,
  `tong_so_luong` INT NULL,
  `so_luong_da_dung` INT NOT NULL DEFAULT 0,
  `gioi_han_moi_khach` INT NULL,
  `trang_thai` ENUM('dang_chay','da_ket_thuc') NOT NULL DEFAULT 'dang_chay',
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `khuyen_mais_ma_code_unique` (`ma_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `chi_tiet_khuyen_mais` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `khuyen_mai_dich_vu` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `khuyen_mai_id` BIGINT UNSIGNED NOT NULL,
  `dich_vu_id` BIGINT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `khuyen_mai_dich_vu_unique` (`khuyen_mai_id`, `dich_vu_id`),
  CONSTRAINT `khuyen_mai_dich_vu_khuyen_mai_id_foreign`
    FOREIGN KEY (`khuyen_mai_id`) REFERENCES `khuyen_mais` (`id`) ON DELETE CASCADE,
  CONSTRAINT `khuyen_mai_dich_vu_dich_vu_id_foreign`
    FOREIGN KEY (`dich_vu_id`) REFERENCES `dich_vus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -------------------------------------------------------------
-- Diễn đàn — Bài viết, bình luận, reaction
-- -------------------------------------------------------------

CREATE TABLE `phan_loai_bai_viets` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ten_phan_loai` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `mo_ta` TEXT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phan_loai_bai_viets_ten_phan_loai_unique` (`ten_phan_loai`),
  UNIQUE KEY `phan_loai_bai_viets_slug_unique` (`slug`),
  INDEX `phan_loai_bai_viets_slug_index` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `bai_viets` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ten_bai_viet` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `noi_dung` LONGTEXT NOT NULL,
  `mo_ta` TEXT NULL,
  `anh_bai_viet` VARCHAR(255) NULL,
  `trang_thai` ENUM('published','hidden') NOT NULL DEFAULT 'published',
  `nhan_vien_id` BIGINT UNSIGNED NULL,
  `phan_loai_bai_viet_id` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bai_viets_slug_unique` (`slug`),
  INDEX `bai_viets_slug_index` (`slug`),
  INDEX `bai_viets_trang_thai_index` (`trang_thai`),
  INDEX `bai_viets_nhan_vien_id_index` (`nhan_vien_id`),
  INDEX `bai_viets_phan_loai_bai_viet_id_index` (`phan_loai_bai_viet_id`),
  CONSTRAINT `bai_viets_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bai_viets_phan_loai_bai_viet_id_foreign`
    FOREIGN KEY (`phan_loai_bai_viet_id`) REFERENCES `phan_loai_bai_viets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `binh_luans` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `noi_dung` TEXT NOT NULL,
  `bai_viet_id` BIGINT UNSIGNED NOT NULL,
  `khach_hang_id` BIGINT UNSIGNED NULL,
  `nhan_vien_id` BIGINT UNSIGNED NULL,
  `parent_id` BIGINT UNSIGNED NULL,
  `trang_thai` ENUM('active','hidden') NOT NULL DEFAULT 'active',
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `binh_luans_bai_viet_id_index` (`bai_viet_id`),
  INDEX `binh_luans_khach_hang_id_index` (`khach_hang_id`),
  INDEX `binh_luans_nhan_vien_id_index` (`nhan_vien_id`),
  INDEX `binh_luans_parent_id_index` (`parent_id`),
  INDEX `binh_luans_trang_thai_index` (`trang_thai`),
  CONSTRAINT `binh_luans_bai_viet_id_foreign`
    FOREIGN KEY (`bai_viet_id`) REFERENCES `bai_viets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `binh_luans_khach_hang_id_foreign`
    FOREIGN KEY (`khach_hang_id`) REFERENCES `khach_hangs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `binh_luans_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE CASCADE,
  CONSTRAINT `binh_luans_parent_id_foreign`
    FOREIGN KEY (`parent_id`) REFERENCES `binh_luans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `reactions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `loai` ENUM('like','dislike') NOT NULL,
  `reactionable_type` VARCHAR(255) NOT NULL,
  `reactionable_id` BIGINT UNSIGNED NOT NULL,
  `khach_hang_id` BIGINT UNSIGNED NULL,
  `nhan_vien_id` BIGINT UNSIGNED NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `reactions_reactionable_type_reactionable_id_index` (`reactionable_type`, `reactionable_id`),
  INDEX `reactions_khach_hang_id_index` (`khach_hang_id`),
  INDEX `reactions_nhan_vien_id_index` (`nhan_vien_id`),
  UNIQUE KEY `unique_reaction` (`reactionable_type`, `reactionable_id`, `khach_hang_id`, `nhan_vien_id`),
  CONSTRAINT `reactions_khach_hang_id_foreign`
    FOREIGN KEY (`khach_hang_id`) REFERENCES `khach_hangs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reactions_nhan_vien_id_foreign`
    FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
