-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for osx10.10 (x86_64)
--
-- Host: localhost    Database: Petty
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `phan_quyen_id` bigint(20) unsigned DEFAULT NULL,
  `ho_ten` varchar(255) NOT NULL,
  `anh_dai_dien` varchar(255) DEFAULT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `so_dien_thoai` varchar(255) DEFAULT NULL,
  `dia_chi` text DEFAULT NULL,
  `trang_thai` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`),
  KEY `admins_phan_quyen_id_foreign` (`phan_quyen_id`),
  CONSTRAINT `admins_phan_quyen_id_foreign` FOREIGN KEY (`phan_quyen_id`) REFERENCES `phan_quyens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,1,'Nguyen Van A',NULL,'$2y$12$5ELnvFlXe51XMRzh9Zgu6.KMkYiy9WA8vnfonUePOqRoI2u6CUBFW','admin1@example.com','0912345678','123 Duong ABC, Quan 1, TP.HCM',1,'2025-12-26 01:15:53','2025-12-26 01:15:56'),(2,1,'Tran Thi B',NULL,'$2y$12$wr8325AOaXbDiQdtEoc4Duy4spsH2dvR.2MRnZN1utMLLRIeueb/K','admin2@example.com','0987654321','456 Duong XYZ, Quan 3, TP.HCM',1,'2025-12-26 01:15:53','2025-12-26 01:15:56'),(3,1,'Le Van C',NULL,'$2y$12$xW04wRIsdszmWK1DWDXV5.CTYVfJwK9pEl/l.C4sW5Lylt8fiHBby','admin3@example.com','0901122334','789 Duong QWE, Quan 5, TP.HCM',1,'2025-12-26 01:15:53','2025-12-26 01:15:56');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bai_viets`
--

DROP TABLE IF EXISTS `bai_viets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bai_viets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ten_bai_viet` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `noi_dung` longtext NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `anh_bai_viet` varchar(255) DEFAULT NULL,
  `trang_thai` enum('published','hidden') NOT NULL DEFAULT 'published',
  `nhan_vien_id` bigint(20) unsigned DEFAULT NULL,
  `phan_loai_bai_viet_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bai_viets_slug_unique` (`slug`),
  KEY `bai_viets_trang_thai_index` (`trang_thai`),
  KEY `bai_viets_nhan_vien_id_index` (`nhan_vien_id`),
  KEY `bai_viets_phan_loai_bai_viet_id_index` (`phan_loai_bai_viet_id`),
  CONSTRAINT `bai_viets_nhan_vien_id_foreign` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bai_viets_phan_loai_bai_viet_id_foreign` FOREIGN KEY (`phan_loai_bai_viet_id`) REFERENCES `phan_loai_bai_viets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bai_viets`
--

