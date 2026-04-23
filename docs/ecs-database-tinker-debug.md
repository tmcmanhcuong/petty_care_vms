# Hướng dẫn Debug và Tương tác Database trong AWS ECS Container

Tài liệu này ghi lại quá trình truy cập vào môi trường máy chủ AWS ECS (Fargate) và cách xử lý lỗi khi tương tác với Database (RDS) thông qua công cụ Tinker của Laravel.

## 1. Truy cập vào Container bằng ECS Exec

Để chui vào bên trong ruột container đang chạy trên AWS (nhằm mục đích chạy lệnh artisan hoặc debug), sử dụng lệnh AWS CLI với `execute-command`:

```bash
aws ecs execute-command \
  --cluster webapp-group10-backend-cluster \
  --task <TASK_ID> \
  --container webapp-group10-container \
  --interactive \
  --command "/bin/sh" \
  --region us-west-2
```
*Lưu ý: Để chạy được lệnh này, máy cá nhân phải cài đặt `session-manager-plugin` và IAM Task Role của container phải có quyền `ssmmessages`.*

## 2. Sử dụng Laravel Tinker để quản lý dữ liệu

Sau khi vào được `/bin/sh` trong container (thư mục mặc định `/var/www/html`), bạn có thể gọi Tinker:
```bash
php artisan tinker
```
Ví dụ tạo tài khoản Khách Hàng:
```php
$k = new \App\Models\KhachHang();
$k->full_name = 'Test Khach Hang';
$k->email = 'test@petty.com';
$k->password = bcrypt('123456');
$k->phone = '0987654321';
$k->rank = 'Silver';
$k->trang_thai = 'active';
$k->email_verified_at = now();
$k->save();
```

## 3. Các Lỗi Đã Gặp Và Cách Xử Lý

### Lỗi 1: Từ chối kết nối Database vì thiếu mã hóa SSL
**Triệu chứng:**
Khi chạy lệnh query trong Tinker, văng lỗi:
`SQLSTATE[HY000] [3159] Connections using insecure transport are prohibited while --require_secure_transport=ON.`

**Nguyên nhân:**
Database AWS RDS của hệ thống đang bật chế độ bắt buộc mọi kết nối phải được mã hóa SSL/TLS. Tuy nhiên, PDO MySQL mặc định trong Alpine Linux container không nhận diện được chứng chỉ của AWS RDS.

**Cách xử lý (Tạm thời trong Tinker):**
Thoát Tinker (`quit`), tải chứng chỉ gốc của Amazon RDS về thư mục tạm, gán biến môi trường và xóa cache cấu hình, sau đó vào lại Tinker:
```bash
# 1. Tải chứng chỉ
curl -sS https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -o /tmp/global-bundle.pem

# 2. Ép sử dụng chứng chỉ này
export MYSQL_ATTR_SSL_CA=/tmp/global-bundle.pem

# 3. Phá băng cache cấu hình cũ của container
php artisan config:clear

# 4. Chạy lại Tinker
php artisan tinker
```
*(Để xử lý triệt để cho toàn bộ web, xem file `production-bug-fixes.md`)*
