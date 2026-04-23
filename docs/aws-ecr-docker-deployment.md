# Quy Trình Build và Triển Khai Docker Lên AWS ECS

Tài liệu này ghi lại chính xác các câu lệnh và quy trình đẩy source code backend (`petty_BE`) lên kho chứa AWS ECR và yêu cầu ECS cập nhật.

## Thông số hệ thống hiện tại
- **Account ID:** `392446151551`
- **Region:** `us-west-2` (Mỹ)
- **ECR Repository:** `webapp-group10/backend`
- **ECS Cluster:** `webapp-group10-backend-cluster`
- **ECS Service:** `webapp-group10-task-definition-service-aq71so0q`

---

## Các Bước Triển Khai

BẮT BUỘC: Phải mở Terminal và di chuyển vào đúng thư mục chứa `Dockerfile` của Backend trước khi chạy bất kỳ lệnh nào.
```bash
cd /Users/enma/Downloads/Coding/Case_Study_PJ/Petty_VMCS_SaaS/Petty/petty_BE
```

### Bước 1: Nạp quyền AWS Admin vào Terminal
*(Chỉ cần làm nếu token cũ hết hạn)*
```bash
export AWS_DEFAULT_REGION="us-west-2"
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
export AWS_SESSION_TOKEN="..."
```

### Bước 2: Build Image Mới
Lưu ý dấu chấm `.` ở cuối lệnh để chỉ định thư mục hiện tại.
```bash
docker build -t petty-be:latest .
```

### Bước 3: Đăng nhập ECR bằng Docker
Lấy token từ AWS ECR và nạp thẳng vào bộ nhớ của Docker:
```bash
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 392446151551.dkr.ecr.us-west-2.amazonaws.com
```

### Bước 4: Đánh Tag và Đẩy (Push) lên ECR
```bash
# Gắn tag khớp với địa chỉ ECR
docker tag petty-be:latest 392446151551.dkr.ecr.us-west-2.amazonaws.com/webapp-group10/backend:latest

# Bắt đầu tải lên
docker push 392446151551.dkr.ecr.us-west-2.amazonaws.com/webapp-group10/backend:latest
```

### Bước 5: Ra lệnh ECS khởi động lại
Yêu cầu ECS Service tắt các container cũ và kéo image mới về chạy (Rolling Update). Quá trình này mất khoảng 2-3 phút (Zero downtime).
```bash
aws ecs update-service \
  --cluster webapp-group10-backend-cluster \
  --service webapp-group10-task-definition-service-aq71so0q \
  --region us-west-2 \
  --force-new-deployment
```

---

## Các Lỗi Đã Gặp Và Cách Xử Lý

### Lỗi 1: 403 Forbidden khi Push Image
**Triệu chứng:**
```
unknown: unexpected status from HEAD request to https://.../v2/...: 403 Forbidden
```

**Nguyên nhân:**
1. **Sai Account ID / Region:** Đang cố đẩy image vào một tài khoản AWS cũ (`493499...`) trong khi credentials hiện tại thuộc về tài khoản (`392446...`) ở vùng `us-west-2`.
2. **Sai tên Repository:** Kho chứa thực tế trên ECR tên là `webapp-group10/backend` chứ không phải `petty-be`.
3. **Kẹt Token cũ trong Docker:** Dù đã dùng `aws configure` đổi tài khoản, nhưng chưa chạy lại lệnh `docker login` (Bước 3), dẫn đến việc Docker vẫn dùng chứng minh thư của account cũ đi gửi data.

**Cách xử lý:**
- Nạp lại đúng AWS credentials (bằng export hoặc `aws configure`).
- Chạy lại lệnh `docker login` (Bước 3) với thông số Account ID và Region chính xác.
- Sửa lại toàn bộ các lệnh Tag và Push về đúng đường dẫn ECR của nhóm.