LOCK TABLES `bai_viets` WRITE;
/*!40000 ALTER TABLE `bai_viets` DISABLE KEYS */;
INSERT INTO `bai_viets` VALUES (1,'Cách chăm sóc thú cưng trong mùa hè','cach-cham-soc-thu-cung-trong-mua-he','Mùa hè là thời kì khó khăn cho thú cưng của bạn. Dưới đây là những lời khuyên hữu ích để giúp thú cưng của bạn thoải mái hơn trong mùa nóng: 1. Cung cấp nước sạch đủ lượng. 2. Tìm chỗ mát mẻ cho thú cưng. 3. Không để thú cưng dưới ánh nắng trực tiếp quá lâu. 4. Tắm cho thú cưng thường xuyên. 5. Cắt lông cho thú cưng để giảm nhiệt độ cơ thể.','Những lời khuyên cơ bản để chăm sóc thú cưng trong mùa hè nóng bức.','/images/thu-cung-mua-he.jpg','published',1,1,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(2,'Các dấu hiệu sức khỏe cần chú ý ở chó','cac-dau-hieu-suc-khoe-can-chu-y-o-cho','Để bảo vệ sức khỏe của thú cưng, bạn cần biết những dấu hiệu cảnh báo. Các dấu hiệu như: tiêu chảy, nôn, chán ăn, mệt mỏi, hay thay đổi hành vi có thể là dấu hiệu của bệnh. Hãy đưa thú cưng đến bệnh viện thú y ngay lập tức nếu bạn nhận thấy những dấu hiệu này.','Nhận biết những dấu hiệu sức khỏe quan trọng ở chó để phát hiện bệnh sớm.','/images/dau-hieu-benh-cho.jpg','published',2,1,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(3,'Hướng dẫn tiêm vắc xin cho mèo','huong-dan-tiem-vac-xin-cho-meo','Tiêm vắc xin là một phần quan trọng trong việc chăm sóc mèo. Mèo cần được tiêm vắc xin thường xuyên để phòng ngừa các bệnh nguy hiểm. Lịch tiêm vắc xin cho mèo thường bắt đầu từ tuần thứ 6-8 tuổi. Hãy tham khảo ý kiến bác sĩ thú y để có lịch tiêm phù hợp.','Hướng dẫn chi tiết về lịch tiêm vắc xin cho mèo để đảm bảo sức khỏe.','/images/tiem-vac-xin-meo.jpg','published',1,2,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(4,'Dinh dưỡng tối ưu cho chó con','dinh-duong-toi-uu-cho-cho-con','Chó con cần có chế độ dinh dưỡng đặc biệt để phát triển khỏe mạnh. Thức ăn cho chó con phải chứa đủ protein, chất béo, vitamin và khoáng chất. Hãy lựa chọn thức ăn chuyên biệt dành cho chó con có tuổi thích hợp. Ngoài ra, cần cho chó con ăn theo lịch trình đều đặn mỗi ngày.','Những kiến thức cơ bản về dinh dưỡng cho chó con phát triển toàn diện.','/images/dinh-duong-cho-con.jpg','published',2,1,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(5,'Cách chọn thức ăn cho thú cưng đúng cách','cach-chon-thuc-an-cho-thu-cung-dung-cach','Lựa chọn thức ăn phù hợp là chìa khóa để duy trì sức khỏe của thú cưng. Bạn cần xem xét tuổi, kích thước, tình trạng sức khỏe của thú cưng. Thành phần thức ăn cũng rất quan trọng - hãy chọn thức ăn chứa đủ protein, chất béo và các chất dinh dưỡng khác. Tránh những thức ăn có chứa các chất gây hại.','Hướng dẫn chi tiết cách chọn thức ăn tốt nhất cho thú cưng của bạn.','/images/chon-thuc-an.jpg','published',1,3,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(6,'Huấn luyện thú cưng: Những điều cơ bản','huan-luyen-thu-cung-nhung-dieu-co-ban','Huấn luyện thú cưng là một quá trình dài và cần kiên nhẫn. Bắt đầu từ những lệnh đơn giản như \"nằm\", \"đứng\", \"đi\". Sử dụng phần thưởng để khuyến khích thú cưng tuân theo lệnh. Huấn luyện thường xuyên mỗi ngày để đạt kết quả tốt nhất. Hãy chọn thời gian phù hợp khi thú cưng tỉnh táo và tỏ ra hứng thú.','Những nguyên tắc cơ bản khi huấn luyện thú cưng của bạn.','/images/huan-luyen-thu-cung.jpg','published',2,2,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(7,'Phòng ngừa và điều trị ve trong cho thú cưng','phong-ngua-va-dieu-tri-ve-trong-cho-thu-cung','Ve trong là một vấn đề phổ biến ở thú cưng. Để phòng ngừa, hãy sử dụng những sản phẩm chuyên dụng như xịt, bột hoặc viên uống. Kiểm tra thú cưng thường xuyên để phát hiện ve sớm. Nếu phát hiện ve, sử dụng những loại thuốc khử trùng phù hợp và vệ sinh môi trường sống của thú cưng.','Hướng dẫn phòng ngừa và điều trị ve cho thú cưng hiệu quả.','/images/ve-trong-thu-cung.jpg','published',1,1,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(8,'Chăm sóc dữ đặt cho các loài chim cảnh','cham-soc-dau-tiet-cho-cac-loai-chim-canh','Các loài chim cảnh cần được chăm sóc đặc biệt. Lồng chim phải đủ lớn và thoáng khí. Cho chim ăn hạt chim chuyên dụng kết hợp với rau xanh và hoa quả. Cung cấp nước sạch hàng ngày. Vệ sinh lồng chim thường xuyên để tránh bệnh. Cho chim tắm nắng một thời gian mỗi ngày để duy trì sức khỏe.','Những kiến thức chi tiết về chăm sóc các loài chim cảnh trong nhà.','/images/chim-canh.jpg','hidden',2,3,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(9,'Sơ cứu thú cưng: Những kỹ năng cần thiết','so-cuu-thu-cung-nhung-ky-nang-can-thiet','Mỗi chủ thú cưng nên biết những kỹ năng sơ cứu cơ bản. Biết cách cấp cứu khi thú cưng bị sốc, chảy máu hoặc bị chấn thương. Chuẩn bị một hộp sơ cứu với các dụng cụ cần thiết. Giữ số điện thoại bác sĩ thú y gần tay. Trong trường hợp khẩn cấp, hãy gọi ngay bác sĩ thú y.','Những kỹ năng sơ cứu quan trọng để xử lý tình huống khẩn cấp với thú cưng.','/images/so-cuu-thu-cung.jpg','published',1,2,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(10,'Cách giữ vệ sinh cho thú cưng của bạn','cach-giu-ve-sinh-cho-thu-cung-cua-ban','Vệ sinh là rất quan trọng để duy trì sức khỏe của thú cưng. Tắm cho thú cưng thường xuyên với nước ấm và xà phòng chuyên dụng. Cắt móng cho thú cưng mỗi tháng một lần. Vệ sinh tai và mắt thường xuyên. Đánh răng cho thú cưng ít nhất 2-3 lần một tuần. Làm sạch vùng hậu môn thường xuyên để tránh bệnh.','Hướng dẫn giữ vệ sinh cơ bản cho thú cưng để chúng luôn khỏe mạnh.','/images/ve-sinh-thu-cung.jpg','published',2,1,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(11,'Hướng dẫn cách chăm sóc thú cưng','huong-dan-cach-cham-soc-thu-cung','dâdasdasdasdasdasdasdasdadasd','adasdasdasd','http://127.0.0.1:8000/storage/articles/images/hH8UwuyBELdWjlzXNc7pngKb3O9Pn0CxxoZeEz7b.png','published',1,1,'2025-12-26 04:22:28','2025-12-26 04:22:28');
/*!40000 ALTER TABLE `bai_viets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('5c785c036466adea360111aa28563bfd556b5fba','i:1;',1775528462),('5c785c036466adea360111aa28563bfd556b5fba:timer','i:1775528462;',1775528462);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_ho_so_benh_ans`
--

DROP TABLE IF EXISTS `chi_tiet_ho_so_benh_ans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chi_tiet_ho_so_benh_ans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_ho_so_benh_ans`
--

LOCK TABLES `chi_tiet_ho_so_benh_ans` WRITE;
/*!40000 ALTER TABLE `chi_tiet_ho_so_benh_ans` DISABLE KEYS */;
/*!40000 ALTER TABLE `chi_tiet_ho_so_benh_ans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_khuyen_mais`
--

DROP TABLE IF EXISTS `chi_tiet_khuyen_mais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chi_tiet_khuyen_mais` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_khuyen_mais`
--

LOCK TABLES `chi_tiet_khuyen_mais` WRITE;
/*!40000 ALTER TABLE `chi_tiet_khuyen_mais` DISABLE KEYS */;
/*!40000 ALTER TABLE `chi_tiet_khuyen_mais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_phieu_nhap_khos`
--

DROP TABLE IF EXISTS `chi_tiet_phieu_nhap_khos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chi_tiet_phieu_nhap_khos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `phieu_nhap_kho_id` bigint(20) unsigned NOT NULL,
  `hang_hoa_id` bigint(20) unsigned NOT NULL,
  `so_luong` int(11) NOT NULL,
  `so_lo` varchar(50) NOT NULL,
  `han_su_dung` date NOT NULL,
  `don_gia` decimal(15,2) NOT NULL,
  `thanh_tien` decimal(15,2) NOT NULL,
  `ghi_chu` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chi_tiet_phieu_nhap_khos_phieu_nhap_kho_id_foreign` (`phieu_nhap_kho_id`),
  KEY `chi_tiet_phieu_nhap_khos_hang_hoa_id_foreign` (`hang_hoa_id`),
  CONSTRAINT `chi_tiet_phieu_nhap_khos_hang_hoa_id_foreign` FOREIGN KEY (`hang_hoa_id`) REFERENCES `hang_hoas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chi_tiet_phieu_nhap_khos_phieu_nhap_kho_id_foreign` FOREIGN KEY (`phieu_nhap_kho_id`) REFERENCES `phieu_nhap_khos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_phieu_nhap_khos`
--

LOCK TABLES `chi_tiet_phieu_nhap_khos` WRITE;
/*!40000 ALTER TABLE `chi_tiet_phieu_nhap_khos` DISABLE KEYS */;
INSERT INTO `chi_tiet_phieu_nhap_khos` VALUES (1,1,3,15,'LO20251226344','2027-03-26',446887.00,6703305.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(2,1,5,91,'LO20251226259','2028-05-26',232728.00,21178248.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(3,1,1,27,'LO20251226126','2027-09-26',347700.00,9387900.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(4,2,3,98,'LO20251226918','2027-01-26',112838.00,11058124.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(5,2,5,30,'LO20251226590','2028-12-26',384118.00,11523540.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(6,2,2,97,'LO20251226734','2027-11-26',156852.00,15214644.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(7,2,6,39,'LO20251226659','2027-08-26',282229.00,11006931.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(8,2,4,94,'LO20251226580','2027-06-26',275353.00,25883182.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(9,3,8,71,'LO20251226874','2027-10-26',359453.00,25521163.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(10,3,10,22,'LO20251226731','2028-05-26',292319.00,6431018.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(11,3,2,17,'LO20251226426','2026-11-26',300792.00,5113464.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(12,3,6,100,'LO20251226508','2027-09-26',52553.00,5255300.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(13,4,10,29,'LO20251226665','2028-10-26',240399.00,6971571.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(14,4,6,29,'LO20251226616','2028-02-26',240420.00,6972180.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(15,4,7,62,'LO20251226199','2026-10-26',288704.00,17899648.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(16,5,7,80,'LO20251226222','2027-12-26',311444.00,24915520.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(17,5,1,69,'LO20251226414','2027-08-26',279632.00,19294608.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(18,5,5,91,'LO20251226213','2026-06-26',166790.00,15177890.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(19,6,3,76,'LO20251226992','2028-10-26',51807.00,3937332.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(20,6,1,77,'LO20251226943','2028-02-26',424294.00,32670638.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(21,6,2,57,'LO20251226304','2028-09-26',296933.00,16925181.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(22,6,7,14,'LO20251226324','2028-01-26',458215.00,6415010.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(23,6,2,59,'LO20251226877','2027-12-26',302045.00,17820655.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(24,7,7,93,'LO20251226126','2028-12-26',474691.00,44146263.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(25,7,1,97,'LO20251226389','2028-01-26',117875.00,11433875.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(26,7,7,17,'LO20251226649','2028-12-26',75563.00,1284571.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(27,7,8,44,'LO20251226896','2028-06-26',309936.00,13637184.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(28,8,6,59,'LO20251226653','2027-09-26',237187.00,13994033.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(29,8,6,85,'LO20251226192','2028-03-26',396569.00,33708365.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(30,8,6,41,'LO20251226436','2027-12-26',431889.00,17707449.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(31,8,4,40,'LO20251226212','2026-07-26',292726.00,11709040.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(32,9,9,83,'LO20251226696','2028-06-26',133023.00,11040909.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(33,9,8,52,'LO20251226137','2027-01-26',327489.00,17029428.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(34,10,6,13,'LO20251226719','2027-01-26',72915.00,947895.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(35,10,1,29,'LO20251226356','2028-09-26',157144.00,4557176.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(36,10,5,60,'LO20251226211','2026-11-26',169611.00,10176660.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56'),(37,10,7,86,'LO20251226129','2027-11-26',267290.00,22986940.00,'Hàng nhập mới, chất lượng tốt','2025-12-26 01:15:56','2025-12-26 01:15:56');
/*!40000 ALTER TABLE `chi_tiet_phieu_nhap_khos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danh_muc_dich_vu_khoa`
--

DROP TABLE IF EXISTS `danh_muc_dich_vu_khoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `danh_muc_dich_vu_khoa` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `danh_muc_dich_vu_id` bigint(20) unsigned NOT NULL,
  `khoa_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `danh_muc_dich_vu_khoa_danh_muc_dich_vu_id_khoa_id_unique` (`danh_muc_dich_vu_id`,`khoa_id`),
  KEY `danh_muc_dich_vu_khoa_khoa_id_foreign` (`khoa_id`),
  CONSTRAINT `danh_muc_dich_vu_khoa_danh_muc_dich_vu_id_foreign` FOREIGN KEY (`danh_muc_dich_vu_id`) REFERENCES `danh_muc_dich_vus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `danh_muc_dich_vu_khoa_khoa_id_foreign` FOREIGN KEY (`khoa_id`) REFERENCES `khoas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danh_muc_dich_vu_khoa`
--

LOCK TABLES `danh_muc_dich_vu_khoa` WRITE;
/*!40000 ALTER TABLE `danh_muc_dich_vu_khoa` DISABLE KEYS */;
/*!40000 ALTER TABLE `danh_muc_dich_vu_khoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danh_muc_dich_vus`
--

DROP TABLE IF EXISTS `danh_muc_dich_vus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `danh_muc_dich_vus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ten_nhom` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `danh_muc_dich_vus_ten_nhom_index` (`ten_nhom`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danh_muc_dich_vus`
--

LOCK TABLES `danh_muc_dich_vus` WRITE;
/*!40000 ALTER TABLE `danh_muc_dich_vus` DISABLE KEYS */;
INSERT INTO `danh_muc_dich_vus` VALUES (1,'Khám tổng quát','Khám và đánh giá toàn diện sức khỏe thú cưng','2025-12-26 01:15:53','2025-12-26 01:15:53'),(2,'Tiêm phòng','Các loại vắc-xin phòng bệnh theo lịch','2025-12-26 01:15:53','2025-12-26 01:15:53'),(3,'Cắt tỉa & Vệ sinh','Dịch vụ tỉa lông, cắt móng và tắm gội','2025-12-26 01:15:53','2025-12-26 01:15:53'),(4,'Khám nha khoa','Chăm sóc răng miệng, lấy cao răng và điều trị nhiễm trùng','2025-12-26 01:15:53','2025-12-26 01:15:53'),(5,'Siêu âm & Cận lâm sàng','Siêu âm, xét nghiệm máu và chẩn đoán hình ảnh','2025-12-26 01:15:53','2025-12-26 01:15:53'),(6,'Phẫu thuật','Phẫu thuật nhỏ và lớn, vô cảm và chăm sóc hậu phẫu','2025-12-26 01:15:53','2025-12-26 01:15:53'),(7,'Điều trị ký sinh trùng','Điều trị và phòng ngừa ve, rận và giun sán','2025-12-26 01:15:53','2025-12-26 01:15:53'),(8,'Dinh dưỡng & Tư vấn','Tư vấn chế độ ăn, cân nặng và dinh dưỡng đặc biệt','2025-12-26 01:15:53','2025-12-26 01:15:53'),(9,'Khám bệnh cấp cứu','Tiếp nhận và xử trí các trường hợp cấp cứu','2025-12-26 01:15:53','2025-12-26 01:15:53'),(10,'Thẩm mỹ & Phục hồi','Dịch vụ thẩm mỹ, phục hồi chức năng và vật lý trị liệu','2025-12-26 01:15:53','2025-12-26 01:15:53');
/*!40000 ALTER TABLE `danh_muc_dich_vus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `danh_muc_hang_hoas`
--

DROP TABLE IF EXISTS `danh_muc_hang_hoas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `danh_muc_hang_hoas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ten_danh_muc_hang_hoa` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `danh_muc_hang_hoas`
--

LOCK TABLES `danh_muc_hang_hoas` WRITE;
/*!40000 ALTER TABLE `danh_muc_hang_hoas` DISABLE KEYS */;
INSERT INTO `danh_muc_hang_hoas` VALUES (1,'Thuốc','Các loại thuốc điều trị','2025-12-26 01:15:55','2025-12-26 01:15:55'),(2,'Vật tư y tế','Các loại vật tư, dụng cụ y tế','2025-12-26 01:15:55','2025-12-26 01:15:55');
/*!40000 ALTER TABLE `danh_muc_hang_hoas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dich_vus`
--

DROP TABLE IF EXISTS `dich_vus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dich_vus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ten` varchar(255) NOT NULL,
  `ma_dich_vu` varchar(255) DEFAULT NULL,
  `gia_tien` decimal(15,2) NOT NULL DEFAULT 0.00,
  `thoi_gian_thuc_hien` int(10) unsigned DEFAULT NULL COMMENT 'minutes',
  `mo_ta` text DEFAULT NULL,
  `huong_dan` text DEFAULT NULL,
  `anh_dich_vu` varchar(255) DEFAULT NULL,
  `trang_thai` enum('kinh_doanh','ngung') NOT NULL DEFAULT 'kinh_doanh',
  `danh_muc_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dich_vus_ma_dich_vu_unique` (`ma_dich_vu`),
  KEY `dich_vus_ten_index` (`ten`),
  KEY `dich_vus_trang_thai_index` (`trang_thai`),
  KEY `dich_vus_danh_muc_id_index` (`danh_muc_id`),
  CONSTRAINT `dich_vus_danh_muc_id_foreign` FOREIGN KEY (`danh_muc_id`) REFERENCES `danh_muc_dich_vus` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dich_vus`
--

LOCK TABLES `dich_vus` WRITE;
/*!40000 ALTER TABLE `dich_vus` DISABLE KEYS */;
INSERT INTO `dich_vus` VALUES (1,'Khám tổng quát','DV001',200000.00,30,'Khám sức khỏe tổng quát cho thú cưng','Đưa thú cưng đến phòng khám, giữ yên trong quá trình khám','kham_tong_quat.jpg','kinh_doanh',NULL,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(2,'Vệ sinh tai','DV002',80000.00,15,'Làm sạch tai, kiểm tra nhiễm trùng','Không dùng tăm bông sâu vào ống tai, làm theo hướng dẫn nhân viên','vesinh_tai.jpg','kinh_doanh',NULL,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(3,'Cắt tỉa lông','DV003',150000.00,45,'Grooming cơ bản: tắm, sấy, cắt tỉa','Đặt lịch trước, đảm bảo thú cưng đã ăn nhẹ','cat_tia_long.jpg','kinh_doanh',NULL,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(4,'Tiêm phòng cơ bản','DV004',300000.00,10,'Tiêm phòng định kỳ (vắc-xin cơ bản)','Mang theo sổ tiêm chủng nếu có','tiem_phong.jpg','kinh_doanh',NULL,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(5,'Khám nha khoa','DV005',180000.00,30,'Kiểm tra răng miệng, làm sạch cao răng cơ bản','Không cho ăn trước khi làm sạch nếu được yêu cầu','kham_nha_khoa.jpg','kinh_doanh',NULL,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(6,'Phẫu thuật nhỏ','DV006',1200000.00,120,'Phẫu thuật nhỏ dưới gây mê','Nhịn ăn trước phẫu thuật theo hướng dẫn bác sĩ','phau_thuat_nho.jpg','ngung',NULL,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(7,'Siêu âm','DV007',350000.00,25,'Siêu âm chẩn đoán nội tạng','Không ăn vài giờ trước khi siêu âm bụng','sieu_am.jpg','kinh_doanh',NULL,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(8,'Xét nghiệm máu','DV008',250000.00,20,'Xét nghiệm công thức máu cơ bản','Không cho ăn trước khi lấy mẫu nếu cần','xet_nghiem_mau.jpg','kinh_doanh',NULL,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(9,'Triệt sản','DV009',1500000.00,90,'Triệt sản cho chó/mèo (bao gồm tiền mê và chăm sóc cơ bản)','Chuẩn bị theo hướng dẫn bác sĩ trước phẫu thuật','triet_sterilization.jpg','kinh_doanh',NULL,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(10,'Khám tai mũi họng','DV010',120000.00,20,'Khám chuyên khoa tai mũi họng','Đeo rọ mõm nếu cần khi khám','kham_tmh.jpg','kinh_doanh',NULL,'2025-12-26 01:15:53','2025-12-26 01:15:53');
/*!40000 ALTER TABLE `dich_vus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hang_hoas`
--

DROP TABLE IF EXISTS `hang_hoas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hang_hoas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ma_hang_hoa` varchar(255) NOT NULL,
  `ten_mat_hang` varchar(255) NOT NULL,
  `don_vi_tinh` varchar(255) NOT NULL,
  `gia_von` decimal(12,2) NOT NULL,
  `gia_ban` decimal(12,2) NOT NULL,
  `dinh_muc_toi_thieu` int(11) NOT NULL DEFAULT 0,
  `anh_san_pham` varchar(255) DEFAULT NULL,
  `tinh_trang` enum('hoat_dong','ngung_kinh_doanh') NOT NULL DEFAULT 'hoat_dong',
  `danh_muc_hang_hoa_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hang_hoas_ma_hang_hoa_unique` (`ma_hang_hoa`),
  KEY `hang_hoas_danh_muc_hang_hoa_id_foreign` (`danh_muc_hang_hoa_id`),
  CONSTRAINT `hang_hoas_danh_muc_hang_hoa_id_foreign` FOREIGN KEY (`danh_muc_hang_hoa_id`) REFERENCES `danh_muc_hang_hoas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hang_hoas`
--

LOCK TABLES `hang_hoas` WRITE;
/*!40000 ALTER TABLE `hang_hoas` DISABLE KEYS */;
INSERT INTO `hang_hoas` VALUES (1,'HH001','Thuốc kháng sinh Amoxicillin','Lọ',50000.00,75000.00,10,'products/amoxicillin.jpg','hoat_dong',1,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(2,'HH002','Thuốc hạ sốt Paracetamol','Vỉ',8000.00,12000.00,20,'products/paracetamol.jpg','hoat_dong',1,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(3,'HH003','Băng cứu vãn y tế','Cuộn',15000.00,25000.00,15,'products/bandage.jpg','hoat_dong',2,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(4,'HH004','Nước muối sinh lý','Chai',12000.00,18000.00,25,'products/saline.jpg','hoat_dong',2,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(5,'HH005','Kháng sinh tịnh mạch Ceftriaxone','Chai',80000.00,120000.00,5,'products/ceftriaxone.jpg','hoat_dong',1,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(6,'HH006','Kem mỡ vết thương','Tuýp',20000.00,35000.00,12,'products/wound_cream.jpg','hoat_dong',2,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(7,'HH007','Vitamin B12 tiêm','Lọ',35000.00,55000.00,8,'products/vitamin_b12.jpg','hoat_dong',1,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(8,'HH008','Khẩu trang y tế 3 lớp','Hộp',45000.00,65000.00,30,'products/mask.jpg','hoat_dong',2,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(9,'HH009','Bông y tế vô trùng','Gói',5000.00,8000.00,50,'products/cotton.jpg','hoat_dong',2,'2025-12-26 01:15:55','2025-12-26 01:15:55'),(10,'HH010','Thuốc hạ huyết áp Lisinopril','Vỉ',25000.00,40000.00,15,'products/lisinopril.jpg','hoat_dong',1,'2025-12-26 01:15:55','2025-12-26 01:15:55');
/*!40000 ALTER TABLE `hang_hoas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ho_so_benh_ans`
--

DROP TABLE IF EXISTS `ho_so_benh_ans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ho_so_benh_ans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ma_benh_an` varchar(50) NOT NULL COMMENT 'Mã bệnh án duy nhất',
  `noi_dung` text NOT NULL COMMENT 'Nội dung chi tiết bệnh án',
  `khach_hang_id` bigint(20) unsigned DEFAULT NULL,
  `thu_cung_id` bigint(20) unsigned DEFAULT NULL,
  `nhan_vien_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ho_so_benh_ans_ma_benh_an_unique` (`ma_benh_an`),
  KEY `ho_so_benh_ans_khach_hang_id_foreign` (`khach_hang_id`),
  KEY `ho_so_benh_ans_thu_cung_id_foreign` (`thu_cung_id`),
  KEY `ho_so_benh_ans_nhan_vien_id_foreign` (`nhan_vien_id`),
  KEY `ho_so_benh_ans_ma_benh_an_index` (`ma_benh_an`),
  CONSTRAINT `ho_so_benh_ans_khach_hang_id_foreign` FOREIGN KEY (`khach_hang_id`) REFERENCES `khach_hangs` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ho_so_benh_ans_nhan_vien_id_foreign` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL,
  CONSTRAINT `ho_so_benh_ans_thu_cung_id_foreign` FOREIGN KEY (`thu_cung_id`) REFERENCES `thu_cungs` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ho_so_benh_ans`
--

LOCK TABLES `ho_so_benh_ans` WRITE;
/*!40000 ALTER TABLE `ho_so_benh_ans` DISABLE KEYS */;
/*!40000 ALTER TABLE `ho_so_benh_ans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khach_hangs`
--

DROP TABLE IF EXISTS `khach_hangs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `khach_hangs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `rank` enum('Silver','Gold','Diamond') NOT NULL DEFAULT 'Silver',
  `anh_dai_dien` varchar(255) DEFAULT NULL,
  `trang_thai` varchar(255) NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `khach_hangs_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khach_hangs`
--

LOCK TABLES `khach_hangs` WRITE;
/*!40000 ALTER TABLE `khach_hangs` DISABLE KEYS */;
INSERT INTO `khach_hangs` VALUES (1,'ctran13904@gmail.com',NULL,NULL,NULL,'Cường Mạnh',NULL,'Silver','https://lh3.googleusercontent.com/a/ACg8ocI84M7mJlxXTPCGSSOalwlhLpDYtWFQhf6jt7LnCk-HH5zyK90=s96-c','active','2025-12-26 01:19:26','2025-12-26 01:19:26');
/*!40000 ALTER TABLE `khach_hangs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khoa_nhan_vien`
--

DROP TABLE IF EXISTS `khoa_nhan_vien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `khoa_nhan_vien` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `khoa_id` bigint(20) unsigned NOT NULL,
  `nhan_vien_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `khoa_nhan_vien_khoa_id_nhan_vien_id_unique` (`khoa_id`,`nhan_vien_id`),
  KEY `khoa_nhan_vien_nhan_vien_id_foreign` (`nhan_vien_id`),
  CONSTRAINT `khoa_nhan_vien_khoa_id_foreign` FOREIGN KEY (`khoa_id`) REFERENCES `khoas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `khoa_nhan_vien_nhan_vien_id_foreign` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khoa_nhan_vien`
--

LOCK TABLES `khoa_nhan_vien` WRITE;
/*!40000 ALTER TABLE `khoa_nhan_vien` DISABLE KEYS */;
/*!40000 ALTER TABLE `khoa_nhan_vien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khoas`
--

DROP TABLE IF EXISTS `khoas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `khoas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ma_khoa` varchar(255) NOT NULL,
  `ten_khoa` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `chuyen_mon` varchar(255) DEFAULT NULL,
  `trang_thai` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `khoas_ma_khoa_unique` (`ma_khoa`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khoas`
--

LOCK TABLES `khoas` WRITE;
/*!40000 ALTER TABLE `khoas` DISABLE KEYS */;
INSERT INTO `khoas` VALUES (1,'KHOA001','Khoa Nội Tổng Quát','Chuyên khám và điều trị các bệnh nội khoa cho thú cưng.','Nội khoa',1,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(2,'KHOA002','Khoa Ngoại','Thực hiện các phẫu thuật và thủ thuật cho thú nuôi.','Ngoại khoa',1,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(3,'KHOA003','Khoa Răng Miệng','Chăm sóc sức khỏe răng miệng, làm sạch và nhổ răng.','Nha khoa',1,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(4,'KHOA004','Khoa Da Liễu','Chẩn đoán và điều trị các bệnh da cho thú cưng.','Da liễu',1,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(5,'KHOA005','Khoa Sản','Chăm sóc sinh sản, đỡ đẻ và theo dõi thai sản cho thú.','Sản',1,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(6,'KHOA006','Khoa Chẩn Đoán Hình Ảnh','Thực hiện siêu âm, X-quang và các xét nghiệm hình ảnh.','Chẩn đoán hình ảnh',1,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(7,'KHOA007','Khoa Cấp Cứu','Xử lý các trường hợp cấp cứu và chăm sóc khẩn cấp.','Cấp cứu',1,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(8,'KHOA008','Khoa Tiêm Chủng','Thực hiện các chương trình tiêm phòng và phòng bệnh.','Tiêm chủng',1,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(9,'KHOA009','Khoa Dinh Dưỡng','Tư vấn dinh dưỡng và chế độ ăn cho thú cưng.','Dinh dưỡng',1,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(10,'KHOA010','Khoa Vật Lý Trị Liệu','Hỗ trợ phục hồi chức năng cho thú sau chấn thương.','Vật lý trị liệu',1,'2025-12-26 01:15:53','2025-12-26 01:15:53');
/*!40000 ALTER TABLE `khoas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khuyen_mai_dich_vu`
--

DROP TABLE IF EXISTS `khuyen_mai_dich_vu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `khuyen_mai_dich_vu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `khuyen_mai_id` bigint(20) unsigned NOT NULL,
  `dich_vu_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `khuyen_mai_dich_vu_khuyen_mai_id_dich_vu_id_unique` (`khuyen_mai_id`,`dich_vu_id`),
  KEY `khuyen_mai_dich_vu_dich_vu_id_foreign` (`dich_vu_id`),
  CONSTRAINT `khuyen_mai_dich_vu_dich_vu_id_foreign` FOREIGN KEY (`dich_vu_id`) REFERENCES `dich_vus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `khuyen_mai_dich_vu_khuyen_mai_id_foreign` FOREIGN KEY (`khuyen_mai_id`) REFERENCES `khuyen_mais` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khuyen_mai_dich_vu`
--

LOCK TABLES `khuyen_mai_dich_vu` WRITE;
/*!40000 ALTER TABLE `khuyen_mai_dich_vu` DISABLE KEYS */;
/*!40000 ALTER TABLE `khuyen_mai_dich_vu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khuyen_mais`
--

DROP TABLE IF EXISTS `khuyen_mais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `khuyen_mais` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ten_khuyen_mai` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `loai_khuyen_mai` enum('ma_giam_gia','chuong_trinh_tu_dong') NOT NULL DEFAULT 'ma_giam_gia',
  `ma_code` varchar(255) DEFAULT NULL,
  `gia_tri_don_toi_thieu` decimal(15,2) DEFAULT NULL,
  `loai_khach_hang` enum('tat_ca','vip') NOT NULL DEFAULT 'tat_ca',
  `hinh_thuc_giam` enum('phan_tram','so_tien') NOT NULL DEFAULT 'phan_tram',
  `giam_toi_da` decimal(15,2) DEFAULT NULL,
  `gia_tri_giam` decimal(15,2) NOT NULL,
  `tu_ngay` datetime NOT NULL,
  `den_ngay` datetime NOT NULL,
  `tong_so_luong` int(11) DEFAULT NULL,
  `so_luong_da_dung` int(11) NOT NULL DEFAULT 0,
  `gioi_han_moi_khach` int(11) DEFAULT NULL,
  `trang_thai` enum('dang_chay','da_ket_thuc') NOT NULL DEFAULT 'dang_chay',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `khuyen_mais_ma_code_unique` (`ma_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khuyen_mais`
--

LOCK TABLES `khuyen_mais` WRITE;
/*!40000 ALTER TABLE `khuyen_mais` DISABLE KEYS */;
INSERT INTO `khuyen_mais` VALUES (1,'Ưu dãi tết','adasđ','ma_giam_gia','SALE11',150000.00,'tat_ca','phan_tram',100000.00,10.00,'2025-12-27 00:00:00','2025-12-28 00:00:00',100,0,1,'da_ket_thuc','2025-12-26 04:26:21','2026-03-18 02:47:42');
/*!40000 ALTER TABLE `khuyen_mais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kiem_kes`
--

DROP TABLE IF EXISTS `kiem_kes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kiem_kes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `hang_hoa_id` bigint(20) unsigned NOT NULL,
  `chi_tiet_phieu_nhap_kho_id` bigint(20) unsigned DEFAULT NULL,
  `so_luong_he_thong` int(11) NOT NULL DEFAULT 0 COMMENT 'Số lượng theo hệ thống',
  `so_luong_thuc_te` int(11) NOT NULL DEFAULT 0 COMMENT 'Số lượng thực tế kiểm',
  `chenh_lech` int(11) NOT NULL DEFAULT 0 COMMENT 'Chênh lệch = Thực tế - Hệ thống',
  `ly_do` varchar(255) DEFAULT NULL COMMENT 'Lý do chênh lệch',
  `ngay_kiem_ke` date NOT NULL COMMENT 'Ngày kiểm kê',
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `nhan_vien_id` bigint(20) unsigned DEFAULT NULL,
  `nguoi_kiem_ke_type` varchar(255) DEFAULT NULL COMMENT 'Admin hoặc NhanVien',
  `ghi_chu` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kiem_kes_hang_hoa_id_foreign` (`hang_hoa_id`),
  KEY `kiem_kes_chi_tiet_phieu_nhap_kho_id_foreign` (`chi_tiet_phieu_nhap_kho_id`),
  KEY `kiem_kes_admin_id_foreign` (`admin_id`),
  KEY `kiem_kes_nhan_vien_id_foreign` (`nhan_vien_id`),
  CONSTRAINT `kiem_kes_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `kiem_kes_chi_tiet_phieu_nhap_kho_id_foreign` FOREIGN KEY (`chi_tiet_phieu_nhap_kho_id`) REFERENCES `chi_tiet_phieu_nhap_khos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `kiem_kes_hang_hoa_id_foreign` FOREIGN KEY (`hang_hoa_id`) REFERENCES `hang_hoas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `kiem_kes_nhan_vien_id_foreign` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kiem_kes`
--

LOCK TABLES `kiem_kes` WRITE;
/*!40000 ALTER TABLE `kiem_kes` DISABLE KEYS */;
INSERT INTO `kiem_kes` VALUES (1,1,1,100,95,-5,'Phát hiện 5 lọ thuốc bị vỡ trong quá trình vận chuyển','2025-11-26',1,NULL,'Admin','Đã báo cáo bộ phận kho','2025-11-26 01:15:56','2025-11-26 01:15:56'),(2,2,2,200,200,0,NULL,'2025-11-28',NULL,1,'NhanVien','Số lượng chính xác','2025-11-28 01:15:56','2025-11-28 01:15:56'),(3,3,3,150,148,-2,'Hai hộp thức ăn bị hết hạn sử dụng, đã loại bỏ','2025-12-01',1,NULL,'Admin','Cần kiểm tra kỹ hạn sử dụng khi nhập kho','2025-12-01 01:15:56','2025-12-01 01:15:56'),(4,4,4,80,85,5,'Phát hiện thêm 5 lọ vaccine trong kho lạnh phụ chưa được cập nhật','2025-12-04',NULL,2,'NhanVien','Đã cập nhật vào hệ thống','2025-12-04 01:15:56','2025-12-04 01:15:56'),(5,5,5,300,290,-10,'Sử dụng khẩn cấp cho ca cấp cứu chưa kịp cập nhật','2025-12-06',1,NULL,'Admin','Đã yêu cầu nhân viên cập nhật đúng quy trình','2025-12-06 01:15:56','2025-12-06 01:15:56'),(6,6,6,120,120,0,NULL,'2025-12-08',NULL,1,'NhanVien','Kiểm kê định kỳ - Không có sai lệch','2025-12-08 01:15:56','2025-12-08 01:15:56'),(7,7,7,250,252,2,'Nhà cung cấp giao thừa 2 gói, chưa xuất hóa đơn','2025-12-11',1,NULL,'Admin','Đã liên hệ nhà cung cấp để xác nhận','2025-12-11 01:15:56','2025-12-11 01:15:56'),(8,8,8,180,175,-5,'Sản phẩm bị hư hỏng do lưu trữ không đúng cách','2025-12-14',NULL,2,'NhanVien','Cần cải thiện điều kiện bảo quản','2025-12-14 01:15:56','2025-12-14 01:15:56'),(9,9,9,90,90,0,NULL,'2025-12-16',1,NULL,'Admin','Kiểm kê đột xuất - Kết quả chính xác','2025-12-16 01:15:56','2025-12-16 01:15:56'),(10,10,10,400,387,-13,'Phát hiện mất mát do nhập liệu sai trong đơn hàng trước','2025-12-21',NULL,1,'NhanVien','Đã điều chỉnh lại số liệu trong hệ thống','2025-12-21 01:15:56','2025-12-21 01:15:56');
/*!40000 ALTER TABLE `kiem_kes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lich_dang_kys`
--

DROP TABLE IF EXISTS `lich_dang_kys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lich_dang_kys` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ngay_gio` datetime NOT NULL COMMENT 'Ngày giờ đăng ký khám',
  `ghi_chu` text DEFAULT NULL COMMENT 'Ghi chú của khách hàng',
  `trang_thai` varchar(50) NOT NULL DEFAULT 'chua_xac_nhan' COMMENT 'Trạng thái: chua_xac_nhan, da_xac_nhan, tu_choi',
  `nhan_vien_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `lich_lam_viec_id` bigint(20) unsigned DEFAULT NULL,
  `khach_hang_id` bigint(20) unsigned DEFAULT NULL,
  `thu_cung_id` bigint(20) unsigned DEFAULT NULL,
  `dich_vu_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lich_dang_kys_nhan_vien_id_foreign` (`nhan_vien_id`),
  KEY `lich_dang_kys_admin_id_foreign` (`admin_id`),
  KEY `lich_dang_kys_lich_lam_viec_id_foreign` (`lich_lam_viec_id`),
  KEY `lich_dang_kys_khach_hang_id_foreign` (`khach_hang_id`),
  KEY `lich_dang_kys_thu_cung_id_foreign` (`thu_cung_id`),
  KEY `lich_dang_kys_dich_vu_id_foreign` (`dich_vu_id`),
  KEY `lich_dang_kys_ngay_gio_index` (`ngay_gio`),
  KEY `lich_dang_kys_trang_thai_index` (`trang_thai`),
  CONSTRAINT `lich_dang_kys_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_dang_kys_dich_vu_id_foreign` FOREIGN KEY (`dich_vu_id`) REFERENCES `dich_vus` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_dang_kys_khach_hang_id_foreign` FOREIGN KEY (`khach_hang_id`) REFERENCES `khach_hangs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lich_dang_kys_lich_lam_viec_id_foreign` FOREIGN KEY (`lich_lam_viec_id`) REFERENCES `lich_lam_viecs` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_dang_kys_nhan_vien_id_foreign` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_dang_kys_thu_cung_id_foreign` FOREIGN KEY (`thu_cung_id`) REFERENCES `thu_cungs` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_dang_kys`
--

LOCK TABLES `lich_dang_kys` WRITE;
/*!40000 ALTER TABLE `lich_dang_kys` DISABLE KEYS */;
/*!40000 ALTER TABLE `lich_dang_kys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lich_hens`
--

DROP TABLE IF EXISTS `lich_hens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lich_hens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ngay_gio` datetime NOT NULL,
  `ghi_chu` text DEFAULT NULL,
  `huong_dan` text DEFAULT NULL,
  `trang_thai` varchar(50) NOT NULL DEFAULT 'pending',
  `nguon_goc` varchar(100) DEFAULT NULL COMMENT 'Nguồn gốc đặt lịch (online, phone, walk-in, etc.)',
  `thoi_gian_checkin` datetime DEFAULT NULL COMMENT 'Thời gian khách hàng check-in',
  `y_ta_checkin_id` bigint(20) unsigned DEFAULT NULL COMMENT 'ID y tá thực hiện check-in',
  `thoi_gian_bat_dau_kham` datetime DEFAULT NULL COMMENT 'Thời gian bắt đầu khám',
  `thoi_gian_hoan_thanh` datetime DEFAULT NULL COMMENT 'Thời gian hoàn thành khám',
  `khach_hang_id` bigint(20) unsigned NOT NULL,
  `thu_cung_id` bigint(20) unsigned NOT NULL,
  `dich_vu_id` bigint(20) unsigned DEFAULT NULL,
  `thanh_toan_id` bigint(20) unsigned DEFAULT NULL,
  `nhan_vien_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lich_hens_khach_hang_id_foreign` (`khach_hang_id`),
  KEY `lich_hens_thu_cung_id_foreign` (`thu_cung_id`),
  KEY `lich_hens_trang_thai_index` (`trang_thai`),
  KEY `lich_hens_dich_vu_id_index` (`dich_vu_id`),
  KEY `lich_hens_thanh_toan_id_index` (`thanh_toan_id`),
  KEY `lich_hens_nhan_vien_id_index` (`nhan_vien_id`),
  KEY `fk_lich_hen_y_ta_checkin` (`y_ta_checkin_id`),
  CONSTRAINT `fk_lich_hen_y_ta_checkin` FOREIGN KEY (`y_ta_checkin_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_hens_dich_vu_id_foreign` FOREIGN KEY (`dich_vu_id`) REFERENCES `dich_vus` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_hens_khach_hang_id_foreign` FOREIGN KEY (`khach_hang_id`) REFERENCES `khach_hangs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lich_hens_nhan_vien_id_foreign` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_hens_thanh_toan_id_foreign` FOREIGN KEY (`thanh_toan_id`) REFERENCES `thanh_toans` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_hens_thu_cung_id_foreign` FOREIGN KEY (`thu_cung_id`) REFERENCES `thu_cungs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_hens`
--

LOCK TABLES `lich_hens` WRITE;
/*!40000 ALTER TABLE `lich_hens` DISABLE KEYS */;
INSERT INTO `lich_hens` VALUES (1,'2025-12-27 11:00:00','Phương thức: offline',NULL,'in-progress',NULL,'2025-12-26 11:14:51',2,'2025-12-26 11:15:47',NULL,1,11,3,NULL,1,'2025-12-26 04:02:39','2025-12-26 04:15:47'),(2,'2026-03-27 11:00:00','Phương thức: offline',NULL,'pending',NULL,NULL,NULL,NULL,NULL,1,11,3,NULL,NULL,'2026-03-24 01:21:21','2026-03-24 01:21:21'),(3,'2026-04-02 13:30:00','Phương thức: offline',NULL,'pending','online',NULL,NULL,NULL,NULL,1,11,3,NULL,NULL,'2026-04-01 03:18:52','2026-04-01 03:18:52');
/*!40000 ALTER TABLE `lich_hens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lich_lam_viecs`
--

DROP TABLE IF EXISTS `lich_lam_viecs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lich_lam_viecs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ngay_lam` date NOT NULL,
  `phong_truc` varchar(255) NOT NULL,
  `thoi_gian_truc` enum('ca_sang','ca_chieu','ca_toi') NOT NULL,
  `nhan_vien_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lich_lam_viecs_nhan_vien_id` (`nhan_vien_id`),
  CONSTRAINT `fk_lich_lam_viecs_nhan_vien_id` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_lam_viecs`
--

LOCK TABLES `lich_lam_viecs` WRITE;
/*!40000 ALTER TABLE `lich_lam_viecs` DISABLE KEYS */;
INSERT INTO `lich_lam_viecs` VALUES (1,'2025-12-26','Phòng Khám A','ca_sang',1,'2025-12-26 01:15:55','2025-12-26 01:15:55',NULL),(2,'2025-12-27','Phòng Khám B','ca_chieu',2,'2025-12-26 01:15:55','2025-12-26 01:15:55',NULL),(3,'2025-12-28','Phòng Trực 1','ca_toi',3,'2025-12-26 01:15:55','2025-12-26 01:15:55',NULL),(4,'2025-12-29','Phòng Trực 2','ca_sang',4,'2025-12-26 01:15:55','2025-12-26 01:15:55',NULL),(5,'2025-12-30','Phòng Khám A','ca_chieu',5,'2025-12-26 01:15:55','2025-12-26 01:15:55',NULL),(6,'2025-12-31','Phòng Khám B','ca_toi',6,'2025-12-26 01:15:55','2025-12-26 01:15:55',NULL),(7,'2026-01-01','Phòng Trực 1','ca_sang',7,'2025-12-26 01:15:55','2025-12-26 01:15:55',NULL),(8,'2026-01-02','Phòng Trực 2','ca_chieu',8,'2025-12-26 01:15:55','2025-12-26 01:15:55',NULL),(9,'2026-01-03','Phòng Khám A','ca_toi',9,'2025-12-26 01:15:55','2025-12-26 01:15:55',NULL),(10,'2026-01-04','Phòng Khám B','ca_sang',10,'2025-12-26 01:15:55','2025-12-26 01:15:55',NULL);
/*!40000 ALTER TABLE `lich_lam_viecs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lich_nhacs`
--

DROP TABLE IF EXISTS `lich_nhacs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lich_nhacs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ngay_nhac` datetime NOT NULL COMMENT 'Ngày giờ nhắc nhở',
  `phan_loai` varchar(100) NOT NULL COMMENT 'Loại nhắc nhở: tái khám, tiêm phòng, xét nghiệm, thuốc, khác',
  `noi_dung` text NOT NULL COMMENT 'Nội dung nhắc nhở',
  `ghi_chu` text DEFAULT NULL COMMENT 'Ghi chú thêm',
  `trang_thai` varchar(50) NOT NULL DEFAULT 'chua_gui' COMMENT 'Trạng thái: chua_gui, da_gui, hoan_thanh, huy',
  `ho_so_benh_an_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lich_nhacs_ho_so_benh_an_id_foreign` (`ho_so_benh_an_id`),
  KEY `lich_nhacs_ngay_nhac_index` (`ngay_nhac`),
  KEY `lich_nhacs_trang_thai_index` (`trang_thai`),
  KEY `lich_nhacs_phan_loai_index` (`phan_loai`),
  CONSTRAINT `lich_nhacs_ho_so_benh_an_id_foreign` FOREIGN KEY (`ho_so_benh_an_id`) REFERENCES `ho_so_benh_ans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_nhacs`
--

LOCK TABLES `lich_nhacs` WRITE;
/*!40000 ALTER TABLE `lich_nhacs` DISABLE KEYS */;
/*!40000 ALTER TABLE `lich_nhacs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lich_su_thanh_toan_phieu_chis`
--

DROP TABLE IF EXISTS `lich_su_thanh_toan_phieu_chis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lich_su_thanh_toan_phieu_chis` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `phieu_chi_id` bigint(20) unsigned NOT NULL,
  `so_tien_thanh_toan` decimal(15,2) NOT NULL COMMENT 'Số tiền thanh toán lần này',
  `hinh_thuc_thanh_toan` enum('tien_mat','chuyen_khoan','ca_hai') NOT NULL DEFAULT 'tien_mat' COMMENT 'Hình thức thanh toán',
  `tien_mat` decimal(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Số tiền mặt',
  `tien_chuyen_khoan` decimal(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Số tiền chuyển khoản',
  `ghi_chu` text DEFAULT NULL COMMENT 'Ghi chú thanh toán',
  `so_tien_da_tra_truoc_do` decimal(15,2) NOT NULL COMMENT 'Tổng đã trả trước đó',
  `so_tien_con_no_sau_thanh_toan` decimal(15,2) NOT NULL COMMENT 'Còn nợ sau khi thanh toán lần này',
  `ngay_thanh_toan` datetime NOT NULL COMMENT 'Ngày giờ thanh toán',
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `nhan_vien_id` bigint(20) unsigned DEFAULT NULL,
  `nguoi_thanh_toan_type` varchar(255) DEFAULT NULL COMMENT 'Admin hoặc NhanVien',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lich_su_thanh_toan_phieu_chis_admin_id_foreign` (`admin_id`),
  KEY `lich_su_thanh_toan_phieu_chis_nhan_vien_id_foreign` (`nhan_vien_id`),
  KEY `lich_su_thanh_toan_phieu_chis_phieu_chi_id_index` (`phieu_chi_id`),
  KEY `lich_su_thanh_toan_phieu_chis_ngay_thanh_toan_index` (`ngay_thanh_toan`),
  CONSTRAINT `lich_su_thanh_toan_phieu_chis_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_su_thanh_toan_phieu_chis_nhan_vien_id_foreign` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lich_su_thanh_toan_phieu_chis_phieu_chi_id_foreign` FOREIGN KEY (`phieu_chi_id`) REFERENCES `phieu_chis` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lich_su_thanh_toan_phieu_chis`
--

LOCK TABLES `lich_su_thanh_toan_phieu_chis` WRITE;
/*!40000 ALTER TABLE `lich_su_thanh_toan_phieu_chis` DISABLE KEYS */;
/*!40000 ALTER TABLE `lich_su_thanh_toan_phieu_chis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2025_11_22_123138_create_personal_access_tokens_table',1),(5,'2025_11_22_123342_create_khach_hangs_table',1),(6,'2025_11_24_085053_create_social_accounts_table',1),(7,'2025_11_24_100838_add_email_verified_at_to_khach_hangs_table',1),(8,'2025_11_25_021337_create_thu_cungs_table',1),(9,'2025_11_25_130000_add_khach_hang_id_to_thu_cungs_table',1),(10,'2025_11_25_134928_create_lich_hens_table',1),(11,'2025_11_25_135103_create_dich_vus_table',1),(12,'2025_11_25_135132_create_thanh_toans_table',1),(13,'2025_11_25_135200_create_nhan_viens_table',1),(14,'2025_11_25_140436_create_danh_muc_dich_vus_table',1),(15,'2025_11_25_140700_add_foreign_keys_to_lich_hens_table',1),(16,'2025_11_28_133251_create_admins_table',1),(17,'2025_11_28_143809_create_khoas_table',1),(18,'2025_11_28_150000_create_danh_muc_dich_vu_khoa_table',1),(19,'2025_11_28_150001_create_khoa_nhan_vien_table',1),(20,'2025_12_02_120000_add_foreign_key_to_dich_vus_table',1),(21,'2025_12_02_130000_add_fields_to_dich_vus_table',1),(22,'2025_12_02_145302_create_danh_muc_hang_hoas_table',1),(23,'2025_12_02_145308_create_hang_hoas_table',1),(24,'2025_12_03_015855_create_lich_lam_viecs_table',1),(25,'2025_12_03_030000_update_lich_lam_viecs_make_fields_required',1),(26,'2025_12_04_030955_create_bai_viets_table',1),(27,'2025_12_04_031306_create_phan_loai_bai_viets_table',1),(28,'2025_12_04_032000_add_foreign_keys_to_bai_viets_table',1),(29,'2025_12_04_075720_create_khuyen_mais_table',1),(30,'2025_12_04_080125_create_chi_tiet_khuyen_mais_table',1),(31,'2025_12_05_131847_create_nha_cung_caps_table',1),(32,'2025_12_05_132049_create_phieu_chis_table',1),(33,'2025_12_05_132050_create_phieu_nhap_khos_table',1),(34,'2025_12_05_141222_create_chi_tiet_phieu_nhap_khos_table',1),(35,'2025_12_05_145633_add_admin_id_to_phieu_nhap_khos_table',1),(36,'2025_12_05_145639_add_admin_id_to_phieu_nhap_khos_table',1),(37,'2025_12_05_150835_make_nhan_vien_id_nullable_in_phieu_chis_table',1),(38,'2025_12_05_150926_make_nhan_vien_id_nullable_in_phieu_nhap_khos_table',1),(39,'2025_12_05_151622_make_ghi_chu_nullable_in_multiple_tables',1),(40,'2025_12_06_031351_create_kiem_kes_table',1),(41,'2025_12_06_124853_create_lich_su_thanh_toan_phieu_chis_table',1),(42,'2025_12_06_133758_create_khuyen_mai_dich_vu_table',1),(43,'2025_12_06_142152_create_phan_quyens_table',1),(44,'2025_12_06_143118_add_phan_quyen_id_to_admins_and_nhan_viens_table',1),(45,'2025_12_10_140952_add_additional_fields_to_lich_hens_table',1),(46,'2025_12_10_143200_create_ho_so_benh_ans_table',1),(47,'2025_12_10_143226_create_chi_tiet_ho_so_benh_ans_table',1),(48,'2025_12_10_143307_create_lich_nhacs_table',1),(49,'2025_12_10_143950_create_ho_so_benh_ans_table',1),(50,'2025_12_11_023418_add_lich_nhac_permissions_to_phan_quyens_table',1),(51,'2025_12_11_024340_create_lich_dang_kys_table',1),(52,'2025_12_11_025550_update_lich_dang_kys_status_to_two_states',1),(53,'2025_12_11_030904_add_tu_choi_status_to_lich_dang_kys',1),(54,'2025_12_11_030912_add_tu_choi_status_to_lich_dang_kys',1),(55,'2025_12_11_070905_make_khach_hang_id_nullable_in_lich_dang_kys',1),(56,'2025_12_13_000000_add_y_ta_checkin_id_to_lich_hens_table',1),(57,'2025_12_16_015942_create_phieu_khams_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nha_cung_caps`
--

DROP TABLE IF EXISTS `nha_cung_caps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nha_cung_caps` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ma_nha_cung_cap` varchar(50) NOT NULL,
  `ten_nha_cung_cap` varchar(255) NOT NULL,
  `ten_nguoi_lien_he` varchar(255) NOT NULL,
  `so_dien_thoai` varchar(15) NOT NULL,
  `dia_chi` text NOT NULL,
  `email` varchar(255) NOT NULL,
  `ma_so_thue` varchar(50) NOT NULL,
  `mo_ta` text NOT NULL,
  `trang_thai` enum('hoat_dong','ngung_hoat_dong') NOT NULL DEFAULT 'hoat_dong',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nha_cung_caps_ma_nha_cung_cap_unique` (`ma_nha_cung_cap`),
  UNIQUE KEY `nha_cung_caps_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nha_cung_caps`
--

LOCK TABLES `nha_cung_caps` WRITE;
/*!40000 ALTER TABLE `nha_cung_caps` DISABLE KEYS */;
INSERT INTO `nha_cung_caps` VALUES (1,'NCC001','Công ty TNHH Thuốc Thú Y Bayer Việt Nam','Nguyễn Văn An','0901234567','123 Đường Lê Lợi, Quận 1, TP.HCM','contact@bayer-vet.vn','0123456789','Cung cấp thuốc thú y, vaccine và các sản phẩm chăm sóc thú cưng chất lượng cao','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:55'),(2,'NCC002','Công ty Cổ phần Thức ăn Gia súc Việt Nam','Trần Thị Bình','0912345678','456 Đường Nguyễn Huệ, Quận 3, TP.HCM','sales@petfood.vn','0234567891','Chuyên cung cấp thức ăn khô, thức ăn ướt cho chó mèo và các loại thú cưng','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:55'),(3,'NCC003','Công ty TNHH Thiết bị Y tế Thú y Medvet','Lê Văn Cường','0923456789','789 Đường Trần Hưng Đạo, Quận 5, TP.HCM','info@medvet.com.vn','0345678912','Cung cấp thiết bị y tế, dụng cụ phẫu thuật và máy móc chuyên dụng cho thú y','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:55'),(4,'NCC004','Công ty CP Phụ kiện Thú cưng PetMart','Phạm Thị Dung','0934567890','321 Đường Cách Mạng Tháng 8, Quận 10, TP.HCM','order@petmart.vn','0456789123','Chuyên cung cấp phụ kiện, đồ chơi, quần áo và vật dụng chăm sóc thú cưng','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:55'),(5,'NCC005','Công ty TNHH Vaccine Thú y VietVax','Hoàng Văn Em','0945678901','654 Đường Võ Văn Tần, Quận 3, TP.HCM','support@vietvax.com','0567891234','Cung cấp các loại vaccine phòng bệnh cho chó, mèo và thú cưng nhỏ','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:55'),(6,'NCC006','Công ty CP Dụng cụ Thú y ProVet','Vũ Thị Phượng','0956789012','147 Đường Pasteur, Quận 1, TP.HCM','contact@provet.vn','0678912345','Chuyên cung cấp dụng cụ khám bệnh, vật tư tiêu hao y tế thú y','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:55'),(7,'NCC007','Công ty TNHH Thức ăn Royal Canin Việt Nam','Đỗ Văn Giang','0967890123','258 Đường Điện Biên Phủ, Quận Bình Thạnh, TP.HCM','business@royalcanin.vn','0789123456','Phân phối thức ăn dinh dưỡng cao cấp cho chó mèo các giống loài','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:55'),(8,'NCC008','Công ty CP Vệ sinh Thú cưng CleanPet','Bùi Thị Hà','0978901234','369 Đường Hai Bà Trưng, Quận 1, TP.HCM','info@cleanpet.vn','0891234567','Cung cấp sản phẩm vệ sinh, khử mùi, tắm rửa cho thú cưng','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:55'),(9,'NCC009','Công ty TNHH Dược phẩm Thú y AnimalPharm','Ngô Văn Kiên','0989012345','741 Đường Lý Thường Kiệt, Quận 11, TP.HCM','sales@animalpharm.com.vn','0912345678','Chuyên cung cấp thuốc kháng sinh, thuốc điều trị các bệnh thường gặp ở thú cưng','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:55'),(10,'NCC010','Công ty CP Dinh dưỡng Thú y NutriPet','Lý Thị Lan','0990123456','852 Đường Xô Viết Nghệ Tĩnh, Quận Bình Thạnh, TP.HCM','customer@nutripet.vn','1023456789','Cung cấp thực phẩm chức năng, vitamin và khoáng chất bổ sung cho thú cưng','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:55');
/*!40000 ALTER TABLE `nha_cung_caps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nhan_viens`
--

DROP TABLE IF EXISTS `nhan_viens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nhan_viens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `phan_quyen_id` bigint(20) unsigned DEFAULT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `anh_dai_dien` varchar(255) DEFAULT NULL,
  `vai_tro` enum('bac_si','y_ta') NOT NULL DEFAULT 'bac_si',
  `chuc_danh` varchar(255) DEFAULT NULL,
  `nam_kinh_nghiem` int(10) unsigned NOT NULL DEFAULT 0,
  `chung_chi_hanh_nghe` text DEFAULT NULL,
  `bang_cap_chuyen_mon` text DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `trang_thai` enum('hoat_dong','da_khoa') NOT NULL DEFAULT 'hoat_dong',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nhan_viens_email_unique` (`email`),
  KEY `nhan_viens_phan_quyen_id_foreign` (`phan_quyen_id`),
  CONSTRAINT `nhan_viens_phan_quyen_id_foreign` FOREIGN KEY (`phan_quyen_id`) REFERENCES `phan_quyens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhan_viens`
--

LOCK TABLES `nhan_viens` WRITE;
/*!40000 ALTER TABLE `nhan_viens` DISABLE KEYS */;
INSERT INTO `nhan_viens` VALUES (1,2,'Nguyễn Văn An','nv1@example.com','0901000001','123 Đường A, Quận 1, TP.HCM',NULL,'bac_si','Bác sĩ thú y',8,'Chứng chỉ hành nghề Thú y - A1','Cử nhân Thú y','$2y$12$cXRD5DZ1RusDwRzdLwMXpOgJ/uC5TZRUpj0biG0caWB4SD8H3m8Ey','hoat_dong','2025-12-26 01:15:54','2025-12-26 01:15:56',NULL),(2,2,'Trần Thị Bình','nv2@example.com','0901000002','45 Đường B, Quận 3, TP.HCM',NULL,'y_ta','Y tá chuyên khoa',4,'Chứng chỉ Y tá - B','Cao đẳng Điều dưỡng','$2y$12$vQhb1Cxeqv77i.1ItQUw8OaB39abz5tXASghOYDGy.EZNR6XQlvRK','hoat_dong','2025-12-26 01:15:54','2025-12-26 01:24:25',NULL),(3,2,'Lê Văn Cường','nv3@example.com','0901000003','78 Đường C, Quận 5, TP.HCM',NULL,'bac_si','Bác sĩ chuyên khoa II',12,'Chứng chỉ chuyên môn - C','Thạc sĩ Thú y','$2y$12$sUKT3VdgpZdKx13gche8Q.ZvFyBl5IjWaU/WzaxRQqlcrngdABZR.','hoat_dong','2025-12-26 01:15:54','2025-12-26 01:15:56',NULL),(4,3,'Phạm Thị Dung','nv4@example.com','0901000004','9 Đường D, Quận 7, TP.HCM',NULL,'y_ta','Y tá',2,'Chứng chỉ Y tá - cơ bản','Cao đẳng Điều dưỡng','$2y$12$ibnCmOtREeXXXsYg4QUOr.TDrZ3IdfNu30phQbdJ4gWr7rFTbSsT6','hoat_dong','2025-12-26 01:15:54','2026-03-24 04:24:56',NULL),(5,2,'Hoàng Minh','nv5@example.com','0901000005','200 Đường E, Quận 2, TP.HCM',NULL,'bac_si','Bác sĩ điều trị',6,'Chứng chỉ hành nghề - B','Cử nhân Thú y','$2y$12$DsdclimHUa.ftZAXOxdm8.6sWjnjgbt8RoEPMk4vsyNFcfoX8uok.','hoat_dong','2025-12-26 01:15:54','2025-12-26 01:15:56',NULL),(6,3,'Ngô Thị Hà','nv6@example.com','0901000006','11 Đường F, Quận 4, TP.HCM',NULL,'y_ta','Y tá phòng khám',5,'Chứng chỉ Y tá - B','Cao đẳng Điều dưỡng','$2y$12$sII5hL1iuJoEInoIwdpu7echOvN3huYaO0AVjRFdcaiE.eAT9Gsya','hoat_dong','2025-12-26 01:15:55','2026-03-24 04:24:56',NULL),(7,2,'Đặng Quang','nv7@example.com','0901000007','33 Đường G, Quận 6, TP.HCM',NULL,'bac_si','Bác sĩ phẫu thuật',15,'Chứng chỉ phẫu thuật chuyên sâu','Tiến sĩ Thú y','$2y$12$GEAzEbD/I2sE7WEJ4PYxMeZJmQGPvpMI4v5czP9SqtxFD0DHmbt8u','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:56',NULL),(8,3,'Vũ Thị Lan','nv8@example.com','0901000008','55 Đường H, Quận 8, TP.HCM',NULL,'y_ta','Y tá phục hồi',7,'Chứng chỉ phục hồi chức năng','Cử nhân Điều dưỡng','$2y$12$1vZoqBzdO.7Zl3Vp8zAtReO3clfYC3t5LgfHaetaKGr/csugq6rqC','hoat_dong','2025-12-26 01:15:55','2026-03-24 04:24:56',NULL),(9,2,'Trương Văn Hùng','nv9@example.com','0901000009','66 Đường I, Quận 9, TP.HCM',NULL,'bac_si','Bác sĩ nội khoa',10,'Chứng chỉ nội khoa','Thạc sĩ Thú y','$2y$12$VAOY4hocLuOyguRHkDCxU.2bQprSodhr5XexHVuNCiEQOFnTANmzK','hoat_dong','2025-12-26 01:15:55','2025-12-26 01:15:56',NULL),(10,3,'Phan Thị Oanh','nv10@example.com','0901000010','77 Đường J, Quận 10, TP.HCM',NULL,'y_ta','Y tá trưởng',11,'Chứng chỉ quản lý điều dưỡng','Cử nhân Điều dưỡng','$2y$12$QEOGIHSF1pUeBsT01JeTqeD2vvj2kx9OmbiNOMaCdWHjjXOuSxCMq','hoat_dong','2025-12-26 01:15:55','2026-03-24 04:24:56',NULL);
/*!40000 ALTER TABLE `nhan_viens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\KhachHang',1,'api-token','b6c078d77480cfcc7a77ff28dec5cff9c9b9d984b864975e5a3b98a6fe00b99c','[\"*\"]','2025-12-26 01:20:12',NULL,'2025-12-26 01:19:26','2025-12-26 01:20:12'),(2,'App\\Models\\Admin',1,'api-token','e151e4582eab719f99d5e77ebfbcd66dd2a2a7e875e68168b0f97c81ca64e92c','[\"*\"]','2025-12-26 01:22:49',NULL,'2025-12-26 01:21:22','2025-12-26 01:22:49'),(3,'App\\Models\\NhanVien',1,'api-token','474192cd365a7affc39a6e2fca5078264db1f1579dfcc4d2e26dcb652c2660c5','[\"*\"]','2025-12-26 01:24:50',NULL,'2025-12-26 01:23:22','2025-12-26 01:24:50'),(4,'App\\Models\\NhanVien',2,'api-token','7093587de99f72139632ef6d2933ca38b6adc5dc94a71adc7edfc4ce265ca876','[\"*\"]','2025-12-26 01:28:03',NULL,'2025-12-26 01:24:20','2025-12-26 01:28:03'),(5,'App\\Models\\Admin',1,'api-token','f1a167223036e92c919c6f807cb414f7ded37779aa1351d5c1f650ebd1b886a3','[\"*\"]','2025-12-26 04:19:03',NULL,'2025-12-26 04:00:01','2025-12-26 04:19:03'),(6,'App\\Models\\KhachHang',1,'api-token','5c523781b182c9ca1451ce26117630abc757910cf793334657f0158825a740e2','[\"*\"]','2025-12-26 04:04:08',NULL,'2025-12-26 04:01:43','2025-12-26 04:04:08'),(7,'App\\Models\\NhanVien',2,'api-token','4158077f7095917eb25d56fdbb0cc8e4d0d8faa358b7e087c3ff1b52953efea6','[\"*\"]','2025-12-26 04:18:51',NULL,'2025-12-26 04:03:17','2025-12-26 04:18:51'),(8,'App\\Models\\NhanVien',1,'api-token','eec11896f2e3a9174bfebf2f9b05fd81bd9d1166e20b0da35ab4c30ef2dd91cf','[\"*\"]','2025-12-26 06:02:17',NULL,'2025-12-26 04:10:09','2025-12-26 06:02:17'),(9,'App\\Models\\KhachHang',1,'api-token','d968acfa4320df162c63d584a0a57faeb337bf75939295bc40f80b64bfaff811','[\"*\"]','2025-12-26 04:21:15',NULL,'2025-12-26 04:20:47','2025-12-26 04:21:15'),(10,'App\\Models\\Admin',1,'api-token','6f0a04739a6fc8a5dbea3e6639cfe9b3d8624d1f8aad71232a1064a812e277c5','[\"*\"]','2025-12-26 06:02:17',NULL,'2025-12-26 04:21:38','2025-12-26 06:02:17'),(11,'App\\Models\\KhachHang',1,'api-token','aabc429b704b6adb6ff56ca301e8b5a76f5704aa65736ff6867b8e3e8906ce45','[\"*\"]','2026-03-18 02:40:21',NULL,'2026-02-28 08:04:10','2026-03-18 02:40:21'),(12,'App\\Models\\Admin',1,'api-token','871b15eae1a564206cf97234a043d7028e6b234564d23f772793caaaafc8ad7a','[\"*\"]','2026-03-18 05:27:00',NULL,'2026-03-18 02:47:08','2026-03-18 05:27:00'),(13,'App\\Models\\KhachHang',1,'api-token','16e27f535ccf070a67aee3961ad1f1079837a44a2811fc211b8a1ccb6105e6f7','[\"*\"]','2026-03-18 05:43:24',NULL,'2026-03-18 05:43:15','2026-03-18 05:43:24'),(14,'App\\Models\\KhachHang',1,'api-token','06df66071a15d740be57ac53af0f4cf8f41f285ff080c081733ad07f5314ceca','[\"*\"]','2026-03-18 06:08:01',NULL,'2026-03-18 06:08:01','2026-03-18 06:08:01'),(15,'App\\Models\\KhachHang',1,'api-token','d86114a635d1a3f401b82573b0491672362eb12edecff9f6ed71a9aa24206b63','[\"*\"]','2026-03-24 01:21:21',NULL,'2026-03-24 00:01:24','2026-03-24 01:21:21'),(16,'App\\Models\\Admin',1,'api-token','443dfbab9d22f8267ef38626f726c1e176b84416317f5547c3f749c378f0c4e6','[\"*\"]','2026-03-24 02:24:37',NULL,'2026-03-24 01:12:21','2026-03-24 02:24:37'),(17,'App\\Models\\NhanVien',1,'api-token','0d5ad46806928e84539243f254079885a72cb3d06fed433a6b63cf57d0c7866b','[\"*\"]','2026-03-24 01:45:32',NULL,'2026-03-24 01:25:31','2026-03-24 01:45:32'),(18,'App\\Models\\NhanVien',2,'api-token','bdb6f1b9142691c33fcbb57c1c43b2feaf87120d1fa27cd93d8dba24b65638c8','[\"*\"]','2026-03-24 02:17:55',NULL,'2026-03-24 01:46:20','2026-03-24 02:17:55'),(19,'App\\Models\\NhanVien',1,'api-token','d20ce712c6bc9c8af2cfe46343edc3d64f14544aba8ecc444d5fcf31dc8271cf','[\"*\"]','2026-03-24 02:24:55',NULL,'2026-03-24 02:01:13','2026-03-24 02:24:55'),(20,'App\\Models\\KhachHang',1,'api-token','98b497a32e5fb9059e84c59edd734d9791890cfb2a354295f42ebd2fe43c94a0','[\"*\"]','2026-03-24 04:28:30',NULL,'2026-03-24 02:26:00','2026-03-24 04:28:30'),(21,'App\\Models\\NhanVien',2,'api-token','d545b70ccebf3bebe4d2b5267e7af063832c5143f46a6b2823e6af4e83098388','[\"*\"]','2026-03-24 04:31:59',NULL,'2026-03-24 04:24:20','2026-03-24 04:31:59'),(22,'App\\Models\\KhachHang',1,'api-token','54e0d7d9280c3c203febceed471591819fcf6717f7b611cbc606b12cd44e29fb','[\"*\"]','2026-03-24 04:33:10',NULL,'2026-03-24 04:32:16','2026-03-24 04:33:10'),(23,'App\\Models\\NhanVien',2,'api-token','af92f8367b214c6a38a37fe461bc408000ad51d6d5b011ca8b06dfb6e94c59fc','[\"*\"]','2026-03-24 04:51:11',NULL,'2026-03-24 04:33:32','2026-03-24 04:51:11'),(24,'App\\Models\\KhachHang',1,'api-token','5db17756546d781789a9b3d205ad88918b1f40150eb86b2d96fa71a6d2e525be','[\"*\"]','2026-03-24 05:21:29',NULL,'2026-03-24 04:51:17','2026-03-24 05:21:29'),(25,'App\\Models\\NhanVien',2,'api-token','db7a4470cafd3058ed1c073ba1d8ccfa17e1cbc93ca3d20fcac22cf118bb0afe','[\"*\"]','2026-03-24 05:25:19',NULL,'2026-03-24 05:16:14','2026-03-24 05:25:19'),(26,'App\\Models\\KhachHang',1,'api-token','d674289d8c1e112376f2a3b78e2185d9467798aa1722a59651cf81b7fc9219ae','[\"*\"]','2026-03-24 06:05:24',NULL,'2026-03-24 05:25:40','2026-03-24 06:05:24'),(27,'App\\Models\\Admin',1,'api-token','69a8fd908a1fda9994fcd4ae7ab42adb293913e42fb5b8577fbc991a5176c407','[\"*\"]','2026-03-28 10:08:20',NULL,'2026-03-24 06:06:03','2026-03-28 10:08:20'),(28,'App\\Models\\KhachHang',1,'api-token','44dc59c732773ee4fb4024d3c30f6b239e28492793a78c407eed352a5d7c52d1','[\"*\"]','2026-03-28 10:10:34',NULL,'2026-03-28 10:10:12','2026-03-28 10:10:34'),(29,'App\\Models\\KhachHang',1,'api-token','f4e9950e83cb7c884feabee58f8595795c1118a52283a06970a28d30a9959866','[\"*\"]',NULL,NULL,'2026-03-28 10:14:39','2026-03-28 10:14:39'),(30,'App\\Models\\KhachHang',1,'api-token','16c971205622008a46a23cd6e810ed05cf393c7bd5f943c39b87ca0fbfc4f7ba','[\"*\"]','2026-03-28 10:14:51',NULL,'2026-03-28 10:14:40','2026-03-28 10:14:51'),(31,'App\\Models\\KhachHang',1,'api-token','05636f79d8b70ab5d2e48d9c9e365c9604c3c809af260f725ba6856746c3c6b8','[\"*\"]','2026-04-01 03:23:39',NULL,'2026-04-01 03:15:40','2026-04-01 03:23:39'),(32,'App\\Models\\NhanVien',1,'api-token','539fc0c40092b21bb136df35c52186349eb1ec8787e5940e0c63c897599b5758','[\"*\"]',NULL,NULL,'2026-04-01 03:16:15','2026-04-01 03:16:15'),(33,'App\\Models\\NhanVien',2,'api-token','7309bb7d84e873b19cb8de8c3fe99e5a7dd19b92208eb44430cb979739bac1a2','[\"*\"]','2026-04-02 03:02:25',NULL,'2026-04-01 03:18:16','2026-04-02 03:02:25'),(34,'App\\Models\\NhanVien',2,'api-token','747358779931b074c8c76391857ce7f45dc5eba2a581f2ba0d134165252e6151','[\"*\"]','2026-04-02 03:02:29',NULL,'2026-04-02 02:37:56','2026-04-02 03:02:29'),(35,'App\\Models\\KhachHang',1,'api-token','6758e5badc94c8023845f260ae9aa8781b9ae5f3c0a84612c73e52a4a483b13f','[\"*\"]','2026-04-06 19:21:26',NULL,'2026-04-02 03:02:37','2026-04-06 19:21:26'),(36,'App\\Models\\KhachHang',1,'api-token','263f19900c52ef80e6b08b745771737459ee077de8741d2e025c52a628d06eb1','[\"*\"]','2026-04-02 03:34:53',NULL,'2026-04-02 03:34:53','2026-04-02 03:34:53'),(37,'App\\Models\\NhanVien',2,'api-token','d0eb71f71abb86c29c9547abcd024172f3b739b13ee3fe992c10ac16d9e9c797','[\"*\"]','2026-04-02 04:41:44',NULL,'2026-04-02 03:35:27','2026-04-02 04:41:44'),(38,'App\\Models\\NhanVien',2,'api-token','3bbef90da50358f167e9b71a4798f5e1d0f936a04869d9e404aef5b51ed2989b','[\"*\"]','2026-04-02 04:49:43',NULL,'2026-04-02 04:42:15','2026-04-02 04:49:43'),(39,'App\\Models\\Admin',1,'api-token','c44f8b6713c1e59e322057d6476957dfe5ae12999c583bf07c70ab425bf54986','[\"*\"]','2026-04-06 19:19:11',NULL,'2026-04-06 19:18:16','2026-04-06 19:19:11');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phan_loai_bai_viets`
--

DROP TABLE IF EXISTS `phan_loai_bai_viets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phan_loai_bai_viets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ten_phan_loai` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phan_loai_bai_viets_ten_phan_loai_unique` (`ten_phan_loai`),
  UNIQUE KEY `phan_loai_bai_viets_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phan_loai_bai_viets`
--

LOCK TABLES `phan_loai_bai_viets` WRITE;
/*!40000 ALTER TABLE `phan_loai_bai_viets` DISABLE KEYS */;
INSERT INTO `phan_loai_bai_viets` VALUES (1,'Chăm sóc thú cưng','cham-soc-thu-cung','Các bài viết về cách chăm sóc, vệ sinh và dinh dưỡng cho thú cưng.','2025-12-26 01:15:55','2025-12-26 01:15:55'),(2,'Sức khỏe thú cưng','suc-khoe-thu-cung','Các bài viết về sức khỏe, bệnh tật và cách phòng ngừa bệnh cho thú cưng.','2025-12-26 01:15:55','2025-12-26 01:15:55'),(3,'Huấn luyện và lựa chọn thức ăn','huan-luyen-va-lua-chon-thuc-an','Các bài viết về huấn luyện thú cưng và lựa chọn thức ăn phù hợp.','2025-12-26 01:15:55','2025-12-26 01:15:55');
/*!40000 ALTER TABLE `phan_loai_bai_viets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phan_quyens`
--

DROP TABLE IF EXISTS `phan_quyens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phan_quyens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ma_vai_tro` varchar(255) NOT NULL,
  `ten_vai_tro` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `lich_hen_xem` tinyint(1) NOT NULL DEFAULT 0,
  `lich_hen_tao` tinyint(1) NOT NULL DEFAULT 0,
  `lich_hen_sua` tinyint(1) NOT NULL DEFAULT 0,
  `lich_hen_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `lich_hen_xac_nhan` tinyint(1) NOT NULL DEFAULT 0,
  `lich_lam_viec_xem` tinyint(1) NOT NULL DEFAULT 0,
  `lich_lam_viec_tao` tinyint(1) NOT NULL DEFAULT 0,
  `lich_nhac_xem` tinyint(1) NOT NULL DEFAULT 0,
  `lich_nhac_tao` tinyint(1) NOT NULL DEFAULT 0,
  `lich_nhac_sua` tinyint(1) NOT NULL DEFAULT 0,
  `lich_nhac_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `lich_nhac_gui` tinyint(1) NOT NULL DEFAULT 0,
  `tai_chinh_xem_doanh_thu` tinyint(1) NOT NULL DEFAULT 0,
  `tai_chinh_thu_tien` tinyint(1) NOT NULL DEFAULT 0,
  `tai_chinh_hoan_tien` tinyint(1) NOT NULL DEFAULT 0,
  `phieu_chi_xem` tinyint(1) NOT NULL DEFAULT 0,
  `phieu_chi_tao` tinyint(1) NOT NULL DEFAULT 0,
  `phieu_chi_sua` tinyint(1) NOT NULL DEFAULT 0,
  `phieu_chi_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `phieu_chi_xuat_pdf` tinyint(1) NOT NULL DEFAULT 0,
  `phieu_chi_thanh_toan` tinyint(1) NOT NULL DEFAULT 0,
  `hang_hoa_xem` tinyint(1) NOT NULL DEFAULT 0,
  `hang_hoa_tao` tinyint(1) NOT NULL DEFAULT 0,
  `hang_hoa_sua` tinyint(1) NOT NULL DEFAULT 0,
  `hang_hoa_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `hang_hoa_doi_trang_thai` tinyint(1) NOT NULL DEFAULT 0,
  `danh_muc_hang_hoa_xem` tinyint(1) NOT NULL DEFAULT 0,
  `danh_muc_hang_hoa_tao` tinyint(1) NOT NULL DEFAULT 0,
  `danh_muc_hang_hoa_sua` tinyint(1) NOT NULL DEFAULT 0,
  `danh_muc_hang_hoa_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `phieu_nhap_kho_xem` tinyint(1) NOT NULL DEFAULT 0,
  `phieu_nhap_kho_tao` tinyint(1) NOT NULL DEFAULT 0,
  `phieu_nhap_kho_doi_trang_thai` tinyint(1) NOT NULL DEFAULT 0,
  `phieu_nhap_kho_xuat_pdf` tinyint(1) NOT NULL DEFAULT 0,
  `phieu_nhap_kho_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `kiem_ke_xem` tinyint(1) NOT NULL DEFAULT 0,
  `kiem_ke_tao` tinyint(1) NOT NULL DEFAULT 0,
  `kiem_ke_sua` tinyint(1) NOT NULL DEFAULT 0,
  `kiem_ke_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `thu_cung_xem` tinyint(1) NOT NULL DEFAULT 0,
  `thu_cung_tao` tinyint(1) NOT NULL DEFAULT 0,
  `thu_cung_sua` tinyint(1) NOT NULL DEFAULT 0,
  `thu_cung_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `ho_so_benh_an_xem` tinyint(1) NOT NULL DEFAULT 0,
  `ho_so_benh_an_tao` tinyint(1) NOT NULL DEFAULT 0,
  `ho_so_benh_an_sua` tinyint(1) NOT NULL DEFAULT 0,
  `ho_so_benh_an_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `dich_vu_xem` tinyint(1) NOT NULL DEFAULT 0,
  `dich_vu_tao` tinyint(1) NOT NULL DEFAULT 0,
  `dich_vu_sua` tinyint(1) NOT NULL DEFAULT 0,
  `dich_vu_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `danh_muc_dich_vu_xem` tinyint(1) NOT NULL DEFAULT 0,
  `danh_muc_dich_vu_tao` tinyint(1) NOT NULL DEFAULT 0,
  `danh_muc_dich_vu_sua` tinyint(1) NOT NULL DEFAULT 0,
  `danh_muc_dich_vu_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `khach_hang_xem` tinyint(1) NOT NULL DEFAULT 0,
  `khach_hang_sua` tinyint(1) NOT NULL DEFAULT 0,
  `nhan_vien_xem` tinyint(1) NOT NULL DEFAULT 0,
  `nhan_vien_tao` tinyint(1) NOT NULL DEFAULT 0,
  `nhan_vien_doi_mat_khau` tinyint(1) NOT NULL DEFAULT 0,
  `nhan_vien_khoa_tai_khoan` tinyint(1) NOT NULL DEFAULT 0,
  `nhan_vien_mo_khoa_tai_khoan` tinyint(1) NOT NULL DEFAULT 0,
  `khoa_tao` tinyint(1) NOT NULL DEFAULT 0,
  `nha_cung_cap_xem` tinyint(1) NOT NULL DEFAULT 0,
  `nha_cung_cap_tao` tinyint(1) NOT NULL DEFAULT 0,
  `nha_cung_cap_sua` tinyint(1) NOT NULL DEFAULT 0,
  `nha_cung_cap_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `nha_cung_cap_doi_trang_thai` tinyint(1) NOT NULL DEFAULT 0,
  `bai_viet_xem` tinyint(1) NOT NULL DEFAULT 0,
  `bai_viet_tao` tinyint(1) NOT NULL DEFAULT 0,
  `bai_viet_sua` tinyint(1) NOT NULL DEFAULT 0,
  `bai_viet_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `phan_loai_bai_viet_xem` tinyint(1) NOT NULL DEFAULT 0,
  `phan_loai_bai_viet_tao` tinyint(1) NOT NULL DEFAULT 0,
  `phan_loai_bai_viet_sua` tinyint(1) NOT NULL DEFAULT 0,
  `phan_loai_bai_viet_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `khuyen_mai_xem` tinyint(1) NOT NULL DEFAULT 0,
  `khuyen_mai_tao` tinyint(1) NOT NULL DEFAULT 0,
  `khuyen_mai_sua` tinyint(1) NOT NULL DEFAULT 0,
  `khuyen_mai_xoa` tinyint(1) NOT NULL DEFAULT 0,
  `khuyen_mai_doi_trang_thai` tinyint(1) NOT NULL DEFAULT 0,
  `upload_file` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phan_quyens_ma_vai_tro_unique` (`ma_vai_tro`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phan_quyens`
--

LOCK TABLES `phan_quyens` WRITE;
/*!40000 ALTER TABLE `phan_quyens` DISABLE KEYS */;
INSERT INTO `phan_quyens` VALUES (1,'Admin','Admin','Quản trị viên - Có toàn quyền quản lý hệ thống',1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(2,'Bac_si','Bác sĩ','Bác sĩ - Khám bệnh, kê đơn, quản lý bệnh án',1,0,1,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(3,'Dieu_duong','Điều dưỡng','Điều dưỡng - Hỗ trợ khám bệnh, quản lý thuốc',1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,1,1,0,0,1,0,1,1,0,0,0,0,0,0,0,1,1,0,1,0,1,1,1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(4,'Le_tan','Lễ tân','Lễ tân - Đặt lịch hẹn, thu tiền, quản lý khách hàng',1,1,1,1,0,1,0,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,'2025-12-26 01:15:53','2025-12-26 01:15:53'),(5,'Tro_ly','Trợ lý','Trợ lý - Hỗ trợ công việc hành chính, quản lý kho',1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,0,1,1,1,0,0,0,0,0,0,1,1,0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'2025-12-26 01:15:53','2025-12-26 01:15:53');
/*!40000 ALTER TABLE `phan_quyens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phieu_chis`
--

DROP TABLE IF EXISTS `phieu_chis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phieu_chis` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ma_phieu_chi` varchar(50) NOT NULL,
  `loai_phieu_chi` enum('chi_nhap_hang','chi_van_hanh') NOT NULL COMMENT 'Loại phiếu chi',
  `ly_do_chi` text NOT NULL COMMENT 'Lý do chi',
  `tong_so_tien` decimal(15,2) NOT NULL COMMENT 'Tổng số tiền chi',
  `so_tien_thanh_toan_ngay` decimal(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Số tiền thanh toán ngay',
  `so_tien_con_no` decimal(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Số tiền còn nợ = Tổng - Thanh toán ngay',
  `tien_mat` decimal(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Số tiền mặt',
  `tien_chuyen_khoan` decimal(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Số tiền chuyển khoản',
  `anh_chung_tu` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Danh sách ảnh chứng từ (JSON array)' CHECK (json_valid(`anh_chung_tu`)),
  `doi_tuong_nhan_tien` varchar(255) DEFAULT NULL COMMENT 'Đối tượng nhận tiền (chi vận hành)',
  `nha_cung_cap_id` bigint(20) unsigned DEFAULT NULL,
  `trang_thai` enum('con_no','da_hoan_thanh') NOT NULL DEFAULT 'con_no' COMMENT 'Trạng thái: con_no (còn nợ NCC) hoặc da_hoan_thanh',
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `nhan_vien_id` bigint(20) unsigned DEFAULT NULL,
  `nguoi_tao_type` varchar(255) DEFAULT NULL COMMENT 'Admin hoặc NhanVien',
  `ngay_chi` date NOT NULL COMMENT 'Ngày chi',
  `ghi_chu` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phieu_chis_ma_phieu_chi_unique` (`ma_phieu_chi`),
  KEY `phieu_chis_nha_cung_cap_id_foreign` (`nha_cung_cap_id`),
  KEY `phieu_chis_admin_id_foreign` (`admin_id`),
  KEY `phieu_chis_nhan_vien_id_foreign` (`nhan_vien_id`),
  CONSTRAINT `phieu_chis_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  CONSTRAINT `phieu_chis_nha_cung_cap_id_foreign` FOREIGN KEY (`nha_cung_cap_id`) REFERENCES `nha_cung_caps` (`id`) ON DELETE SET NULL,
  CONSTRAINT `phieu_chis_nhan_vien_id_foreign` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phieu_chis`
--

LOCK TABLES `phieu_chis` WRITE;
/*!40000 ALTER TABLE `phieu_chis` DISABLE KEYS */;
INSERT INTO `phieu_chis` VALUES (1,'PC00001','chi_nhap_hang','Thanh toán tiền hàng nhập kho đợt 1',37269453.00,37269453.00,0.00,11999041.00,37269453.00,'[\"chungtu_1.jpg\"]',NULL,3,'da_hoan_thanh',1,NULL,'Admin','2025-11-29','Phiếu chi cho phiếu nhập kho đợt 1','2025-12-26 01:15:55','2025-12-26 01:15:55'),(2,'PC00002','chi_nhap_hang','Thanh toán tiền hàng nhập kho đợt 2',74686421.00,42622129.00,32064292.00,42266142.00,42622129.00,'[\"chungtu_2.jpg\"]',NULL,4,'con_no',1,NULL,'Admin','2025-12-21','Phiếu chi cho phiếu nhập kho đợt 2','2025-12-26 01:15:55','2025-12-26 01:15:55'),(3,'PC00003','chi_nhap_hang','Thanh toán tiền hàng nhập kho đợt 3',42320945.00,6948320.00,35372625.00,4484655.00,6948320.00,'[\"chungtu_3.jpg\"]',NULL,3,'con_no',1,NULL,'Admin','2025-12-09','Phiếu chi cho phiếu nhập kho đợt 3','2025-12-26 01:15:55','2025-12-26 01:15:55'),(4,'PC00004','chi_nhap_hang','Thanh toán tiền hàng nhập kho đợt 4',31843399.00,31843399.00,0.00,5261749.00,31843399.00,'[\"chungtu_4.jpg\"]',NULL,1,'da_hoan_thanh',1,NULL,'Admin','2025-12-10','Phiếu chi cho phiếu nhập kho đợt 4','2025-12-26 01:15:55','2025-12-26 01:15:55'),(5,'PC00005','chi_nhap_hang','Thanh toán tiền hàng nhập kho đợt 5',59388018.00,59388018.00,0.00,50085268.00,59388018.00,'[\"chungtu_5.jpg\"]',NULL,2,'da_hoan_thanh',1,NULL,'Admin','2025-12-24','Phiếu chi cho phiếu nhập kho đợt 5','2025-12-26 01:15:55','2025-12-26 01:15:55'),(6,'PC00006','chi_nhap_hang','Thanh toán tiền hàng nhập kho đợt 6',77768816.00,77768816.00,0.00,22578486.00,77768816.00,'[\"chungtu_6.jpg\"]',NULL,5,'da_hoan_thanh',1,NULL,'Admin','2025-12-17','Phiếu chi cho phiếu nhập kho đợt 6','2025-12-26 01:15:56','2025-12-26 01:15:56'),(7,'PC00007','chi_nhap_hang','Thanh toán tiền hàng nhập kho đợt 7',70501893.00,41299188.00,29202705.00,5617187.00,41299188.00,'[\"chungtu_7.jpg\"]',NULL,2,'con_no',1,NULL,'Admin','2025-11-27','Phiếu chi cho phiếu nhập kho đợt 7','2025-12-26 01:15:56','2025-12-26 01:15:56'),(8,'PC00008','chi_nhap_hang','Thanh toán tiền hàng nhập kho đợt 8',77118887.00,13408221.00,63710666.00,13315608.00,13408221.00,'[\"chungtu_8.jpg\"]',NULL,7,'con_no',1,NULL,'Admin','2025-12-06','Phiếu chi cho phiếu nhập kho đợt 8','2025-12-26 01:15:56','2025-12-26 01:15:56'),(9,'PC00009','chi_nhap_hang','Thanh toán tiền hàng nhập kho đợt 9',28070337.00,11901914.00,16168423.00,4396925.00,11901914.00,'[\"chungtu_9.jpg\"]',NULL,5,'con_no',1,NULL,'Admin','2025-12-12','Phiếu chi cho phiếu nhập kho đợt 9','2025-12-26 01:15:56','2025-12-26 01:15:56'),(10,'PC00010','chi_nhap_hang','Thanh toán tiền hàng nhập kho đợt 10',38668671.00,27234527.00,11434144.00,4143794.00,27234527.00,'[\"chungtu_10.jpg\"]',NULL,4,'con_no',1,NULL,'Admin','2025-12-19','Phiếu chi cho phiếu nhập kho đợt 10','2025-12-26 01:15:56','2025-12-26 01:15:56');
/*!40000 ALTER TABLE `phieu_chis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phieu_khams`
--

DROP TABLE IF EXISTS `phieu_khams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phieu_khams` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nhiet_do` decimal(5,2) DEFAULT NULL COMMENT 'Nhiệt độ (°C)',
  `can_nang` decimal(8,2) DEFAULT NULL COMMENT 'Cân nặng (kg)',
  `nhip_tim` int(11) DEFAULT NULL COMMENT 'Nhịp tim (bpm)',
  `nhip_tho` int(11) DEFAULT NULL COMMENT 'Nhịp thở (lần/phút)',
  `ly_do_den_kham` varchar(255) DEFAULT NULL COMMENT 'Lý do đến khám',
  `trieu_chung` text DEFAULT NULL COMMENT 'Triệu chứng',
  `chan_doan` text DEFAULT NULL COMMENT 'Chẩn đoán',
  `ghi_chu` text DEFAULT NULL COMMENT 'Ghi chú thêm',
  `loai_chi_dinh` varchar(50) DEFAULT NULL COMMENT 'Loại chỉ định (chi_dinh_can_lam_sang, don_thuoc, hen_tai_kham)',
  `lich_hen_id` bigint(20) unsigned DEFAULT NULL,
  `nhan_vien_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `phieu_khams_lich_hen_id_foreign` (`lich_hen_id`),
  KEY `phieu_khams_nhan_vien_id_foreign` (`nhan_vien_id`),
  CONSTRAINT `phieu_khams_lich_hen_id_foreign` FOREIGN KEY (`lich_hen_id`) REFERENCES `lich_hens` (`id`) ON DELETE SET NULL,
  CONSTRAINT `phieu_khams_nhan_vien_id_foreign` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phieu_khams`
--

LOCK TABLES `phieu_khams` WRITE;
/*!40000 ALTER TABLE `phieu_khams` DISABLE KEYS */;
/*!40000 ALTER TABLE `phieu_khams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phieu_nhap_khos`
--

DROP TABLE IF EXISTS `phieu_nhap_khos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phieu_nhap_khos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ma_phieu_nhap` varchar(50) NOT NULL,
  `ngay_nhap` date NOT NULL,
  `tong_tien` decimal(15,2) NOT NULL DEFAULT 0.00,
  `ghi_chu` text DEFAULT NULL,
  `trang_thai` enum('cho_duyet','da_duyet','huy') NOT NULL DEFAULT 'cho_duyet',
  `nha_cung_cap_id` bigint(20) unsigned NOT NULL,
  `phieu_chi_id` bigint(20) unsigned NOT NULL,
  `nhan_vien_id` bigint(20) unsigned DEFAULT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phieu_nhap_khos_ma_phieu_nhap_unique` (`ma_phieu_nhap`),
  KEY `phieu_nhap_khos_nha_cung_cap_id_foreign` (`nha_cung_cap_id`),
  KEY `phieu_nhap_khos_phieu_chi_id_foreign` (`phieu_chi_id`),
  KEY `phieu_nhap_khos_nhan_vien_id_foreign` (`nhan_vien_id`),
  KEY `phieu_nhap_khos_admin_id_foreign` (`admin_id`),
  CONSTRAINT `phieu_nhap_khos_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phieu_nhap_khos_nha_cung_cap_id_foreign` FOREIGN KEY (`nha_cung_cap_id`) REFERENCES `nha_cung_caps` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phieu_nhap_khos_nhan_vien_id_foreign` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_viens` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phieu_nhap_khos_phieu_chi_id_foreign` FOREIGN KEY (`phieu_chi_id`) REFERENCES `phieu_chis` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phieu_nhap_khos`
--

LOCK TABLES `phieu_nhap_khos` WRITE;
/*!40000 ALTER TABLE `phieu_nhap_khos` DISABLE KEYS */;
INSERT INTO `phieu_nhap_khos` VALUES (1,'PNK00001','2025-12-15',37269453.00,'Phiếu nhập kho hàng hóa đợt 1','cho_duyet',4,1,7,NULL,'2025-12-26 01:15:56','2025-12-26 01:15:56'),(2,'PNK00002','2025-12-05',74686421.00,'Phiếu nhập kho hàng hóa đợt 2','da_duyet',6,2,5,NULL,'2025-12-26 01:15:56','2025-12-26 01:15:56'),(3,'PNK00003','2025-12-20',42320945.00,'Phiếu nhập kho hàng hóa đợt 3','huy',7,3,3,NULL,'2025-12-26 01:15:56','2025-12-26 01:15:56'),(4,'PNK00004','2025-11-26',31843399.00,'Phiếu nhập kho hàng hóa đợt 4','huy',7,4,3,NULL,'2025-12-26 01:15:56','2025-12-26 01:15:56'),(5,'PNK00005','2025-12-04',59388018.00,'Phiếu nhập kho hàng hóa đợt 5','da_duyet',10,5,4,NULL,'2025-12-26 01:15:56','2025-12-26 01:15:56'),(6,'PNK00006','2025-12-14',77768816.00,'Phiếu nhập kho hàng hóa đợt 6','da_duyet',5,6,2,NULL,'2025-12-26 01:15:56','2025-12-26 01:15:56'),(7,'PNK00007','2025-12-23',70501893.00,'Phiếu nhập kho hàng hóa đợt 7','cho_duyet',5,7,6,NULL,'2025-12-26 01:15:56','2025-12-26 01:15:56'),(8,'PNK00008','2025-12-23',77118887.00,'Phiếu nhập kho hàng hóa đợt 8','da_duyet',10,8,1,NULL,'2025-12-26 01:15:56','2025-12-26 01:15:56'),(9,'PNK00009','2025-12-20',28070337.00,'Phiếu nhập kho hàng hóa đợt 9','da_duyet',6,9,2,NULL,'2025-12-26 01:15:56','2025-12-26 01:15:56'),(10,'PNK00010','2025-12-13',38668671.00,'Phiếu nhập kho hàng hóa đợt 10','huy',1,10,1,NULL,'2025-12-26 01:15:56','2025-12-26 01:15:56');
/*!40000 ALTER TABLE `phieu_nhap_khos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_accounts`
--

DROP TABLE IF EXISTS `social_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_accounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `khach_hang_id` bigint(20) unsigned NOT NULL,
  `provider` varchar(255) NOT NULL,
  `provider_user_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `social_accounts_khach_hang_id_foreign` (`khach_hang_id`),
  CONSTRAINT `social_accounts_khach_hang_id_foreign` FOREIGN KEY (`khach_hang_id`) REFERENCES `khach_hangs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_accounts`
--

LOCK TABLES `social_accounts` WRITE;
/*!40000 ALTER TABLE `social_accounts` DISABLE KEYS */;
INSERT INTO `social_accounts` VALUES (1,1,'google','105104878298779387544','2025-12-26 01:19:26','2025-12-26 01:19:26'),(2,1,'facebook','4364094363910725','2026-03-18 06:08:01','2026-03-18 06:08:01');
/*!40000 ALTER TABLE `social_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thanh_toans`
--

DROP TABLE IF EXISTS `thanh_toans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thanh_toans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thanh_toans`
--

LOCK TABLES `thanh_toans` WRITE;
/*!40000 ALTER TABLE `thanh_toans` DISABLE KEYS */;
/*!40000 ALTER TABLE `thanh_toans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thu_cungs`
--

DROP TABLE IF EXISTS `thu_cungs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thu_cungs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `khach_hang_id` bigint(20) unsigned DEFAULT NULL,
  `anh_dai_dien` varchar(255) DEFAULT NULL,
  `ten_thu_cung` varchar(255) NOT NULL,
  `loai_thu_cung` varchar(255) NOT NULL,
  `giong_thu_cung` varchar(255) NOT NULL,
  `tuoi_thu_cung` date NOT NULL,
  `gioi_tinh` varchar(255) NOT NULL,
  `can_nang` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `thu_cungs_khach_hang_id_foreign` (`khach_hang_id`),
  CONSTRAINT `thu_cungs_khach_hang_id_foreign` FOREIGN KEY (`khach_hang_id`) REFERENCES `khach_hangs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thu_cungs`
--

LOCK TABLES `thu_cungs` WRITE;
/*!40000 ALTER TABLE `thu_cungs` DISABLE KEYS */;
INSERT INTO `thu_cungs` VALUES (1,NULL,'bong.jpg','Bông','Chó','Poodle','2022-06-01','Cái','4.5 kg','2025-12-26 01:15:53','2025-12-26 01:15:53'),(2,NULL,'mun.jpg','Mun','Mèo','Mèo Ta','2023-09-10','Đực','3.2 kg','2025-12-26 01:15:53','2025-12-26 01:15:53'),(3,NULL,'vang.jpg','Vàng','Chó','Labrador','2021-03-15','Đực','28 kg','2025-12-26 01:15:53','2025-12-26 01:15:53'),(4,NULL,'beo.jpg','Béo','Mèo','Ba Tư','2024-08-20','Cái','2.8 kg','2025-12-26 01:15:53','2025-12-26 01:15:53'),(5,NULL,'luc.jpg','Lục','Chó','Shiba','2023-11-01','Đực','9 kg','2025-12-26 01:15:53','2025-12-26 01:15:53'),(6,NULL,'nho.jpg','Nhỏ','Chó','Chihuahua','2024-01-05','Cái','2.0 kg','2025-12-26 01:15:53','2025-12-26 01:15:53'),(7,NULL,'hat.jpg','Hạt','Mèo','Munchkin','2022-11-11','Đực','4.0 kg','2025-12-26 01:15:53','2025-12-26 01:15:53'),(8,NULL,'soi.jpg','Sói','Chó','Husky','2020-04-02','Đực','22 kg','2025-12-26 01:15:53','2025-12-26 01:15:53'),(9,NULL,'kim.jpg','Kim','Mèo','Sphynx','2023-02-18','Cái','3.5 kg','2025-12-26 01:15:53','2025-12-26 01:15:53'),(10,NULL,'hoa.jpg','Hoa','Chó','Corgi','2022-09-09','Cái','11 kg','2025-12-26 01:15:53','2025-12-26 01:15:53'),(11,1,'thu_cungs/B4qIVVbx5cdIRILTUjflKJMMaQcHIX9evypkuedY.png','Eggs','dog','golden-retriever','2025-12-01','male','28','2025-12-26 01:20:12','2025-12-26 01:20:12'),(12,1,'thu_cungs/gSvTip6AgZWGbROV8LiexBj28GUUFHPTiNwBBzwh.png','Miu','dog','golden-retriever','2025-12-02','male','28','2025-12-26 04:02:16','2025-12-26 04:02:16');
/*!40000 ALTER TABLE `thu_cungs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-16 13:51:51
