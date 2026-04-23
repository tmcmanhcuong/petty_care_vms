# Lịch Sử Sửa Lỗi Khi Triển Khai Production (AWS ECS)

Tài liệu này ghi chú lại những bug phát sinh trong quá trình chuyển code từ môi trường Localhost lên môi trường thật (Production) trên AWS ECS, và những đoạn code đã phải can thiệp để hệ thống chạy ổn định.

## Bug 1: Lỗi 500 Server Error vì thiếu chứng chỉ bảo mật RDS

**Triệu chứng:**
Toàn bộ các API liên quan đến Database (như đăng nhập, đăng ký) đều trả về `500 Internal Server Error`. Trong CloudWatch Logs báo lỗi: `Connections using insecure transport are prohibited while --require_secure_transport=ON`.

**Nguyên nhân:**
Database RDS của nhóm bật chế độ bắt buộc mọi kết nối phải dùng mã hóa SSL. Tuy nhiên:
1. Docker container mặc định không có chứng chỉ Root CA của Amazon RDS.
2. Mặc dù đã cố gắng thêm biến môi trường `MYSQL_ATTR_SSL_CA` vào AWS Secrets Manager, nhưng **ECS Task Definition của nhóm đã bị cấu hình cứng (hardcode)**. Tức là Task Definition chỉ lấy đúng 19 biến cũ đã định sẵn từ Secret, dẫn đến biến `MYSQL_ATTR_SSL_CA` bị vứt bỏ, container không bao giờ nhận được biến này.

**Cách xử lý:**
1. **Sửa `petty_BE/Dockerfile`:** Thêm lệnh tự động tải chứng chỉ Amazon RDS global bundle vào thư mục hệ thống trong quá trình build image.
   ```dockerfile
   # Tải chứng chỉ bảo mật của AWS RDS
   && curl -sS https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -o /etc/ssl/certs/global-bundle.pem
   ```
2. **Sửa `petty_BE/config/database.php`:** Thay vì phụ thuộc vào việc cấu hình lại ECS Task Definition vô cùng phiền phức, đã sửa logic để kết nối PDO luôn luôn nhắm vào đường dẫn chứng chỉ mặc định của hệ thống nếu AWS không cấp biến môi trường.
   ```php
   'options' => extension_loaded('pdo_mysql') ? array_filter([
       PDO::MYSQL_ATTR_SSL_CA => env('MYSQL_ATTR_SSL_CA', '/etc/ssl/certs/global-bundle.pem'),
   ]) : [],
   ```

---

## Bug 2: Tạo User thủ công sai bảng dữ liệu (Users vs KhachHang)

**Triệu chứng:**
Tạo tài khoản thành công qua Tinker, nhưng trên web đăng nhập báo `401 Unauthorized` (Sai tài khoản).

**Nguyên nhân:**
Trong Tinker chạy lệnh `\App\Models\User::create(...)` -> Lệnh này chèn dữ liệu vào bảng `users` (dành cho Admin).
Trong khi đó, luồng Đăng nhập trên web gọi API `/api/khach-hang/dang-nhap` -> API này tìm dữ liệu trong bảng `khach_hangs`. Vì không có data trong `khach_hangs` nên bị lỗi.

**Cách xử lý:**
Dùng Tinker để chèn dữ liệu vào đúng model: `\App\Models\KhachHang::create(...)` hoặc đăng ký trực tiếp qua giao diện web.

---

## Bug 3: Đăng ký thành công nhưng nút "Xác thực email" trỏ sai đường dẫn

**Triệu chứng:**
Khách hàng nhận được email xác thực tài khoản. Khi bấm vào nút "Xác thực", trình duyệt mở đường dẫn `http://localhost:5173/?token=...` và báo lỗi "This site can't be reached".

**Nguyên nhân:**
Trong quá trình code trên máy cá nhân, developer đã "Hardcode" (điền chết) đường dẫn trả về của Frontend là `localhost:5173`. Khi đẩy lên Production, hệ thống backend vẫn hồn nhiên điều hướng khách hàng về máy tính cá nhân của họ thay vì về tên miền thật.

**Cách xử lý:**
Sửa trực tiếp file `app/Http/Controllers/KhachHangController.php` (hàm `verifyEmail`). Thay thế dòng code hardcode bằng biến môi trường `FRONTEND_URL` kèm theo giá trị dự phòng là tên miền Production thực tế.

```php
// Code cũ lỗi:
// return redirect('http://localhost:5173/?token=' . $token . '&verified=true');

// Code mới sửa:
$frontendUrl = env('FRONTEND_URL', 'https://project2.hungtran.id.vn');
return redirect($frontendUrl . '/?token=' . $token . '&verified=true');
```
