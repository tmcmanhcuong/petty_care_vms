# Hướng Dẫn Chuyển Đổi Git Giữa Repo Đồ ÁN (Mới) và Repo Cũ

Tài liệu này hướng dẫn cách chuyển đổi môi trường code cục bộ giữa repo Đồ án mới (`origin`) và repo dự án cũ (`old`) để phục vụ cho việc Deploy AWS độc lập mà không làm hỏng hay xung đột code giữa 2 dự án.

## Nguyên tắc hoạt động
- **Repo mới (Đồ án):** Kết nối với remote tên là `origin`, đang được làm việc trên nhánh `main`.
- **Repo cũ (Dự án deploy):** Kết nối với remote tên là `old`, được làm việc trên một nhánh phân lập tên là `aws-deploy`.
Hai nhánh này hoạt động song song. Khi bạn đổi nhánh, nội dung các file trong máy tính sẽ tự động biến đổi qua lại tương ứng mà không "giẫm chân" lên nhau.

---

## 1. Cách chuyển sang Repo Cũ để tiến hành Deploy AWS

*Sử dụng các lệnh này khi bạn đang code Đồ án và muốn đổi cảnh sang repo cũ:*

**Bước 1: Lưu lại tiến độ Đồ án (Nếu đang code dở, chưa lưu)**
```bash
git add .
git commit -m "Save tiến độ đồ án để qua repo cũ"
```
*(Nếu bạn chưa code thêm gì so với lần commit trước, có thể bỏ qua bước này).*

**Bước 2: Tải dữ liệu mới nhất từ repo cũ về (Cho chắc chắn)**
```bash
git fetch old
```

**Bước 3: Chuyển toàn bộ code trong ổ cứng về phiên bản cũ**
- **Nếu đây là lần đầu tiên bạn làm việc này:** Tạo một nhánh tên là `aws-deploy` nối với `main` của repo cũ.
  ```bash
  git checkout -b aws-deploy old/main
  ```
- **Nếu bạn ĐÃ TỪNG tạo nhánh `aws-deploy` trước đó rồi, thì chỉ cần gõ:**
  ```bash
  git checkout aws-deploy
  ```

*(Lúc này, bạn có thể thoải mái sửa file, thêm cấu hình AWS. Code của Đồ án đã được cất đi)*.

**💡 Lưu ý khi Push code lên github của repo cũ:**
Trường hợp bạn có thay đổi cấu hình trên nhánh `aws-deploy` và muốn đẩy (push) lên Github của dự án cũ, hãy dùng lệnh sau để tránh đẩy nhầm sang Đồ án:
```bash
git add .
git commit -m "Cập nhật cấu hình deploy trên AWS"
git push old aws-deploy:main
```

---

## 2. Cách quay về Repo Đồ Án để làm bài tập tiếp

*Khi deploy xong, bạn muốn quay lại code tính năng cho Đồ án:*

**Bước 1: Lưu lại những gì vừa cấu hình ở nhánh cũ**
```bash
git add .
git commit -m "Lưu tạm cấu hình AWS Deploy"
```

**Bước 2: Quay lại nhánh Đồ án**
```bash
git checkout main
```

*(Tuyệt vời! Lúc này mọi file cấu hình deploy biến mất, code đồ án của bạn xuất hiện trở lại nguyên vẹn).*
