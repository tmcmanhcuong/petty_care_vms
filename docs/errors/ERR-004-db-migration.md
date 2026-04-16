# Lỗi Export/Import Database (Data Migration)

Tài liệu này ghi chú lại các lỗi phổ biến gặp phải trong quá trình làm việc với `mysqldump` và thao tác migration dự án Petty VMCS lên AWS RDS.

### 1. Lỗi 2002: MySQL/MariaDB chưa được khởi động
**Thông báo lỗi:**
```
mysqldump: Got error: 2002: "Can't connect to local MySQL server through socket '/Applications/XAMPP/xamppfiles/var/mysql/mysql.sock' (2)" when trying to connect
```
**Nguyên nhân:**
Database cục bộ (XAMPP/MAMP/Native) chưa được bật.
**Cách khắc phục:** 
Mở giao diện bật/tắt (Control Panel) của phần mềm Database, ấn Start cho mục MySQL (chờ cho tới khi đèn xanh). Ngoài ra có thể thay Socket bằng TCP bằng việc thêm `-h 127.0.0.1` vào câu lệnh.

---

### 2. Lỗi 1045: Sai mật khẩu (hoặc dư thư mục password) đối với user root
**Thông báo lỗi:**
```
mysqldump: Got error: 1045: "Access denied for user 'root'@'localhost' (using password: YES)" when trying to connect
```
**Nguyên nhân:** 
Mặc định XAMPP không xét mật khẩu cho user `root`. Khi người dùng chạy lệnh `mysqldump` có chứa cờ `-p` hệ thống sẽ mặc định kiểm tra mật khẩu. Nếu gửi mật khẩu rỗng mà XAMPP đòi YES password sẽ báo lỗi.
**Cách khắc phục:** 
- Gỡ bỏ cờ `-p` khỏi câu lệnh.
- Điền đúng tên cơ sở dữ liệu có phân biệt hoa thường (VD: thay vì `petty` đổi thành `Petty`).

**Câu lệnh chuẩn:** 
```bash
mysqldump -u root Petty > petty_vms_backup.sql
```
